x = 100

mainloop do
  if keypressed?("LEFT")
    x -= 3
  end
  if keypressed?("RIGHT")
    x += 3
  end

  if keydown?("ESCAPE")
    exit
  end
  clear_window
  put_image("ruby.png", x: x, y: 100)
end
