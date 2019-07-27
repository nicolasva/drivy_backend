require 'json'
require 'time'
require '../../../services/parser_db/car_service.rb'
require '../../../services/parser_db/rental_service.rb'
require '../../../services/parser_db_service.rb'
require '../../../services/parser_db/assistance_service.rb'
require '../../../services/parser_db/payment_service.rb'
require 'rspec'

RSpec.describe ParserDb::RentalService do
  let(:params) {{ "id" => 1, "car_id" => 1, "start_date" => "2017-12-8", "end_date" => "2017-12-10", "distance" => 100 }}
  let(:parse_db_service) {ParserDbService.new("../../../data/input.json")}
  let(:price) {0}
  let(:purcents) {[0, 0.1, 0.1, 0.1, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.5]}
  let(:id) {params['id']}
  let(:distance) {params['distance']}
  let(:end_date) {params['end_date']}
  let(:start_date) {params['start_date']}
  let(:price_option) {0}
  let(:result_options) {Array.new}
  subject { ParserDb::RentalService.new(params, parse_db_service) }

  describe "#initialize" do
    it "parse_db_service" do
      expect(subject.parse_db_service).to eq(parse_db_service)
    end

    it "purcents" do
      expect(subject.purcents).to eq(purcents)
    end

    it "start_date" do
      expect(subject.start_date).to eq(start_date)
    end

    it "end_date" do
      expect(subject.end_date).to eq(end_date)
    end

    it "distance" do
      expect(subject.distance).to eq(distance)
    end

    it "id" do
      expect(subject.id).to eq(id)
    end
  end

  describe "#call" do
    it "work" do
      subject.call
    end
  end
end
