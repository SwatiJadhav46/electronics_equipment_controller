require_relative 'floor'
require_relative 'bulb'
require_relative 'air_conditioner'

class MainCoridor < Floor
  attr_accessor :floor, :bulb, :ac, :sub_coridors, :number

  MAX_POWER_CONSUMPTION = 15

  def initialize(floor, number)
    @floor = floor
    @bulb  = Bulb.new(true)
    @ac    = AirConditioner.new(true)
    @number = number
  end

  def get_sub_coridor(sub_coridor_number)
    sub_coridors.select{ |coridor| coridor.number.eql?(sub_coridor_number) }[0]
  end

  def get_idle_sub_coridor(active_sub_coridor_number)
    sub_coridors.select{ |coridor| !coridor.number.eql?(active_sub_coridor_number) }[0]
  end

  def sub_coridors_count
    sub_coridors.count
  end

  def power_consumption
    bulb.power_consumption + ac.power_consumption + sub_coridor_power_consumption
  end
  
  def sub_coridor_power_consumption
    sub_coridors.map{ |coridor| coridor.power_consumption }.sum
  end

  #Reset electronic equipments if respective coridor is idle for more than 1 minute
  def reset_equipments
    sub_coridors.each{ |coridor| coridor.reset_subcoridor_equipments }
  end

  def formatted_euqipment_details
    puts "Main Coridor #{@number} Light: #{@bulb.formatted_status}, AC: #{@ac.formatted_status}"

    sub_coridors.each do |coridor|
      coridor.formatted_euqipment_details
    end
  end
end