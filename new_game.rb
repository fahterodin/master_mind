require './player'
require './cpu'
require './pins'

class Game
  @@count = 0

  def initialize
    puts 'Who will be the master? 1 for Cpu, 2 for Player'
    @master = gets.to_i
    case @master
    when 1
      @name = 'Cpu'
      @code = Cpu.new(true).sequence
      play
    when 2
      @name = 'Player'
      @code = Player.new(true).sequence
      play
    else
      puts 'Please pick 1 or 2'
      initialize
    end
  end

  private

  def round(pins)
    master = @code.dup
    case @name
    when 'Cpu'
      breaker = Player.new.sequence
    when 'Player'
      b = Cpu.new(false, pins)
      breaker = b.sequence.dup
    end
    pins = Pins.new
    i = 3

    until i == -1
      if breaker[i] == master[i]
        pins.sequence[:red] += 1
        master.delete_at(i)
        breaker.delete_at(i)
      end
      i -= 1
    end

    breaker.each do |v|
      i = master.index(v)
      unless i.nil?
        pins.sequence[:white] += 1
        master.delete_at(i)
      end
    end

    if pins.sequence[:red] == 4
      puts 'Breaker wins!'
      exit
    end
    pins.display

    if @name == 'Player'
      puts "Cpu is thinking..."
      sleep 3
    end
    pins.sequence
  end

  def play(pins = 0)
    if @@count == 12
      puts 'Masters wins!'
      puts ''
      puts " The #{@name}'s secret code was:"
      puts " #{@code[0]} | #{@code[1]} | #{@code[2]} | #{@code[3]}"
      puts ''
      exit
    end
    @@count += 1
    play(round(pins))
  end
end

Game.new
