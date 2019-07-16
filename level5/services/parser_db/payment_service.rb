module ParserDb
  class PaymentService
    def initialize(rental, assistance)
      @rental = rental
      @assistance = assistance
      @debit_type = 'debit'
      @credit_type = 'credit'
    end

    attr_reader :debit_type, 
      :credit_type, 
      :rental, 
      :assistance, 
      :assistance_credit,
      :insurance_credit,
      :drivy_credit,
      :owner_credit,
      :driver_debit

    def call
      actions = general_card.merge(cart_detail)
      unless actions.nil?
        actions.map do |party, action|
          {
            'who': party.to_s,
            'type': action,
            'amount': eval("assistance.#{party}_#{action}")
          }
        end
      end
    end

    private
    def general_card
      { driver: debit_type, owner: credit_type }
    end

    def cart_detail
      { insurance: credit_type, assistance: credit_type, drivy: credit_type }
    end


  end
end
