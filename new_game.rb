require './player.rb'
require './cpu.rb'

class Game
  include Display

  @@count = 0

  def initialize
    puts "Who will be the master? 1 for Cpu, 2 for Player"
    @master = gets.to_i
    if @master == 1
      @name = 'Cpu'
      @code = Cpu.new(true).sequence
      play()
    elsif @master == 2
      @name = 'Player'
      @code = Player.new(true).sequence
    else 
      puts "Please pick 1 or 2"
      initialize()
    end
  end
  #cpu is master
  def round
    pins = Pins.new
    master = @code.dup
    breaker = Player.new().sequence
    i = 3

    until i == -1
      if breaker[i] == master[i]
        pins.sequence << 'R'
        master.delete_at(i)
        breaker.delete_at(i)
      end
      i -= 1
    end 

    breaker.each_with_index do |v, v_idx|
      i = master.index(v)
      if i != nil
        pins.sequence << 'W'
        master.delete_at(i)
      end
    end
    pins.display

    if pins.sequence == ['R', 'R', 'R', 'R']
      puts "Breaker wins!"
      exit
    end
  end

  def play
    if @@count == 12
      puts "Masters wins!" 
      exit
    end
    round()
    @@count += 1
    play()
  end
end

game = Game.new
    