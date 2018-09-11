class User < ApplicationRecord
  include Passwords

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_uniqueness_of :email, :allow_nil => false
  validates :password, :length => { :in => 5..21, :message => 'must be between 6 and 20 characters long'}, :if => :password

  before_save :encrypt_password

  has_many :short_posts
  has_many :blog_posts
  has_many :work_logs
  has_and_belongs_to_many :groups, join_table: :user_groups

  scope :by_email, -> (email) {where(email: email)}

  def belongs_to?(group)
    return true if self.is_admin?
    groups.select{|g| g.name == group.to_s}.count > 0
  end

  def can?(permission)
    return true if self.is_admin?
    permissions.include? permission
  end

  def is_admin?
    self.groups.select{|g| g.name.to_sym == :admin}.count > 0
  end

  private

  def permissions
    perms = []
    groups.each{|g| perms += g.permissions.collect{|p| p.name.to_sym}}
    perms
  end
end