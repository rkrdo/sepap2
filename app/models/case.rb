class Case < ActiveRecord::Base
  belongs_to :problem
  has_many :feedbacks, :as => :textable, :class_name => "Text", 
           :conditions => {:text_identifier => "feedback"}
  
  has_many :results
  
  accepts_nested_attributes_for :feedbacks
  
  after_initialize :initialize_case
  
  attr_accessor :from_form
  attr_accessible :input, :output, :feedbacks_attributes, :from_form
  
  def initialize_case
    if new_record? and self.from_form.nil?
      self.feedbacks.build({:locale => "es"})
      self.feedbacks.build({:locale => "en"})
    end
  end
  
  def self.to_judge(cases)
    cases.inject({}) do |hash, cse|
      hash[cse.id] = {
        "input" => cse.input,
        "output" => cse.output
      }
      hash
    end
  end
  
end
