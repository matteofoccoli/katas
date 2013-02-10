require 'test/unit'

class BinarySearchTree

  attr_reader :root
  
  def insert(node)
    current = @root
    parent = nil
    while current 
      parent = current
      if node.key < current.key
       current = current.left
      else
       current = current.right
      end 
    end
    node.parent = parent
    if parent == nil
      @root = node
    elsif node.key < parent.key
      parent.left = node
    else
      parent.right = node
    end
  end

  def keys?(node=root)
    keys = []
    if node
      keys += keys?(node.left)
      keys << node.key
      keys += keys?(node.right)
    end
    return keys
  end

  def search?(node=root, key)
    if node == nil || node.key == key
      return node
    end
    if key < node.key
      return search?(node.left, key)
    else
      return search?(node.right, key)
    end
  end

  def max?(current=root)
    while current.right
      current = current.right
    end
    return current
  end

  def min?(current=root)
    while current.left
      current = current.left
    end
    return current
  end

  def predecessor?(node)
    if node.left 
      return max?(node.left)
    end
    current = node
    parent = node.parent
    while parent && parent.left == current
      current = parent
      parent = parent.parent
    end
    return parent
  end

  def successor?(node)
    if node.right
      return min?(node.right)
    end
    current = node
    parent = node.parent
    while parent && parent.right == current
      current = parent
      parent = parent.parent
    end
    return parent
  end

  def remove(node)
    if node.left == nil
      transplant(node, node.right)
    elsif node.right == nil
      transplant(node, node.left)
    else
      successor = min?(node.right)
      if successor.parent != node
	transplant(successor, successor.right)
	successor.right = node.right
	successor.right.parent = successor
      end
      transplant(node, successor)
      successor.left = node.left
      successor.left.parent = successor
    end
    
  end

  def transplant(dest, src)
    if dest.parent == nil
      @root = src
    end
    if dest == dest.parent.left
      dest.parent.left = src
    else
      dest.parent.right = src
    end
    if src 
      src.parent = dest.parent
    end
  end

end

class Node
  attr_reader :key
  attr_accessor :left, :right, :parent

  def initialize(key)
    @key = key
  end
end

class BinarySearchTreeTest < Test::Unit::TestCase
  def setup
    @bst = BinarySearchTree.new
    @bst.insert Node.new 20
  end

  def test_create_empty_tree
    assert_not_nil @bst
  end

  def test_insert_root
    assert_not_nil @bst.root
    assert_equal 20, @bst.root.key
  end

  def test_insert_first_node_after_root
    node = Node.new 10
    @bst.insert node

    assert_equal 10, @bst.root.left.key
    assert_equal 20, node.parent.key
  end

  def test_insert_two_nodes
    first = Node.new 10
    second = Node.new 30

    @bst.insert first
    @bst.insert second

    assert_equal 10, @bst.root.left.key
    assert_equal 30, @bst.root.right.key
  end

  def test_insert_nested_nodes
    @bst = create_tree_from_keys [20, 10, 5, 15, 30]
    
    assert_equal 10, @bst.root.left.key
    assert_equal 20, @bst.root.left.parent.key

    assert_equal 5, @bst.root.left.left.key
    assert_equal 10, @bst.root.left.left.parent.key
    assert_nil @bst.root.left.left.left
    assert_nil @bst.root.left.left.right

    assert_equal 15, @bst.root.left.right.key
    assert_equal 10, @bst.root.left.right.parent.key
    assert_nil @bst.root.left.right.left
    assert_nil @bst.root.left.right.right
    
    assert_equal 30, @bst.root.right.key
    assert_equal 20, @bst.root.right.parent.key
    assert_nil @bst.root.right.left
  end

  def test_get_sorted_keys
    @bst = create_tree_from_keys [10, 5, 15, 30, 12, 20]

    assert_equal [5, 10, 12, 15, 20, 30], @bst.keys?
  end

  def test_search_key
    @bst = create_tree_from_keys [10, 5, 15, 30, 12]

    assert_not_nil @bst.search?(12)
  end

  def test_search_not_existing_key
    @bst = create_tree_from_keys [10, 5, 15, 30, 12]
  
    assert_nil @bst.search?(34)
  end

  def test_find_max_key
    @bst = create_tree_from_keys [20, 10, 30, 15, 45]

    assert_equal 45, @bst.max?.key
  end
  
  def test_find_min_key
    @bst = create_tree_from_keys [20, 10, 22, 33, 1]

    assert_equal 1, @bst.min?.key
  end

  def test_find_predecessor
    @bst = create_tree_from_keys [20, 10, 5, 15, 30]

    assert_equal 5, @bst.predecessor?(@bst.root.left).key
    assert_nil @bst.predecessor?(@bst.root.left.left)
    assert_equal 10, @bst.predecessor?(@bst.root.left.right).key
  end

  def test_find_successor
    @bst = create_tree_from_keys [20, 10, 5, 15, 30]
    
    assert_equal 30, @bst.successor?(@bst.root).key
    assert_nil @bst.successor?(@bst.root.right)
    assert_equal 10, @bst.successor?(@bst.root.left.left).key
  end

  def test_remove_leaf
    @bst = create_tree_from_keys [20, 10, 5]

    @bst.remove(@bst.root.left.left)

    assert_nil @bst.root.left.left
  end

  def test_remove_node_with_left_child
    @bst = create_tree_from_keys [20, 10, 5]
    
    @bst.remove(@bst.root.left)

    assert_equal 5, @bst.root.left.key
    assert_equal [5, 20], @bst.keys?
  end

  def test_remove_node_with_left_and_right_children
    @bst = create_tree_from_keys [20, 10, 5, 30, 25, 40]
    
    @bst.remove(@bst.root.right)

    assert_equal [5, 10, 20, 25, 40], @bst.keys?
    assert_equal 40, @bst.root.right.key
    
    @bst = create_tree_from_keys [20, 10, 5, 30, 25, 40, 35, 50, 37]

    @bst.remove(@bst.root.right)

    assert_equal 35, @bst.root.right.key
    assert_equal 25, @bst.root.right.left.key
    assert_nil @bst.root.right.left.left
    assert_nil @bst.root.right.left.right
    assert_equal 40, @bst.root.right.right.key
    assert_equal 37, @bst.root.right.right.left.key
    assert_equal 50, @bst.root.right.right.right.key
  end
    
  private

  def create_tree_from_keys(keys)
    bst = BinarySearchTree.new
    keys.each {|k|
      bst.insert Node.new k
    }
    return bst
  end

end

