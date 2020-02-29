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
      expect(@world.find_neighbor(0)).to eql(2)
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
      expect(world_array).to eql([%w[x o x x], %w[o o x o]])
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
      end.to output("x o x x\no o x o\n").to_stdout
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

      @world.reproduct(0, 2)

      expect(@world.life_array[-1]).to eql([1, 1])
    end

    it 'dont add life when a location is surounded less than 3 life' do
      @world.add_life(0, 2)
      @world.add_life(2, 0)

      @world.reproduct(0, 2)

      expect(@world.life_array[-1]).to eql([2, 0])
    end

    it 'dont add life when a location is more than 4 life' do
      @world.add_life(0, 2)
      @world.add_life(2, 0)
      @world.add_life(2, 1)
      @world.add_life(0, 0)

      @world.reproduct(0, 2)

      expect(@world.life_array[-1]).to eql([0, 0])
    end
  end
end
