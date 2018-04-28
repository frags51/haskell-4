{-|
Module      : BAdapter.Shell
Description : Contains the Description of the Shell Adapter
Copyright   : (c) Supreet Singh, 2018
License     : WTFPL
Maintainer  : supreet51.cs@gmail.com
Stability   : experimental
Portability : POSIX/Windows/MacOS

Exports the Shell constructor. Mostly used for testing purposes.
-}

module BAdapter.Shell (
    Shell (..)
    )
where
    import Control.Monad -- for mapM_
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
    data Shell = Shell {inp :: T.Text -- ^ The message that was input
                        , plgLst :: [PluginD] -- ^ The List of plugins to be used
                        , userLst :: [User] -- ^ The list of users operating this shell
                        , sender :: User -- ^ The person that send this message
                        , receiver :: User -- ^ The user that recieves this message
                        }

    instance IsAdapter Shell where
        _init x = do

                putStrLn "         __"
                putStrLn " _(\\    |@@| "
                putStrLn "(__/\\__ \\--/ __"
                putStrLn "   \\___|----|  |   __"
                putStrLn "       \\ BR /\\ )_ / _\\ "
                putStrLn "       /\\__/\\ \\__O (__ "
                putStrLn "      (--/\\--)    \\__/ "
                putStrLn "      _)(  )(_ "
                putStrLn "     `---''---` "
                putStrLn "BENDER RODRIGUEZ AT YOUR SERVICE <3"
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
    
    -- | A Function composition for getting the userName as a [Char]
    myUnpakUname = T.unpack . userName

    -- | Extracts the value from a Maybe Tuple generated from Regex
    myFunc :: Maybe (String, String, String, [String]) -> (String, String, String, [String])
    myFunc x = fromMaybe ("", "", "", [""]) x

    -- | Gets the matched part of the regex
    get2nd :: (String, String, String, [String]) -> String
    get2nd (_, x, _, _) = x

    -- | A function Composition to get the matched part of the regex from the stirng
    getMatchString = get2nd . myFunc --Composition

    -- | A function to check if a tuple is empty or not
    get2nd2 :: (String, String, String, [String]) -> Bool
    get2nd2 (_, "", _, _) = False
    get2nd2 (_, _, _, _) = True
    
    -- | Check if the matched thing actually contains something
    isNotEmptyStr = get2nd2 . myFunc
   
    -- | Converts a Bool to a String
    boolToString :: Bool -> String
    boolToString True = "TRUE"
    boolToString False = "FALSE"

    {-| Not my foot :P 
        | Head of empty list of ints : -1
    -}
    myHead :: [Int] -> Int
    myHead [] = -1
    myHead (x:xs) = x
    
