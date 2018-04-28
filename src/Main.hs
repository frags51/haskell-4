{-|
Module      : Main
Description : The main function that is run on startup
Copyright   : (c) Supreet Singh, 2018
License     : WTFPL
Maintainer  : supreet51.cs@gmail.com
Stability   : experimental
Portability : POSIX/Windows/MacOS

Starts listening on an adapter using the selected plugins!
-}

module Main where

import qualified Data.Text as T
import qualified Data.Text.IO as I
import System.IO

import BTypes

import BAdapter
import qualified BAdapter.Shell as S
import qualified Plugins.Echo as PEcho
import qualified Plugins.Arithmetic as PD

-- | Store a list of users. May add another getULst fxn for other adapters.
uLst = [User (T.pack "0") (T.pack "Room"),User (T.pack "1") (T.pack "Sup"), 
        User (T.pack "2") (T.pack "R2D2"), User (T.pack "3") (T.pack "Marvin"),
        User (T.pack "4") (T.pack "GroundControl"), User (T.pack "5") (T.pack "MajorTom")]

main :: IO ()
main = do 
    -- Initialize the shell!
    _init $ S.Shell T.empty [] [] emptyUser emptyUser
    loop

-- | Loop here implements the Read-Eval-Loop for the Shell Adapter.
loop :: IO ()
loop = do
    putStr("-------------------------\nYour User ID:> ")
    -- Need To flush, otherwise prints in wrong order
    hFlush stdout
    ff <- getLine
    let me = read (ff):: Int
    putStr("To User ID (0 for room):> ")
    hFlush stdout
    ff <- getLine
    let you = read (ff):: Int
    putStr("Your message:> ")
    hFlush stdout
    ff <- I.getLine
    --I.putStrLn . hear $ S.Shell ff -- Function Composition
    hear $ S.Shell ff [PEcho.pExport
        , PD.pExport] uLst (uLst !! me) (uLst !! you)
    return ()
    loop