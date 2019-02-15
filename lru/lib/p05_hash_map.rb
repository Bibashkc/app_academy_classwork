require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    resize! if count == num_buckets
    if include?(key)
      bucket = bucket(key)
      bucket.update(key,val)
    else
      bucket(key).append(key,val)
      @count += 1
    end
  end

  def get(key)
   bucket(key).get(key)
  end

  def delete(key)
    bucket = bucket(key)
    bucket.remove(key)
    @count -= 1
  end

  def each
    @store.each do |bucket|
      bucket.each do |node|
        yield node.key, node.val 
      end
    end
    self
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    # create new array of linked lists of num_buckets * 2 
    # iterate through @store.each | each of those items is a linked list
    # iterate through linked list

    new_store = Array.new(num_buckets * 2) { LinkedList.new }
    @store.each do |list|
      list.each do |node|
        new_idx = node.key.hash % (num_buckets * 2)
        new_store[new_idx].<<(node.key,node.val)
      end
    end
    @store = new_store 
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
