class Problem < ActiveRecord::Base
  belongs_to :user
  belongs_to :command

  has_many :attempts, :dependent => :destroy
  has_many :cases, :dependent => :destroy
  has_many :assignments, :dependent => :destroy
  has_and_belongs_to_many :topics, :join_table => :problems_topics

  # titles and descriptions that supports different languages
  has_many :titles, :as => :textable, :class_name => "Text",
           :conditions => {:text_identifier => "title"},
           :dependent => :destroy
  has_many :descriptions, :as => :textable, :class_name => "Text",
           :conditions => {:text_identifier => "description"},
           :dependent => :destroy

  accepts_nested_attributes_for :titles
  accepts_nested_attributes_for :descriptions
  accepts_nested_attributes_for :cases

  attr_accessible :descriptions_attributes, :module, :time, :titles_attributes, :main,
                  :method, :language, :problem, :topic_ids, :dificulty, :cases_attributes, :command_id,
                  :compile_error, :error_message, :active

  validates_numericality_of :time, :greater_than_or_equal_to =>1,
                            :message => "debe ser mayor o igual a 1."

  validates_presence_of :main

  DIFICULTY_LEVELS = ['easy', 'normal', 'hard']

  after_save :compile_and_run, :if => lambda { |problem| problem.new_record? or problem.main_changed? or problem.method_changed? }

  scope :active, where(active: true)

  #before_save :maybe_set_as_module

  def compile_and_run
    DebWorker.perform_async(hash_for_judge(1))
  end

  def maybe_set_as_module
    self.module = !self.method.empty?
  end

  # Validation method
  # It validates that the association for title or description has both idioms
  # The number 2 should change when idioms change
  def both_languages_on_text(association)
    if self.send(association).count < 2
      errors.add(association, "debe tener mas de 1.")
    else
      self.send(association).each do |assoc|
        errors.add(association, "debe estar en todos los idiomas.") if assoc.text_content.blank?
      end
    end
  end

  # This method returns the title in the current locale
  def title(locale = "en")
    self.titles.find_by_locale(locale).text_content
  end
  
  def description(locale = "en")
    self.descriptions.find_by_locale(locale).text_content
  end

  def source_code
    if self.method.blank?
      return self.main
    else
      return self.main.gsub("<yield>",self.method)
    end
  end

  def has_accepted_attempt_for_user?(user)
    self.attempts.accepted.of(user).count > 0
  end

  def compile_from_toolkit(toolkit)
    Requests.request_to_deb(hash_for_judge(2, toolkit[:input], toolkit[:channel]), true)
  end

  def hash_for_judge(return_type, case_from_toolkit = nil, channel = nil)
    if return_type == 1
      cases = Case.to_judge(self.cases)
    else
      cases = {0 => {"input" => case_from_toolkit, "output" => nil}}
    end

    ActiveSupport::JSON.encode({
      :id => self.id,
      :ext => self.command.name.downcase,
      :return_type => return_type,
      :command => self.command.compile_command,
      :run_command => command.run_command || " ",
      :run_extension => command.run_extension || " ",
      :source => self.source_code.to_json,
      :time => self.time,
      :cases => cases,
      :channel => channel
    })
  end
end
