class Hotel
  attr_accessor :name, :floors

  def initialize(name)
    @name   = name
    @floors = []
  end

  def get_floor(number)
    floors.select{ |floor| floor.number.eql?(number) }[0]
  end

  #Reset electronic equipments if respective coridor is idle for more than 1 minute
  def reset_equipments
    floors.each{ |floor| floor.reset_equipments }
  end
end