require 'journey'

describe Journey do
  let(:station) {Station.new("test", 1)}
  subject(:journey) {described_class.new}
  
  it "Initialises journey with an entry station" do
    expect(journey.entry).to eq nil
  end


end
