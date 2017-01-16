require 'journey'

describe Journey do

  subject(:journey) {described_class.new}
  let(:station) { double :station}
  let(:oystercard) { double :oystercard, touch_in: starting}
  let(:starting) { "Bank"}

    it {is_expected.to respond_to(:start).with(1).argument}


    it "Initialises journey with an entry station" do
      sojourn = journey.start("Bank")
      expect(sojourn).to eq(starting)
    end



   it "checks journey is complete" do
     journey.start(station)
     journey.finish(station)
     expect(journey.complete).to eq true
   end

  #  it "checks journey is incomplete if no entry station" do
  #    journey.finish(station)
  #    expect(journey.complete).to eq false
  #  end


   it "checks journey is incomplete if no exit station" do
     expect(journey.complete).to eq false
   end

   it "charges a penalty fare for two consecutive touch ins" do
     2.times {journey.start(station)}
     expect(journey.fare).to eq Journey::PENALTY_CHARGE
   end

   it "charges a penalty fare for a touch out with no touch in" do
     journey.finish(station)
     expect(journey.fare).to eq Journey::PENALTY_CHARGE
   end

   it "charges the minimum fare when a journey starts and finishes properly" do
     journey.start(station)
     journey.finish(station)
     expect(journey.fare).to eq Journey::MINIMUM_CHARGE
   end

end
