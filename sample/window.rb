
set_title("Test Widnow (1024x768)")
window_size(1024, 768)
fill_rect(0, 0, 1024, 768, WHITE)

mainloop do
  if keydown?("ESCAPE")
    exit
  end
end
