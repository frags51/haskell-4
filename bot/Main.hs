module Main where

import Control.Monad
import Data.Aeson (encode)
import Data.Bool
import Data.ByteString
import Data.Char(toUpper)
import Data.Maybe
import Data.Monoid ((<>))
import qualified Data.Text as T
import GHC.Types (IO (..))
import Network.HTTP.Base
import Network.HTTP.Client
import Network.HTTP.Types
import Network.HTTP.Types.Status (statusCode)
import Network.Linklater
import Network.TLS
import Network.Wai.Handler.Warp (run)
import Network.Wreq
import Prelude
import Reddit
import Reddit.Types.Post
import Reddit.Types.SearchOptions (Order (..))
import Servant.Client (ClientEnv(ClientEnv), runClientM)
import Servant.Common.Req
import System.Environment (getEnv, setEnv)
--Reads from the hook file which has the webhook for our channel and it formats in IO format
readSlackFile :: FilePath -> IO T.Text
readSlackFile filename =
  T.filter (/= '\n') . T.pack <$> Prelude.readFile filename
--configIO actually calls the function
configIO :: IO Config
configIO =
  Config <$> (readSlackFile "hook")
--checks whether there is a word following the slash command , returns if empty
parseText :: T.Text -> Maybe T.Text
parseText text = case T.strip text of
  "" -> Nothing
  x -> Just x
--A monad which returns the topic we're looking for.
liftMaybe :: Maybe a -> IO a
liftMaybe = maybe mzero return

--Printpost formats the link to display in the message.
printPost :: Post -> T.Text
printPost post = do
  title post <> "\n" <> (T.pack . show . created $ post) <> "\n" <> "http://reddit.com"<> permalink post <> "\n" <> "Score: " <> (T.pack . show . score $ post)

--Hot programming context is searched in reddit
findQPosts:: T.Text -> RedditT IO PostListing
findQPosts c = search (Just $ R "programming") (Reddit.Options Nothing (Just 0)) Hot c

--Gets the message that will be 
--posted to Slack. 
messageOfCommandReddit :: Command -> IO Network.Linklater.Message
messageOfCommandReddit (Command "redditbot" user channel (Just text)) = do
  query <- liftMaybe (parseText text)
  posts <- runRedditAnon (findQPosts query)
  case posts of
    Right posts' ->
       return (messageOf [FormatAt user, FormatString (T.intercalate "\n\n". Prelude.map printPost $ contents posts')]) where
        messageOf =
          FormattedMessage(EmojiIcon "gift") "redditbot" channel
          
--Redditify actually calls the *messageOfCommandReddit*, which actually posts the 
--message to Slack after running *stack build*, then *stack 
--exec redditbot*, and then opening up a Ngrok tunnel at the same port.
redditify :: Maybe Command -> IO T.Text
redditify Nothing =
  return "Unrecognized Slack request!"

redditify(Just command) = do
  Prelude.putStrLn ("+ Incoming command: " <> show command)
  message <- (messageOfCommandReddit) command
  config <- configIO
  --putStrLn ("+ Outgoing message: " <> show (message))
  case (debug, message) of
    (False,  m) -> do
      _ <- say m config
      return ""
    _ ->
      return ""
  where
    debug = False

main :: IO ()
main =  do
	Prelude.putStrLn ("Accepted")
	run port (slashSimple redditify)
	where 
		port = 3000

                    
