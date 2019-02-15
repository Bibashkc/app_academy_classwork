class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return if include?(key)
    resize! if count == num_buckets
    self[key] << key
    @count+=1
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    return unless include?(key)
    self[key].reject!{|ele|ele==key}
    @count-=1
  end

  private

  def [](num)
   @store[num.hash%num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
  end
end
