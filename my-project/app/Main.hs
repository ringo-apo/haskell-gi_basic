{-# LANGUAGE OverloadedStrings, OverloadedLabels #-}

{- cabal:
build-depends: base, haskell-gi-base, gi-gtk == 3.0.*
-}

{-# OPTIONS_GHC -fno-warn-unused-do-bind #-}

{- Hello World example of GTK+ documentation. For information please refer to README -}

module Main where

-- import qualified Data.Text as T
import Data.Text 

import qualified GI.Gio as Gio
import qualified GI.Gtk as Gtk
import Data.GI.Base
import Data.Text.Encoding 
import qualified Data.ByteString 


--printHello :: IO ()
--printHello = do
--                 putStrLn "Hello, World!"
--                 buffer1 <- Gtk.entryGetBuffer entry1
--                 buffer2 <- Gtk.entryBufferGetText buffer1
--                 set label1 [ #sensitive := False, #label := buffer2 ]

activateApp :: Gtk.Application -> IO ()
activateApp app = do
  win1 <- new Gtk.ApplicationWindow [ #application := app
                                    , #title := "BasicSample"
                                    , #defaultHeight := 200
                                    , #defaultWidth := 200
                                    ]

  box1 <- new Gtk.Box [ #orientation := Gtk.OrientationVertical ]
  #add win1 box1

  entry1 <- new Gtk.Entry[ #text := "0" ]
  #add box1 entry1

  label1 <- new Gtk.Label [#label := "1" ]
  #add box1 label1

  
  button1 <- new Gtk.Button [ #label := "Increment"]

  on button1 #clicked ( do
                            buffer <- Gtk.entryGetBuffer entry1
                            bufferText <- Gtk.entryBufferGetText buffer
                            let bufferString = Data.Text.unpack bufferText 
                            let bufferInt = (read bufferString :: Int) + 1
                            let label1String = show (bufferInt)
                            let label1Text = Data.Text.pack label1String
                            set label1 [ #sensitive := False, #label := label1Text ]
                      )
  --on btn #clicked $ Gtk.widgetDestroy w
  #add box1 button1
  
  #showAll win1
  return ()

main :: IO ()
main = do
  app <- new Gtk.Application [ #applicationId := "haskell-gi.examples.hello-world"
                             , #flags := [ Gio.ApplicationFlagsFlagsNone ]
                             ]
  on app #activate $ activateApp app
  Gio.applicationRun app Nothing
  return ()
