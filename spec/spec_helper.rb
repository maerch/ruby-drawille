# -*- encoding: utf-8 -*-
require 'drawille'

BRAILLE = %w[⠁ ⠉ ⠋ ⠛ ⠟ ⠿ ⡿ ⣿]

def set_and_check_char px_range, py_range, cx, cy
  i = 0
  py_range.each do |y|
    px_range.each do |x|
      subject.set(x, y)
      expect(subject.char(cx, cy)).to eq BRAILLE[i]
      i += 1
    end
  end
end
