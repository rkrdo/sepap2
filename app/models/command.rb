class Command < ActiveRecord::Base
  has_many :problems
  has_many :attempts

  attr_accessible :compile_command, :run_command, :run_extension, :description, :name
end
