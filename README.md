RUBY-DRAWILLE
========

Drawing in terminal with Unicode [Braille][] characters. Implementation based on [drawille][] by @asciimoo.

[Braille]: http://en.wikipedia.org/wiki/Braille
[Drawille]: https://github.com/asciimoo/drawille


## Installation

Add this line to your application's Gemfile:

    gem 'ruby-drawille'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-drawille

## Usage

``ruby
c = Drawille::Canvas.new

(0..1800).step(10).each do |x| 
  c.set(x/10, 10 + Math.sin(x * Math::PI / 180) * 10) 
end

puts c.frame
``

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
