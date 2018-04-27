{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module BTypes
  ( PluginD
  ) where


import           Data.Aeson
import           Data.Text                    (Text)
import           Data.ByteString              (ByteString)

type BotId = Text
type UserId = Text
type BotName = Text
type BotToken = Text
type Namespace = Text

data Bot = Bot{ botId     :: BotId
, botName   :: BotName
, botIcon   :: Text
, botToken  :: BotToken
, botUserId :: UserId
} deriving (Show, Eq)

data User = User { userId   :: !UserId
, userName :: !Text
} deriving (Show, Eq)

data Message = Message { messageUser   :: !User
, messageText   :: !Text
, messageDirect :: Bool
} deriving Show

data BotInfo = BotInfo { botInfoToken :: BotToken
, botInfoIcon  :: Text
}

data PluginD = PluginD { name :: Text
 ,action :: Text -> Text
}