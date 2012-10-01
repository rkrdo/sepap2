class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  attr_accessible :group_id, :user_id, :user_attributes
  accepts_nested_attributes_for :user
end
