class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :num
  # attr_accessible :title, :body
  has_many :attempts
  has_many :problems, through: :attempts, group: :id, counter_sql: true
  has_many :enrollments

  validates_presence_of :num, :email, :password, :password_confirmation
  validates_format_of :num, with: /\A(A|L)([0-9]{8})\z/i
  validates_uniqueness_of :num, case_sensitive: false
  validates_uniqueness_of :email

end
