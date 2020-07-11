require 'minitest/autorun'
Dir["../models/*.rb"].each {|file| require_relative file }

class SubCoridorSpec < MiniTest::Test
  def test_sub_coridor
    hotel = Hotel.new('Cafe Goodluck')
    floor = Floor.new(0, hotel)
    main_coridor = MainCoridor.new(floor)
    sub_coridor  = SubCoridor.new(main_coridor)
    
    assert sub_coridor.main_coridor.instance_of?(MainCoridor), "Sub coridor should have valid assocaition with main coridor"
  end

  def test_default_equipment_state_of_sub_coridor
    hotel = Hotel.new('Cafe Goodluck')
    floor = Floor.new(0, hotel)
    main_coridor = MainCoridor.new(floor)
    sub_coridor  = SubCoridor.new(main_coridor)

    assert_equal sub_coridor.bulb.status, false, "Lights on sub coridor should be off at first place"
    assert_equal sub_coridor.ac.status, true, "AC on sub coridor should always be on"
  end
end