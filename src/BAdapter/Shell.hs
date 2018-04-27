module BAdapter.Shell (
    Shell (..)
    )
where
    import BAdapter
    import qualified Data.Text as T
    import qualified Data.Text.IO as I

    import BTypes (PluginD(..))

    data Shell = Shell {name :: T.Text}

    instance IsAdapter Shell where
        hear x = do -- Should do IO and return T.Text
                I.putStrLn $ name x
                -- Lifts it into a monad 
                return $ name x
 