{-|
Module      : Plugins.Echo
Description : A simple echo plugin
Copyright   : (c) Supreet Singh, 2018
License     : WTFPL
Maintainer  : supreet51.cs@gmail.com
Stability   : experimental
Portability : POSIX/Windows/MacOS

Simply echo if you hear a cat or Cat!
-}

module Plugins.Date (
    pExport
    )
where
    import BTypes (PluginD(..), User(..), emptyUser) -- Type constructor
    import Text.Regex
    import qualified Data.Text    as T
    import qualified Data.Text.IO as I
    import System.IO
    import Data.Time.Clock
    import Data.Time.Calendar
    import Data.Time.LocalTime

    tm :: Regex
    tm = mkRegex "^[Bb]ender [dD]ate"

    f :: T.Text -> User -> User -> IO T.Text
    f x me you = do
        let res = ""
        now <- getCurrentTime
        timezone <- getCurrentTimeZone
        let zoneNow = utcToLocalTime timezone now
        let (year, month, day) = toGregorian $ localDay zoneNow
        putStr("BENDER: "++res)
        putStrLn $ "Year: " ++ show year
        putStrLn $ "Month: " ++ show month
        putStrLn $ "Day: " ++ show day

        hFlush stdout
        return x -- Lift x to IO Text, and return it!

    pExport :: PluginD
    pExport = PluginD "Date" tm f