class Assignment < ActiveRecord::Base
  belongs_to :problem
  belongs_to :group
  has_many  :attempts
  has_many :users, through: :group
  attr_accessible :due_date, :title, :problem_id, :group_id
  
  def accepted_for_user?(user)
    self.attempts.where(:user_id => user.id, :accepted => true).count > 0
  end
  
end
