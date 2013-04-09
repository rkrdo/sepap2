class Result < ActiveRecord::Base
  belongs_to :case
  belongs_to :attempt
  attr_accessible :result, :case_id
end
