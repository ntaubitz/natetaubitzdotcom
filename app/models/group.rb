class Group < ApplicationRecord
  validates :name, presence: true

  has_and_belongs_to_many :permissions, join_table: :group_permissions
end