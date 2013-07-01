require "cpf_generator/version"

module CpfGenerator
  class Cpf
    attr_accessor :numbers

    def initialize
      @numbers = [*0..9].sample(9)
    end

    def first_dv
      value = 0
      down = [10,9,8,7,6,5,4,3,2]
      up = [0,1,2,3,4,5,6,7,8]

      9.times do |n|
        value += @numbers[up[n]].to_i * down[n]
      end

      remainder = (value % 11)
      if remainder < 2
        @numbers << 0
        0
      else
        @numbers << (11 - remainder)
        (11 - remainder)
      end
    end

    def second_dv
      value = 0
      down = [11,10,9,8,7,6,5,4,3,2]
      up = [0,1,2,3,4,5,6,7,8,9]

      10.times do |n|
        value += @numbers[up[n]].to_i * down[n]
      end

      remainder = (value % 11)
      if remainder < 2
        @numbers << 0
        0
      else
        @numbers << (11 - remainder)
        (11 - remainder)
      end
    end

    def formatted
      first_dv
      second_dv
      cpf = @numbers.join("")
      "#{cpf[0..2]}.#{cpf[3..5]}.#{cpf[6..8]}-#{cpf[9..11]}"
    end

    def unformatted
      first_dv
      second_dv
      @numbers.join("")
    end
  end
end
