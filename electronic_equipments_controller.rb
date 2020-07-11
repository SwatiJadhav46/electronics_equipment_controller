Dir["./models/*.rb"].each {|file| require_relative file }

class ElectronicEquipmentsController
  attr_accessor :hotel

  def initialize(hotel_name, floor_count, main_coridor_count, sub_coridor_count)
    @hotel        = Hotel.new(hotel_name)
    @hotel.floors = []
    set_floors(floor_count, main_coridor_count, sub_coridor_count)
  end

  #Assumed that, this method will be called on every movement captured
  #along with params as floor number and sub_coridor_number
  def control_equipments(floor_number, sub_coridor_number)
    floor = self.hotel.get_floor(floor_number)
    return if floor.nil?

    floor.main_coridors.each do |main_coridor| 
      @sub_coridor      = main_coridor.get_sub_coridor(sub_coridor_number)
      @idle_sub_coridor = main_coridor.get_idle_sub_coridor(sub_coridor_number) 
      break if @sub_coridor
    end
    
    (self.hotel.reset_equipments and return )if @sub_coridor.nil?

    @sub_coridor.bulb.switch_on!
    @sub_coridor.set_last_operated_at!
    @idle_sub_coridor.ac.switch_off! if floor.is_power_consumption_exceeding?

    self.hotel.reset_equipments
  end

  def formatted_output
    @hotel.floors.each do |floor|
      floor.formatted_euqipment_details
    end
  end

  private

  # Following methods are responsible for setting hotel with floors and coridors

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
