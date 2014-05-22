# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Drawille do
  subject { Drawille::Canvas.new }

  describe '#set' do

    it 'sets the first char in the first row' do
      set_and_check_char (0..1), (0..3), 0, 0
    end

    it 'sets the third char in the first row' do
      set_and_check_char (4..5), (0..3), 2, 0
    end

    it 'sets the second char in the second row' do
      set_and_check_char (2..3), (4..7), 1, 1
    end

  end

  describe "#rows" do

    it 'should over 9 columns and 3 rows' do

      subject.set(0,  1)
      subject.set(4,  4)
      subject.set(8,  5)
      subject.set(16, 8)

      expect(subject.rows.size).to eq 3
      subject.rows.each do |row|
        expect(row.length).to eq 9
      end

    end

  end

  describe "#frame" do

    it 'should print a happy sinus' do
      (0..1800).step(10).each do |x| 
          subject.set(x/10, 10 + Math.sin(x * Math::PI / 180) * 10) 
      end

      expect(subject.frame).to eq IO.read("spec/sinus.dat")
    end

  end

end

