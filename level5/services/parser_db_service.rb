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

  def find_by_rental_id(name, rental_id)
    begin
      result_hash_names = Array.new
      hash_names = eval(name)
      hash_names.each do |option|
        result_hash_names.push(option) if option.id == rental_id
      end
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

  def get_options!
    options_services = Array.new
    json_file['options'].each do |option|
      options_services << ParserDb::OptionService.new(option)
    end
    return options_services
  end

  def get_rentals!
    rentals_services = Array.new 
    json_file['rentals'].each do |rental|
      rentals_services << ParserDb::RentalService.new(rental, self)
    end
    return rentals_services
  end
end
