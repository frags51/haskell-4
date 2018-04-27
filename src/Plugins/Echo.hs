module Plugins.Echo (
    pExport
    )
where
    import BTypes (PluginD(..))
    import Text.Regex
    import Data.Text    (Text)

    tm :: Regex
    tm = mkRegex "[cC]at"

    f :: Text -> Text
    f x = "Hey, you entered cat somewhere!"

    pExport :: PluginD
    pExport = PluginD "Echo" tm f