class Result < ActiveRecord::Base
  belongs_to :case
  belongs_to :attempt
  attr_accessible :result
end
