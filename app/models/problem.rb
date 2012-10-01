class Problem < ActiveRecord::Base
  has_many :attempts, :dependent => :delete_all
  attr_accessible :description, :module, :time, :title, :main, :method

  mount_uploader :main, MainUploader
  mount_uploader :method, MethodUploader

  validates_numericality_of :time, :greater_than_or_equal_to =>1, :message => "El tiempo no puede ser negativo."
  validates_presence_of :title, :description, :main


end
