# -*- encoding: utf-8 -*-
require 'spec_helper'

include Drawille

describe Canvas do
  subject(:canvas) { Canvas.new }

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

  describe "#unset" do
    it 'sets and unsets a pixel' do
      canvas.set(0, 0)
      expect(canvas.char(0, 0)).to eq BRAILLE[0]
      canvas.unset(0, 0)
      expect(canvas.char(0, 0)).to eq BRAILLE.last
    end

    it 'sets four pixel but only unsets one' do
      canvas.set(0, 0)
      canvas.set(0, 1)
      canvas.set(1, 0)
      canvas.set(1, 1)
      expect(canvas.char(0, 0)).to eq BRAILLE[3]
      canvas.unset(1, 1)
      expect(canvas.char(0, 0)).to eq BRAILLE[2]
    end
  end

  describe "#get" do
    it 'returns the state of a pixel' do
      canvas.set(1, 1)
      expect(canvas.get(0, 0)).to eq false
      expect(canvas.get(1, 1)).to eq true
    end
  end

  describe "#toggle" do
    it 'toggles a pixel' do
      canvas.toggle(0, 0)
      canvas.toggle(1, 0)
      expect(canvas.char(0, 0)).to eq BRAILLE[1]
      canvas.toggle(1, 0)
      expect(canvas.char(0, 0)).to eq BRAILLE[0]
      canvas.toggle(0, 0)
      expect(canvas.char(0, 0)).to eq BRAILLE.last
    end
  end

  describe "#clear" do
    it 'clears the canvas' do
      canvas.set(0, 0)
      canvas.set(2, 0)
      expect(canvas.char(0, 0)).to eq BRAILLE[0]
      expect(canvas.char(1, 0)).to eq BRAILLE[0]
      canvas.clear
      expect(canvas.char(0, 0)).to eq BRAILLE.last
      expect(canvas.char(1, 0)).to eq BRAILLE.last
    end
  end

  describe '#[]' do
    it 'works with alternate syntax' do
      canvas[0, 0] = true
      expect(canvas.char(0, 0)).to eq BRAILLE[0]
      expect(canvas[0, 0]).to eq true
      expect(canvas[1, 0]).to eq false
      canvas[0, 0] = false
      expect(canvas.char(0, 0)).to eq BRAILLE.last
      expect(canvas[0, 0]).to eq false
    end
  end

  describe "#rows" do
    it 'has over 9 columns and 3 rows' do
      canvas.set(0,  1)
      canvas.set(4,  4)
      canvas.set(8,  5)
      canvas.set(16, 8)

      expect(canvas.rows.size).to eq 3
      canvas.rows.each do |row|
        expect(row.length).to eq 9
      end
    end
  end

  describe "#frame" do
    it 'prints a happy sinus' do
      (0..1800).step(10).each do |x| 
          canvas.set(x/10, 10 + Math.sin(x * Math::PI / 180) * 10) 
      end
      expect(canvas.frame).to eq IO.read("spec/sinus.dat")
    end

    it 'does not throw an exception on an empty canvas' do
      canvas.frame
    end

    it 'is an empty frame for an empty canvas' do
      expect(canvas.rows.size).to eq 0
      expect(canvas.frame).to eq ""
    end
  end
end

describe Brush do
  subject(:canvas) { Canvas.new }
  subject(:brush)  { Brush.new(canvas) }

  describe "#up" do
    it 'is up by default' do
      brush.forward 40
      expect(canvas.rows.size).to eq 0
    end

    it 'does not draw anymore after putting brush up' do
      brush.down
      brush.forward 1
      brush.up
      brush.forward 2
      expect(canvas.rows.size).to eq 1
      expect(canvas.rows[0].size).to eq 1
      expect(canvas.char(0, 0)).to eq BRAILLE[1]
    end
  end

  describe "#down" do
    it "draws if brush is put down" do
      brush.down
      brush.forward 1
      expect(canvas.rows.size).to eq 1
      expect(canvas.rows[0].size).to eq 1
      expect(canvas.char(0, 0)).to eq BRAILLE[1]
    end
  end

  describe "#forward" do
    it 'moves to the right without changing the direction' do
      brush.down
      brush.forward 3
      expect(canvas.rows.size).to eq 1
      expect(canvas.rows[0].size).to eq 2
      expect(canvas.char(0, 0)).to eq BRAILLE[1]
      expect(canvas.char(1, 0)).to eq BRAILLE[1]
    end
  end

  describe "#back" do
    it 'moves backward without drawing' do
      brush.forward 10
      brush.back 10
      expect(canvas.rows.size).to eq 0
    end

    it 'moves backward with drawing' do
      brush.forward 9
      brush.down
      brush.back 9
      expect(canvas.rows.size).to eq 1
      expect(canvas.rows[0].size). to eq 5
      5.times do |i|
        expect(canvas.char(i, 0)).to eq BRAILLE[1]
      end
    end
  end

  describe "#right" do
    it 'changes the direction' do
      brush.down
      brush.forward 1
      brush.right 90
      brush.forward 3
      brush.right 90
      brush.forward 1
      brush.right 90
      brush.forward 3
      expect(canvas.rows.size).to eq 1
      expect(canvas.rows[0].size).to eq 1
      expect(canvas.char(0, 0)).to eq BRAILLE[-2]
    end
  end

  describe "#left" do
    it 'changes the direction' do
      brush.move 0, 3
      brush.down
      brush.down
      brush.forward 1
      brush.left 90
      brush.forward 3
      brush.left 90
      brush.forward 1
      brush.left 90
      brush.forward 3
      expect(canvas.rows.size).to eq 1
      expect(canvas.rows[0].size).to eq 1
      expect(canvas.char(0, 0)).to eq BRAILLE[-2]
    end
  end

  describe "#move" do
    it 'moves and does not draw a line' do
      brush.move 200, 200
      expect(canvas.rows.size).to eq 0
    end

    it 'moves and does draw a line' do
      brush.down
      brush.move 99, 0
      brush.up
      brush.move 99, 4
      brush.down
      brush.move  0, 4
      expect(canvas.rows.size).to eq 2
      expect(canvas.rows[0].size).to eq 50
      50.times do |i|
        expect(canvas.char(i, 0)).to eq BRAILLE[1]
        expect(canvas.char(i, 1)).to eq BRAILLE[1]
      end
    end
  end

  describe "#line" do
    it 'should draw a line regardless of the brush state' do
      brush.line from: [2, 0], to: [5, 0]
      expect(canvas.rows.size).to eq 1
      expect(canvas.char(0, 0)).to eq BRAILLE.last
      expect(canvas.char(1, 0)).to eq BRAILLE[1]
      expect(canvas.char(2, 0)).to eq BRAILLE[1]
    end

    it 'should not draw with the move to the beginning of the line' do
      brush.down
      brush.line from: [2, 0], to: [5, 0]
      expect(canvas.rows.size).to eq 1
      expect(canvas.char(0, 0)).to eq BRAILLE.last
      expect(canvas.char(1, 0)).to eq BRAILLE[1]
      expect(canvas.char(2, 0)).to eq BRAILLE[1]
    end
  end
end

describe FlipBook do
  subject(:canvas)   { Canvas.new }
  subject(:flipbook) { FlipBook.new }

  describe "#each_frame" do
    it 'yields four frames' do
      canvas.set(0, 0)
      flipbook.snapshot canvas
      canvas.set(1, 0)
      flipbook.snapshot canvas
      canvas.set(0, 1)
      flipbook.snapshot canvas
      canvas.set(1, 1)
      flipbook.snapshot canvas

      i = 0
      flipbook.each_frame do |frame|
        expect(frame).to eq BRAILLE[i]
        i += 1
      end
    end

    it 'yields multiline frames' do
      canvas.set(0, 0)
      flipbook.snapshot canvas
      canvas.set(0, 4)
      flipbook.snapshot canvas

      expect(flipbook.rows.size).to eq 2
      expect(flipbook.char(0, 0)).to eq BRAILLE[0]
      expect(flipbook.char(0, 1)).to eq BRAILLE[0]
    end

    it 'yields the same frame twice' do
      canvas.set(0, 0)
      flipbook.snapshot canvas
      canvas.set(1, 0)
      flipbook.snapshot canvas
      2.times do
        i = 0
        flipbook.each_frame do |frame|
          expect(frame).to eq BRAILLE[i]
          i += 1
        end
      end
    end

    it 'returns an enumerator without a block given' do
      canvas.set(0, 0)
      flipbook.snapshot canvas
      canvas.set(1, 0)
      flipbook.snapshot canvas
      flipbook.each_frame.with_index do |frame, i|
        expect(frame).to eq BRAILLE[i]
      end
    end
  end
end
