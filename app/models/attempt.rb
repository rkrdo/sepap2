class Attempt < ActiveRecord::Base
  belongs_to :problem
  belongs_to :user
  attr_accessible :language, :outcome, :problem_id, :code

  # File uploader
  mount_uploader :code, CodeUploader

end
