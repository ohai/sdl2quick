# -*- coding: utf-8 -*-
require 'sdl2'
require 'set'

# @api private
class FPSKeeper
  def initialize(target_fps = 60, skip_limit=15, delay_accuracy = 10)
    @target_fps = target_fps
    @skip_limit = skip_limit
    @delay_accuracy = delay_accuracy
  end

  # タイマーをリセット。メインループの開始直前に呼びだす。
  def reset
    @old_ticks = get_ticks
    @num_skips = 0
  end

  def wait_frame
    now_ticks = get_ticks
    next_ticks = @old_ticks  + (1000.0/@target_fps)
    if next_ticks > now_ticks
      yield
      wait_until(next_ticks)
      @old_ticks = next_ticks
    elsif @num_skips > @skip_limit
      yield
      @num_skips = 0
      @old_ticks = get_ticks
    else
      @old_ticks = now_ticks
    end
  end

  def get_ticks
    SDL2.get_ticks.to_f
  end

  def wait_until(ticks)
    d = ticks - get_ticks
    if d < @delay_accuracy
      while get_ticks < ticks
        # do nothing
      end
    else
      SDL2.delay(Integer(d)) if d > 0
    end
  end
end

module SDL2::Q
  module_function

  # @api private
  # 初期化
  def init(title)
    SDL2.init(SDL2::INIT_EVERYTHING)
    @@window = SDL2::Window.create(title, 0, 0, 640, 480, 0)
    @@renderer = @@window.create_renderer(-1, 0)
    @@fpskeeper = FPSKeeper.new(30)
    @@title = title
    SDL2::TTF.init
    @@font = SDL2::TTF.open(FONT_PATH, 32)
    
    clear_window
  end

  FONT_PATH = File.join(__dir__, "VL-Gothic-Regular.ttf")
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
      @@fpskeeper.wait_frame { @@renderer.present }
    end
  end

  # @!group Window
  
  # ウィンドウを黒でクリアします。
  def clear_window
    @@renderer.clear
  end

  # 文字列をウィンドウの (x, y) の位置に描画します。
  #
  # @param str [String] 描画する文字列
  # @param x [Integer] 描画文字列の左上X座標
  # @param y [Integer] 描画文字列の左上Y座標
  # @param color [Array<Integer>] 描画色
  def text(str, x: 0, y: 0, color: WHITE)
    surface = @@font.render_solid(str, color)
    texture = @@renderer.create_texture_from(surface)
    @@renderer.copy(texture, nil,
                    SDL2::Rect.new(x, y, texture.w, texture.h)) 
  end
  
  # @!endgroup
  
  # @!group Input and Events

  # 指定したキーが押し下げられた時に true を返します。
  #
  # @param keyname [String] キーの名前("ESCAPE"、"F" など)
  #
  # @example
  #     keydown?("X")
  def keydown?(keyname)
    @@keydown.member?(SDL2::Key.keycode_from_name(keyname))
  end

  # @!endgroup

  
  # @!group Message box

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

  # @!endgroup

  WHITE = [255, 255, 255]
  RED = [255, 0, 0]
  GREEN = [0, 255, 0]
  BLUE = [0, 0, 255]
  BLACK = [0, 0, 0]
end


