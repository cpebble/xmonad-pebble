module Keybinds where
import XMonad
import XMonad.Util.Ungrab (unGrab)
import XMonad.Actions.CycleRecentWS (cycleRecentNonEmptyWS)
import XMonad.Actions.GridSelect (goToSelected)
import XMonad.Util.Scratchpad (scratchpadSpawnActionCustom)
import XMonad.Layout.ToggleLayouts (ToggleLayout(Toggle))
import XMonad.Hooks.ManageDocks (ToggleStruts(ToggleStruts))
import XMonad.StackSet (greedyView, shift)


keyBinds :: [([Char], X ())]
keyBinds =
      [ ("<Print>", unGrab *> spawn "screenshot"),
        ("M-z", spawn "glxgears"),
        ("M-S-q", kill),
        ("M-d", spawn "rofi -show drun -modi drun,calc"),
        ("M-y", spawn "rofi -show emoji"),
        ("M-S-d", spawn "rofi -show run"),
        ("M-<Return>", spawn "kitty"), -- TODO: Figure new bind for old M-r
        ("M1-<Tab>", cycleRecentNonEmptyWS [xK_Alt_L] xK_Tab xK_grave), -- moveTo Next (Not emptyWS))
        ("M-S-r", spawn "xmonad --restart"),
        ("M-f", sendMessage $ Toggle "Full"),
        ("M-g", goToSelected def), -- TODO: This might be fun
        ("M-b", sendMessage ToggleStruts),
        -- Scratchpad
        ("M-<Tab>", scratchpadSpawnActionCustom "/home/cpj/scratchpad.sh"),
        ("M-/", windows $ greedyView "Enpass"),
        ("M-S-/", windows $ shift "Enpass"),
        -- Media controls
        ("<XF86MonBrightnessUp>", spawn "/home/cpj/Projects/lc/lc intel_backlight +10"),
        ("<XF86MonBrightnessDown>", spawn "/home/cpj/Projects/lc/lc intel_backlight -10"),
        ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%"),
        ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%"),
        ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"),
        ("<XF86AudioMicMute>", spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle")
      ]
unusedKeys :: [[Char]]
unusedKeys =
  [ "M-S-c",
    "M-p",
    "M-S-q" -- Don't Kill xmonad
  ]
