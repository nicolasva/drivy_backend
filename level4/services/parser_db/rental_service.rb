module ParserDb
  class RentalService
    def initialize(params, parse_db_service)
      @parse_db_service = parse_db_service
      @car = @parse_db_service.find_by('get_cars!', params['car_id'])
      @params = params
      @id = params['id']
      @distance = params['distance']
      @end_date = params['end_date']
      @start_date = params['start_date']
      @purcents = [0, 0.1, 0.1, 0.1, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.5]
      @price = 0
    end
    attr_accessor :params, 
                  :car, 
                  :parse_db_service, 
                  :id, 
                  :distance, 
                  :end_date, 
                  :start_date
                  :assistance

    attr_reader :purcents

    attr_writer :price

    def call 
      #begin
        count_rental
      #rescue
      #  puts "error no car find"
      #end
    end

    def count_rental
      price
      return {id:         params['id'], 
              #price:      get_price.to_i, 
              #action: AssistanceService.new(get_price, days).call
              action: ParserDb::PaymentService.new(self, AssistanceService.new(get_price, days)).call
             }
    end

    def price
      @price = 0
      days.times do |day|
        @price += (@car.price_per_day - @car.price_per_day*get_purcent(day))
      end
      return @price
    end

    def get_price
      price + @distance * @car.price_per_km
    end
    
    private
    def days
      ((Time.parse(@end_date) - Time.parse(@start_date))/(60*60*24)+1).to_i
    end

    def get_purcent(day)
      return purcents.last  if day > 9
      return purcents[day]
    end
  end
end
