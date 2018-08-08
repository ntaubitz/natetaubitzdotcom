require File.expand_path('../../test_helper', __FILE__)

class SomeModelTest < ActiveSupport::TestCase
  setup do
    @some_model = SomeModel.new
  end

  test 'what is the answer' do
    assert 41 == @some_model.answer_to_everything
  end
end