class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable 

  def initialize
    @head, @tail = Node.new, Node.new
    @head.next, @tail.prev = @tail, @head 
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def to_s
    self.each do |node|
      p [node.prev.to_s,node.to_s,node.next.to_s]
      puts "\n"
    end
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key,val)
    left_neighbor, right_neighbor = @tail.prev, @tail 
    left_neighbor.next, right_neighbor.prev = new_node, new_node
    new_node.prev, new_node.next = left_neighbor, right_neighbor
  end
  
  def update(key, val)
    self.each do |node|
      if node.key == key
        node.val = val 
        return
      end
    end
  end

  alias_method :<<, :append 
  
  def remove(key)
    return unless self.include?(key)
    # find the node 
    # reassign its left neighbor's next to it's right neighbor
    # reassign its right neighbor's prev to it's left neighbor 
    self.each do |node|
      if node.key == key 
        left_neighbor, right_neighbor = node.prev, node.next 
        left_neighbor.next, right_neighbor.prev  = right_neighbor, left_neighbor
        return node 
      end 
    end 
    nil 

  end



  def each
    # we start at @head, we set current node to @head 
    # we set current_node to current_node.next
    # we're done when next is nil
    current_node = @head.next
    until current_node.next == nil 
      yield current_node
      current_node = current_node.next
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
