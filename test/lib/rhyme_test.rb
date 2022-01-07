require File.expand_path('../../test_helper', __FILE__)

class RhymeTest < ActiveSupport::TestCase
  setup do
    @rhyme = Rhyme.new
  end

  test 'all things' do
    mike = Word.new letters: :mike
    like = Word.new letters: :like

    # assert mike.rhymes_with(@rhyme) like
  end
end