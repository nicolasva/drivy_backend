require 'json'
require 'time'
require '../../../services/parser_db/assistance_service.rb'
require 'rspec'

RSpec.describe ParserDb::AssistanceService do
  let(:commission_percentage) {0.3}
  let(:insurance_commission) {0.5}
  let(:assistance_commission) {100}
  let(:duration) {3}
  let(:price) {6600}
  subject { ParserDb::AssistanceService.new(price, duration) }

  describe '#initialize' do
    it "price" do
      expect(subject.price).to eq(price)
    end

    it "duration" do
      expect(subject.duration).to eq(duration)
    end

    it "assistance_commission" do
      expect(subject.assistance_commission).to eq(assistance_commission)
    end

    it "insurance_commission" do
      expect(subject.insurance_commission).to eq(insurance_commission)
    end

    it "assistance_commission" do
      expect(subject.assistance_commission).to eq(assistance_commission)
    end
  end

  describe "#call" do
    let(:amount) {{:insurance_fee=>990, :assistance_fee=>300, :drivy_fee=>690}}
    
    it "work" do
      subject.call
    end

    it "call equal at {:insurance_fee=>990, :assistance_fee=>300, :drivy_fee=>690}" do
      expect(subject.call).to eq(amount)
    end
  end

  describe "#total_commission" do
    it "total_commission equal 1980.0" do
      expect(subject.total_commission).to eq(1980.0)
    end
  end

  describe "#assistance_credit" do
    it "assistance_credit equal" do
      expect(subject.assistance_credit).to eq(300)
    end
  end

  describe "#insurance_credit" do
    it "insurance_credit" do
      expect(subject.insurance_credit).to eq(990)
    end
  end

  describe "#drivy_credit" do
    it "drivy_credit" do
      expect(subject.drivy_credit).to eq(690)
    end
  end

  describe "#owner_credit" do
    it "owner_credit" do
      expect(subject.owner_credit).to eq(4620)
    end
  end

  describe "#driver_debit" do
    it "driver_debit" do
      expect(subject.driver_debit).to eq(6600)
    end
  end

  describe "#private method" do
    describe "#assistant_amount!" do
      let(:assistant_amount!) {subject.send(:assistant_amount!)}
      let(:result_amount) {{:insurance_fee=>990, :assistance_fee=>300, :drivy_fee=>690}}
      it "assistant_amount!" do
        expect(assistant_amount!).to eq(result_amount)
      end
    end
  end
end
