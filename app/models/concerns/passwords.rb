module Passwords
  extend ActiveSupport::Concern

  attr_accessor :password

  def authenticate(password)
    return nil unless self.authenticated?(password)
    true
  end

  def authenticated?(password)
    self.crypted_password == encrypt(password, self.salt)
  end

  def change_password(params)
    potential_password = encrypt(params[:current_password], self.salt)
    return :invalid_current_password unless potential_password == self.crypted_password
    return :confirmation_invalid if params[:new_password] != params[:confirm_password]
    self.password = params[:new_password]
    return :password_invalid unless self.save
    ApplicationMailer.new.password_changed(self)
    :success
  end

  def encrypt_password
    return if password.blank?
    self.salt = new_sha_hex if new_record?
    self.crypted_password = encrypt(password, self.salt)
  end

  def encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  def new_sha_hex
    Digest::SHA1.hexdigest(Time.now.to_s.split(//).concat(email.split(//)).sort_by { rand }.join)
  end
end