require_relative './electronic_equipments_controller'

class ManageEquipmentController 
  def perform
    puts "************** Welcome to Electronics Equipment Controller **************"
    get_input
    
    return if @hotel_name.empty? || @floor_count.zero? || @main_coridors_count.zero? || @sub_coridors_count.zero?

    @equipment_controller = ElectronicEquipmentsController.new(@hotel_name, @floor_count, @main_coridors_count, @sub_coridors_count)
    puts "Inital Status Of Electronics Equipments :"
    puts "*****************************************"
    @equipment_controller.formatted_output

    count = 0
    while(count < 2)
      movement_captured
      count += 1
    end
  end
  
  def get_input
    puts "Enter hotel name"
    @hotel_name = gets.chomp

    puts "Number of floors:"
    @floor_count = gets.chomp.to_i
  
    puts "Main coridors per floor:"
    @main_coridors_count = gets.chomp.to_i
  
    puts "Sub coridors per floor"
    @sub_coridors_count = gets.chomp.to_i
  end

  #Assuming that this will be behavior of sensor.
  #To give user feel of exceution, asking for inputs
  def movement_captured
    puts "*********************Movement Captured (2 attempts )*********************"
    puts "Enter floor number:"
    floor_number = gets.chomp.to_i
  
    puts "Enter sub coridor number:"
    sub_coridor_number = gets.chomp.to_i
    
    return if floor_number.zero? || sub_coridor_number.zero?
    @equipment_controller.control_equipments(floor_number, sub_coridor_number)
    @equipment_controller.formatted_output
  end
end

ctrl_object = ManageEquipmentController.new
ctrl_object.perform

