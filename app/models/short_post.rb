class ShortPost < ApplicationRecord
  belongs_to :user

  validates :text, presence: true

  scope :most_recent, -> () {order(created_at: :desc).limit(7)}
end