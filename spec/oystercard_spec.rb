
require 'oystercard'


describe Oystercard do

  subject(:oystercard){described_class.new(journeys)}
  let(:entry_station) { double :entry_station }
  let(:exit_station) {double :exit_station}
  let(:journey_log) { {:entry_station => entry_station, :exit_station => exit_station} }
  let(:journey) { double :journey }
  let(:trip) { double :trip }
  let(:journeys) { double :journeys, start: entry_station }

  it "should send the start journey message" do
    oystercard.top_up(10)
    oystercard.touch_in(entry_station)
    expect(journeys).to have_received(:start).with(entry_station)
  end

    it 'Shows initial balance of zero' do
      expect(oystercard.balance).to eq(0)
    end

    it "checks if balance is less than minimum limit" do
      expect{oystercard.touch_in(entry_station)}.to raise_error "Insufficient funds"
    end

    it 'initializes with a blank journey history' do
      expect(oystercard.journey_history).to eq []
    end

      context 'it has a full balance' do
        before{oystercard.top_up(Oystercard::BALANCE_LIMIT)}

            it "won't let you top up over the balance limit" do
              expect{ oystercard.top_up(1)}.to raise_error "Maximum balance of #{Oystercard::BALANCE_LIMIT} exceeded"
            end

              describe "state of journey" do

              it '"touch in" writes an entry station' do
                oystercard.touch_in(entry_station)
                expect(oystercard.entry_station).to eq(entry_station)
              end

              it '"touch_out" sets exit station to nil' do
                oystercard.touch_in(entry_station)
                oystercard.touch_out
                expect(oystercard.entry_station).to eq nil
              end

              it 'does in_journey? become true when touch_in' do
                oystercard.touch_in(entry_station)
                expect(oystercard.in_journey?).to eq true
              end

              it 'does in_journey? become false when touch_out' do
                oystercard.touch_in(entry_station)
                oystercard.touch_out
                expect(oystercard.in_journey?).to eq false
              end

              it 'records a journey on touch_out' do
                oystercard.touch_in(entry_station)
                oystercard.touch_out(exit_station)
                expect(oystercard.journey).to include journey_log
              end

              it 'reverts exit station to nil on touch_out' do
                oystercard.touch_in(entry_station)
                oystercard.touch_out(exit_station)
                expect(oystercard.exit_station).to eq nil
              end
          end
        end

      it 'reduces minimum fare from balance when touching out' do
        expect{ oystercard.touch_out }.to change{ oystercard.balance }.by(-Oystercard::MINIMUM_CHARGE)
      end
end
