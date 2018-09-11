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

  test 'history contains 2 months' do
    history = WorkLog.history(users(:nate))
    assert 2 == history.count
  end

  test 'billed hours are correct' do
    history = WorkLog.history(users(:nate))
    entry = history.first
    assert 1 == entry[:billed_hours]

    entry = history.last
    assert 3 == entry[:billed_hours]
  end
end