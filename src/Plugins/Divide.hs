{-|
Module      : Plugins.Divde
Description : A simple echo plugin
Copyright   : (c) Supreet Singh, 2018
License     : WTFPL
Maintainer  : supreet51.cs@gmail.com
Stability   : experimental
Portability : POSIX/Windows/MacOS

Matches Bender divide/Divide/div/Div Num <text> Num2 and returns Num / Num2
-}

module Plugins.Divide (
    pExport
    )
where
    import BTypes (PluginD(..), User(..), emptyUser) -- Type constructor
    import Text.Regex
    import qualified Data.Text    as T
    import qualified Data.Text.IO as I
    import System.IO
    import Data.Maybe

    tm :: Regex
    tm = mkRegex "^Bender (divide|Divide|Div|div) ([0-9]+) [A-z]+ ([0-9]+)"

    f :: T.Text -> User -> User -> IO T.Text
    f x me you = do
        let res = show . divFromTuple . getNumsAsTuple $ (getNumsAsList x tm)

        putStrLn("BENDER: The answer is: "++res)
        hFlush stdout
        return x -- Lift x to IO Text, and return it!

    pExport :: PluginD
    pExport = PluginD "Echo" tm f

    -- |Returns the matched numbers as a List
    getNumsAsList :: T.Text -> Regex -> [String]
    getNumsAsList x tm=  fromMaybe ([]) $ matchRegex tm $ T.unpack x

    -- |Converts the list of String to a tuple
    getNumsAsTuple :: [String] -> (Int, Int)
    getNumsAsTuple (x:xs) = (read (head xs) :: Int, read (head (tail xs)) :: Int)

    -- |Divides the numbers
    divFromTuple :: (Int, Int) -> Double
    divFromTuple a = (fromIntegral(fst a)) / fromIntegral(( snd a))