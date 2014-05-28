# -*- encoding: utf-8 -*-
require 'curses'

module Drawille

  class FlipBook
    include Frameable

    def initialize
      clear
    end

    def clear
      @snapshots = []
      @chars     = {}
    end

    def snapshot canvas
      cloned     = clone_chars canvas.chars
      @snapshots << HashDiff.diff(@chars, cloned)
      @chars     = cloned
    end

    def each_frame options={}
      @snapshots.reduce({}) do |memo, diff|
        patched = HashDiff.patch!(memo, deep_clone(diff))
        yield frame(options.merge({chars: to_int_keys(patched)}))
        patched
      end
    end

    def play options={}
      options = {
        repeat: false, fps: 6,
        min_x: 0, min_y: 0
      }.merge(options)

      Curses::init_screen
      begin
        Curses::crmode
        Curses::curs_set 0
        repeat options do
          each_frame options do |frame|
            Curses::setpos(0, 0)
            Curses::addstr(frame)
            Curses::refresh
            sleep(1.0/options[:fps])
          end
        end
      ensure
        Curses::close_screen
      end
    end

    def repeat options
      options[:repeat] ? loop { yield; clear_screen options } : yield
    end

    private

    def clear_screen options
      Curses::clear
      Curses::refresh
    end

    def deep_clone a
      Marshal.load(Marshal.dump(a))
    end

    def clone_chars chars
      chars.inject({}) do |memo, (key, value)| 
        memo[key] = value.clone; memo
      end
    end

    # Returns a hash where all keys are ints since 'hashdiff' messes the types up
    def to_int_keys chars
      Hash[chars.map{ |k, v| [k.to_i, v.is_a?(Hash) ? to_int_keys(v) : v] }]
    end
  end
end
