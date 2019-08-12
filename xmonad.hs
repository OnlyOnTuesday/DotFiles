-- default desktop configuration for Fedora

import System.Posix.Env (getEnv)
import System.Exit
import System.Process
import System.IO
import Data.Maybe (maybe)
import Data.Monoid
import Data.Default

import XMonad
--import XMonad.Config.Desktop
--import XMonad.Config.Gnome
--import XMonad.Config.Kde
--import XMonad.Config.Xfce
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog --This is what I want if I want to update xmobar
import XMonad.Util.Run(spawnPipe)
import XMonad.Actions.SpawnOn

import XMonad.Util.EZConfig -- for keybindings
import Graphics.X11.ExtraTypes.XF86

import qualified XMonad.StackSet as W
import qualified Data.Map        as M
--import Prelude.mod

main = do
     session <- getEnv "DESKTOP_SESSION"
     xmproc <- spawnPipe "xmobar /home/User1/.xmobarrc"
     --xmonad  $ maybe desktopConfig desktop session
     xmonad $ docks def
     
       { manageHook = manageSpawn <+> manageDocks <+> manageHook def 
       , layoutHook = avoidStruts $ layoutHook def 
       , logHook = dynamicLogWithPP $ myXmobarPP --xmobarPP { ppTitle = (\str -> " ")}
                   { ppOutput = hPutStrLn xmproc
                   , ppTitle = xmobarColor "green" "" . shorten 50
                   }

       -- , startupHook = do
       --     spawnOn "1" "xterm"
       --     spawnOn "2" "/home/User1/firefox/firefox-bin"
       --     spawnOn "3" "xterm -e htop"

       , startupHook = myStartupHook
         --logHook = myLogHook xmproc,
       , modMask = myModMask
       , normalBorderColor = myNormalBorderColor
       , focusedBorderColor = myFocusedBorderColor
       , keys = mkKeys
       }


myXmobarPP = xmobarPP { ppOrder = \(ws:l:_:_) -> [ws,l]--ppTitle = (\str -> "")
                      , ppCurrent = xmobarColor "magenta" "" . wrap "[" "]"
                      , ppSep = " | "}
myStartupHook = do
  spawnOn "1" "xterm"
  spawnOn "2" "/home/User1/firefox/firefox-bin"
  spawnOn "3" "xterm -e htop"
         
  
 
                      
--desktop "gnome" = gnomeConfig
--desktop "kde" = kde4Config
--desktop "xfce" = xfceConfig
--desktop "xmonad-mate" = gnomeConfig
--desktop _ = desktopConfig

myModMask = mod4Mask
myNormalBorderColor = "#dddddd"
myFocusedBorderColor = "#31ff1e"
myWebBrowser = "/home/User1/firefox/firefox-bin"
myLowerVolume = "/home/User1/Bash/toggleSound.sh --lower"
myRaiseVolume = "/home/User1/Bash/toggleSound.sh --raise"
myToggleMute = "/home/User1/Bash/toggleSound.sh --toggle"

-- Key bindings. Add, modify or remove key bindings here.

mkKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
                                                
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    --, ((modm, xK_o) , spawnOn "4" "xterm")

    -- launch firefox developer edition
    , ((modm .|. shiftMask, xK_f     ), spawn myWebBrowser)

    -- lower the volume using the function5 fn
    , ((0, xF86XK_AudioLowerVolume), spawn myLowerVolume)

    -- raise the volume using function6 fn
    , ((0, xF86XK_AudioRaiseVolume), spawn myRaiseVolume)

    , ((0, xF86XK_AudioMute), spawn myToggleMute)

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
 
    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")
 
    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)
 
     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)
 
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
 
    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)
 
    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)
 
    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)
 
    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )
 
    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )
 
    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)
 
    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )
 
    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )
 
    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)
 
    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)
 
    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
 
    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))
 
    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
 
    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((modm              , xK_b     ), sendMessage ToggleStruts)
 
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
 
    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++
 
    --
    -- mod-[1..9], Switch to workspace N
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
 
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


