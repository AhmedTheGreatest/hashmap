# frozen_string_literal: true

require './lib/hashmap'

map = HashMap.new
map.set('name', 'Ahmed')
puts map.get('name')
map.clear
puts map.get('name')
