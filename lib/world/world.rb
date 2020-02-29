module GameOfLife
  class World
    attr_accessor :life_array
    def initialize
      @life_array = []
    end

    def add_life(x, y)
      @life_array << [x, y]
    end

    def kill_life(x, y)
      @life_array.delete([x, y])
    end

    def find_neighbor(neighbor_n)
      neighbor_count = 0

      center_x = @life_array[neighbor_n][0]
      center_y = @life_array[neighbor_n][1]

      up = [center_x, center_y + 1]
      up_right = [center_x + 1, center_y + 1]
      right = [center_x + 1, center_y]
      down_right = [center_x + 1, center_y - 1]
      down = [center_x, center_y - 1]
      down_left = [center_x - 1, center_y - 1]
      left = [center_x - 1, center_y]
      up_left = [center_x, center_y + 1]

      direction = [up, up_right, right, down_right, down, down_left, left, up_left]

      direction.each do |direct|
        if @life_array.include?(direct)
          neighbor_count += 1
        end
      end
      neighbor_count
    end

    def find_extremes
      x = []
      y = []

      @life_array.each do |life|
        x << life[0]
        y << life[1]
      end

      [x.min, x.max, y.min, y.max]
    end

    def array_to_draw
      x_min, x_max, y_min, y_max = find_extremes
      x_range = 1 + (x_max - x_min)
      y_range = 1 + (y_max - y_min)

      world_array = Array.new(y_range) { Array.new(x_range, 'o') }

      @life_array.each do |life|
        world_array[life[1] - y_min][life[0] - x_min] = 'x'
      end
      world_array.reverse
    end
  end
end
