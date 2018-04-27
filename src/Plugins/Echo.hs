module Plugins.Echo (
    pExport
    )
where
    import BTypes (PluginD(..)) -- Type constructor
    import Text.Regex
    import Data.Text    (Text)
    import qualified Data.Text.IO as I

    tm :: Regex
    tm = mkRegex "[cC]at"

    f :: Text -> IO Text
    f x = do 
        putStrLn("Hey, you entered a cat/Cat somewhere!")
        return x -- Lift x to IO Text, and return it!

    pExport :: PluginD
    pExport = PluginD "Echo" tm f