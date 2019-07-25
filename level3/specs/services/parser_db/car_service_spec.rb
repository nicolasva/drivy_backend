require '../../../services/parser_db/car_service.rb'
require 'rspec'

RSpec.describe ParserDb::CarService do
  describe '#initialize' do
    subject { ParserDb::CarService.new({"id" => 12, "price_per_day" => 45, "price_per_km" => 50}) }
    it "id equal 12" do
      expect(subject.id).to eq(12)
    end

    it "price_per_day equal 45" do
      expect(subject.price_per_day).to eq(45)
    end

    it "price_per_km  equal 50" do
      expect(subject.price_per_km).to eq(50)
    end
  end

end
