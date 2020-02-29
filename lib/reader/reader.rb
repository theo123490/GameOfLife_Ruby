require 'csv'

module Reader
  def csv_to_location(file_location)
    csv_text = File.read(file_location)
    csv = CSV.parse(csv_text, headers: false)

    life_location = []
    i = 0
    csv.each do |row|
      j = 0
      row.each do |data|
        if data == 'o'
          life_location << [i, j]
        end
        j += 1
      end
      i += 1
    end
    life_location
  end
end
