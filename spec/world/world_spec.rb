require '././lib/world/world.rb'

RSpec.describe GameOfLife::World do
  before(:all) do
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
end
