require './display.rb'

class Player
  include Display

  attr_accessor :sequence
  attr_reader :name

  def initialize(master=false)
    @name = 'Player'
    puts "Choose four numbers between 1-6, duplicate possible"
    @sequence = gets.chomp.split('').map(&:to_i)
    until @sequence.length == 4 && @sequence.all? { |v| v > 0 && v < 7 } do
      puts "Please choose four numbers between 1-6"
      initialize()
    end
    if master == false
      self.display()
    end
  end
end
