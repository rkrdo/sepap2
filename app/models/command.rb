class Command < ActiveRecord::Base
  has_many :problems
  has_many :attempts
  
  attr_accessible :compile_command, :description, :name
end
