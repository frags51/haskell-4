import Text.Regex

import Data.Text as T

main :: IO ()
main = do
	i <- getLine
	matchRegexAll (mkRegex "[cC]+at") "Cat!!!"