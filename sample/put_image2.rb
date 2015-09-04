put_image("ruby.png", x: 100, y: 100)
put_image("ruby.png", x: 110, y: 110, blend_mode: "ADD")
put_image("ruby.png", x: 120, y: 120)
put_image("ruby.png", x: 130, y: 130, alpha: 128)

mainloop do
  exit if keydown?("ESCAPE")
end
