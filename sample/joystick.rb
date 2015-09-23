required_joysticks(1)

def button_state_string(button)
  return "DONW & PRESSED" if joybutton_pressed?(button) && joybutton_down?(button)
  return "PRESSED" if joybutton_pressed?(button) 
  return "DONW" if joybutton_down?(button)
  return "-"
end

mainloop do
  clear_window

  text("X: #{joyhat_x}", x: 0, y: 0)
  text("Y: #{joyhat_y}", x: 0, y: 30)
  (0 .. num_joystick_buttons - 1).each do |button|
    text("Button #{button}: #{button_state_string(button)}",
         x: 0, y: 60 + button*30)
  end
  exit if keydown?("ESCAPE")
end
