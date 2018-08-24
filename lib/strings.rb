class Strings
  def reverse_words(input)
    # 'the sky is blue'
    heap = Heap.new
    input.split(' ').each do |word|
      heap.push(word)
    end
    words = []
    while heap.count > 0
      words << heap.pop
    end
    words.join(' ')
  end

  def str_str(input, find)
    index = 0
    while index < input.length - 1
      if input[index] == find.first
        matches = 0
        while matches < find.length && find[matches] == input[matches + index]
          matches += 1
        end
        return index if matches == find.length
      end
      index += 1
    end
    return -1
  end

  def valid_parentheses?(input)
    # I overcomplicated this problem by not just pushing each char onto the stack and poping it off
    # when it is closed. This isn't ideal, but it's me learning so it's staying as it is :)
    types = {
      '('.to_sym => ')',
      '['.to_sym => ']',
      '{'.to_sym => '}',
    }
    heap = Heap.new
    current_type = nil
    current_count = 0
    input.length.times do |i|
      type = input[i]
      if current_type.nil?
        current_count = 1
        current_type = type
      elsif type == current_type
        current_count += 1
      else
        # we have either opened a new type or closed the current type, assuming it's valid
        if type == types[current_type.to_sym]
          # it's a close
          current_count -= 1
          return false if current_count < 0
          if current_count == 0
            previous = heap.pop
            unless previous.nil?
              current_type = previous[:type]
              current_count = previous[:count]
            end
          end
        else
          # we have switched to another type
          return false if types[type.to_sym].nil?
          heap.push({type: current_type, count: current_count})
          current_count = 1
          current_type = type
        end
      end
    end

    heap.count == 0 && current_count == 0
  end

end