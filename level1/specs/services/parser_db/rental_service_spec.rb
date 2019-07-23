require 'json'
require 'time'
require '../../../services/parser_db/car_service.rb'
require '../../../services/parser_db/rental_service.rb'
require '../../../services/parser_db_service.rb'
require 'rspec'

RSpec.describe ParserDb::RentalService do
  let(:params) {{ "id" => 1, "car_id" => 1, "start_date" => "2017-12-8", "end_date" => "2017-12-10", "distance" => 100 }}
  let(:parse_db_service) {ParserDbService.new("../../../data/input.json")}
  describe '#initialize' do
    subject { ParserDb::RentalService.new(params, parse_db_service) }
    it "parse_db_service" do
      expect(subject.parse_db_service).to eq(parse_db_service)
    end


    it "car id" do
      #expect(parse_db_service).to receive(:find_by).with('get_cars!', params['car_id'])
      
      expect(subject.car.id).to eq(1)
    end

    it "car price_per_day" do
      expect(subject.car.price_per_day).to eq(2000)
    end

    it "car price_per_km" do
      expect(subject.car.price_per_km).to eq(10)
    end
  end

  describe "#call" do
    subject { ParserDb::RentalService.new(params, parse_db_service) }
    it "work" do
      subject.call
    end

    it "call equal at {:id=>1, :price=>7000}" do
      expect(subject.call).to eq({:id=>1, :price=>7000})
    end
  end

  describe "price" do
    subject { ParserDb::RentalService.new(params, parse_db_service) }
    let(:price) {((Time.parse(params['end_date']) - Time.parse(params['start_date']))/(60*60*24)+1) * subject.car.price_per_day + params['distance'] * subject.car.price_per_km}
    let(:subject_price) {subject.send(:price)}
    it "price" do
      expect(subject_price).to eq(price)
    end
  end
end
