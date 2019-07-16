module ParserDb
  class CarService
    
    def initialize(params)
      @id = params['id']
      @price_per_day = params['price_per_day']
      @price_per_km = params['price_per_km']
    end

    attr_accessor :id, :price_per_day, :price_per_km
  end
end
