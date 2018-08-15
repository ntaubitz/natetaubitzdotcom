class Arrays

  # Given two sorted arrays A and B, generate all possible arrays such that first element
  # is taken from A then from B then from A and so on in increasing order till the arrays exhausted.
  # The generated arrays should end with an element from B.
  # The resulting arrays are:
  # [10, 15, 25]
  # [1, 5, 20, 30]
  #   10 20
  #   10 20 25 30
  #   10 30
  #   15 20
  #   15 20 25 30
  #   15 30
  #   25 30
  def all_possible_sorted_arrays(a, b, results, c=nil, a_index=0, b_index=0, a_len=nil, b_len=nil, len=0, flag=true)
    a_len ||= a.count - 1
    b_len ||= b.count - 1
    c ||= Array.new(a_len+b_len+1)
    # puts "call: c #{c.inspect} ai: #{a_index} bi: #{b_index}, len #{len} flag #{flag}"
    if flag
      if len > 0
        # puts "result found #{c[0..len]}"
        results << c[0..len]
      end

      (a_index..a_len).each do |l|
        if len.zero?
          c[len] = a[l]
          all_possible_sorted_arrays(a, b, results, c, a_index+1, b_index, a_len, b_len, len, !flag)
        else
          if a[l] > c[len]
            c[len+1] = a[l]
            all_possible_sorted_arrays(a, b, results, c, a_index+1, b_index, a_len, b_len, len+1, !flag)
          end
        end
      end
    else
      (b_index..b_len).each do |l|
        if b[l] > c[len]
          c[len+1] = b[l]
          all_possible_sorted_arrays(a, b, results, c, a_index, b_index+1, a_len, b_len, len+1, !flag)
        end
      end
    end
  end
end