require File.expand_path('../../test_helper', __FILE__)

class WorkLogTest < ActiveSupport::TestCase
  setup do
    @user = users(:nate)
  end

  test 'a job is required' do
    entry = WorkLog.create(user: @user)
    assert false == entry.valid?
    assert entry.errors.first.first == :job
    assert entry.errors.first.last == "can't be blank"
  end
end