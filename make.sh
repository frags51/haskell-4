#! /bin/sh
ghc src/BAdapter.hs src/BTypes.hs src/BAdapter/Shell.hs src/Main.hs src/Plugins/Echo.hs \
 src/Plugins/Arithmetic.hs src/Plugins/Commit.hs src/Plugins/Oddity.hs src/Plugins/Shout.hs \
 -o Bender