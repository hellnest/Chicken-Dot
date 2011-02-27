  ---[ XMonad Configuration ]---
 --------XMonad Ver 0.10-------
-----------------------------------	
---	Author : Martin Lee   	---
---   hellnest.fuah@gmail.com	---
-----------------------------------

-- main
import XMonad
import System.Exit
import System.IO
import qualified XMonad.StackSet as W
import qualified Data.Map as M
-- import Data.list

-- actions
import XMonad.Actions.CycleWS
import XMonad.Actions.WindowGo
import XMonad.Actions.GridSelect
import XMonad.Actions.Submap
import qualified XMonad.Actions.Submap as SM
import qualified XMonad.Actions.Search as S
import XMonad.Actions.Search
import XMonad.Actions.FloatKeys

-- layouts
import XMonad.Layout.Grid
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.PerWorkspace (onWorkspace)

-- prompt
import XMonad.Prompt
import XMonad.Prompt.RunOrRaise (runOrRaisePrompt)
import XMonad.Prompt.AppendFile (appendFilePrompt)
import XMonad.Prompt.Shell
import qualified XMonad.Prompt	as P
-- hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageHelpers
-- utils
import XMonad.Util.EZConfig
import XMonad.Util.Run (spawnPipe, runInTerm, safeSpawn, unsafeSpawn)
import XMonad.Util.Font

-- The basics {{{

myTerminal      = "urxvtc"
myFocusFollowsMouse :: Bool
myFocusFollowsMouse  = False
myBorderWidth   = 2
myModMask :: KeyMask
myModMask       = mod4Mask
myWorkspaces    = ["Code","Web","irssi","Pad","Box"]
myNormalBorderColor  = "black" 
myFocusedBorderColor = "white"
myTXTColor 	= "#ffffff" 
myBGColor  	= "#262626" 
myFFGColor 	= myBGColor 
myFBGColor 	= "#FFFEA8" 
myVFGColor 	= "#8abfb0"
myVBGColor 	= "#3b848c"
myUFGColor 	= myTXTColor
myUBGColor 	= "#d91e0d"
myIFGColor 	= "#8abfd0"
myIBGColor 	= myBGColor
mySColor   	= myTXTColor
myIconDir 	= "/home/lee/.xmonad/xbm/"
myFont		= "Monaco:size=8"

-- }}}
-- Dzen2 & Conky {{{

myDzenPP h = defaultPP
    { ppCurrent         = dzenColor myFFGColor myFBGColor . wrap (" ^fg(" ++ myFFGColor ++ ")^i(" ++ myIconDir ++ "/pacman.xbm)" ++ " ^fg(" ++ myFFGColor ++ ")") " "
    , ppVisible         = dzenColor myVFGColor myVBGColor . wrap (" ^fg(" ++ myVFGColor ++ ")^i(" ++ myIconDir ++ "/eye_r.xbm)" ++ " ^fg(" ++ myVFGColor ++ ")") " "
    , ppHidden          = dzenColor myTXTColor myBGColor . wrap (" ^i(" ++ myIconDir ++ "/has_win.xbm) ") " "
    , ppHiddenNoWindows = dzenColor myTXTColor myBGColor . wrap (" ^i(" ++ myIconDir ++ "/has_win_nv.xbm) ") " "
    , ppUrgent          = dzenColor myUFGColor myUBGColor . wrap (" ^i(" ++ myIconDir ++ "/info_03.xbm) ") " " . dzenStrip
    , ppWsSep           = ""
    , ppSep             = " | "
    , ppLayout          = dzenColor myTXTColor myBGColor .
                          (\x -> case x of
                          "Full"           -> "^fg(" ++ myTXTColor ++ ")^i(" ++ myIconDir ++ "/xbm8x8/full.xbm)"
                          "Spacing 3 Grid" -> "^fg(" ++ myTXTColor ++ ")^i(" ++ myIconDir ++ "/xbm8x8/grid.xbm)"
                          "Spacing 3 Tall" -> "^fg(" ++ myTXTColor ++ ")^i(" ++ myIconDir ++ "/xbm8x8/tall.xbm)"
                          _                 -> x
                          )
    , ppTitle           = (" " ++) . dzenColor myTXTColor myBGColor . dzenEscape
    , ppOutput          = hPutStrLn h 
    }

myStatus = "dzen2 -x '0' -y '0' -h '14' -w '1000' -ta 'l' -bg '" ++ myBGColor ++ "' -fn '" ++ myFont ++ "'"
myTray	 = "/home/lee/.xmonad/tray.zsh | dzen2 -x '800' -y '0' -ta 'r' -h '14' -bg '" ++ myBGColor ++ "' -fn '" ++ myFont ++ "'" 
-- myBottom = "conky -c ~/.conkyrc | dzen2 -x '0' -y '880' -h '14'  -bg  '" ++ myBGColor ++ "' -fg '" ++ myTXTColor ++ "' -fn '" ++ myFont ++ "'"

-- XP Config
myXPConfig = defaultXPConfig                                    
    { 
	 font			= "-*-dina-medium-r-*-*-13-*-*-*-*-*-*-*" 
	,fgColor 		= myTXTColor
	,bgColor 		= myBGColor
	,promptBorderWidth  	= 0
	,height			= 16
	,bgHLight   		= "#000000"
	,fgHLight   		= "#FF0000"
	,position 		= Bottom
    }

--Search engines to be selected :  [google (g), wikipedia (w) , youtube (y) , maps (m), dictionary (d) , wikipedia (w), bbs (b) ,aur (r), wiki (a) , TPB (t), mininova (n), isohunt (i) ]
--keybinding: hit mod + s + <searchengine>
searchEngineMap method = M.fromList 
       [ ((0, xK_g), method S.google )
       , ((0, xK_y), method S.youtube )
       , ((0, xK_m), method S.maps )
       , ((0, xK_d), method S.dictionary )
       , ((0, xK_w), method S.wikipedia )
       , ((0, xK_h), method S.hoogle )
       , ((0, xK_i), method S.isohunt )
       , ((0, xK_b), method $ S.searchEngine "archbbs" "http://bbs.archlinux.org/search.php?action=search&keywords=")
       , ((0, xK_r), method $ S.searchEngine "AUR" "http://aur.archlinux.org/packages.php?O=0&L=0&C=0&K=")
       , ((0, xK_a), method $ S.searchEngine "archwiki" "http://wiki.archlinux.org/index.php/Special:Search?search=")
       ]


-- }}}
-- Key bindings {{{

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
 
    -- launch a terminal
    [ ((modm, 				xK_Return), spawn $ XMonad.terminal conf)
 
    -- launch Application Launcher
    , ((modm, 				xK_s 	 ), SM.submap $ searchEngineMap $ S.promptSearchBrowser myXPConfig "luakit")
    , ((modm,				xK_p	 ), spawn 					"/home/lee/bin/dmenu")
    , ((modm, 				xK_r	 ), shellPrompt myXPConfig)
    , ((0,					xK_F12	 ), appendFilePrompt myXPConfig "/home/hellnest/chicken-TODO") 
    
    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)
 
    -- Focus Urgent
    , ((modm,		    xK_Escape), focusUrgent)

    -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)
 
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
 
    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)
 
    -- Select an application from a grid
    , ((modm,               xK_g     ), goToSelected defaultGSConfig)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)
 
    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)
 
    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )
 
    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )
 
    -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)
 
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
    , ((modm              , xK_q     ), spawn "killall conky dzen2; xmonad --recompile; xmonad --restart")
    , ((modm              , xK_Right ), nextWS)
    , ((modm              , xK_Left  ), prevWS)

    -- volume control
    , ((0		, 0x1008ff13 ), spawn "amixer -q set Master 2dB+ && amixer -q set PCM 2dB+")
    , ((0		, 0x1008ff11 ), spawn "amixer -q set Master 2dB- && amixer -q set PCM 2dB-")
    , ((0		, 0x1008ff12 ), spawn "amixer -q set Master toggle")

    -- MPC Control
    --, ((controlMask	, xK_Right   ), unsafeSpawn "mpc next")
    --, ((controlMask	, xK_Left    ), unsafeSpawn "mpc prev")
    --, ((controlMask	, xK_Up      ), unsafeSpawn "mpc play")
    --, ((controlMask	, xK_Down    ), unsafeSpawn "mpc stop")
        
    -- brightness control
    , ((0		, 0x1008ff03 ), spawn "nvclock -S -5")
    , ((0		, 0x1008ff02 ), spawn "nvclock -S +5")
    
    -- Screenshot
    , ((0		, xK_Print), unsafeSpawn "scrot '%d-%m-%Y-%H%M_$wx$h.png' -e 'mv $f ~/screenshot'")

    -- Application KeyBind
    , ((modm .|. shiftMask, xK_g     ), spawn "gedit")
    , ((modm 		  , xK_e     ), spawn "dbus-launch thunar")
    , ((modm .|. shiftMask, xK_u     ), spawn "luakit")
    , ((modm .|. shiftMask, xK_b     ), spawn "chromium-browser")
    , ((modm .|. shiftMask, xK_t     ), spawn "urxvtc -e tmux")
    , ((modm .|. shiftMask, xK_f     ), spawn "/home/lee/bin/rwpaper")
    , ((modm .|. shiftMask, xK_r     ), spawn "urxvtc -name irssi -e irssi")

    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [ ((m .|. modm, k), windows $ f i)
        | (i, k) <- zip myWorkspaces [xK_1 .. xK_8]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]


-- }}}
-- Mouse bindings {{{

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)
    , ((modm, button2), \w -> focus w >> windows W.shiftMaster)
    , ((modm, button3), \w -> focus w >> mouseResizeWindow w  >> windows W.shiftMaster)
    ]

-- }}}
-- Hooks & Layouts {{{

myLayoutHook = onWorkspace "Web" (full ||| grid) $ onWorkspace "irssi" (full ||| tiled) $ onWorkspace "Pad" (tiled ||| grid) $ onWorkspace "Box" full standardL
  where
    tiled 	= spacing 3 $ Tall nmaster delta ratio
    nmaster 	= 1
    ratio 	= 1/2
    delta	= 3/100
    grid 	= spacing 3  Grid
    full 	= noBorders  Full
    standardL   = full ||| tiled ||| grid
    
myManageHook = composeAll . concat $
    [[ className =? "Gimp"          --> doShift "x.x"
    , className =? "Zenity"         --> doCenterFloat
    , className =? "Xmessage"       --> doCenterFloat
    , className =? "MPlayer"        --> doCenterFloat
    , className =? "irssi"	    --> doShift "irssi"
    , className =? "luakit"	    --> doShift "Web" 
    , className =? "Chrome"         --> doShift "Web"
    , className =? "MPlayer"        --> doShift "Box"
    , className =? "Gedit"	    --> doShift "Box"
    , resource  =? "desktop_window" --> doIgnore 
    , resource  =? "kdesktop"       --> doIgnore
    ]]

    where

        role    = stringProperty "WM_WINDOW_ROLE"
        name    = stringProperty "WM_NAME"

myLogHook = return ()

-- }}}
-- Main {{{

main :: IO ()
main = do
    dzen <- spawnPipe myStatus
    tray <- spawnPipe myTray
--    bottom <- spawnPipe myBottom
    xmonad $ ewmh $ withUrgencyHook NoUrgencyHook defaultConfig {
       -- Basic Configuration
        terminal = myTerminal
        , focusFollowsMouse = myFocusFollowsMouse
        , borderWidth = myBorderWidth
        , modMask = myModMask
        , workspaces = myWorkspaces
        , normalBorderColor = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , keys = myKeys
        , mouseBindings = myMouseBindings
        , layoutHook = avoidStruts myLayoutHook
        , manageHook = manageHook defaultConfig <+> myManageHook
        , logHook = myLogHook >> dynamicLogWithPP  (myDzenPP dzen) >> setWMName "LG3D"
    }

-- }}}