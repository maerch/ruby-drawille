# -*- encoding: utf-8 -*-
module Drawille

  class Canvas
    include Frameable

    attr_reader :chars

    def initialize 
      clear
      @snapshots = [{}]
    end

    def paint &block
      Brush.new(self).instance_eval(&block)
      self
    end

    def clear
      @chars = Hash.new { |h,v| h[v] = Hash.new(0) }
    end

    def set x, y
      x, y, px, py = convert x, y
      @chars[py][px] |= PIXEL_MAP[y % 4][x % 2]
    end

    def unset x, y
      x, y, px, py = convert x, y
      @chars[py][px] &= ~PIXEL_MAP[y % 4][x % 2]
    end

    def get x, y
      x, y, px, py = convert x, y
      @chars[py][px] & PIXEL_MAP[y % 4][x % 2] != 0
    end

    def []= x, y, bool
      bool ? set(x, y) : unset(x, y)
    end

    alias_method :[], :get

    def toggle x, y
      x, y, px, py = convert x, y
      @chars[py][px] & PIXEL_MAP[y % 4][x % 2] == 0 ? set(x, y) : unset(x, y) 
    end

    def convert x, y
      x = x.round
      y = y.round
      [x, y, (x / 2).floor, (y / 4).floor]
    end
  end
end
