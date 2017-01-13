require_relative './balance_error'
require_relative 'station'
require_relative 'journey'

class Oystercard

  BALANCE_LIMIT = 90
  MINIMUM_CHARGE = 1

  attr_reader :balance, :entry_station, :exit_station, :journey, :journeys
  attr_accessor :journey_history

  def initialize(journeys = Journey.new)
    @journeys = journeys
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

  def touch_in(entry_station=nil)
    fail "Insufficient funds" if balance < MINIMUM_CHARGE
    #@entry_station ? "already touched in"
    @entry_station = entry_station
    journeys.start(entry_station)

  end

  def touch_out(exit_station=nil)
    @exit_station = exit_station
    @journey = {:entry_station => entry_station, :exit_station => exit_station}
    @journey_history << @journey
    deduct(MINIMUM_CHARGE)
    @exit_station = nil
    @entry_station = nil
    #exit_station
  end

  def over_limit?(amount)
    (@balance + amount) > BALANCE_LIMIT
  end


private

  def deduct(amount)
    @balance -= amount
  end

end
