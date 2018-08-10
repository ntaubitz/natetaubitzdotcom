class User < ApplicationRecord
  include Passwords

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_uniqueness_of :email, :allow_nil => false
  validates :password, :length => { :in => 5..21, :message => 'must be between 6 and 20 characters long'}, :if => :password

  before_save :encrypt_password

  has_many :short_posts

  scope :by_email, -> (email) {where(email: email)}
end