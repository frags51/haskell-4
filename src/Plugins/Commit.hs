{-|
Module      : Plugins.Commit
Description : A simple echo plugin
Copyright   : (c) Supreet Singh, 2018
License     : WTFPL
Maintainer  : supreet51.cs@gmail.com
Stability   : experimental
Portability : POSIX/Windows/MacOS

Get a random commit from whatthecommit.com
-}

module Plugins.Commit (
    pExport
    )
where
    import BTypes (PluginD(..), User(..), emptyUser) -- Type constructor
    import Text.Regex
    import qualified Data.Text    as T
    import qualified Data.Text.IO as I
    import System.IO
    import Data.Maybe

    import Network.HTTP

    tm :: Regex
    tm = mkRegex "^[Bb]ender [ ]*(commit| show me a commit |yolo)"

    f :: T.Text -> User -> User -> IO T.Text
    f x me you = do
        res <- (simpleHTTP (getRequest "http://whatthecommit.com/index.txt") >>= fmap (take 100) . getResponseBody)

        putStrLn("BENDER: The commit is: "++res)
        hFlush stdout
        return x -- Lift x to IO Text, and return it!

    pExport :: PluginD
    pExport = PluginD "Arithmetic" tm f

