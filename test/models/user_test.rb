require File.expand_path('../../test_helper', __FILE__)

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:nate)
  end

  test 'password should be long enough' do
    @user.password = 'as'
    assert !@user.valid?
    assert 1 == @user.errors.messages[:password].count
    assert @user.errors.messages[:password].first == 'must be between 6 and 20 characters long'
  end

  test 'password is crypted' do
    @user.password = 'foo shnickens'
    @user.save
    assert 'e72de807f2fc4695bd423c50649356313015b2ba' == @user.crypted_password
  end
end