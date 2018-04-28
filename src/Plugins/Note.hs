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
    tm = mkRegex "^Bender Note"
    f :: T.Text -> User -> User -> IO T.Text
    f x me you = do
        let res = splitAt 10 f

        appendFile "myNote.txt" f
        hFlush stdout
        return x -- Lift x to IO Text, and return it!
    pExport :: PluginD
    pExport = PluginD "Note" tm f
