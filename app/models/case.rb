class Case < ActiveRecord::Base
  belongs_to :problem
  has_many :feedbacks, :as => :textable, :class_name => "Text", 
           :conditions => {:text_identifier => "feedback"}
           
  accepts_nested_attributes_for :feedbacks
  
  after_initialize :initialize_case
  
  attr_accessor :from_form
  attr_accessible :input, :output, :feedbacks_attributes, :from_form
  
  validate :both_languages_on_feedbacks
  
  def initialize_case
    if new_record? and self.from_form.nil?
      self.feedbacks.build({:locale => "es"})
      self.feedbacks.build({:locale => "en"})
    end
  end
  
  def both_languages_on_feedbacks
    self.feedbacks.each do |feedback|
      errors.add(:feedbacks, "debe estar en todos los idiomas.") if feedback.text_content.blank?
    end
  end
end
