module ParserDb
  class OptionService
    def initialize(options)
      @id = options['id']
      @rental_id = options['rental_id']
      @type = options['type']
      @available_options = { 
        gps: { cost: 500, to_party: 'owner' },
        baby_seat: { cost: 200, to_party: 'owner' },
        additional_insurance: { cost: 1000, to_party: 'drivy' },
      }
    end

    attr_accessor :id, :rental_id, :type, :available_options
  end
end
