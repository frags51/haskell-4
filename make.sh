#! /bin/sh
ghc src/BAdapter.hs src/BTypes.hs src/BAdapter/Shell.hs src/Main.hs src/Plugins/Echo.hs \
src/Plugins/Arithmetic.hs src/Plugins/Note.hs src/Plugins/Date.hs \
-o Bender