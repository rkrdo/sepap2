class Problem < ActiveRecord::Base
  belongs_to :user
  belongs_to :command
  
  has_many :attempts, :dependent => :destroy
  has_many :cases, :dependent => :destroy
  has_many :assignments
  has_and_belongs_to_many :topics, :join_table => :problems_topics
  
  # titles and descriptions that supports different languages
  has_many :titles, :as => :textable, :class_name => "Text", 
           :conditions => {:text_identifier => "title"}
  has_many :descriptions, :as => :textable, :class_name => "Text",
           :conditions => {:text_identifier => "description"}
  
  accepts_nested_attributes_for :titles
  accepts_nested_attributes_for :descriptions
  accepts_nested_attributes_for :cases
  
  attr_accessible :descriptions_attributes, :module, :time, :titles_attributes, :main, 
                  :method, :language, :problem, :topic_ids, :dificulty, :cases_attributes, :command_id

  validates_numericality_of :time, :greater_than_or_equal_to =>1, 
                            :message => "debe ser mayor o igual a 1."
  
  validates_presence_of :main
  
  DIFICULTY_LEVELS = ['easy', 'normal', 'hard']
  
  after_create :evaluate_inputs
  
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
  def title(locale)
    if locale
      return self.titles.find_by_locale(locale).text_content
    else
      return self.titles.find_by_locale("en").text_content
    end
  end
  
  def evaluate_inputs
#    "request":{
#      "id":"1",
#      "command": "compiler command",
#      "source": "source_code",
#      "time": "time",
#      "cases":{
#        "1":{
#            "input":"input",
#            "output":
#            },
#        "2":{
#            "input":"input",
#            "output":
#            }
#      }
#      callback_url: "problems/{id}/judge_results"
#    }
    ActiveSupport::JSON.encode(
      :request => {
        :id => self.id,
        :command => self.command.compile_command,
        :source => self.source_code,
        :time => self.time,
        :cases => Case.to_judge(self.cases),
        :callback_url => "problems/#{self.id}/judge_results"
      })
  end
  
  def source_code
    if self.method.blank?
      return self.main
    else
      return self.main.gsub("<yield>",self.method)
    end
  end

  def toolkit(params)
    file = File.basename(main.to_s, self.extension)
    time=Integer(self.time)

    if !params[:input].empty?

      if self.extension.include? "java"
        exe = "#{self.basepath_problem} #{file}"
        resultado = `#{Rails.root.to_s}/lib/scripts/toolkit '#{exe}' '#{params[:input]}' '#{time}'`

      elsif self.extension.include? "cs"
        exe="#{self.basepath_problem}/#{file}.exe"
        resultado = `#{Rails.root.to_s}/lib/scripts/toolkit_cs '#{exe}' '#{params[:input]}' '#{time}'`

      elsif (self.extension.include? "c") || (self.extension.include? "cpp")
        exe = "#{self.basepath_problem}/#{file}"
        resultado = `#{Rails.root.to_s}/lib/scripts/toolkit_c '#{exe}' '#{params[:input]}' '#{time}'`

      end

    else

      resultado = "[Missing input]"
    end

    resultado.gsub! /\n/, "&#013;&#010;"
    return resultado
    end

    def is_assigned?(user)
      true if true
    end
  end
