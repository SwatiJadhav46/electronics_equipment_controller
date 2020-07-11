require_relative 'main_coridor'

class SubCoridor < MainCoridor
  attr_accessor :main_coridor, :light_status, :ac_status, :index

  MAX_POWER_CONSUMPTION = 10

  def initialize(main_coridor, index)
    @main_coridor = main_coridor
    @bulb         = Bulb.new(false)
    @ac           = AirConditioner.new(true)
    @index        = index
  end

  def power_consumption
    bulb.power_consumption + ac.power_consumption
  end
end