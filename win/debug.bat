@echo off
cd /d %~dp0
set SDL2QUICK_PATH_BACK=%PATH%
set PATH=%~dp0\Ruby22\bin;%~dp0\sdl2quick;%PATH%
Ruby22\bin\ruby.exe -I %~dp0\sdl2quick sdl2quick\start.rb %1
set PATH=%SDL2QUICK_PATH_BACK%
