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
  end
end
