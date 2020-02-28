require '././lib/world/world.rb'

RSpec.describe GameOfLife::World do
  before(:all) do
    @world = GameOfLife::World.new
  end

  context 'Adding life' do
    it 'adds one more life to the world' do
      @world.add_life(2, 2)
      expect(@world.life_array[0]).to eql([2, 2])
    end
  end
end
