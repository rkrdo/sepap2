class Group < ActiveRecord::Base
  belongs_to :subject
  has_many :attempts, through: :users
  has_many :users, through: :enrollments
  has_many :assignments
  has_many :enrollments,  dependent: :destroy
  attr_accessible :name, :period, :subject_id, :members, :enrollments_attributes

  accepts_nested_attributes_for :enrollments, allow_destroy: true
  accepts_nested_attributes_for :users

  validates_presence_of :name, :period, :subject, :members

  attr_accessor :members 

  #Method that finds or creates students and adds them to the group
  def populate_group
    formatedMembers = members.downcase!.gsub(" ","")
    groupMembers = formatedMembers.split(',')
    errors = Array.new

    groupMembers.each do |num|
      
      conditions = {num: "#{num}", email: "#{num}@itesm.mx", password: "#{num}", password_confirmation: "#{num}"}

      member = User.find_by_num("#{num}") || User.create(conditions)
      if member.nil?
        errors << member
      else
        enroll = Enrollment.create(user_id: member.id, group_id: id) unless users.include? member
      end
    end
    return errors
  end

  PERIODS  = ["Ene - May","Verano","Ago - Dic"]

end