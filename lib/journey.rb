class Journey
  MINIMUM_CHARGE = 1
  PENALTY_CHARGE = 6
  attr_reader :entry, :exit, :complete

  def initialize
    @entry = nil
    @exit = nil
    @complete = false
  end

  def start(station)#??
    @complete = false
   (@entry != nil) ? @complete = true : @entry = station#osytercard.entry_station
  end

  def finish(station)
    @exit = station
    @complete = true
  end

  def fare
    valid_journey? ? MINIMUM_CHARGE : PENALTY_CHARGE
  end

  def valid_journey?
    @complete = true && @entry != nil && @exit != nil
  end
end

trip = Journey.new
@trip = trip
