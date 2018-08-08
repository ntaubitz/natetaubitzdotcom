class User < ApplicationRecord
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  has_many :short_posts
end