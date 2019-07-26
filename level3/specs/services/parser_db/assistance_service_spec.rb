require 'json'
require 'time'
require '../../../services/parser_db/assistance_service.rb'
require 'rspec'

RSpec.describe ParserDb::AssistanceService do
  #days = 3
  #price = 6600
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
  end

  describe "#call" do
    let(:amount) {{:insurance_fee=>990, :assistance_fee=>300, :drivy_fee=>690}}
    it "work" do
      subject.call
    end

    it "call eaqual at {:insurance_fee=>990, :assistance_fee=>300, :drivy_fee=>690}" do
      expect(subject.call).to eq(amount)
    end
  end

  describe "#private method" do
    describe "#assisant_amount!" do
      let(:assistant_amount!) {subject.send(:assistant_amount!)}
      let(:result_amount) {{:assistance_fee=>300, :drivy_fee=>690, :insurance_fee=>990}}
      it "assistant_amount!" do
        expect(assistant_amount!).to eq(result_amount)
      end
    end
  end
end
