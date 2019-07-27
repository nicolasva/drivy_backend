require 'json'
require 'time'
require '../../../services/parser_db/car_service.rb'
require '../../../services/parser_db_service.rb'
require '../../../services/parser_db/rental_service.rb'
require '../../../services/parser_db/payment_service.rb'
require '../../../services/parser_db/assistance_service.rb'
require 'rspec'

RSpec.describe ParserDb::PaymentService do
  let(:params) {{ "id" => 1, "car_id" => 1, "start_date" => "2017-12-8", "end_date" => "2017-12-10", "distance" => 100 }}
  let(:parse_db_service) {ParserDbService.new("../../../data/input.json")}
  let(:rental) {ParserDb::RentalService.new(params, parse_db_service)}
  let(:get_price) {rental.get_price}
  let(:days) {rental.send(:days)}
  let(:assistance) {ParserDb::AssistanceService.new(get_price, days)}
  let(:debit_type) {'debit'}
  let(:credit_type) {'credit'}
  subject { ParserDb::PaymentService.new(rental, assistance) }


  describe "#initialize" do
    it "debit_type" do
      expect(subject.debit_type).to eq(debit_type)
    end

    it "credit_type" do
      expect(subject.credit_type).to eq(credit_type)
    end

    it "assistance" do
      expect(subject.rental).to eq(rental)
    end

    it "rental" do
      expect(subject.assistance).to eq(assistance)
    end
  end

  describe "#call" do
    it "work" do
      subject.call
    end

    let(:result_call) {[{:who=>"driver", :type=>"debit", :amount=>6600}, {:who=>"owner", :type=>"credit", :amount=>4620}, {:who=>"insurance", :type=>"credit", :amount=>990}, {:who=>"assistance", :type=>"credit", :amount=>300}, {:who=>"drivy", :type=>"credit", :amount=>690}]}
    it "call equal at" do
      expect(subject.call).to eq(result_call)
    end
  end

  describe "#Privayte method" do
    describe "#general_card" do
      let(:general_card) {subject.send(:general_card)}
      let(:result_general_card) {{:driver=>"debit", :owner=>"credit"}}
      it "general cardi equal at " do
        expect(general_card).to eq(result_general_card)
      end
    end

    describe "#cart_detail" do
      let(:cart_detail) {subject.send(:cart_detail)}
      let(:result_cart_detail) {{:insurance=>"credit", :assistance=>"credit", :drivy=>"credit"}}
      it "cart_detail equal at" do
        expect(cart_detail).to eq(result_cart_detail)
      end
    end
  end
end
