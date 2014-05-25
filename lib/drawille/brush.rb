# -*- encoding: utf-8 -*-

module Drawille

  class Brush

    attr_accessor :canvas

    def initialize canvas
      @canvas = canvas
      @state  = {
        x:        0, 
        y:        0,
        up:       true,
        rotation: 0
      }
    end

    def down
      @state[:up] = false
    end

    def up
      @state[:up] = true
    end

    def forward length
      theta = ((@state[:rotation]) / 180.0 * Math::PI)
      x     = (@state[:x] + length * Math::cos(theta)).round
      y     = (@state[:y] + length * Math::sin(theta)).round

      move x, y
    end

    def back length
      forward -length
    end

    def right angle
      @state[:rotation] += angle
    end

    def left angle
      @state[:rotation] -= angle
    end

    def move x, y
      unless @state[:up]
        x1 = @state[:x].round
        y1 = @state[:y].round
        x2 = x
        y2 = y

        xdiff = [x1, x2].max - [x1, x2].min
        ydiff = [y1, y2].max - [y1, y2].min

        xdir = x1 <= x2 ? 1 : -1
        ydir = y1 <= y2 ? 1 : -1

        r = [xdiff, ydiff].max

        (0..r).each do |i|
          x, y = x1, y1
          y += (i.to_f*ydiff)/r*ydir if ydiff > 0
          x += (i.to_f*xdiff)/r*xdir if xdiff > 0
          @canvas.set(x, y)
        end
      end
      @state[:x], @state[:y] = x, y
    end

    def line coordinates={}
      last_state = @state[:up]

      up
      move *coordinates[:from]
      down
      move *coordinates[:to]

      @state[:up] = last_state
    end

    alias_method :fd, :forward
    alias_method :bk, :back
    alias_method :rt, :right
    alias_method :lt, :left
    alias_method :pu, :up
    alias_method :pd, :down
    alias_method :mv, :move
  end
end
