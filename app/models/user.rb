class User < ApplicationRecord
  include Passwords

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_uniqueness_of :email, :allow_nil => false
  validates :password, :length => { :in => 5..21, :message => 'must be between 6 and 20 characters long'}, :if => :password

  before_save :encrypt_password

  has_many :short_posts
  has_and_belongs_to_many :groups, join_table: :user_groups

  scope :by_email, -> (email) {where(email: email)}

  def can?(permission)
    permissions.include? permission
  end

  private

  def permissions
    perms = []
    groups.each{|g| perms += g.permissions.collect{|p| p.name.to_sym}}
    perms
  end
end