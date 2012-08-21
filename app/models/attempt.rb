class Attempt < ActiveRecord::Base
  belongs_to :problem
  belongs_to :user
  attr_accessible :language, :outcome, :problem_id, :code
end
