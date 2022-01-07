class Phonetic < ApplicationRecord
  validates :letters, :length => { :in => 1..64, :message => 'must be between 1 and 64 characters long'}, :if => :letters

  belongs_to :word
end