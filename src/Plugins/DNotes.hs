{-|
Module      : Plugins.DNotes
Description : A simple note plugin
Copyright   : (c) Aishwarya G M, 2018
License     : WTFPL
Maintainer  : supreet51.cs@gmail.com
Stability   : experimental
Portability : POSIX/Windows/MacOS

Simply display notes when user enters bender display notes
-}
module Plugins.DNotes (
    pExport
    )
where
    import BTypes (PluginD(..), User(..), emptyUser) -- Type constructor
    import Text.Regex
    -- import System.IO
    import qualified Data.Text    as T
    import qualified Data.Text.IO as I
    import System.IO

    tm :: Regex
    tm = mkRegex "^[B/b]ender [D/d]isplay [N/n]otes"
    f :: T.Text -> User -> User -> IO T.Text
    f x me you = do
        contents <- readFile "myNote.txt" 
        putStrLn contents 
        hFlush stdout
        return x -- Lift x to IO Text, and return it!
    
    pExport :: PluginD
    pExport = PluginD "DNotes" tm f
