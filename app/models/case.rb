class Case < ActiveRecord::Base
  belongs_to :problem
  has_many :feedbacks, :as => :textable, :class_name => "Text", 
           :conditions => {:text_identifier => "feedback"}
           
  accepts_nested_attributes_for :feedbacks
  
  after_initialize do
    if new_record?
      self.feedbacks.build({:locale => "es"})
      self.feedbacks.build({:locale => "en"})
    end
  end
  
  attr_accessible :input, :output, :feedbacks_attributes
  
  validate :both_languages_on_feedbacks
  
  def both_languages_on_feedbacks
    if self.feedbacks.count < 2
      errors.add(:feedbacks, "debe tener mas de 1.")
    else
      self.feedbacks.each do |feedback|
        errors.add(:feedbacks, "debe estar en todos los idiomas.") if feedback.text_content.blank?
      end
    end
  end
end
