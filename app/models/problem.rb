class Problem < ActiveRecord::Base
  belongs_to :user
  
  has_many :attempts, :dependent => :destroy
  has_many :feedbacks, :dependent => :destroy
  has_many :assignments
  has_and_belongs_to_many :topics, :join_table => :problems_topics
  
  # titles and descriptions that supports different languages
  has_many :titles, :as => :textable, :class_name => "Text", 
           :conditions => {:text_identifier => "title"}
  has_many :descriptions, :as => :textable, :class_name => "Text",
           :conditions => {:text_identifier => "description"}
  accepts_nested_attributes_for :titles, 
                                :reject_if => proc { |attributes| attributes['text_content'].blank? }
  accepts_nested_attributes_for :descriptions, 
                                :reject_if => proc { |attributes| attributes['text_content'].blank? }
  
  attr_accessible :descriptions_attributes, :module, :time, :titles_attributes, :main, 
                  :method, :language, :problem, :topic_ids

  validates_numericality_of :time, :greater_than_or_equal_to =>1, 
                            :message => "El tiempo debe ser mayor o igual a 1."
  
  DIFICULTY_LEVELS = ['easy', 'normal', 'hard']

  #validates_presence_of :main

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
