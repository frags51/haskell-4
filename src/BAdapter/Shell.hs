module BAdapter.Shell (
    Shell (..)
    )
where
    import BAdapter
    import qualified Data.Text as T
    import qualified Data.Text.IO as I

    import Data.Maybe

    import Text.Regex

    import BTypes (PluginD(..))

    {-| This is the constructor for data Shell.
    | Takes in input string and a list of plugins

    -}
    data Shell = Shell {inp :: T.Text
                        , plgLst :: [PluginD]
                        }

    instance IsAdapter Shell where
        hear x = do -- Should do IO and return T.Text
                -- Lists are Monads!
                --I.putStrLn $ T.pack $ plgLst x >>= ((\y ->(getMatchString $ matchRegexAll (toMatch  y) (T.unpack $ inp x))))
                
                let j = T.pack $ plgLst x >>= ((\y ->(getMatchString $ matchRegexAll (toMatch  y) (T.unpack $ inp x))))
                
                I.putStrLn $ T.pack . boolToString $ not (T.null j)
                -- Lifts it into a monad 
                -- This is not actual return. This just elevates a type to a monad
                return $ inp x
 
    myFunc :: Maybe (String, String, String, [String]) -> (String, String, String, [String])
    myFunc x = fromMaybe ("", "", "", ["B"]) x

    get2nd :: (String, String, String, [String]) -> String
    get2nd (_, x, _, _) = x

    getMatchString = get2nd . myFunc

    {-
    get2nd2 :: (String, String, String, [String]) -> Bool
    get2nd2 (_, "", _, _) = False
    get2nd2 (_, _, _, _) = True
    -}

    isEmptyStr :: String -> Bool
    isEmptyStr x = case x of
                    "" -> False
                    otherwise -> True

    boolToString :: Bool -> String
    boolToString True = "TRUE"
    boolToString False = "FALSE"
     