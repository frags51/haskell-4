module Main where

import qualified Data.Text as T
import qualified Data.Text.IO as I

import BTypes

import BAdapter
import qualified BAdapter.Shell as S
import qualified Plugins.Echo as PEcho

uLst = [User (T.pack "0") (T.pack "Sup"), User (T.pack "1") (T.pack "R2D2"), User (T.pack "2") (T.pack "Marvin")]

main :: IO ()
main = do 
    -- Initialize the shell!
    _init $ S.Shell T.empty [] [] emptyUser emptyUser
    loop

loop :: IO ()
loop = do
    ff <- getLine
    let me = read (ff):: Int
    ff <- getLine
    let you = read (ff):: Int
    ff <- I.getLine
    --I.putStrLn . hear $ S.Shell ff -- Function Composition
    hear $ S.Shell ff [PEcho.pExport, PEcho.pExport] uLst (uLst !! me) (uLst !! you)
    return ()
    loop