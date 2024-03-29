module ParserDb
  class RentalService
    def initialize(params, parse_db_service)
      @parse_db_service = parse_db_service
      @car = @parse_db_service.find_by('get_cars!', params['car_id'])
      @options = @parse_db_service.find_by_rental_id('get_options!', params['id'])
      @params = params
      @id = params['id']
      @distance = params['distance']
      @end_date = params['end_date']
      @start_date = params['start_date']
      @purcents = [0, 0.1, 0.1, 0.1, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.5]
      @price = 0
      @price_option = 0
      @result_options = Array.new
    end
    attr_accessor :params, 
                  :car, 
                  :parse_db_service, 
                  :id, 
                  :distance, 
                  :end_date, 
                  :start_date
                  :assistance
                  :options
                  :price_option
                  :result_options

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
      price
      return {id:      params['id'],
              options: options,
              action:  ParserDb::PaymentService.new(self, ParserDb::AssistanceService.new(get_price, days, @result_options, @price_option)).call
             }
    end

    def options
      @result_options = Array.new
      return @result_options if @options.empty?
      @options.each do |option|
        if option.rental_id == @id
          @price_option +=  option.available_options[option.type.to_sym][:cost]
          @result_options.push(option.type)
        end
      end
      return @result_options
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
