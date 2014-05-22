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

### ``Drawille::Canvas`` API

#### ``#set(x, y)`` / ``#[x, y] = true``

Sets the state of the given position to ``true``, i.e. the ``#frame`` method will render a point at ``[x,y]``.

#### ``#unset(x, y)`` / ``#[x, y] = false``

Sets the state of the given position to ``false``, i.e. the ``#frame`` method will _not_ render a point at ``[x,y]``.

#### ``#toggle(x, y)``

Toggles the state of the given position.

#### ``#clear``

No point will be rendered by the ``#frame`` method.

#### ``#frame``

Returns newline-delimited string of the given canvas state. Braille characters are used to represent points. Please note that a single character contains 2 x 4 pixels.

## License

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
