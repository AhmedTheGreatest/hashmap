# frozen_string_literal: true

require './lib/hasher'
require './lib/linked_list'

# Implementation of a HashMap
class HashMap
  INITIAL_CAPACITY = 16
  LOAD_FACTOR = 0.75
  HASH_PRIME_NUMBER = 31

  def initialize
    @buckets = Array.new(INITIAL_CAPACITY)
    @length = 0
  end

  private

  def hash(value)
    hash_code = 0

    value.each_char { |char| hash_code = HASH_PRIME_NUMBER * hash_code + char.ord }

    hash_code
  end
end
