
i = 0
mainloop do
  exit if keydown?("ESCAPE")

  clear_window
  put_image("ruby.png", x: 100, y: 100, w: 128, h: 128, flip_vertically: true)
  put_image("ruby.png", x: 300, y: 300, w: 128, h: 128, angle: i)

  draw_rect(300, 300, 128, 128, WHITE)
  
  i += 5
end
