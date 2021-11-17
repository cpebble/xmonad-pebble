{-# LANGUAGE PartialTypeSignatures #-}
{-# LANGUAGE UnicodeSyntax #-}

module Bar where

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Util.Loggers
import XMonad.Util.WorkspaceCompare (getSortByTag)
import XMonad.Util.Scratchpad (scratchpadFilterOutWorkspace)

xmobarrcLocation = "/home/cpj/.config/xmonad/xmobarrc"

xmobarCmd = "xmobar " ++ xmobarrcLocation

barProps = statusBarProp xmobarCmd (pure myBarPP)

myBarPP :: PP
myBarPP =
  xmobarPP
    { ppSep = magenta " • ",
      ppTitleSanitize = xmobarStrip,
      ppCurrent = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2,
      ppHidden = white . wrap " " "",
      ppHiddenNoWindows = const "", -- lowWhite . wrap " " "",
      ppUrgent = red . wrap (yellow "!") (yellow "!"),
      ppOrder = \[ws, l, _] -> [ws, l],
      ppExtras = [],
      ppSort = ppSortFun,
      ppRename = customRename
    }
  where
    formatFocused = wrap (white "[") (white "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue . ppWindow

    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    ppSortFun = fmap (.scratchpadFilterOutWorkspace) getSortByTag

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta = xmobarColor "#ff79c6" ""
    blue = xmobarColor "#bd93f9" ""
    white = xmobarColor "#f8f8f2" ""
    yellow = xmobarColor "#f1fa8c" ""
    red = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""

    customRename "Enpass" _ = "\xf023"--""
    customRename s _ = s
