import Graphics.X11.ExtraTypes.XF86
import XMonad
import XMonad.Actions.CopyWindow
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.MultiToggle
import XMonad.Layout.Spacing
import XMonad.Util.Cursor
import XMonad.Util.SpawnOnce
import XMonad.Util.Run (safeSpawn)
import XMonad.Util.EZConfig (additionalKeys)

--------------------------------------------------------------------------
-- TODO                                                                 --
--------------------------------------------------------------------------
{-|

  * Less obtrusive active window indicator
  * New layouts (tabs, 3-column, flex, etc.)
  * Check out hidden layouts (Xmonad.Layout.Hidden)
  * Rework theme
  * Rework workspaces
  * Replace gnome-terminal with urxvt after adapting a 256-color theme
  * Add VPN indicator to xmobar
  * Fix flashing layout bug when toggling tray
  * Multi-monitor tray support
  * Learn how to work with floating windows better
  * Mouse move/resize windows
  * Launch applications in default workspaces
  * Default applications/layouts for blank workspaces
  * Temporary workspaces (create/name/remove on the fly)
  * Context-aware task manager
  * Fancier xmobar (someday)
  * Global media keys for ncmcpp
  * Spotify/Google music player

  DONE

  * Layout spacing for non-Full layouts
  * Custom rofi theme, bound to ALT+SPACE
  * Fix a floating window across all workspaces (for watching videos, etc.) (toggle w/ M+s)

-}

-- A simple desktop config, from xmonad-contrib.
baseConfig = desktopConfig

-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey (ewmh $ myConfig)

-- Modkey.
myModMask = mod4Mask
-- Terminal.
myTerminal = "termite"

-- Workspaces.
myws1 = "\xf120"
myws2 = "\xf269"
myws3 = "\xf121"
myws4 = "\xf07b"
myws5 = "\xf099"
myws6 = "\xf1bc"
myws7 = "\xf11b"

myWorkspaces :: [String]
myWorkspaces = [myws1, myws2, myws3, myws4, myws5, myws6 , myws7 ]

-- Startup.
myStartupHook = do

  -- Sets up all major "desktop environment" like components.
  spawnOnce "$HOME/.xmonad/init.sh"

  setDefaultCursor xC_left_ptr

-- Window transparency.
myLogHook :: X ()
myLogHook = do
  -- The following block marks copied windows.
  -- Currently this is not being used; I need to figure out how I can use it to send output to `statusBar`.
  copies <- wsContainingCopies
  let check ws | ws `elem` copies =
                 pad . xmobarColor yellow red . wrap "*" " "  $ ws
               | otherwise = pad ws

  fadeInactiveLogHook fadeAmount

  ewmhDesktopsLogHook

  where
    fadeAmount = 0.85

-- Style.
yellow  = "#b58900"
red = "#dc322f"

myBorderWidth = 3
myNormalBorderColor = "#2b303b"
myFocusedBorderColor = "#bf616a"

-- Xmobar.
myBar = "xmobar"
myPP = xmobarPP { ppCurrent = xmobarColor "#bf616a" ""
                     , ppHidden = xmobarColor "#c0c5ce" ""
                     , ppHiddenNoWindows = xmobarColor "#4f5b66" ""
                     , ppUrgent = xmobarColor "#a3be8c" ""
                     , ppLayout = xmobarColor "#4f5b66" ""
                     , ppTitle =  xmobarColor "#c0c5ce" "" . shorten 80
                     , ppSep = xmobarColor "#4f5b66" "" "  "
                     }

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Layout.
myLayoutHook = avoidStruts $ smartBorders ((spacing 5 $ (tall ||| grid)) ||| (noBorders Full ))
  where
    tall = Tall 1 (3/100) (1/2)
    grid = GridRatio (4/3)

-- Mangehooks.
myManageHook = manageDocks

-- Event Hooks.
myEventHook = docksEventHook <+> fullscreenEventHook

-- Keyboard.
-- ((modMask, xK_f ), runOrRaiseMaster "firefox" (className =? "Firefox"))
myAdditionalKeys =
  [
    ((0, xF86XK_AudioRaiseVolume      ), safeSpawn "pamixer" ["-i", "5"]),
    ((0, xF86XK_AudioLowerVolume      ), safeSpawn "pamixer" ["-d", "5"]),
    ((0, xF86XK_AudioMute             ), safeSpawn "pamixer" ["-t"]),
    ((0, xF86XK_MonBrightnessUp       ), safeSpawn "light" ["-A", "15"]),
    ((0, xF86XK_MonBrightnessDown     ), safeSpawn "light" ["-U", "15"]),
    ((shiftMask, xF86XK_MonBrightnessUp     ), safeSpawn "/home/josh/bin/acdlight" ["-A", "100"]),
    ((shiftMask, xF86XK_MonBrightnessDown   ), safeSpawn "/home/josh/bin/acdlight" ["-U", "100"]),
    ((myModMask, xK_t                       ), safeSpawn "/home/josh/bin/tray" []),
    ((mod1Mask, xK_space                    ), safeSpawn "rofi" ["-show", "run"]),
    -- Toggle make focused window always visible
    ((myModMask, xK_s), toggleCopyToAll)
  ] where
      toggleCopyToAll = wsContainingCopies >>= \ws -> case ws of
        [] -> windows copyToAll
        _ -> killAllOtherCopies

-- Main configuration, override the defaults to your liking.
myConfig = baseConfig {
	modMask = myModMask,
  terminal = myTerminal,
  workspaces = myWorkspaces,
  layoutHook = myLayoutHook,
  manageHook = myManageHook,
  handleEventHook = myEventHook,
  normalBorderColor = myNormalBorderColor,
  focusedBorderColor = myFocusedBorderColor,
  borderWidth = myBorderWidth,
  startupHook = myStartupHook,
  logHook = myLogHook
} `additionalKeys` myAdditionalKeys
