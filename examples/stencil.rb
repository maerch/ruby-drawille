require 'drawille'
require 'chunky_png'

include ChunkyPNG

canvas = Drawille::Canvas.new

def draw canvas, img, xoffset=0
  (0..img.dimension.width-1).each do |x|
    (0..img.dimension.height-1).each do |y|
      r = Color.r(img[x,y])
      g = Color.g(img[x,y])
      b = Color.b(img[x,y])
      canvas.set(x+xoffset, y) if (r + b + g) > 100
    end
  end
end

draw canvas, Image.from_file('examples/stencil-1.png')
draw canvas, Image.from_file('examples/stencil-2.jpg'), 141

puts canvas.frame
