module ParserDb
  class OptionService
    def initialize(options)
      @id = options['id']
      @rental_id = options['rental_id']
      @type = options['type']
    end

    attr_accessor :id, :rental_id, :type
  end
end
