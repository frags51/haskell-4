module BAdapter.Shell (
    Shell (..)
    )
where
    import BAdapter
    import qualified Data.Text as T
    import qualified Data.Text.IO as I

    import Data.Maybe
    import Data.List (findIndices)
    import Text.Regex

    import BTypes (PluginD(..), User(..))

    {-| This is the constructor for data Shell.
    | Takes in input string and a list of plugins

    -}
    data Shell = Shell {inp :: T.Text
                        , plgLst :: [PluginD]
                        , userLst :: [User]
                        , sender :: User
                        , receiver :: User
                        }

    instance IsAdapter Shell where
        _init x = do
                I.putStrLn((T.pack "Welcome to Shell!"))
                I.putStrLn((T.pack "Enter messages like this: UserIDYour <Enter> UserIDTo(-1 for all (room)) <Enter> <Message>"))
                I.putStrLn((T.pack "<ctrl>+c to quit!"))

        hear x = do -- Should do IO and return T.Text
                -- Lists are Monads!
                --I.putStrLn $ T.pack $ plgLst x >>= ((\y ->(getMatchString $ matchRegexAll (toMatch  y) (T.unpack $ inp x))))
                
                --let j = T.pack $ plgLst x >>= ((\y ->(getMatchString $ matchRegexAll (toMatch  y) (T.unpack $ inp x))))
                let k = myHead $ findIndices ((\y ->(isNotEmptyStr $ matchRegexAll (toMatch  y) (T.unpack $ inp x)))) (plgLst x)
                if k >=0 then (action ((plgLst x) !! k)) (inp x)
                else return $ T.pack "nothing" 
                --I.putStrLn $ T.pack . boolToString $ not (T.null j)
                -- Lifts it into a monad 
                -- This is not actual return. This just elevates a type to a monad
                return $ inp x
 
    myFunc :: Maybe (String, String, String, [String]) -> (String, String, String, [String])
    myFunc x = fromMaybe ("", "", "", [""]) x

    get2nd :: (String, String, String, [String]) -> String
    get2nd (_, x, _, _) = x

    getMatchString = get2nd . myFunc --Composition

    
    get2nd2 :: (String, String, String, [String]) -> Bool
    get2nd2 (_, "", _, _) = False
    get2nd2 (_, _, _, _) = True
    

    isNotEmptyStr = get2nd2 . myFunc
   

    boolToString :: Bool -> String
    boolToString True = "TRUE"
    boolToString False = "FALSE"

    {-| Not my foot :P 
        | Head of empty list of ints : -1
    -}
    myHead :: [Int] -> Int
    myHead [] = -1
    myHead (x:xs) = x
    
