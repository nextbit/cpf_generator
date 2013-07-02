require "cpf_generator/version"

module CpfGenerator
  class Cpf
    attr_accessor :numbers

    def initialize
      @numbers = [*0..9].sample(9)
    end

    def first_dv
      value = 0
      multipliers = [10,9,8,7,6,5,4,3,2]

      multipliers.each_with_index do |mult, index|
        value += @numbers[index] * mult
      end

      check_remainder(value % 11)
    end

    def second_dv
      value = 0
      multipliers = [11,10,9,8,7,6,5,4,3,2]

      multipliers.each_with_index do |mult, index|
        value += @numbers[index] * mult
      end

      check_remainder(value % 11)
    end

    def check_remainder(remainder)
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
