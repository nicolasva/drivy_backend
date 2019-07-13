module ParserDb
  class RentalService
    def initialize(params, parse_db_service)
      @parse_db_service = parse_db_service
      @car = @parse_db_service.find_by('get_cars!', params['car_id'])
      @params = params
      @purcents = [0, 0.1, 0.1, 0.1, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.5]
      @price = 0
    end
    attr_accessor :params, :car, :parse_db_service

    attr_reader :purcents

    attr_writer :price

    def call 
      begin
        count_rental
      rescue
        puts "error no car find"
      end
    end

    def count_rental
      @price = 0
      days.times do |day|
        puts "day -=-=-=-=-=-=-#{day} purcent -=-=-=-=-=-#{get_purcent(day)}"
        @price += (@car.price_per_day - @car.price_per_day*get_purcent(day))
      end
      {id: params['id'], price: get_price.to_i}
    end

    private
    def get_price
       @price + @car.price_per_day + params['distance'] * @car.price_per_km
    end

    def days
      ((Time.parse(params['end_date']) - Time.parse(params['start_date']))/(60*60*24)+1).to_i
    end

    def get_purcent(day)
      return purcents.last  if day > 9
      return purcents[day]
    end
  end
end
