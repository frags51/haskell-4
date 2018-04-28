{-|
Module      : Plugins.Oddity
Description : A simple echo plugin
Copyright   : (c) Supreet Singh, 2018
License     : WTFPL
Maintainer  : supreet51.cs@gmail.com
Stability   : experimental
Portability : POSIX/Windows/MacOS

Gives a line from the song space oddity 
-}

module Plugins.Oddity (
    pExport
    )
where
    import BTypes (PluginD(..), User(..), emptyUser) -- Type constructor
    import Text.Regex
    import qualified Data.Text    as T
    import qualified Data.Text.IO as I
    import System.IO
    import Data.Maybe


    tm :: Regex
    tm = mkRegex "[bB]ender [A-z ]*"


    f :: T.Text -> User -> User -> IO T.Text
    f x me you = do
        if (((myUnpakUname me) == "GroundControl") && ((myUnpakUname you) == "MajorTom")) then
                putStrLn ("Bender: Take your protein pills and put your helmet on")
        else putStr("")

        
        return x -- Lift x to IO Text, and return it!

    pExport :: PluginD
    pExport = PluginD "Oddity" tm f

    myUnpakUname = T.unpack . userName