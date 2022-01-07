class Word < ApplicationRecord
  validates_uniqueness_of :letters, :allow_nil => false
  validates :letters, :length => { :in => 1..64, :message => 'must be between 1 and 64 characters long'}, :if => :letters
  has_many :phonetics

  before_create do
    letters.downcase!
  end

  def rhymes_with?(word)
    return true if ends_the_same? self.letters, word.letters
    return true if phonetics_match? word
    false
  end

  def rhyming_words
    Word.where.not(id: self.id).select { |word| rhymes_with? word }
  end

  def phonetics_match?(word)
    phonetics.each do |phonetic|
      return true if word.rhymes_with? phonetic
    end
    if word.respond_to?(:phonetics)
      word.phonetics.each do |phonetic|
        return true if self.rhymes_with? phonetic
      end
    end
    false
  end

  def ends_the_same?(first, second)
    # maybe common endings like ly, ing, ed
    chars_matched = 0
    f_i = first.length - 1
    s_i = second.length - 1
    while f_i >= 0 && s_i >= 0
      f_c = first[f_i]
      s_c = second[s_i]
      chars_matched += 1 if f_c.downcase == s_c.downcase
      f_i -= 1
      s_i -= 1
    end
    chars_matched > 2
  end
end