class Group < ActiveRecord::Base
  belongs_to :subject
  attr_accessible :name, :period, :subject_id, :members

  attr_accessor :members 
  #Method that finds or creates students and adds them to the group
  def populate_group
    groupMembers = members.split(',')
    groupMembers.collect{|x| x.strip.squeeze(" ").downcase}
    errors = Array.new

    groupMembers.each do |num|
      member = User.find_by_num(num)
      member ||= User.create(num: num, email: "#{num}@itesm.mx", 
          password: num, password_confirmation: num)
      if member != nil
        enroll = Enrollment.create(user_id: member.id, group_id: id)
      else
        errors << member
      end
    end
    return errors
  end
end
