module ParserDb
  class AssistanceService

    def initialize(price, duration)
      @commission_percentage = 0.3
      @insurance_commission = 0.5
      @assistance_commission = 100
      @price = price
      @duration = duration
    end

    attr_accessor :price, 
                  :duration
                 
    attr_reader   :commission_percentage, 
                  :insurance_commission, 
                  :assistance_commission

    def call
      assistant_amount!
    end

    def total_commission
      @price * commission_percentage
    end

    def assistance_credit
      (duration * assistance_commission).to_i
    end

    def insurance_credit
      (total_commission * insurance_commission).to_i
    end

    def drivy_credit
      (total_commission - insurance_credit - assistance_credit).to_i
    end

    def owner_credit
      (@price - total_commission).to_i
    end

    def driver_debit
      @price.to_i
    end

    private
    def assistant_amount!

      {insurance_fee: insurance_credit.to_i, assistance_fee: assistance_credit.to_i, drivy_fee: drivy_credit.to_i}
    end
  end
end
