module MasterMind
  @@count = 0

  def compare(maker, breaker)
    sequence = [' ', ' ', ' ', ' ']
    if @@count == 12
      puts "You lose"
      exit
    end
    maker.each_with_index do |maker_color, maker_idx|
      breaker.each_with_index do |breaker_color, breaker_idx|
        if sequence[breaker_idx] == ' '
          if maker_color == breaker_color && maker_idx == breaker_idx
            sequence[maker_idx] = 1
            break
          elsif maker_color == breaker_color
            sequence[breaker_idx] = 0
            break
          end
        elsif sequence[breaker_idx] == 0
          if maker_color == breaker_color && maker_idx == breaker_idx
            sequence[maker_idx] = 1
          end
        end
      end
    end
    @@count += 1
    display(sequence)
    sequence
  end

  private

  def display(sequence)
    puts ""
    puts " Results"
    puts " #{sequence[0]} | #{sequence[1]} | #{sequence[2]} | #{sequence[3]}"
    puts ""
  end 
end

class Players
  COLORS = ['red', 'blue', 'white', 'yellow', 'green', 'purple']

  include MasterMind

  attr_reader :name, :sequence

  def initialize(name)
    @name = name
    @sequence
  end

  def populate
    if @name == 'Cpu'
      @sequence = Array.new(4) { COLORS.sample }
    else 
      @sequence = 
        Array.new(4) do
          puts "Choose color between #{COLORS.join(", ")}"
          gets.chomp
        end
      self.display
      @sequence
    end
  end

  private

  def display
    puts ""
    puts " Your sequence"
    puts " #{self.sequence[0]} | #{self.sequence[1]} | #{self.sequence[2]} | #{self.sequence[3]}"
    puts ""
  end
end

cpu = Players.new('Cpu')
human = Players.new('Human')

include MasterMind

def game (maker, breaker)
  breaker_sequence = breaker.populate
  sequence = compare(maker, breaker_sequence)
  if sequence == [1, 1, 1, 1]
    puts "You win!"
    return
  else 
    game(maker, breaker)
  end
end

game(cpu.populate, human)
