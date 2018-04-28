module BAdapter.Shell (
    Shell (..)
    )
where
    import Control.Monad
    import BAdapter
    import qualified Data.Text as T
    import qualified Data.Text.IO as I

    import Data.Maybe
    import Data.List (findIndices)
    import Text.Regex

    import BTypes (PluginD(..), User(..), emptyUser)

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

                putStrLn "         __"
                putStrLn " _(\\    |@@| "
                putStrLn "(__/\\__ \\--/ __"
                putStrLn "   \\___|----|  |   __"
                putStrLn "       \\ B  /\\ )_ / _\\ "
                putStrLn "       /\\__/\\ \\__O (__ "
                putStrLn "      (--/\\--)    \\__/ "
                putStrLn "      _)(  )(_ "
                putStrLn "     `---''---` "
                putStrLn "BENDER AT YOUR SERVICE <3"
                I.putStrLn((T.pack "Welcome to Shell!"))
                I.putStrLn((T.pack "Enter messages like this: UserIDYour <Enter> UserIDTo(0 for all (room)) <Enter> <Message>"))
                I.putStrLn((T.pack "<ctrl>+c to quit!"))

        hear x = do -- Should do IO and return T.Text
                -- Lists are Monads!
                --I.putStrLn $ T.pack $ plgLst x >>= ((\y ->(getMatchString $ matchRegexAll (toMatch  y) (T.unpack $ inp x))))
                
                --let j = T.pack $ plgLst x >>= ((\y ->(getMatchString $ matchRegexAll (toMatch  y) (T.unpack $ inp x))))
                putStrLn("\n"++( myUnpakUname $ sender x)++" to "++( myUnpakUname $ receiver x)++": "++(T.unpack $ inp x)++"\n")
                
                -- Following, commented code for doing only one script!
                --let k = myHead $ findIndices ((\y ->(isNotEmptyStr $ matchRegexAll (toMatch  y) (T.unpack $ inp x)))) (plgLst x)
                --if k >=0 then (action ((plgLst x) !! k)) (inp x) (emptyUser) (emptyUser)
                --else return $ T.pack "nothing" 

                -- mapM_ maps a list over a monad, and discards results, onyl keeps side effects
                -- From Prelude/Control.Monad
                mapM_ (\k -> 
                    (action ((plgLst x) !! k)) (inp x) (sender x) (receiver x)) (findIndices ((\y ->(isNotEmptyStr $ matchRegexAll (toMatch  y) (T.unpack $ inp x)))) (plgLst x))
                
                --I.putStrLn $ T.pack . boolToString $ not (T.null j)
                -- Lifts it into a monad 
                -- This is not actual return. This just elevates a type to a monad
                return $ inp x
 
    myUnpakUname = T.unpack . userName

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
    
