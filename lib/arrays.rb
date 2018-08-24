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

  def largest_value_at(input, index)
    list = LinkedList.new
    input.each do |value|
      if list.empty?
        list.add_to(value)
      elsif value >= list.head.value
        insert_at = nil
        list.iterate do |node|
          break if node.value >= value
          insert_at = node
        end
        list.add_to(value, insert_at, false)
      end
      if list.count > index
         list.remove(list.head)
      end
    end

    list.head.value
  end

  def missing_value_simple(input)
    at = nil
    input.each do |value|
      unless at.nil?
        return at + 1 if value - at > 1
      end
      at = value
    end
    nil
  end

  def missing_value_divide_and_conquer(input, left=nil, right=nil)
    # divide array in half
    # if the start value + count is not the last value, missing is in that half
    left = 0 if left.nil?
    right = input.count - 1 if right.nil?

    if (right - left) == 1
      return input[left] + 1
    end

    middle = left + ((right - left) / 2)
    if (input[left] + (middle - left)) != input[middle]
      return missing_value_divide_and_conquer(input, left, middle)
    elsif (input[middle+1] + right - (middle+1)) != input[right]
      return missing_value_divide_and_conquer(input, middle + 1, right)
    else
      return input[middle] + 1
    end

    nil
  end

  def evaluate_reverse_polish_notation(input)
    heap = Heap.new
    input.each do |value|
      if character_type(value) == :none
        heap.push(value)
      else
        second = heap.pop.to_i
        first = heap.pop.to_i
        heap.push(first * second) if character_type(value) == :multiplication
        heap.push(first / second) if character_type(value) == :division
        heap.push(first + second) if character_type(value) == :addition
        heap.push(first - second) if character_type(value) == :subtraction
      end
    end
    heap.pop.to_i
  end

  def character_type(character)
    return :multiplication if character == '*'
    return :division if character == '/'
    return :addition if character == '+'
    return :subtraction if character == '-'
    :none
  end
end