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
  
  validate do |problem|
    #problem.both_languages_on_text(:titles)
    #problem.both_languages_on_text(:descriptions)
  end
  
#  after_create do
#    if new_record? and self.titles.count == 0
#      self.titles.build({:locale => "es"})
#      self.titles.build({:locale => "en"})
#      self.descriptions.build({:locale => "es"})
#      self.descriptions.build({:locale => "en"})
#      self.cases.build
#    end
#  end
  
  DIFICULTY_LEVELS = ['easy', 'normal', 'hard']
  
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
