module Plugins.Echo (
    pExport
    )
where
    import BTypes (PluginD(..), User(..), emptyUser) -- Type constructor
    import Text.Regex
    import Data.Text    (Text)
    import qualified Data.Text.IO as I
    import System.IO

    tm :: Regex
    tm = mkRegex "[cC]at"

    f :: Text -> User -> User -> IO Text
    f x me you = do
        let res = "Hey, you entered a cat/Cat somewhere!"

        putStrLn("BENDER: "++res)
        hFlush stdout
        return x -- Lift x to IO Text, and return it!

    pExport :: PluginD
    pExport = PluginD "Echo" tm f