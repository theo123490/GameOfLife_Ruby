require_relative 'world/world.rb'

world = GameOfLife::World.new
world.add_life(1, 0)
world.add_life(1, 1)
world.add_life(1, 2)

world.add_life(5, 0)
world.add_life(5, 1)
world.add_life(5, 2)

world.add_life(10, 5)
world.add_life(11, 5)
world.add_life(12, 5)

loop do
  puts '********************************************'
  world.draw_array
  world.update_life_array
  puts '********************************************'
end
