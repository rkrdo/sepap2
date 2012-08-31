class Problem < ActiveRecord::Base
  has_many :attempts, :dependent => :delete_all
  attr_accessible :description, :module, :time, :title, :main, :method

  mount_uploader :main, MainUploader
  mount_uploader :method, MethodUploader


  validates :title, :description, :main, :presence => true

  validates :method, :presence => true

  validates_numericality_of :time, :greater_than_or_equal_to =>1, :message => "El tiempo no puede ser negativo."

end
