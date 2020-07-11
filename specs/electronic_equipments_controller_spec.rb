require 'minitest/autorun'
require_relative '../electronic_equipments_controller'
Dir["../models/*.rb"].each {|file| require_relative file }

describe "Test Electronics Equipment Controller" do
  before do
    @equipment_controller = ElectronicEquipmentsController.new('Cafe Goodluck', 2, 1, 2)
    @hotel   = @equipment_controller.hotel
    @floor_a = @hotel.floors[0]
    @main_coridor_a_one = @floor_a.main_coridors[0]
    @subcoridor_a_one   = @main_coridor_a_one.sub_coridors[0]
    @subcoridor_a_two   = @main_coridor_a_one.sub_coridors[1]

    @floor_b = @hotel.floors[1]
    @main_coridor_b_one = @floor_b.main_coridors[0]
    @subcoridor_b_one   = @main_coridor_b_one.sub_coridors[0]
    @subcoridor_b_two   = @main_coridor_b_one.sub_coridors[1]
  end

  describe "Initial Status of electrical equipments" do
    describe "Floor One" do
      describe "Bulb" do 
        it "of main coridor must be switched on" do
          @main_coridor_a_one.bulb.status.must_equal true
        end

        it "of sub coridor one must be switched off" do
          @subcoridor_a_one.bulb.status.must_equal false
        end

        it "of sub coridor one must be switched off" do
          @subcoridor_a_two.bulb.status.must_equal false
        end
      end

      describe "AC" do 
        it "of main coridor must be switched on" do
          @main_coridor_a_one.ac.status.must_equal true
        end

        it "of sub coridor one must be switched on" do
          @subcoridor_a_one.ac.status.must_equal true
        end

        it "of sub coridor one must be switched on" do
          @subcoridor_a_two.ac.status.must_equal true
        end
      end
    end
    
    describe "Floor Two" do
      describe "Bulb" do 
        it "of main coridor must be switched on" do
          @main_coridor_b_one.bulb.status.must_equal true
        end

        it "of sub coridor one must be switched off" do
          @subcoridor_b_one.bulb.status.must_equal false
        end

        it "of sub coridor one must be switched off" do
          @subcoridor_b_two.bulb.status.must_equal false
        end
      end

      describe "AC" do 
        it "of main coridor must be switched on" do
          @main_coridor_b_one.ac.status.must_equal true
        end

        it "of sub coridor one must be switched on" do
          @subcoridor_b_one.ac.status.must_equal true
        end

        it "of sub coridor one must be switched on" do
          @subcoridor_b_two.ac.status.must_equal true
        end
      end
    end
  end

  describe "If movement found on one of the sub coridors" do
    it "should switch on lights in respective sub coriidor" do
      @equipment_controller.movement_in_floor(1, 2)
      @subcoridor_a_two.bulb.status.must_equal true
    end
  end

  

end