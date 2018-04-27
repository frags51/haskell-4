module Main where

import qualified Data.Text as T
import qualified Data.Text.IO as I

import BAdapter
import qualified BAdapter.Shell as S
import qualified Plugins.Echo as PEcho

main :: IO ()
main = do 
    ff <- I.getLine
    --I.putStrLn . hear $ S.Shell ff -- Function Composition
    hear $ S.Shell ff [PEcho.pExport, PEcho.pExport]
    return ()
