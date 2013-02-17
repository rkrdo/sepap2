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
                  :method, :input, :output, :feedbacks, :exe, :language, :problem, :topic_ids

  mount_uploader :main, MainUploader
  mount_uploader :method, MethodUploader

  validates_numericality_of :time, :greater_than_or_equal_to =>1, 
                            :message => "El tiempo debe ser mayor o igual a 1."

  validates_presence_of :main

  def basepath_problem
    basepath_problem=Rails.root.to_s+"/files/problems/#{self.id}"
  end

  def extension
    extension = File.extname(self.main.to_s)
  end


  def get_feedback_comment(line)
    self.feedbacks.each do |f|
      if f.line_number == line
        return f.comment
      end
    end
  end

  def  store_input

    # input_path = self.basepath_problem+"/input"

    exe = File.basename(self.main.to_s,File.extname(self.main.to_s))

    # File.open(input_path,'w') {|f| f.write(self.input)}
    # self.update_attributes(:input=> input_path)

    # Store output path
    self.update_attributes(:output=> self.basepath_problem+"/output")

    # Store exe path
    self.update_attributes(:exe=> self.basepath_problem+"/"+exe)

    # Store problem language
    if self.extension.include? "java"
      self.update_attributes(:language=> "java")
    elsif self.extension.include? "cs"
      self.update_attributes(:language=> "cs")
    elsif (self.extension.include? "c") || (self.extension.include? "cpp")
      self.update_attributes(:language=> "c")
    end


  end

  def compile_solution

    # File containing compile errors
    error=self.basepath_problem+"/error"

    # File with main, source code
    file=self.main.to_s

    # Filename without extension
    file_basename=File.basename(file, self.extension)

    if self.extension.include? "java"
      # where executable should be
      exe = self.basepath_problem+" "+file_basename

      # Compile!
      compile=`./lib/scripts/compilarJava_solucion #{self.basepath_problem} #{file} '#{exe}' '#{self.input}' #{self.output} #{error}`

    elsif self.extension.include? "cs"
      exe="./"+File.basename(file,self.extension)+".exe"
      # Compile C# code !
      compile=`./lib/scripts/compilarCs_solucion #{self.basepath_problem} #{file} #{exe} '#{self.input}' #{self.output} #{error}  `

    elsif (self.extension.include? "c") || (self.extension.include? "cpp")
      exe="./"+File.basename(file,self.extension)
      # Compile C code !
      compile=`./lib/scripts/compilarC_solucion #{self.basepath_problem} #{file} #{exe} '#{self.input}' #{self.output} #{error}`
    else
      compile="error"
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
