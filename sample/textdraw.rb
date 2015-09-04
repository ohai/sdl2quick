i = 0

mainloop do
  clear_window
  text "#{i}", x: 200, y: 200
  i += 1
  
  exit if keydown?("ESCAPE")
end
