class Assignment < ActiveRecord::Base
  belongs_to :problem
  belongs_to :group
  attr_accessible :due_date, :title, :problem_id, :group_id
end
