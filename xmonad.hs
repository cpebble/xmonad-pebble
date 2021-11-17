import XMonad

-- Large list of imports
import XMonad.Hooks.EwmhDesktops ( ewmh )
import XMonad.Hooks.ManageDocks (docks)
import XMonad.Hooks.StatusBar (withSB)
import XMonad.Util.EZConfig ( additionalKeysP, removeKeysP )

-- Custom keybinds
import Keybinds
-- Custom hooks
import Hooks
-- Custom bar conf
import Bar (barProps)

main :: IO ()
main =
  xmonad
    . ewmh
    . docks
    . withSB barProps
    $ customConfig

customConfig =
  def
    { modMask = mod4Mask, -- Rebind mod to super
      layoutHook = pebbleLayoutHook, 
      terminal = "kitty",
      logHook = pebbleLogHook,
      manageHook = pebbleManageHook,
      startupHook = pebbleStartupHook,
      workspaces = 
        map (show :: Integer -> String) [1..9]
        ++ ["Enpass"]
    }
    `removeKeysP` unusedKeys
    `additionalKeysP` keyBinds
