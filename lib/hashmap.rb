# frozen_string_literal: true

require './lib/hasher'
require './lib/linked_list'

# Implementation of a HashMap
class HashMap
  attr_reader :length

  INITIAL_CAPACITY = 16
  LOAD_FACTOR = 0.75
  HASH_PRIME_NUMBER = 31

  def initialize
    @buckets = Array.new(INITIAL_CAPACITY)
    @length = 0
  end

  def set(key, value)
    index = hash_index(key)
    @buckets[index] ||= LinkedList.new(key, value)

    entry = @buckets[index].find(key)

    if entry
      entry.value = value
    elsif load_factor_exceeded?
      grow_capacity
      set(key, value)
    else
      @buckets[index].prepend(key, value)
      @length += 1
    end
  end

  def get(key)
    index = hash_index(key)
    entry = @buckets[index]&.find(key)
    entry&.value
  end

  def key?(key)
    !!get(key)
  end

  def remove(key)
    index = hash_index(key)
    output = @buckets[index]&.remove(key)
    @length -= 1 if output

    output
  end

  def clear
    @buckets = Array.new(capacity)
    @length = 0
  end

  private

  def entries
    @buckets.each_with_object([]) do |bucket, array|
      next unless bucket

      bucket.traverse { |entry| array << [entry.key, entry.value] }
    end
  end

  def grow_capacity
    current_entries = entries
    @length = 0

    @buckets = Array.new(current_capacity * 2)
    current_entries.each { |key, value| set(key, value) }
  end

  def load_factor_exceeded?
    (length / current_capacity) > MAX_LOAD_FACTOR
  end

  def hash_index(key)
    index = hash(key) & current_capacity
    raise IndexError if index.negative? || index >= @buckets.length

    index
  end

  def current_capacity
    @buckets.size
  end

  def hash(key)
    hash_code = 0

    key.each_char { |char| hash_code = HASH_PRIME_NUMBER * hash_code + char.ord }

    hash_code
  end
end
