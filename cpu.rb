require './display'

class Cpu
  NUMBERS = [1, 2, 3, 4, 5, 6]

  include Display

  attr_accessor :sequence
  attr_reader :name

  def initialize(master=false)
    @name = 'Cpu'
    @sequence = Array.new(4) { NUMBERS.sample }
    if master == false
      self.display()
    end
  end
end

class Pins 
  include Display

  attr_accessor :sequence
  attr_reader :name

  def initialize
    @name = 'Pins'
    @sequence = Array.new(0)
  end
end

  
