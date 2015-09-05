
mainloop do
  play_sound("sample.ogg") if keydown?("0")
  play_sound("sample.ogg", channel: 0) if keydown?("1")
  halt_sound  if keydown?("2")
  exit if keydown?("ESCAPE")
end
