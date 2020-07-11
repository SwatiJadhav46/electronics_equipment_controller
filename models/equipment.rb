class Equipment
  attr_accessor :status, :volts

  def initialize(status = false, volts)
    @status = status
    @volts  = volts
  end

  def switch_off!
    @status = false
  end

  def switch_on!
    @status = true
  end

  def power_consumption
    status ? volts : 0
  end
end