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

  # @private
  def init(title)
    SDL2.init(SDL2::INIT_EVERYTHING)
    @@window = SDL2::Window.create(title, 0, 0, 640, 480, 0)
    @@renderer = @@window.create_renderer(-1, 0)
    @@fpskeeper = FPSKeeper.new
    @@title = title
    
    clear_window
  end

  # メインループ。
  #
  # ブロック付きで呼び出すと毎ループごとにそのブロックが呼びだされます。
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
  
  # ウィンドウを黒でクリアします。
  def clear_window
    @@renderer.clear
  end
  
  # Event functions

  # 指定したキーが押し下げられた時に true を返します。
  #
  # @param keyname [String] キーの名前("ESCAPE"、"F" など)
  #
  # @example
  #     keydown?("X")
  def keydown?(keyname)
    @@keydown.member?(SDL2::Key.keycode_from_name(keyname))
  end

  # Message box functions

  # モーダルメッセージボックスを表示します。
  #
  # @param message [String] メッセージ
  # @param title [String] メッセージボックスのウィンドウタイトル
  #        (省略時はスクリプト名)
  # @param type [String] メッセージボックスの種類
  #        ("ERROR", "WARNING", "INFORMATION" のいずれか)
  #
  # @example
  #     messagebox("こんにちは!")
  def messagebox(message, title: nil, type: "INFORMATION")
    flag = case type
           when "INFORMATION"; SDL2::MessageBox::INFORMATION
           when "ERROR"; SDL2::MessageBox::ERROR
           when "WARNING"; SDL2::MessageBox::ERROR
           end
    title ||= @@title
    SDL2::MessageBox.show_simple_box(flag, title, message, nil)
  end
end


