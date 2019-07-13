class ParserDbService
  def initialize(file_path)
    @json_file = JSON.parse(File.new(file_path, 'r').read)
  end

  attr_accessor :json_file

  def find_by(name, id)
    begin
      hash_names = eval(name)
      position = hash_names.index { |c| c.id == id }
      return position ? hash_names[position] : 'Undefined'
    rescue
      return "Undefined #{name}"
    end
  end

  def get_cars!
    cars_services = Array.new
    json_file['cars'].each do |car|
      cars_services << ParserDb::CarService.new(car)
    end
    return cars_services
  end

  def get_rentals!
    rentals_services = Array.new 
    json_file['rentals'].each do |rental|
      rentals_services << ParserDb::RentalService.new(rental, self)
    end
    return rentals_services
  end
end
