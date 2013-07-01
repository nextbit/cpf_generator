require 'spec_helper'
require_relative '../../lib/cpf_generator'

describe "CPF class" do
  it "initialize a cpf class with an array of 9 randon numbers" do
    first_cpf = CpfGenerator::Cpf.new
    first_cpf.numbers.size.should == 9

    second_cpf = CpfGenerator::Cpf.new
    second_cpf.numbers.size.should == 9

    first_cpf.numbers.should_not == second_cpf.numbers
  end

  describe "#first_dv" do
    it "with remainder < 2" do
      cpf = CpfGenerator::Cpf.new
      numbers = [3, 7, 2, 0, 5, 8, 6, 3, 9]
      cpf.numbers = numbers

      cpf.first_dv.should == 1
    end

    it "with remainder >= 2" do
      cpf = CpfGenerator::Cpf.new
      numbers = [2, 1, 1, 6, 3, 0, 7, 8, 9]
      cpf.numbers = numbers

      cpf.first_dv.should == 9
    end
  end

  describe "#second_dv" do
    it "with remainder < 2" do
      cpf = CpfGenerator::Cpf.new
      numbers = [2, 1, 1, 3, 3, 0, 7, 8, 9, 9]
      cpf.numbers = numbers

      cpf.second_dv.should == 0
    end

    it "with remainder >= 2" do
      cpf = CpfGenerator::Cpf.new
      numbers = [1, 7, 2, 0, 5, 8, 6, 3, 9, 0]
      cpf.numbers = numbers

      cpf.second_dv.should == 2
    end
  end

  it "format as 000.000.000-00" do
    cpf = CpfGenerator::Cpf.new
    numbers = [3, 4, 4, 9, 6, 4, 0, 4, 5]
    cpf.numbers = numbers

    cpf.formatted.should == "344.964.045-32"
  end

  it "unformated " do
    cpf = CpfGenerator::Cpf.new
    numbers = [3, 4, 4, 9, 6, 4, 0, 4, 5]
    cpf.numbers = numbers

    cpf.unformatted.should == "34496404532"
  end
end
