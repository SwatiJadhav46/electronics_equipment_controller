require_relative 'equipment.rb'

class AirConditioner < Equipment
  MAX_POWER_CONSUMPTION = 10

  def initialize(status)
    super(status, MAX_POWER_CONSUMPTION) 
  end  
end