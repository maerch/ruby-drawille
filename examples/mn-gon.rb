require 'drawille'

c = Drawille::Canvas.new

frame = c.paint do
  move 0, 0
  down

  36.times do
    right 10
    36.times do
      right 10
      forward 8
    end
  end

end.frame

puts frame
