require File.expand_path('../../test_helper', __FILE__)

class PhoneticsTest < ActiveSupport::TestCase
  setup do
    @phone = Phonetics.new
    @liquor = words(:liquor)
    @phone.phoneticize @liquor
  end

  test 'all things' do
    assert 2 == @liquor.phonetics.count
  end

  test 'liquor rhymes with quicker' do
    quicker = words(:quicker)

    assert @liquor.rhymes_with?(quicker)
    assert quicker.rhymes_with?(@liquor)
  end
end