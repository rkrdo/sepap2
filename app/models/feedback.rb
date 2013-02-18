class Feedback < ActiveRecord::Base
  belongs_to :problem
  has_many :feedbacks, :as => :textable, :class_name => "Text"
  
  attr_accessible :comment, :line_number
end
