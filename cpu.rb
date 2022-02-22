require './display'

class Cpu
  NUMBERS = [1, 2, 3, 4, 5, 6]
  @@permutations = {}
  @@breaker_stored = []
  # use @@combinations.delete(x) to delete something from it

  include Display

  attr_accessor :sequence
  attr_reader :name

  def initialize(master=false, pins_stored = 0)
    @name = 'Cpu'
    @sequence = Array.new(4) { NUMBERS.sample } if master == true
    if master == false
      @sequence = cpu_logic(pins_stored)
      display
    end
  end

  private

  def cpu_logic(pins_stored)
    if pins_stored.class != Hash
      NUMBERS.repeated_permutation(4) { |e| @@permutations[e] = { red: 0, white: 0 } }
      return @@breaker_stored = [1, 1, 2, 2]
    end
    find_code(pins_stored)
    @@breaker_stored = @@permutations.keys[0]
  end

  def find_code(pins_stored)
    breaker_permutations = Marshal.load(Marshal.dump(@@permutations))
    # compare our breaker with the permutations
    breaker_permutations.each do |breaker, pins|
      master = @@breaker_stored.dup
      i = 3

      until i == -1
        if breaker[i] == master[i]
          pins[:red] += 1
          breaker.delete_at(i)
          master.delete_at(i)
        end
        i -= 1
      end

      breaker.each do |v|
        j = master.index(v)
        unless j.nil?
          pins[:white] += 1
          master.delete_at(j)
        end
      end
    end
    # set pins finded in every permutations
    breaker_permutations.each_with_index {|(_keys, pins), idx| @@permutations[@@permutations.keys[idx]] = pins}
    # iterate through @@permutations and delete all combinations that doesnt match pins_stored
    @@permutations.reverse_each {|breaker, pins| @@permutations.delete(breaker) unless pins == pins_stored}
    # set all pins of @@permutations to default
    @@permutations.each do |_breaker, pins| 
      pins[:red] = 0
      pins[:white] = 0
    end
    @@permutations
  end
end
