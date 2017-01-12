require 'station'

describe Station do
  subject(:station) {described_class.new("Bank", 1)}
  it "knows it's name" do
    expect(station.name).to eq("Bank")
  end
  it "know's it's zone" do
    expect(subject.zone).to eq(1)
  end

end
