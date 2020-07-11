require_relative 'main_coridor'

class SubCoridor < MainCoridor
  attr_accessor :main_coridor, :light_status, :ac_status, :number, :last_operated_at

  MAX_POWER_CONSUMPTION = 10

  def initialize(main_coridor, number)
    @main_coridor     = main_coridor
    @bulb             = Bulb.new(false)
    @ac               = AirConditioner.new(true)
    @number            = number
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

  #Reset electronic equipments if respective coridor is idle for more than 1 minute
  def reset_subcoridor_equipments
    return unless is_coridor_idle_for_more_than_minute?

    @bulb.switch_off!
    @ac.switch_on!
    set_last_operated_at!
  end

  def formatted_euqipment_details
    puts "Sub Coridor #{@number} Light: #{@bulb.formatted_status}, AC: #{@ac.formatted_status}"
  end
end