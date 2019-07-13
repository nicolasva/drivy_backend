require 'json'
require 'time'
require './services/parser_db/car_service.rb'
require './services/parser_db/rental_service.rb'
require './services/parser_db_service.rb'

class Main
  def initialize
    @json = ParserDbService.new("./data/input.json")
    @hrentals = {rentals: []}
  end

  attr_writer :hrentals

  def call
    @json.get_rentals!.each do |rental|
      @hrentals[:rentals] << rental.call
    end

    output = File.open('./data/expected_output.json','w')
    output << JSON.generate(@hrentals)
    output.close
  end
end
