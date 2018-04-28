module Plugins.Echo (
    pExport
    )
where
    import BTypes (PluginD(..), User(..), emptyUser) -- Type constructor
    import Text.Regex
    import qualified Data.Text    as T
    import qualified Data.Text.IO as I
    import System.IO

    tm :: Regex
    tm = mkRegex "[cC]at"

    f :: T.Text -> User -> User -> IO T.Text
    f x me you = do
        let res = "Hey, "++ (T.unpack $ userName me) ++ " entered a cat/Cat somewhere!"

        putStrLn("BENDER: "++res)
        hFlush stdout
        return x -- Lift x to IO Text, and return it!

    pExport :: PluginD
    pExport = PluginD "Echo" tm f