require_relative 'main_coridor'

class SubCoridor < MainCoridor
  attr_accessor :main_coridor, :light_status, :ac_status, :index, :last_operated_at

  MAX_POWER_CONSUMPTION = 10

  def initialize(main_coridor, index)
    @main_coridor  = main_coridor
    @bulb          = Bulb.new(false)
    @ac            = AirConditioner.new(true)
    @index         = index
    @last_operated_at = Time.now
  end

  def power_consumption
    bulb.power_consumption + ac.power_consumption
  end

  def set_last_operated_at!
    @last_operated_at = Time.now
  end

  def is_coridor_idle_for_more_than_minute?
    time_diff = ((Time.now - @last_operated_at) / 60.0).to_f
    time_diff > 1
  end

  def reset_subcoridor_equipments
    return unless is_coridor_idle_for_more_than_minute?

    @bulb.switch_off!
    @ac.switch_on!
    set_last_operated_at!
  end
end