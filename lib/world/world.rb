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

      direction = make_surrounding_array(center_x, center_y)

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

    def draw_array
      array = array_to_draw
      array_map = array.map { |position| position.join(' ') }
      puts array_map
    end

    def make_surrounding_array(center_x, center_y)
      up = [center_x, center_y + 1]
      up_right = [center_x + 1, center_y + 1]
      right = [center_x + 1, center_y]
      down_right = [center_x + 1, center_y - 1]
      down = [center_x, center_y - 1]
      down_left = [center_x - 1, center_y - 1]
      left = [center_x - 1, center_y]
      up_left = [center_x - 1, center_y + 1]

      direction = [up, up_right, right, down_right, down, down_left, left, up_left]
      direction
    end

    def reproduct(reference_x, reference_y)
      reference_surrounding = make_surrounding_array(reference_x, reference_y)
      reference_surrounding.each do |possible_birth|
        parent = 0
        possible_birth_surrounding = make_surrounding_array(possible_birth[0], possible_birth[1])

        possible_birth_surrounding.each do |available_parent_location|
          if @life_array.include?(available_parent_location)
            parent += 1
          end
        end

        if parent == 3
          add_life(possible_birth[0], possible_birth[1])
        end
      end
    end

    def remove_life_duplicate
      @life_array = @life_array.uniq
    end
  end
end
