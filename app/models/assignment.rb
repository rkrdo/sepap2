class Assignment < ActiveRecord::Base
  belongs_to :problem
  belongs_to :group
  has_many  :attempts
  has_many :users, through: :group
  attr_accessible :due_date, :title, :problem_id, :group_id
  
  def accepted_for_user?(user)
    self.attempts.where(:user_id => user.id, :state => "accept").count > 0
  end

  def hash_for_varch()
    users = self.users.includes(:attempts).where(:attempts => {:state => "accept"})
    ActiveSupport::JSON.encode({
      :algorithms => [1,2],
      :files => users.map{ |user| { :id => user.id, :code => user.attemps.first.code } }
    })
  end
  
end
