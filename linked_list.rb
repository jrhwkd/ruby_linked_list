#linked list class

class LinkedList
  attr_accessor :head
  def initialize
    @head = nil
    @size = 0
  end

  def append(val, current_value = @head)
    if @head == nil
      @head = Node.new(val)
      @size += 1
    elsif current_value.next_node == nil
      current_value.next_node = Node.new(val)
      @size += 1
    else
      append(val, current_value.next_node)
    end
  end

  def prepend(value)
    @head = Node.new(value, @head)
    @size += 1
  end

  def size
    return "Size: #{@size}"
  end

  def head
    return @head.value
  end

  def tail(node = @head)
    node.next_node == nil ? node.value : tail(node.next_node)
  end

  def at(index, current_node = @head)
    return "Index does not exist, list length is #{@size} elements." if index >= @size
    index.times do
      current_node = current_node.next_node
    end
    return current_node.value
  end

  def pop(node = @head)
    if node.next_node.next_node == nil
      node.next_node = nil
      @size -= 1
    else
      pop(node.next_node)
    end
  end

  def contains?(val, current_node = @head)
    if current_node.value == val
      return true
    elsif current_node.next_node != nil
      contains?(val, current_node.next_node)
    else
      return false
    end
  end

  def find(val, current_node = @head, index = 0)
    if current_node.value == val
      return index
    elsif current_node.next_node != nil
      index += 1
      find(val, current_node.next_node, index)
    else
      return nil
    end
  end

  def to_s(current_node = @head)
    string = ""
    if current_node.next_node != nil
      string += "( #{current_node.value} ) -> "
      string += to_s(current_node.next_node)
    else
      string += "( #{current_node.value} ) -> "
      string += "nil" if current_node.next_node == nil
    end
    return string
  end

  def insert_at(val, index, current_node = @head)
    puts "Not an index in list" if index >= (@size + 1)
    self.prepend(val) if index == 0
    if index < @size && index != 0
      (index - 1).times do
        current_node = current_node.next_node
      end
      current_node.next_node = Node.new(val, current_node.next_node)
      @size += 1
    end
    self.append(val) if index == @size
  end

  def remove_at(index, current_node = @head)
    puts "Not an index in list" if index >= (@size + 1)
    if index == 0
      @head = @head.next_node
      @size -= 1
    end
    if index > 0 && index < @size
      (index - 1).times do
        current_node = current_node.next_node
      end
      current_node.next_node = current_node.next_node.next_node
      @size -= 1
    end
    self.pop if index == (@size - 1)
  end
end

class Node
  attr_accessor :value, :next_node
  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

list = LinkedList.new

15.times do
  list.append(rand(100))
end

p list.to_s
p list.size

list.remove_at(1)
p list.to_s
p list.size