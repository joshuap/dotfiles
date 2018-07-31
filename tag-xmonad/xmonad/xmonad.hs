{-# LANGUAGE AllowAmbiguousTypes, DeriveDataTypeable, TypeSynonymInstances, MultiParamTypeClasses #-}

import Graphics.X11.ExtraTypes.XF86
import XMonad
import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import XMonad.Actions.MessageFeedback
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.ManageDocks
import XMonad.Layout.BinarySpacePartition
import XMonad.Layout.Fullscreen
import XMonad.Layout.Grid
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders
import XMonad.Layout.Reflect
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.Minimize
import XMonad.Util.Cursor
import XMonad.Util.SpawnOnce
import XMonad.Util.Run (safeSpawn)
import XMonad.Util.EZConfig (additionalKeys)
import qualified XMonad.StackSet as W

import System.Taffybar.Support.PagerHints (pagerHints)

--------------------------------------------------------------------------
-- TODO                                                                 --
--------------------------------------------------------------------------
{-|

  * xcape service doesn't always start -- can't find $DISPLAY
  * Dropbox service has never worked right; probably same issue as xcape (also the tray icon is finicky).
  * Less obtrusive active window indicator
  * New layouts (tabs, 3-column, flex, etc.)
  * Try XMonad.Layout.BinarySpacePartition (currently have reflect support already)
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
  * I'd like to have super+tab toggle the last window rathre than next, similar
    to how my alt+tab toggles the last workspace.
  * `toggleWS` seems to have some issues w/ multiple displays.
  * In full-screen mode, taffyBar is fixed on top of the full-screen window.

  IN PROGRESS

  * Standardize window/workspace/display management keys between xmonad and chunkwm.

  DONE

  * Layout spacing for non-Full layouts
  * Custom rofi theme, bound to ALT+SPACE
  * Fix a floating window across all workspaces (for watching videos, etc.) (toggle w/ M+s)

-}

-- A simple desktop config, from xmonad-contrib.
baseConfig = desktopConfig

-- The main function.
-- main = xmonad =<< statusBar myBar myPP toggleStrutsKey (docks $ ewmh $ myConfig)
main = xmonad $
  docks $
  pagerHints $
  ewmh $
  myConfig

-- Modkey.
myModMask = mod4Mask
-- Terminal.
myTerminal = "kitty"

-- Workspaces.
myws1 = "term"
myws2 = "gen"
myws3 = "code"
myws4 = "hb"
myws5 = "hint"
myws6 = "game"
myws7 = "tmp"

-- myWorkspaces = map show [1..9]
myWorkspaces :: [String]
myWorkspaces = [myws1, myws2, myws3, myws4, myws5, myws6, myws7]

-- Startup.
myStartupHook = do

  -- Sets up all major "desktop environment" like components.
  spawnOnce "$HOME/.lib/init-wm.sh"

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
    fadeAmount = 0.98

--------------------------------------------------------------------------
-- Style                                                                --
--------------------------------------------------------------------------

yellow  = "#fabd2f"
red = "#fb4934"

myBorderWidth = 3
myNormalBorderColor = "#32302f"
myFocusedBorderColor = "#504945"

myWideFont  = "xft:Hack:"
  ++ "style=Regular:pixelsize=120:hinting=true"

myShowWNameTheme = def
  { swn_font              = myWideFont
  , swn_fade              = 0.5
  , swn_bgcolor           = "#000000"
  , swn_color             = "#FFFFFF"
  }

-- Xmobar.
myBar = "xmobar"
myPP = xmobarPP { ppCurrent = xmobarColor "#e06c75" ""
                     , ppHidden = xmobarColor "#abb2bf" ""
                     , ppHiddenNoWindows = xmobarColor "#4f5b66" ""
                     , ppUrgent = xmobarColor "#a3be8c" ""
                     , ppLayout = xmobarColor "#4f5b66" ""
                     , ppTitle =  xmobarColor "#abb2bf" "" . shorten 80
                     , ppSep = xmobarColor "#4f5b66" "" "  "
                     }

-- toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask .|. shiftMask, xK_b)

-- Layout.
myLayoutHook = showWorkspaceName
  $ smartBorders
  $ fullScreenToggle
  $ mirrorToggle
  $ reflectToggle
  $ tall ||| grid ||| bsp ||| full
  where
    fullScreenToggle = mkToggle (single FULL)
    mirrorToggle = mkToggle (single MIRROR)
    reflectToggle = mkToggle (single REFLECTX)
    showWorkspaceName = showWName' myShowWNameTheme
    named n = renamed [(XMonad.Layout.Renamed.Replace n)]
    tall = named "Tall"
      $ avoidStruts
      $ minimize
      $ smartSpacingWithEdge 4
      $ Tall 1 (3/100) (1/2)
    grid = named "Grid"
      $ avoidStruts
      $ minimize
      $ smartSpacingWithEdge 4
      $ GridRatio (4/3)
    bsp = named "BSP"
      $ avoidStruts
      $ minimize
      $ smartSpacingWithEdge 4
      $ emptyBSP
    full = named "Full"
      $ avoidStruts
      $ minimize
      $ Full

-- Event Hooks.
myEventHook = docksEventHook <+> XMonad.Hooks.EwmhDesktops.fullscreenEventHook

altMask = mod1Mask
ctrlMask = controlMask

-- Keyboard.
-- ((modMask, xK_f ), runOrRaiseMaster "firefox" (className =? "Firefox"))
myAdditionalKeys =
  [
    ((0, xF86XK_AudioRaiseVolume      ), safeSpawn "pamixer" ["-i", "5"]),
    ((0, xF86XK_AudioLowerVolume      ), safeSpawn "pamixer" ["-d", "5"]),
    ((0, xF86XK_AudioPlay             ), safeSpawn "playerctl" ["play-pause"]),
    ((0, xF86XK_AudioStop             ), safeSpawn "playerctl" ["stop"]),
    ((0, xF86XK_AudioNext             ), safeSpawn "playerctl" ["next"]),
    ((0, xF86XK_AudioPrev             ), safeSpawn "playerctl" ["previous"]),
    ((0, xF86XK_MonBrightnessUp       ), safeSpawn "light" ["-A", "15"]),
    ((0, xF86XK_MonBrightnessDown     ), safeSpawn "light" ["-U", "15"]),
    ((shiftMask, xF86XK_MonBrightnessUp   ), safeSpawn "/home/josh/bin/acdlight" ["-A", "100"]),
    ((shiftMask, xF86XK_MonBrightnessDown ), safeSpawn "/home/josh/bin/acdlight" ["-U", "100"]),
    ((mod1Mask, xK_space                  ), safeSpawn "rofi" ["-show", "run"]),

    -- Toggle make focused window always visible
    ((myModMask, xK_s ), toggleCopyToAll),

    -- Use alt+tab instead of the default super+tab to cycle windows (like on
    -- macOS), super+tab to cycle workspaces.
    ((mod1Mask, xK_Tab                    ), windows W.focusDown),
    ((myModMask, xK_Tab                   ), toggleWS),

    -- Toggle make focused window always visible
    ((myModMask, xK_s                     ), toggleCopyToAll),
    ((ctrlMask .|. myModMask, xK_l        ), nextWS),
    ((ctrlMask .|. myModMask, xK_h        ), prevWS),
    ((myModMask .|. shiftMask, xK_l       ), nextScreen),
    ((myModMask .|. shiftMask, xK_h       ), prevScreen),
    ((myModMask, xK_f                     ), sendMessage (XMonad.Layout.MultiToggle.Toggle FULL)),
    ((myModMask, xK_r                     ), tryMsgR (Rotate) (XMonad.Layout.MultiToggle.Toggle REFLECTX)),
    ((myModMask .|. shiftMask, xK_r       ), sendMessage (XMonad.Layout.MultiToggle.Toggle REFLECTX)),
    -- ((myModMask, xK_m                     ), sendMessage (XMonad.Layout.MultiToggle.Toggle MIRROR)),
    -- ((myModMask .|. shiftMask, xK_b       ), sendMessage (ToggleStruts)),

    ((myModMask, xK_b                     ), safeSpawn "firefox-dynamic" [])

    , ((myModMask .|. shiftMask, xK_l     ), safeSpawn "xscreensaver-command" ["-lock"])

    , ((myModMask,               xK_m     ), withFocused minimizeWindow)
    , ((myModMask .|. shiftMask, xK_m     ), sendMessage RestoreNextMinimizedWin)

    , ((myModMask .|. altMask,               xK_l     ), sendMessage $ ExpandTowards R)
    , ((myModMask .|. altMask,               xK_h     ), sendMessage $ ExpandTowards L)
    , ((myModMask .|. altMask,               xK_j     ), sendMessage $ ExpandTowards D)
    , ((myModMask .|. altMask,               xK_k     ), sendMessage $ ExpandTowards U)
    , ((myModMask .|. altMask .|. ctrlMask , xK_l     ), sendMessage $ ShrinkFrom R)
    , ((myModMask .|. altMask .|. ctrlMask , xK_h     ), sendMessage $ ShrinkFrom L)
    , ((myModMask .|. altMask .|. ctrlMask , xK_j     ), sendMessage $ ShrinkFrom D)
    , ((myModMask .|. altMask .|. ctrlMask , xK_k     ), sendMessage $ ShrinkFrom U)
    -- , ((myModMask,                           xK_r     ), sendMessage Rotate)
    -- , ((myModMask,                           xK_s     ), sendMessage Swap)
    , ((myModMask,                           xK_n     ), sendMessage FocusParent)
    , ((myModMask .|. ctrlMask,              xK_n     ), sendMessage SelectNode)
    , ((myModMask .|. shiftMask,             xK_n     ), sendMessage MoveNode)
  ] where
      toggleCopyToAll = wsContainingCopies >>= \ws -> case ws of
        [] -> windows copyToAll
        _ -> killAllOtherCopies

      -- try sending one message, fallback if unreceived, then refresh
      tryMsgR x y = sequence_ [(tryMessage_ x y), refresh]

-- Main configuration, override the defaults to your liking.
myConfig = baseConfig {
	modMask = myModMask,
  terminal = myTerminal,
  workspaces = myWorkspaces,
  layoutHook = myLayoutHook,
  handleEventHook = myEventHook,
  normalBorderColor = myNormalBorderColor,
  focusedBorderColor = myFocusedBorderColor,
  borderWidth = myBorderWidth,
  startupHook = myStartupHook,
  logHook = myLogHook
} `additionalKeys` myAdditionalKeys
