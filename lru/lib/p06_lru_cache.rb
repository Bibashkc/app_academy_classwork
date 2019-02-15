require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'
class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    # if @map[key] is not nil give us that value by accessing 
    # node.val of @map[key], then move the node so that it is
    # tail.prev 
    # else, it is not in the cache, calculate the value and
    # append the node, eject the lru if @store.count > max 
    if @map[key]
      update_node!(@map[key])
    else  
      calc!(key)
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    # come up with a value for the key prc.call(key)
    # insert it into our linked list list.append(key, prc.call(key))
    # 
    # @map[key] = @tail.prev 
    value = @prc.call(key)
    @store.append(key,value)
    @map[key] = @store.last 
    eject! if count > @max 
    value
  end

  def update_node!(node)
    # # suggested helper method; move a node to the end of the list
    # # find the node
    # # reassing prev and next for its neighbors 
    # # move this node to the end so that tail.prev = node 
  

    # # we can just remove the node and append it, reassigning 
    # # the value at end 
    key, value = node.key, node.val
    @store.remove(key)
    @store.append(key, value)
    @map[key] = @store.last

  end

  def eject!
    # get @store.first
    # new_first @store.first.next
    # head = @store.first.prev 
    # head.next = new first
    # @map[key] = nil
    # debugger
    @map[@store.first.key] = nil
    @store.remove(@store.first.key)
  end


end
