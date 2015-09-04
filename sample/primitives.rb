
draw_line 100, 100, 540, 380, WHITE
fill_rect 10, 10, 50, 50, BLUE
draw_rect 100, 100, 30, 40, CYAN
draw_point 120, 130, GREEN
draw_circle 320, 240, 80, YELLOW

mainloop do
  exit if keydown?("ESCAPE")
end
