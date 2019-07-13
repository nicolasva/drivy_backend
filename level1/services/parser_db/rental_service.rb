module ParserDb
  class RentalService
    def initialize(params, parse_db_service)
      @parse_db_service = parse_db_service
      @car = @parse_db_service.find_by('get_cars!', params['car_id'])
      @params = params
    end
    attr_accessor :params, :car, :parse_db_service

    def call 
      begin
        count_rental
      rescue
        puts "error no car find"
      end
    end

    def count_rental
      {id: params['id'], price: price.to_i}
    end

    private
    def price
      ((Time.parse(params['end_date']) - Time.parse(params['start_date']))/(60*60*24)+1) * @car.price_per_day + params['distance'] * @car.price_per_km
    end
  end
end
