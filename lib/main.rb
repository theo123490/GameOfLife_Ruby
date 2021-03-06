require_relative 'world/world.rb'
require_relative 'reader/reader.rb'

class ReaderModule
  include Reader
end

file_location = File.join(File.dirname(__FILE__), 'input.csv')
live_location = ReaderModule.new.csv_to_location(file_location)

world = GameOfLife::World.new

live_location.each do |life|
  world.add_life(life[1], life[0])
end

loop do
  puts '********************************************'
  world.draw_array
  world.update_life_array
  $stdout.flush
  puts '********************************************'
  sleep(0.2)
end
