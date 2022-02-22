require './display'

class Pins 
  attr_accessor :sequence
  attr_reader :name

  def initialize
    @name = 'Pins'
    @sequence = { red: 0, white: 0 }
  end

  def display
    puts ''
    puts " Red pins = #{@sequence[:red]}"
    puts " White pins = #{@sequence[:white]}"
    puts ''
  end
end
