class Heap
  @list = nil

  def initialize
    @list = LinkedList.new
  end

  def push(value)
    @list.add_to_head(value)
  end

  def append(value)
    @list.add_to_tail(value)
  end

  def pop
    return nil if @list.empty?

    value = @list.head.value
    @list.remove(@list.head)
    value
  end
end