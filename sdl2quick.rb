# -*- coding: utf-8 -*-
require 'sdl2'
require 'set'

class FPSKeeper
  def initialize(target_fps = 60)
    @target_fps = target_fps
  end

  # タイマーをリセット。メインループの開始直前に呼びだす。
  def reset
    @old_ticks = get_ticks
  end

  def wait_frame
    now_ticks = get_ticks
    next_ticks = @old_ticks  + (1.0/@target_fps)
    if next_ticks > now_ticks 
      wait_until(next_ticks)
      @old_ticks = next_ticks
    else
      @old_ticks = now_ticks
    end
  end

  def get_ticks
    SDL2.get_ticks.to_f
  end

  def wait_until(ticks)
    SDL2.delay(Integer(ticks - get_ticks))
  end
end

module SDL2::Q
  module_function
  
  def init
    SDL2.init(SDL2::INIT_EVERYTHING)
    @@window = SDL2::Window.create("", 0, 0, 640, 480, 0)
    @@renderer = @@window.create_renderer(-1, 0)
    @@fpskeeper = FPSKeeper.new
  end

  def mainloop
    @@fpskeeper.reset
    
    loop do
      @@keydown = Set.new
      while event = SDL2::Event.poll
        case event
        when SDL2::Event::Quit
          exit
        when SDL2::Event::KeyDown
          @@keydown.add(event.sym)
        end
      end
      
      yield if block_given?
      @@renderer.present
      @@fpskeeper.wait_frame
    end
  end

  # Window functions
  def clear_window
    @@renderer.clear
  end
  
  # Event functions
  def keydown?(keyname)
    @@keydown.member?(SDL2::Key.keycode_from_name(keyname))
  end
end


