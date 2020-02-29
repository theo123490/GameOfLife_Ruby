require '././lib/reader/reader.rb'

RSpec.describe Reader do
  include Reader
  context 'csv_to_location' do
    it 'find location from csv array' do
      file_location = File.join(File.dirname(__FILE__), 'input_test.csv')
      location = csv_to_location(file_location)
      expect(location).to eql([[2, 1]])
    end
  end
end
