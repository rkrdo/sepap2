class Assignment < ActiveRecord::Base
  belongs_to :problem
  belongs_to :group
  has_many  :attempts, :dependent => :nullify
  has_many :users, :through => :group
  attr_accessible :due_date, :title, :problem_id, :group_id
  
  scope :for, lambda {|problem| where(:problem_id => problem.id)}
  
  def accepted_for_user?(user)
    self.attempts.accepted.of(user).count > 0
  end
  
  def compare_attempts
    if attempts.accepted.count >= 2
      Requests.request_to_varch hash_for_varch
    else
      return nil
    end
  end

  def hash_for_varch
    users = self.users.includes(:attempts).where(:attempts => {:state => "accept"})
    
    ActiveSupport::JSON.encode({
      :params => {
        :algorithms => ['1','2'],
        :files => attempts.accepted.map{|attempt| {:id => attempt.user.id, :code => attempt.code}},
        :url => "#{SERVERS[:myself]}varch/#{group_id}/#{id}"
      }
    })
  end
end
