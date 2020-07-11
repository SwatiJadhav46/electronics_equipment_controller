require_relative 'equipment.rb'

class Bulb < Equipment
  MAX_POWER_CONSUMPTION = 5

  def initialize(status)
    super(status, MAX_POWER_CONSUMPTION)
  end
end