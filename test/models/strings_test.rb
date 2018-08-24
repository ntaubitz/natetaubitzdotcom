require File.expand_path('../../test_helper', __FILE__)

class StringsTest < ActiveSupport::TestCase
  setup do
    @strings = Strings.new
  end

  test 'words in sentence are reversed' do
    assert 'blue is sky the' == @strings.reverse_words('the sky is blue')
  end

  test 'str_str finds the index' do
    input = 'this is is a aa stringing thingy'
    assert 2 == @strings.str_str(input, 'is')
    assert 13 == @strings.str_str(input, 'aa')
    assert 21 == @strings.str_str(input, 'gin')
  end

  test 'str_str does not find a string' do
    input = 'this is is a aa stringing thingy'
    assert -1 == @strings.str_str(input, 'stuff')
  end

  test'parens are valid' do
    assert @strings.valid_parentheses?('()')
    assert @strings.valid_parentheses?('(())')
    assert @strings.valid_parentheses?('([])')
    assert @strings.valid_parentheses?('([{}])')
    assert @strings.valid_parentheses?('([{{}}])')
    assert @strings.valid_parentheses?('([{{}}])()')
  end

  test'parens are invalid' do
    assert_not @strings.valid_parentheses?('(')
    assert_not @strings.valid_parentheses?('())')
    assert_not @strings.valid_parentheses?('()[(]{}')
  end
end