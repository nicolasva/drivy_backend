class AssistanceService

  def initialize(price, duration, result_options, price_option = 0)
    @commission_percentage = 0.3
    @insurance_commission = 0.5
    @assistance_commission = 100
    @price = price
    @duration = duration
    @price_option = price_option
    @result_options = result_options
  end

  attr_accessor :price, 
                :duration
               
  attr_reader   :commission_percentage, 
                :insurance_commission, 
                :assistance_commission,
                :price_option

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
    amount = (total_commission - insurance_credit - assistance_credit).to_i
    return amount if @result_options.empty?
    
    return extra_for - amount if @result_options.include?("gps")
    return extra_for - amount if @result_options.include?("baby_seat")
    return extra_for + amount
  end

  def extra_for
    price_option * duration
  end

  def owner_credit
    amount = (@price - total_commission).to_i
    amount = (amount + extra_for).to_i  if @result_options.include?("gps") || @result_options.include?("baby_seat") 
    
    return amount 
  end

  def driver_debit
    @price.to_i + price_option * duration
  end

  private
  def assistant_amount!

    {insurance_fee: insurance_credit.to_i, assistance_fee: assistance_credit.to_i, drivy_fee: drivy_credit.to_i}
  end
end
