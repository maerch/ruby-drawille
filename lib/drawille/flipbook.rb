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
      @snapshots << canvas.frame
      @chars     =  canvas.chars
    end

    def each_frame options={}
      return enum_for(:each_frame) unless block_given?
      @snapshots.each do |frame|
        yield frame
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
  end
end
