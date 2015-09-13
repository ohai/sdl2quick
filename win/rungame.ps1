param($script="")
PowerShell -windowstyle hidden -command exit
$old_path = $Env:Path
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Env:Path += ";" + $dir + "\Ruby22\bin;" + $dir + "\sdl2quick"
$Env:RUBYLIB = $dir + "\sdl2quick"

if ($script -eq "") {
  $script = $dir + "\game.rb"
}
ruby ($dir + "\sdl2quick\start.rb") $script

$Env:Path = $old_path

