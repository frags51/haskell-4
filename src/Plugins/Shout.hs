{-|
 - Module      : Plugins.BENDER
 - Description : Bender doesn't like shouting
 - Copyright   : (c) Mayank Hooda, 2018
 - License     : WTFPL
 - Maintainer  : gelblow@gmail.com
 - Stability   : experimental
 - Portability : POSIX/Windows/MacOS
 - Respond at topmost priority if you hear a shot
 - -}

module Plugins.Shout (
    pExport
    )
where
    import BTypes (PluginD(..), User(..), emptyUser) -- Type constructor
    import Text.Regex
    import qualified Data.Text    as T
    import qualified Data.Text.IO as I
    import System.IO

    tm :: Regex
    tm = mkRegex "BENDER"

    f :: T.Text -> User -> User -> IO T.Text
    f x me you = do
        let res = "Rodriguez Reporting "++ (T.unpack $ userName me) ++ " Why are you shouting?"

        putStrLn("BENDER: "++res)
        hFlush stdout
        return x -- Lift x to IO Text, and return it!

    pExport :: PluginD
    pExport = PluginD "Shout" tm f