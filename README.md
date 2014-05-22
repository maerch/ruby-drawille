RUBY-DRAWILLE
========

Drawing in terminal with Unicode [Braille][] characters. Implementation based on [drawille][] by @asciimoo.

[Braille]: http://en.wikipedia.org/wiki/Braille
[Drawille]: https://github.com/asciimoo/drawille


## Installation

Add this line to your application's Gemfile:

    gem 'drawille'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install drawille

## Usage

```ruby
c = Drawille::Canvas.new

(0..1800).step(10).each do |x| 
  c.set(x/10, 10 + Math.sin(x * Math::PI / 180) * 10) 
end

puts c.frame
```

![Usage](docs/images/sinus.gif)
