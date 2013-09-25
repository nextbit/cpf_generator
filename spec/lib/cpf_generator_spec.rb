require 'spec_helper'
require_relative '../../lib/cpf_generator'

describe CpfGenerator do

  it "#formatted" do
    CpfGenerator.formatted.should =~ /\d{3}.\d{3}.\d{3}-\d{2}$/
  end

  it "a new formatted cpf always need be generated" do
    CpfGenerator.formatted.should_not == CpfGenerator.formatted
  end

  it "#unformatted" do
    CpfGenerator.unformatted.should match(/\d{11}$/)
  end

  it "a new unformatted cpf always need be generated" do
    CpfGenerator.unformatted.should_not == CpfGenerator.unformatted
  end

  it "#numbers" do
    CpfGenerator.numbers.size.should == 9
  end
end


describe "CPF class" do

  describe "#first_dv" do
    it "with remainder < 2" do
      numbers = [3, 7, 2, 0, 5, 8, 6, 3, 9]
      cpf = CpfGenerator::Cpf.new(numbers)
      cpf.numbers = numbers

      cpf.first_dv.should == 1
    end

    it "with remainder >= 2" do
      numbers = [2, 1, 1, 6, 3, 0, 7, 8, 9]
      cpf = CpfGenerator::Cpf.new(numbers)
      cpf.numbers = numbers

      cpf.first_dv.should == 9
    end
  end

  describe "#second_dv" do
    it "with remainder < 2" do
      numbers = [2, 1, 1, 3, 3, 0, 7, 8, 9, 9]
      cpf = CpfGenerator::Cpf.new(numbers)
      cpf.numbers = numbers

      cpf.second_dv.should == 0
    end

    it "with remainder >= 2" do
      numbers = [1, 7, 2, 0, 5, 8, 6, 3, 9, 0]
      cpf = CpfGenerator::Cpf.new(numbers)
      cpf.numbers = numbers

      cpf.second_dv.should == 2
    end
  end

  it "format as 000.000.000-00" do
    numbers = [3, 4, 4, 9, 6, 4, 0, 4, 5]
    cpf = CpfGenerator::Cpf.new(numbers)
    cpf.numbers = numbers

    cpf.formatted.should == "344.964.045-32"
  end

  it "unformated " do
    numbers = [3, 4, 4, 9, 6, 4, 0, 4, 5]
    cpf = CpfGenerator::Cpf.new(numbers)
    cpf.numbers = numbers

    cpf.unformatted.should == "34496404532"
  end
end
