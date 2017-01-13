class Journey
  MINIMUM_CHARGE = 1
  PENALTY_CHARGE = 6
  attr_reader :entry, :exit, :complete

  def initialize
    @entry = nil
    @exit = nil
    @complete = false
  end

  def start(station)

 @entry != nil ?   fail "already touched in" : @entry = station
  end

  def finish(station=nil)
    @exit = station
    entry == nil ? @complete = false : @complete = true
  end

  def fare
    (entry == nil || exit == nil) ? PENALTY_CHARGE : MINIMUM_CHARGE
  end


end
