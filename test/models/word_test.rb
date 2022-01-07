require File.expand_path('../../test_helper', __FILE__)

class WordTest < ActiveSupport::TestCase
  setup do
  end

  test 'mike rhymes with ike' do
    mike = words(:mike)
    ike = words(:like)

    assert mike.rhymes_with?(ike)
    assert ike.rhymes_with?(mike)
  end

  test 'mike rhymes with like' do
    mike = words(:mike)
    like = words(:like)

    assert mike.rhymes_with?(like)
    assert like.rhymes_with?(mike)
  end

  test 'mike does not rhyme with tom' do
    mike = words(:mike)
    tom = words(:tom)

    assert !mike.rhymes_with?(tom)
  end

  test 'mike rhymes with like and ike' do
    assert words(:ike).rhyming_words.count == 2
  end

end