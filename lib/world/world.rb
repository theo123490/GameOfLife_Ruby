module GameOfLife
  class World
    attr_accessor :life_array
    def initialize
      @life_array = []
    end

    def add_life(x, y)
      life_array << [x, y]
    end
  end
end
