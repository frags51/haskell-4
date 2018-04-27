i{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE CPP #-}


module Main where

import Data.ByteString
import Data.Char(toUpper)
import Data.Maybe
import Data.Monoid ((<>))
import Reddit
import Reddit.Types.Post
import Reddit.Types.SearchOptions (Order (..))
import Servant.Client (ClientEnv(ClientEnv), runClientM)
import Servant.Common.Req
import System.Environment (getEnv, setEnv)
main :: IO ()
main =  do
	Prelude.putStrLn ("Connected")
    run port (slashSimple redditify)
	where
		port = 3000
