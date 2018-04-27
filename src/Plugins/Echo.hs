module Plugins.Echo (
    pExport
    )
where
    import BTypes (PluginD(..))
    import Text.Regex
    import Data.Text    (Text)

    tm :: Regex
    tm = mkRegex "[cC]+at"

    f :: Text -> Text
    f x = x

    pExport :: PluginD
    pExport = PluginD "Echo" tm f