# How to build win32 version

## まずはじめに
Windowsを準備してください。この手順は Win 8 で確認しています。

64bitと32bitのどちらを使うかあらかじめ決めてください。
他人に使わせることを考えると32bit版のほうが良いでしょう。

## Ruby のインストール
まず、RubyInstaller for Windowsとdevkitをインストールします。
http://rubyinstaller.org/ からダウンロードしてインストールします。
RubyInstaller、devkitともに
32bit版と64bit版の両方があるので適切なほうを使ってください。

## SDL2 の準備
まず、あらかじめ「dll」「include」「lib」というディレクトリを
作っておきます。必要なファイルをここにコピーします。
SDL2、SDL2\_mixer、SDL2\_image、SDL2\_ttfを準備します。

* [SDL2](https://www.libsdl.org/download-2.0.php)
* [SDL2\_mixer](https://www.libsdl.org/projects/SDL_mixer/)
* [SDL2\_image](https://www.libsdl.org/projects/SDL_image/)
* [SDL2\_ttf](https://www.libsdl.org/projects/SDL_ttf/)

からぞれぞれ「Development: MinGW 32/64-bit」
というファイルをダウンロード、展開し、その下にある
i686-w64-mingw32 (32bit版) もしくは x86_64-w64-mingw32 (64bit版)
というディレクトリから以下のファイルを上で作ったディレクトリに
コピーします。

* bin というディレクトリの下にある *.dll ファイルを「dll」ディレクトリに
* include/SDL2 というディレクトリの下にある *.h という
  ファイルを「include」ディレクトリに
* lib というディレクトリの下にある *.a *.la *.dll.a というファイルを
「lib」ディレクトリに

## Ruby/SDL2 のインストール
gem を使います。Ruby コンソール(RubyInstallerによってインストールされます)
から

    gem install ruby-sdl2 -- --with-opt-include="上で作ったincludeディレクトリのパス" --with-opt-lib="上で作ったlibディレクトリのパス"

でインストールされます。
必要なファイルがすべてそろっていればこれでエラーなくうまく動くはずです。

## ディレクトリの作成
次に、

    sdl2quick
    sdl2quick/sdl2quick

というディレクトリを作成します。ここに必要なファイルをコピーしていきます。

## DLL のコピー
「dll」ファイルにコピーした *.dll ファイルを上で作った
「sdl2quick/sdl2quick」にコピーします。

## Ruby本体のコピー
最初にRubyInstallerでインストールしたRubyの処理系を sdl2quick に
コピーします。おそらく「C:\Ruby22」という名前のはずなので
これをディレクトリごとコピーします。

## sdl2quick のファイルからコピー
sdl2quick.rb start.rb VL-Gothic-Regular.ttf を sdl2quick/sdl2quick へ、
win/debug-game.ps1 win/rungame.ps1 を sdl2quick へ、
sample/blank_window.rb を sdl2quick へ game.rb という名前で、
それぞれコピーしてください。

## PowerShell script の調整
Ruby処理系のディレクトリ名が Ruby22 である場合は何もする必要は
ありません。それ以外の場合は、debug-game.ps1 rungame.ps1 の
Ruby22 の部分を適切な名前に置き換えてください。

## 実行テスト
rungame.ps1 を実行します。
explorer から右クリックして「PowerShell として実行」を
選びます。最初はセキュリティに関する警告が出るはずですが、
これは許可をしてください。

## セキュリティ警告について
詳しくは
http://www.atmarkit.co.jp/ait/articles/0805/16/news139.html
などを参照してください。

