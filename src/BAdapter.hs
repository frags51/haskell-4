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
{-| Adapter should have these methods...
    | _init: Initialize the adatper
    | hear: Listen for events and inputs

-}

    class IsAdapter a where
        _init :: a -> IO () 
        hear :: a -> IO T.Text    
    -- Can add other fxns like IO Networks etc in the future