# -*- encoding: utf-8 -*-
require 'spec_helper'

describe Drawille do
  subject { Drawille::Canvas.new }

  describe '#set' do
    it 'sets pixel in the first char in the first row' do
      set_and_check_char (0..1), (0..3), 0, 0
    end

    it 'sets pixel in the third char in the first row' do
      set_and_check_char (4..5), (0..3), 2, 0
    end

    it 'sets pixel in the second char in the second row' do
      set_and_check_char (2..3), (4..7), 1, 1
    end
  end

  describe "#rows" do
    it 'has over 9 columns and 3 rows' do
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
    it 'prints a happy sinus' do
      (0..1800).step(10).each do |x| 
          subject.set(x/10, 10 + Math.sin(x * Math::PI / 180) * 10) 
      end
      expect(subject.frame).to eq IO.read("spec/sinus.dat")
    end
  end

  describe "#clear" do
    it 'clears the canvas' do
      subject.set(0, 0)
      subject.set(2, 0)
      expect(subject.char(0, 0)).to eq BRAILLE[0]
      expect(subject.char(1, 0)).to eq BRAILLE[0]
      subject.clear
      expect(subject.char(0, 0)).to eq BRAILLE.last
      expect(subject.char(1, 0)).to eq BRAILLE.last
    end
  end

  describe "#unset" do
    it 'sets and unsets a pixel' do
      subject.set(0, 0)
      expect(subject.char(0, 0)).to eq BRAILLE[0]
      subject.unset(0, 0)
      expect(subject.char(0, 0)).to eq BRAILLE.last
    end

    it 'sets four pixel but only unsets one' do
      subject.set(0, 0)
      subject.set(0, 1)
      subject.set(1, 0)
      subject.set(1, 1)
      expect(subject.char(0, 0)).to eq BRAILLE[3]
      subject.unset(1, 1)
      expect(subject.char(0, 0)).to eq BRAILLE[2]
    end
  end

  describe "#toggle" do
    it 'toggles a pixel' do
      subject.toggle(0, 0)
      subject.toggle(1, 0)
      expect(subject.char(0, 0)).to eq BRAILLE[1]
      subject.toggle(1, 0)
      expect(subject.char(0, 0)).to eq BRAILLE[0]
      subject.toggle(0, 0)
      expect(subject.char(0, 0)).to eq BRAILLE.last
    end
  end
end

