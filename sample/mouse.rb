
class ButtonEffect
  def initialize(x, y, color)
    @x = x; @y = y; @color = color
    @clock = 0
  end

  def update
    @clock += 1
  end

  def dead?
    @clock > 15
  end

end

class ClickEffect < ButtonEffect
  def draw
    draw_circle(@x, @y, 30 - 2*@clock, @color)
  end
end

class ReleaseEffect < ButtonEffect
  def draw
    draw_circle(@x, @y, 2*@clock, @color)
  end
end

def button_state_string(index)
  return mousebutton_pressed?(index) ? "pressed" : "released"
end

effects = []

mainloop do
  exit if keydown?("ESCAPE")

  if mousebutton_click?(1)
    effects.push(ClickEffect.new(mouse_x, mouse_y, WHITE))
  end
  if mousebutton_click?(2)
    effects.push(ClickEffect.new(mouse_x, mouse_y, RED))
  end
  if mousebutton_click?(3)
    effects.push(ClickEffect.new(mouse_x, mouse_y, BLUE))
  end
  if mousebutton_released?(1)
    effects.push(ReleaseEffect.new(mouse_x, mouse_y, WHITE))
  end
  if mousebutton_released?(2)
    effects.push(ReleaseEffect.new(mouse_x, mouse_y, RED))
  end
  if mousebutton_released?(3)
    effects.push(ReleaseEffect.new(mouse_x, mouse_y, BLUE))
  end
  
  clear_window

  text("Mouse Button 1: #{button_state_string(1)}", x: 0, y: 0)
  text("Mouse Button 2: #{button_state_string(2)}", x: 0, y: 30)
  text("Mouse Button 3: #{button_state_string(3)}", x: 0, y: 60)
  
  effects.each{|effect| effect.update; effect.draw }
  effects.delete_if{|effect| effect.dead? }
end
