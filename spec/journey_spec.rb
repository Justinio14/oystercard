require 'journey'

describe Journey do

  subject(:journey) {described_class.new}
  let(:station) { double :station }


    it "Initialises journey with an entry station" do
      expect(journey.entry).to eq nil
    end

   it "checks journey is complete" do
     journey = Journey.new(station)
     journey.finish(station)
     expect(journey.complete).to eq true
   end

   it "checks journey is incomplete if no entry station" do
     journey.finish(station)
     expect(journey.complete).to eq false
   end

   it "checks journey is incomplete if no exit station" do
     journey = Journey.new(station)
     expect(journey.complete).to eq false
   end

end
