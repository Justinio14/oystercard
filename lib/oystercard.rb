require_relative './balance_error'

class Oystercard

  BALANCE_LIMIT = 90
  MINIMUM_CHARGE = 1

  attr_reader :balance, :entry_station, :exit_station, :journey
  attr_accessor :journey_history

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journey_history = []
  end

  def top_up(amount)
    fail "Maximum balance of #{BALANCE_LIMIT} exceeded" if over_limit?(amount)
    @balance += amount
  end

  def in_journey?

  @entry_station == nil ? false : true

  end

  def touch_in(station=nil)
    fail "Insufficient funds" if balance < MINIMUM_CHARGE
    @entry_station = station

  end

  def touch_out(exit_station=nil)
    @exit_station = exit_station
    @journey = {entry_station => exit_station}
    @journey_history << @journey
    deduct(MINIMUM_CHARGE)
    @exit_station = nil
    @entry_station = nil
    exit_station
  end

  def over_limit?(amount)
    (@balance + amount) > BALANCE_LIMIT
  end


private

  def deduct(amount)
    @balance -= amount
  end

end
