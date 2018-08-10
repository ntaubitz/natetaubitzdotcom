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