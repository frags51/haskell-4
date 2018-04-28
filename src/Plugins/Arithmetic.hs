{-|
Module      : Plugins.Arithmetic
Description : A simple echo plugin
Copyright   : (c) Supreet Singh, 2018
License     : WTFPL
Maintainer  : supreet51.cs@gmail.com
Stability   : experimental
Portability : POSIX/Windows/MacOS

Matches Bender add/div/mult/sub Num <text> Num2 and returns Num / Num2
-}

module Plugins.Arithmetic (
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
    tm = mkRegex "^Bender (add|div|sub|mult) ([0-9]+) [A-z]* ([0-9]+)"

    f :: T.Text -> User -> User -> IO T.Text
    f x me you = do
        let res = show . (getFxn (getNumsAsList x tm)) . getNumsAsTuple $ (getNumsAsList x tm)

        putStrLn("BENDER: The answer is: "++res)
        hFlush stdout
        return x -- Lift x to IO Text, and return it!

    pExport :: PluginD
    pExport = PluginD "Arithmetic" tm f

    -- |Returns the matched numbers as a List
    getNumsAsList :: T.Text -> Regex -> [String]
    getNumsAsList x tm=  fromMaybe ([]) $ matchRegex tm $ T.unpack x

    -- |Converts the list of String to a tuple. Note, head is the first capture -> add, mult div etc
    getNumsAsTuple :: [String] -> (Int, Int)
    getNumsAsTuple (x:xs) = (read (head xs) :: Int, read (head (tail xs)) :: Int)

    -- |Divides the numbers
    divFromTuple :: (Int, Int) -> Double
    divFromTuple a = (fromIntegral(fst a)) / fromIntegral(( snd a))

    -- |Multiplies the numbers
    multFromTuple :: (Int, Int) -> Double
    multFromTuple a = fromIntegral((fst a) * (snd a))

    -- |Adds the numbers
    addFromTuple :: (Int, Int) -> Double
    addFromTuple a = fromIntegral((fst a) + (snd a))

    -- |Subracts the numbers
    subFromTuple :: (Int, Int) -> Double
    subFromTuple a = fromIntegral((fst a) - (snd a))

    -- |Returns what func to use
    getFxn ::  [String] -> ((Int, Int) -> Double)
    getFxn (g:gs) = case g of
                    "div" -> divFromTuple
                    "mult" -> multFromTuple
                    "add" -> addFromTuple
                    "sub" -> subFromTuple
