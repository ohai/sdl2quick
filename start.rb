require 'sdl2quick'
include SDL2::Q

if __FILE__ == $0
  path = ARGV.shift || "game.rb"
  SDL2::Q.init(path)
  load(path)
end
