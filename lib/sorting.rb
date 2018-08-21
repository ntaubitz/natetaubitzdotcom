class Sorting

  def merge_sort(input, left=nil, right=nil)
    left = 0 if left.nil?
    right = input.count - 1 if right.nil?

    return unless left < right

    middle = left+(right - left) / 2
    merge_sort(input, left, middle)
    merge_sort(input, middle + 1, right)

    merge(input, left, middle, right)
  end

  def merge(input, left, middle, right)
    left_data = input[left..middle]
    right_data = input[(middle+1)..right]

    i = j = 0
    k = left
    n1 = middle - left + 1
    n2 = right - middle
    while i < n1 && j < n2
      if left_data[i] <= right_data[j]
        input[k] = left_data[i]
        i += 1
      else
        input[k] = right_data[j]
        j += 1
      end
      k += 1
    end
    while i < n1
      input[k] = left_data[i]
      i += 1
      k += 1
    end

    while j < n2
      input[k] = right_data[j]
      j += 1
      k += 1
    end
  end
end