class Journey
  MINIMUM_CHARGE = 1
  PENALTY_CHARGE = 6
  attr_reader :entry, :exit, :complete

  def initialize(station=nil)
    @entry = station
    @exit = nil
    @complete = false
  end

  def finish(station=nil)
    @exit = station
    entry == nil ? @complete = false : @complete = true
  end

  def fare
    (entry == nil || exit == nil) ? PENALTY_CHARGE : MINIMUM_CHARGE
  end


end
