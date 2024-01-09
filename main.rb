# frozen_string_literal: true

require './lib/hashmap'

map = HashMap.new
map.set('name', 'Ahmed')
puts map.get('name')
map.remove('name')
puts map.get('name')
