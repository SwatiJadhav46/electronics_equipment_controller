Dir["./models/*.rb"].each {|file| require_relative file }

class ElectronicEquipmentsController
  attr_accessor :hotel

  def initialize(hotel_name, floor_count, main_coridor_count, sub_coridor_count)
    @hotel  = Hotel.new(hotel_name)
    @hotel.floors = []
    set_floors(floor_count, main_coridor_count, sub_coridor_count)
  end

  def movement_in_floor(floor_number, sub_coridor_index)
    floor = self.hotel.get_floor(floor_number)

    floor.main_coridors.each do |main_coridor| 
      @sub_coridor      = main_coridor.get_sub_coridor(sub_coridor_index)
      @idle_sub_coridor = main_coridor.get_idle_sub_coridor(sub_coridor_index) 
      break if @sub_coridor
    end

    @sub_coridor.bulb.switch_on!
    @idle_sub_coridor.ac.switch_off! if floor.is_power_consumption_exceeding?
  end

  private

  def set_floors(floor_count, main_coridor_count, sub_coridor_count)
    floor_count.times do |count|
      floor = Floor.new(count + 1, @hotel)
      floor.main_coridors = set_main_coridors(floor, main_coridor_count, sub_coridor_count)
      @hotel.floors << floor
    end
  end

  def set_main_coridors(floor, main_coridor_count, sub_coridor_count)
    result = []

    main_coridor_count.times do |count|
      main_coridor = MainCoridor.new(floor, count + 1)
      main_coridor.sub_coridors = set_sub_coridors(main_coridor, sub_coridor_count)
      result << main_coridor
    end
    
    result
  end

  def set_sub_coridors(main_coridor, sub_coridor_count)
    result = []
    sub_coridor_count.times do |count|
      result << SubCoridor.new(main_coridor, count + 1)
    end

    result
  end
end