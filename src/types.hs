{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Bender.Types
  ( Bot(..)
  , BotId
  , BotInfo(..)
  , BotName
  , BotToken
  , Message(..)
  , Namespace
  , UserId
  , User(..)
  ) where

import           Control.Monad.Except         (MonadError)
import           Control.Monad.IO.Class       (MonadIO)
import           Control.Monad.Trans.Resource (MonadBaseControl)
import           Data.Aeson
import           Data.Text                    (Text)
import           Data.ByteString              (ByteString)


type BotId = Text
type UserId = Text
type BotName = Text
type BotToken = Text
type Namespace = Text

data Bot = Bot
{ botId     :: BotId
, botName   :: BotName
, botIcon   :: Text
, botToken  :: BotToken
, botUserId :: UserId
} deriving (Show, Eq)

data User = User
{ userId   :: !UserId
, userName :: !Text
} deriving (Show, Eq)

data Message = Message -- an _incoming_ message
{ messageRoom   :: !Room
, messageUser   :: !User
, messageText   :: !Text
, messageDirect :: Bool
} deriving Show

data BotInfo = BotInfo
{ botInfoToken :: BotToken
, botInfoIcon  :: Text
}
