class AssistanceService

  def initialize(price, duration)
    @price = price
    @duration = duration
  end

  attr_accessor :price, :duration 

  def call
    assistant_amount!
  end

  private
  def assistant_amount!
    commission_amount = price * 0.3

    insurance_fee = commission_amount * 0.5
    assistance_fee = duration * 100
    drivy_fee = commission_amount - insurance_fee - assistance_fee

    {insurance_fee: insurance_fee.to_i, assistance_fee: assistance_fee.to_i, drivy_fee: drivy_fee.to_i}
  end
end
