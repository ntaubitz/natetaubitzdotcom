class Phonetics
  def phoneticize(word)
    word.phonetics.destroy_all
    foo_wagon word
    word.reload
  end

  def foo_wagon(word)
    if word.letters == 'liquor'
      Phonetic.create({word: word, letters: 'lickher'})
      Phonetic.create({word: word, letters: 'licker'})
    end
  end
end