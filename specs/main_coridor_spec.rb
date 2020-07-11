require 'minitest/autorun'
require_relative '../models/floor'
require_relative '../models/main_coridor'
require_relative '../models/hotel'

class MainCoridorSpec < MiniTest::Test
  def test_main_coridor
    hotel = Hotel.new('Cafe Goodluck')
    floor = Floor.new(0, hotel)
    main_coridor = MainCoridor.new(floor)

    assert main_coridor.floor.instance_of?(Floor), "Main coridor should have valid floor association"
    assert main_coridor.floor.number.zero?, "Main coridor's floor should have valid number"
  end

  def test_default_equipment_state_of_main_coridor
    hotel = Hotel.new('Cafe Goodluck')
    floor = Floor.new(1, hotel)
    main_coridor = MainCoridor.new(floor)
    
    assert_equal main_coridor.bulb.status, true, "Lights of main coridor should always be on"
    assert_equal main_coridor.ac.status, true, "AC of main coridor should always be on"
    assert_equal main_coridor.floor.number, 1, "Invalid floor number"
  end
end