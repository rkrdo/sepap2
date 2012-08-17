class Feedback < ActiveRecord::Base
  belongs_to :problem
  attr_accessible :comment, :line_number
end
