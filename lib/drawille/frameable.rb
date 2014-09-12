# -*- encoding: utf-8 -*-

module Drawille

  module Frameable

    PIXEL_MAP = [[0x01, 0x08], 
      [0x02, 0x10], 
      [0x04, 0x20], 
      [0x40, 0x80]]

    BRAILLE_CHAR_OFFSET = 0x2800

    def row y, options={}
      chars = options[:chars] || @chars
      row   = chars[y]
      min   = options[:min_x]
      max   = options[:max_x]
      return "" if min.nil? || max.nil?
      (min..max).reduce("") { |memo, i| memo << to_braille(row.nil? ? 0 : row[i] || 0) }
    end

    def rows options={}
      chars = options[:chars] || @chars
      min   = options[:min_y] || [(chars.keys.min || 0), 0].min
      max   = options[:max_y] ||  chars.keys.max
      return [] if min.nil? || max.nil?
      options[:min_x] ||= [chars.reduce([]) { |m,x| m << x.last.keys }.flatten.min, 0].min
      options[:max_x] ||=  chars.reduce([]) { |m,x| m << x.last.keys }.flatten.max
      (min..max).map { |i| row i, options }
    end

    def frame options={}
      rows(options).join("\n")
    end

    def char x, y
      to_braille @chars[y][x]
    end

    def to_braille x
      [BRAILLE_CHAR_OFFSET + x].pack("U*")
    end
  end
end
