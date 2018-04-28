{-|
Module      : BAdapter
Description : Contains the Description of an Adapter
Copyright   : (c) Supreet Singh, 2018
License     : WTFPL
Maintainer  : supreet51.cs@gmail.com
Stability   : experimental
Portability : POSIX/Windows/MacOS

Exports the IsAdapter class. Defines a functions an Adapter should have by default.
-}

{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE AllowAmbiguousTypes #-}

module BAdapter(
    module BAdapter
    )
where
    import BTypes
    
    import qualified Data.Text as T

    {-| 
    Any Adapter should have these methods...
   _init: Initialize the adatper
   hear: Listen for events and inputs
    -}
    class IsAdapter a where
        -- | _init: Initialize an Adapter. Display a start message, etc.
        _init :: a -> IO () 
        -- | hear: receive an Adapeter as input, along with the State, and do IO etc
        hear :: a -> IO T.Text    
    -- Can add other fxns like IO Networks etc in the future