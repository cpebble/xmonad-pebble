{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE FlexibleContexts #-}
module Hooks where

import Bar (myBarPP)

import XMonad
import XMonad.Hooks.DynamicLog (dynamicLogWithPP)
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers (isDialog)
import XMonad.Hooks.WorkspaceHistory (workspaceHistoryHook)
import XMonad.Layout.Magnifier (magnifiercz', Magnifier)
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ToggleLayouts (toggleLayouts, ToggleLayouts)
import XMonad.StackSet
import XMonad.Util.Scratchpad (scratchpadManageHook)
import XMonad.Util.SpawnOnce (spawnOnce, spawnOnOnce)
import qualified XMonad.Layout.LayoutModifier

pebbleLayoutHook =
   avoidStruts . toggleLayouts Full $ layoutList
  where
    layoutList =  tiled ||| Mirror tiled ||| Full ||| threeCol
    tiled = Tall nmaster delta ratio
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    nmaster = 1 -- Number of windows in master pane
    ratio = 1 / 2 -- Portion of screen for master pane
    delta = 3 / 100 -- Percent rezising

pebbleStartupHook = 
  do
    spawnOnce "copyQ"
    spawnOnce "feh --bg-center /home/cpj/.wallpaper"
    spawnOnce "picom -b"
    spawnOnce "nm-applet"
    spawnOnOnce "Enpass" "/usr/bin/enpass"
    spawnOnce "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 5 --transparent true --tint 0x5f5f5f --height 45"
    spawnOnce "xsetroot -cursor_name left_ptr"
    

pebbleLogHook =
  --dynamicLogWithPP myBarPP >> I don't think this is neccesary
  workspaceHistoryHook

pebbleManageHook :: ManageHook
pebbleManageHook =
        manageDocks <+>
        scratchpadManageHook
          (RationalRect 0.25 0.2 0.5 0.6) <+>
          composeAll [
            isDialog --> doFloat 
          ] 
