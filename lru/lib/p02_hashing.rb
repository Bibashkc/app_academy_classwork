class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    # for every element convert it to integer representation
    # add the hashed values together
    # add the hashed value of each element plus hashed value of the index
    return 0.hash if self.empty?
    self.map.with_index do |el, i|
      el.hash ^ i
    end.inject(:+)
  end
end

class String
  def hash
    hashed = 0
    (0...self.length).each do |i|
      hashed += self[i].ord ^ i
    end 
    hashed
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hashed = 0
    self.each do |k,v|
      hashed += k.hash ^ v.hash 
    end
    hashed 
  end
end
