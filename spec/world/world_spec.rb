require '././lib/world/world.rb'

RSpec.describe GameOfLife::World do
  before(:each) do
    @world = GameOfLife::World.new
  end

  context 'Adding life' do
    it 'adds one more life to the world with a specific location' do
      @world.add_life(2, 2)
      expect(@world.life_array[0]).to eql([2, 2])
    end
  end

  context 'kill life' do
    it 'kills life with a specific locataion' do
      @world.add_life(2, 2)
      @world.add_life(2, 2)
      @world.add_life(1, 1)
      @world.add_life(-4, 2)
      @world.kill_life(2, 2)
      expect(@world.life_array.include?([2, 2])).to be false
    end
  end

  context 'find neighbor' do
    it 'finds number of neighbor available for a life' do
      @world.add_life(2, 2)
      @world.add_life(1, 2)
      @world.add_life(1, 1)
      @world.add_life(-4, 2)
      expect(@world.find_neighbor(2, 2)).to eql(2)
    end
  end

  context 'find extremes' do
    it 'find the extreme position of all the life array' do
      @world.add_life(2, 2)
      @world.add_life(1, 2)
      @world.add_life(1, 1)
      @world.add_life(-4, 2)
      expect(@world.find_extremes).to eql([-4, 2, 1, 2])
    end
  end

  context 'array_to_draw' do
    it 'give array to be drawn of the given world state' do
      @world.add_life(2, 2)
      @world.add_life(1, 2)
      @world.add_life(1, 1)
      @world.add_life(-1, 2)
      world_array = @world.array_to_draw
      expect(world_array).to eql([%w[o . o o], %w[. . o .]])
    end
  end

  context 'draw_array' do
    it 'draw the array given' do
      @world.add_life(2, 2)
      @world.add_life(1, 2)
      @world.add_life(1, 1)
      @world.add_life(-1, 2)
      expect do
        @world.draw_array
      end.to output("o . o o\n. . o .\n").to_stdout
    end
  end

  context 'make_surrounding_array' do
    it 'make an array that containts surrounding position' do
      x = 0
      y = 0

      surrounding_array = [[0, 1],
                           [1, 1],
                           [1, 0],
                           [1, -1],
                           [0, -1],
                           [-1, -1],
                           [-1, 0],
                           [-1, 1]]

      expect(@world.make_surrounding_array(x, y)).to eql(surrounding_array)
    end
  end

  context 'reproduct' do
    it 'add life when a location is surounded by 3 life' do
      @world.add_life(0, 2)
      @world.add_life(2, 0)
      @world.add_life(2, 1)

      expect(@world.reproduct(0, 2)).to eql([[1, 1]])
    end

    it 'dont add life when a location is surounded less than 3 life' do
      @world.add_life(0, 2)
      @world.add_life(2, 0)
      expect(@world.reproduct(0, 2)).to eql([])
    end

    it 'dont add life when a location is more than 3 life' do
      @world.add_life(0, 2)
      @world.add_life(2, 0)
      @world.add_life(2, 1)
      @world.add_life(0, 0)

      @world.reproduct(0, 2)

      expect(@world.reproduct(0, 2)).to eql([])
    end
  end

  context 'remove life duplicate' do
    it 'remove any duplicate in the life_array' do
      @world.add_life(0, 2)
      @world.add_life(1, 2)
      @world.add_life(2, 2)
      @world.add_life(2, 2)

      @world.remove_life_duplicate

      expect(@world.life_array.length).to eql(3)
    end
  end

  context 'reproduct_all' do
    it 'make all cells that can reproduct to reproduct' do
      @world.add_life(0, 3)
      @world.add_life(2, 3)
      @world.add_life(1, 1)
      @world.add_life(3, 2)
      @world.add_life(3, 1)
      @world.add_life(3, 0)

      new_birth = @world.reproduct_all

      expect(new_birth.include?([1, 2])).to be true
      expect(new_birth.include?([2, 0])).to be true
      expect(new_birth.include?([4, 1])).to be true
    end
  end

  context 'who_live_list' do
    it 'any cell that have 2 or 3 neighbor live, everyone else will die' do
      @world.add_life(0, 3)
      @world.add_life(2, 3)
      @world.add_life(1, 1)
      @world.add_life(3, 2)
      @world.add_life(3, 1)
      @world.add_life(3, 0)

      new_life_array = @world.who_live_list

      expect(new_life_array.include?([0, 3])).to be false
      expect(new_life_array.include?([1, 1])).to be false
      expect(new_life_array.include?([2, 3])).to be false
      expect(new_life_array.include?([3, 0])).to be false
      expect(new_life_array.include?([3, 2])).to be true
      expect(new_life_array.include?([3, 1])).to be true
    end
  end

  context 'update_life_array' do
    it 'will update the life array' do
      @world.add_life(0, 3)
      @world.add_life(2, 3)
      @world.add_life(1, 1)
      @world.add_life(3, 2)
      @world.add_life(3, 1)
      @world.add_life(3, 0)

      @world.update_life_array

      expect(@world.life_array.include?([0, 3])).to be false
      expect(@world.life_array.include?([1, 1])).to be false
      expect(@world.life_array.include?([2, 3])).to be false
      expect(@world.life_array.include?([3, 0])).to be false
      expect(@world.life_array.include?([3, 2])).to be true
      expect(@world.life_array.include?([3, 1])).to be true
      expect(@world.life_array.include?([1, 2])).to be true
      expect(@world.life_array.include?([2, 0])).to be true
      expect(@world.life_array.include?([4, 1])).to be true
    end
  end
end
