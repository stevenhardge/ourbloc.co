class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts  

  
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  acts_as_messageable

  def mailboxer_name
    self.name
  end
 
  def mailboxer_email(object)
    self.email
  end

  def username
    self.email.split(/@/).first
  end

  def to_param
    "#{id} #{username}".to_normalize.to_s
  end
end

