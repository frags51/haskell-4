{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleContexts #-}

module Adapter(
    module Adapter
    )
where
    import qualified Data.Text as T


    class IsAdapter where 
        hearAndProcecss :: T.Text -> T.Text
    
    data Ada = Ada  deriving (IsAdapter)
