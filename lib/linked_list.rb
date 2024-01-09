# frozen_string_literal: true

# A Class representing a Node in a Linked List
class Node
  attr_accessor :value, :key, :next_node

  def initialize(key, value, next_node = nil)
    @key = key
    @value = value
    @next_node = next_node
  end
end

# A Class representing a Linked List
class LinkedList
  attr_reader :head

  def initialize(key, value)
    @head = Node.new(key, value)
  end

  # Appends a new node at the end of the list
  def append(key, value)
    tail.next_node = Node.new(key, value)
  end

  # Prepends a new node at the start of the list
  def prepend(key, value)
    @head = Node.new(key, value, head)
  end

  # Returns the size of the linked list
  def size(node = head, count = 1)
    return count if last_node?(node) # If the node is last node return the count

    size(node.next_node, count + 1) # Increases the counter and checks the next node
  end

  # Returns the last node in the list
  def tail(node = head)
    return node if last_node?(node) # Returns the node if it is the last one

    tail(node.next_node) # Checks if the next node is the last one
  end

  # Returns the node at a specific index
  def at(index, node = head)
    return node if index.zero? # Returns the node if it's index matches the given index

    # Invokes this method again with index - 1 and the next node
    at(index - 1, node.next_node)
  end

  # Pops the last node from this link
  def pop(node = head)
    # Removes the node if it is the last one
    return node.next_node = nil if last_node?(node.next_node)

    # Invokes this method with the next node
    pop(node.next_node)
  end

  # Returns true if the list contains the given key-value pair else false
  def contains?(key, node = head)
    # Returns true if the node contains the key-value pair
    return true if node.key == key
    # Returns false if the node is the last one
    return false if last_node?(node)

    # Calls this method again with the next node
    contains?(key, node.next_node)
  end

  # Traverses the linked list and calls the given block
  def traverse
    current_node = @head

    while current_node
      yield(current_node)
      current_node = @head.next_node
    end
  end

  # Finds a node in the list and returns it
  def find(key, node = head)
    # Returns the node if its key matches with the given key
    return node if node.key == key
    # Returns nil if the node is the last one
    return nil if last_node?(node)

    # Calls this method again with the next node
    find(key, node.next_node)
  end

  # Inserts a node at the given index
  def insert_at(key, value, index)
    prev_node = at(index - 1)
    next_node = prev_node.next_node
    prev_node.next_node = Node.new(key, value, next_node)
  end

  # Removes the node at the given index
  def remove_at(index)
    node = at(index)
    prev_node = at(index - 1)
    prev_node.next_node = node.next_node
  end

  private

  # Returns true if the given node is the last one
  def last_node?(node)
    return true if node.next_node.nil?

    false
  end
end
