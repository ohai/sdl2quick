play_bgm("sample.ogg")

mainloop do
  exit if keydown?("ESCAPE")
  stop_bgm if keydown?("S")
  play_bgm("sample.ogg") if keydown?("P")
end
