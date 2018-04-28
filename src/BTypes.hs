{-|
Module      : BTypes
Description : Contains Types that are used by Bender
Copyright   : (c) Supreet Singh, 2018
License     : WTFPL
Maintainer  : supreet51.cs@gmail.com
Stability   : experimental
Portability : POSIX/Windows/MacOS

Exports PluginD , emptyUser and User for now
-}

{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module BTypes
  ( PluginD (..) -- DData Constructor for PluginD
    , User(..)
    , emptyUser
  ) where


import           Data.Aeson -- For JSON, if required? Aeson was the father of JSON ^-^
import           Data.Text                    (Text, pack)
import           Data.ByteString              (ByteString)
import           Text.Regex

-- | Bot's ID
type BotId = Text

-- | User's ID
type UserId = Text

-- | Name of the bot - self explanators
type BotName = Text
type BotToken = Text
type Namespace = Text

data Bot = Bot{ botId     :: BotId
, botName   :: BotName
, botIcon   :: Text
, botToken  :: BotToken
, botUserId :: UserId
} deriving (Show, Eq)

-- |Stores the user's info. 
data User = User { userId   :: !UserId
, userName :: !Text
} deriving (Show, Eq)

-- |Stores the message that is to be sent/received
data Message = Message { messageUser   :: !User
, messageText   :: !Text
, messageDirect :: Bool
} deriving Show

data BotInfo = BotInfo { botInfoToken :: BotToken
, botInfoIcon  :: Text
}

-- |Defines a Plugin
data PluginD = PluginD { name :: [Char] -- ^ The name of the Plugin
 , toMatch :: Regex -- ^ The regex this plugin matches
 ,action :: Text -> (User) -> (User) -> IO Text -- ^ The function that should be executed on regex match.
}

-- | Just an empty user to save time 
emptyUser = User (pack "") (pack "")