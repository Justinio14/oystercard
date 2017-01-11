require_relative './balance_error'

class Oystercard

  BALANCE_LIMIT = 90
  MINIMUM_CHARGE = 1

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    fail "Maximum balance of #{BALANCE_LIMIT} exceeded" if over_limit?(amount)
    @balance += amount
  end

  def in_journey?

  @entry_station == nil ? false : true

  end

  def touch_in(station)
    fail "Insufficient funds" if balance < MINIMUM_CHARGE
    @entry_station = station

  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @entry_station = nil
  end

  def over_limit?(amount)
    (@balance + amount) > BALANCE_LIMIT
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
