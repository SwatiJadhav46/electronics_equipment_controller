require 'minitest/autorun'
require_relative '../models/floor'
require_relative '../models/hotel'

class FloorSpec < Minitest::Test
  def test_floor_creation
    floor = Floor.new(1, Hotel.new('Cafe Goodluck'))
    
    assert_equal floor.number, 1, "You should not save floor without floor number"
    assert floor.hotel.instance_of?(Hotel), "Floor should have valid associated hotel"
    assert_equal floor.hotel.name, 'Cafe Goodluck', "Hotel should have proper name"
  end
end
