{-|
Module      : Plugins.Note
Description : A simple note plugin
Copyright   : (c) Aishwarya G M, 2018
License     : WTFPL
Maintainer  : supreet51.cs@gmail.com
Stability   : experimental
Portability : POSIX/Windows/MacOS

Simply write note when sentence starts with bender note
-}
module Plugins.Note (
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
    tm = mkRegex "^[B/b]ender [N/n]ote"
    f :: T.Text -> User -> User -> IO T.Text
    f x me you = do
        let res = splitAt 12 (T.unpack x)

        appendFile "myNote.txt" ((snd res)++"\n") 
        hFlush stdout
        return x -- Lift x to IO Text, and return it!
    
    pExport :: PluginD
    pExport = PluginD "Note" tm f
