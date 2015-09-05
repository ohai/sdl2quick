i = 0

mainloop do
  clear_window
  set_fontsize(32)
  text("#{i}", x: 200, y: 200)
  set_fontsize(64)
  text("#{i}", x: 200, y: 300)
  
  i += 1
  
  exit if keydown?("ESCAPE")
end
