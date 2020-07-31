require_relative 'hotel'

class Floor < Hotel
  attr_accessor :hotel, :number, :main_coridors
   
  def initialize(number = 0, hotel)
    @number = number
    @hotel  = hotel
  end

  def max_power_consumption
    sub_coridor_count = main_coridors.map{|coridor| coridor.sub_coridors_count}.sum
    ( main_coridors.count * MainCoridor::MAX_POWER_CONSUMPTION ) + (sub_coridor_count * SubCoridor::MAX_POWER_CONSUMPTION )
  end
  
  def power_consumption
    main_coridors.map{ |coridor| coridor.power_consumption }.sum
  end

  def is_power_consumption_exceeding?
    power_consumption > max_power_consumption
  end

  #Reset electronic equipments if respective coridor is idle for more than 1 minute
  def reset_equipments
    main_coridors.each{ |coridor| coridor.reset_equipments }
  end

  def formatted_euqipment_details
    puts "Floor #{@number}"
    
    main_coridors.each do |coridor|
      coridor.formatted_euqipment_details
      puts "---------------------------------"
    end
  end
end