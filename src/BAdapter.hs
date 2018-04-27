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

    class IsAdapter a where 
        hear :: a -> T.Text    
