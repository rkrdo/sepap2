class Group < ActiveRecord::Base
  belongs_to :subject
  attr_accessible :name, :period, :subject_id, :members

  mount_uploader :members, MembersUploader
end
