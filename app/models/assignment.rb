class Assignment < ActiveRecord::Base
  belongs_to :problem
  belongs_to :group
  has_many  :attempts, :dependent => :nullify
  has_many :users, :hrough => :group
  attr_accessible :due_date, :title, :problem_id, :group_id
  
  def accepted_for_user?(user)
    self.attempts.where(:user_id => user.id, :state => "accept").count > 0
  end
  
  def compare_attempts
    request_to_varch hash_for_varch
  end

  def hash_for_varch
    users = self.users.includes(:attempts).where(:attempts => {:state => "accept"})
    
    ActiveSupport::JSON.encode({
      :params => {
        :algorithms => ['1','2'],
        :files => users.map{ |user| { :id => user.id, :code => user.attempts.first.code } },
        :url => "http://localhost:3000/varch/#{group_id}/#{id}"
      }
    })
  end
  
  def request_to_varch(params)
    # Sends HTTP post to python webservice that runs the algorithms
    uri = URI.parse('http://localhost:3001/compare')
    req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' => 'application/json'})
    #puts params
    req.body = params

    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 15
    http.read_timeout = 15
    begin
      response =  http.request(req)
      puts response.body
      return response
    rescue Exception
      puts "Connection refused"
      return nil
    end
  end
end
