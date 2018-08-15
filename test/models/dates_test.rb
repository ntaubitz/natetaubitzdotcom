require File.expand_path('../../test_helper', __FILE__)

class DatesTest < ActiveSupport::TestCase
  setup do
    @dates = Dates.new
  end

  test 'years are ordered correctly' do
    years = '2016, 2018, 2014'
    assert [2014,2016,2018] == @dates.parse_years(years)
  end

  test 'empty years are removed' do
    years = '2016, , 2014'
    assert [2014,2016] == @dates.parse_years(years)
  end

  test 'year ranges are created' do
    years = '2016, 2002-2007 , 2014'
    assert [2002,2003,2004,2005,2006,2007,2014,2016] == @dates.parse_years(years)
  end

  test 'out of bounds years are rejected' do
    years = '1998, 2018, 1999, 2002-2005, , 2019'
    assert [1999, 2002, 2003, 2004, 2005, 2018] == @dates.parse_years(years, '1999', '2018')
  end
end