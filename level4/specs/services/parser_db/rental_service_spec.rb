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
  let(:purcents) {[0, 0.1, 0.1, 0.1, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.5]}
  let(:price) {0}
  let(:parse_db_service) {ParserDbService.new("../../../data/input.json")}
  let(:id) {params['id']}
  let(:distance) {params['distance']}
  let(:end_date) {params['end_date']}
  let(:start_date) {params['start_date']}
  subject { ParserDb::RentalService.new(params, parse_db_service) }

  describe "#initialize" do
    it "parse_db_service" do
      expect(subject.parse_db_service).to eq(parse_db_service)
    end

    it "car id" do
      expect(subject.car.id).to eq(1)
    end

    it "car price per day" do
      expect(subject.car.price_per_day).to eq(2000)
    end

    it "car price per km" do
      expect(subject.car.price_per_km).to eq(10)
    end

    it "distance" do
      expect(subject.distance).to eq(params['distance'])
    end

    it "end_date" do
      expect(subject.end_date).to eq(params['end_date'])
    end

    it "start date" do
      expect(subject.start_date).to eq(params['start_date'])
    end

    it "price" do
      expect(price).to eq(price)
    end

    it "purcents" do
      expect(purcents).to eq(purcents)
    end
  end

  describe "#call" do
    it "work" do
      subject.call
    end

    it "call equal at " do
      expect(subject.call).to eq({:id=>1, :action=>[{:who=>"driver", :type=>"debit", :amount=>6600}, {:who=>"owner", :type=>"credit", :amount=>4620}, {:who=>"insurance", :type=>"credit", :amount=>990}, {:who=>"assistance", :type=>"credit", :amount=>300}, {:who=>"drivy", :type=>"credit", :amount=>690}]})
    end 
  end

  describe "#count_rental" do
    it "count_rental" do
      expect(subject.count_rental).to eq({:id=>1, :action=>[{:who=>"driver", :type=>"debit", :amount=>6600}, {:who=>"owner", :type=>"credit", :amount=>4620}, {:who=>"insurance", :type=>"credit", :amount=>990}, {:who=>"assistance", :type=>"credit", :amount=>300}, {:who=>"drivy", :type=>"credit", :amount=>690}]})
    end
  end

  describe "price" do
    it "price" do
      expect(subject.price).to eq(5600.0)
    end
  end

  describe "get price" do
    it "get_price" do
      expect(subject.get_price).to eq(6600.0)
    end
  end

  describe "#Private method" do
    describe "#days" do
      let(:days) {subject.send(:days)}
      it "days" do
        expect(days).to eq(3)
      end
    end

    describe "#get_purcent" do
      describe "get_purcent with params 0 day" do
        let(:subject_get_purcent) {subject.send(:get_purcent, 0)}
        it "get_purcent day 0 purcent equal 0" do
          expect(subject_get_purcent).to eq(0)
        end
      end

      describe "get_purcent with params 1 day" do
        let(:subject_get_purcent) {subject.send(:get_purcent, 1)}
        it "get purcent day 1 purcent equal 0.1" do
          expect(subject_get_purcent).to eq(0.1)
        end
      end

      describe "get_purcent with params 2 day" do
        let(:subject_get_purcent) {subject.send(:get_purcent, 2)}
        it "get purcent day 1 purcent equal 0.1" do
          expect(subject_get_purcent).to eq(0.1)
        end
      end

      describe "get_purcent with params 3 day" do
        let(:subject_get_purcent) {subject.send(:get_purcent, 3)}
        it "get purcent day 1 purcent equal 0.1" do
          expect(subject_get_purcent).to eq(0.1)
        end
      end

      describe "get_purcent with params 4 day" do
        let(:subject_get_purcent) {subject.send(:get_purcent, 4)}
        it "get purcent day 1 purcent equal 0.3" do
          expect(subject_get_purcent).to eq(0.3)
        end
      end

      describe "get_purcent with params 5 day" do
        let(:subject_get_purcent) {subject.send(:get_purcent, 5)}
        it "get purcent day 1 purcent equal 0.3" do
          expect(subject_get_purcent).to eq(0.3)
        end
      end

      describe "get_purcent with params 6 day" do
        let(:subject_get_purcent) {subject.send(:get_purcent, 6)}
        it "get purcent day 1 purcent equal 0.3" do
          expect(subject_get_purcent).to eq(0.3)
        end
      end

      describe "get_purcent with params 7 day" do
        let(:subject_get_purcent) {subject.send(:get_purcent, 7)}
        it "get purcent day 1 purcent equal 0.3" do
          expect(subject_get_purcent).to eq(0.3)
        end
      end

      describe "get_purcent with params 8 day" do
        let(:subject_get_purcent) {subject.send(:get_purcent, 8)}
        it "get purcent day 1 purcent equal 0.3" do
          expect(subject_get_purcent).to eq(0.3)
        end
      end

      describe "get_purcent with params 9 day" do
        let(:subject_get_purcent) {subject.send(:get_purcent, 9)}
        it "get purcent day 1 purcent equal 0.3" do
          expect(subject_get_purcent).to eq(0.3)
        end
      end

      describe "get_purcent with params 10 day" do
        let(:subject_get_purcent) {subject.send(:get_purcent, 10)}
        it "get purcent day 1 purcent equal 0.5" do
          expect(subject_get_purcent).to eq(0.5)
        end
      end

      describe "get_purcent with params 11 day" do
        let(:subject_get_purcent) {subject.send(:get_purcent, 11)}
        it "get purcent day 1 purcent equal 0.5" do
          expect(subject_get_purcent).to eq(0.5)
        end
      end

      describe "get_purcent with params 12 day" do
        let(:subject_get_purcent) {subject.send(:get_purcent, 12)}
        it "get purcent day 1 purcent equal 0.5" do
          expect(subject_get_purcent).to eq(0.5)
        end
      end

      describe "get_purcent with params 13 day" do
        let(:subject_get_purcent) {subject.send(:get_purcent, 13)}
        it "get purcent day 1 purcent equal 0.5" do
          expect(subject_get_purcent).to eq(0.5)
        end
      end
    end
  end
end
