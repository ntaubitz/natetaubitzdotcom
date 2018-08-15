class Dates

  def parse_years(years, min_year=nil, max_year=nil)
    return [] if years.blank?
    min_date = DateTime.new(min_year.to_i) unless min_year.nil?
    max_date = DateTime.new(max_year.to_i) unless max_year.nil?
    # split on , trim strings and reject blanks
    splits = years.split(',').map{|d| d.strip}.reject{|d| d.blank?}
    # Turn ranges into years
    results = []
    splits.each do |split|
      if split.include?('-')
        start_year = DateTime.new(split.split('-').first.to_i)
        end_year = DateTime.new(split.split('-').last.to_i)
        while start_year.year <= end_year.year
          results << start_year
          start_year += 1.year
        end
      else
        results << DateTime.new(split.to_i)
      end
    end

    # reject older years
    results = results.reject{|d| d.year < min_date.year} unless min_year.nil?
    # reject newer years
    results = results.reject{|d| d.year > max_date.year} unless min_year.nil?

    # Sort by date and build results of just the year
    results.sort{|x,y| x <=> y}.map{|d| d.year}
  end
end