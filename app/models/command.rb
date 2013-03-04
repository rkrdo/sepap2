class Command < ActiveRecord::Base
  attr_accessible :compile_command, :description, :name
end
