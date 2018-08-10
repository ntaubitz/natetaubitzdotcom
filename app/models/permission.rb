class Permission < ApplicationRecord
  validates :name, presence: true
end