class Problem < ActiveRecord::Base
  has_many :attempts, :dependent => :delete_all
  attr_accessible :description, :module, :time, :title, :main

  mount_uploader :main, MainUploader

end
