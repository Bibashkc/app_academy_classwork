class MaxIntSet
  def initialize(max)
    @max = max 
    @store = Array.new(max) { false }
  end

  def insert(num)
    # we can only insert if num < @max
    # if the number is valid we insert it
    # to insert we set @store[idx] to true 
    raise 'Out of bounds' unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    raise 'invalid' unless is_valid?(num)
    @store[num] = false 
  end

  def include?(num)
    return false unless is_valid?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num < @max && num >= 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    # take a number to insert into store 
    # we bracket into store with []
    # return if include?(num)
    # else << num
    if self[num].include?(num) 
      return 
    else 
      self[num] << num
    end
  end

  def remove(num)
    if self[num].include?(num)
      self[num].select!{|ele|ele!=num} 
    else
      return
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return if include?(num)
    if count == num_buckets
      resize!
    end
    self[num]<<num 
    @count+=1
  end

  def remove(num)
    return unless include?(num)
    self[num].reject!{|ele| ele==num}
    @count-=1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp_arr = Array.new(num_buckets*2){[]}
    @store.each do |bucket|
      bucket.each do |ele|
        idx = ele%temp_arr.length
        temp_arr[idx] << ele
      end
    end
    @store = temp_arr
  end
end
