
def intro
  text("Press space to start", x:200, y:200)
  text("Hiscore: #{$max_score}", x: 220, y: 300)
  
  if keydown?("SPACE")
    setup_main
  end
end

def setup_main
  $x = 20
  $y = 240
  $enemies = []
  $scene = "main"
  $score = 0
  $crushing = false
  $crushing_time = 0
end

Enemy = Struct.new(:x, :y, :dx, :dy)

def generate_enemy_randomly
  return Enemy.new(660, rand(480), -(15 + rand(10)), 0)
end

def main
  put_image("shump/fly.png", x: $x-16, y: $y-16)
  $score += 1
  
  text("Score: #{$score}", x: 0, y: 0)
  

  if keypressed?("LEFT")
    $x -= 10
    $x = 0 if $x < 0
  end
  if keypressed?("RIGHT")
    $x += 10
    $x = 640 if $x > 640
  end
  if keypressed?("UP")
    $y -= 10
    $y = 0 if $y < 0
  end
  if keypressed?("DOWN")
    $y += 10
    $y = 480 if $y > 480
  end

  if rand(10) == 0
    $enemies.push(generate_enemy_randomly())
  end

  $enemies.each do |enemy|
    enemy.x += enemy.dx
    enemy.y += enemy.dy
    draw_circle(enemy.x, enemy.y, 16, RED)
  end

  $enemies.delete_if do |enemy|
    enemy.x < -10
  end

  $enemies.each do |enemy|
    if (enemy.x - $x).abs < 16 && (enemy.y - $y).abs < 16 then
      $scene = "crushing"
    end
  end
end

def crushing
  text("#{$score}", x: 0, y: 0)
  $enemies.each do |enemy|
    draw_circle(enemy.x, enemy.y, 16, RED)
  end

  draw_circle($x, $y, $crushing_time * 10, WHITE)
  
  $crushing_time += 1
  if $crushing_time > 60
    $gameover_time = 0
    $scene = "gameover"
  end
end

def gameover
  text("Game over", x: 200, y: 200)
  text("Score: #{$score}", x: 200, y: 240)
  $gameover_time += 1

  if $gameover_time > 60 || keydown?("SPACE")
    $max_score = [$max_score, $score].max
    $scene = "intro"
  end
end

$scene = "intro"
$max_score = 0
mainloop do
  exit if keydown?("ESCAPE")

  clear_window
  case $scene
  when "intro"
    intro
  when "main"
    main
  when "crushing"
    crushing
  when "gameover"
    gameover
  end
end
