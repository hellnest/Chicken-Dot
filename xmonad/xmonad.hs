		---[ XMonad Configuration ]---
		--------XMonad Ver 0.10-------
		------------------------------ 	
---  		Author : Martin Lee   		---
---  	   hellnest.fuah@gmail.com		---
--------------------------------------------
-- main
import XMonad
import System.Exit
import System.IO
import qualified XMonad.StackSet as W
import qualified Data.Map as M
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
import XMonad.Layout.Reflect
-- prompt
import XMonad.Prompt
import XMonad.Prompt.RunOrRaise (runOrRaisePrompt)
import XMonad.Prompt.AppendFile (appendFilePrompt)
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
import qualified XMonad.Prompt 		as P
import XMonad.Prompt.Shell
import XMonad.Prompt

-- The basics {{{

myTerminal      = "urxvtc"
myFocusFollowsMouse :: Bool
myFocusFollowsMouse  = True
myBorderWidth   = 1
myModMask       = mod4Mask
myWorkspaces    = ["1:code","2:web","3:chat","4:irssi","5:doc","6:V","7:Vid","8:GI"]
myNormalBorderColor  = "white"
myFocusedBorderColor = "red"
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
myIconDir 	= "/home/hellnest/.xbm/"
myFont 		= "xft:Droid Sans:size=8"

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
                          "Full"            -> "^fg(" ++ myTXTColor ++ ")^i(" ++ myIconDir ++ "/full.xbm)"
                          "Spacing 10 Grid" -> "^fg(" ++ myTXTColor ++ ")^i(" ++ myIconDir ++ "/mtall.xbm)"
                          "Spacing 10 Tall" -> "^fg(" ++ myTXTColor ++ ")^i(" ++ myIconDir ++ "/tall.xbm)"
                          _                 -> x
                          )
    , ppTitle           = (" " ++) . dzenColor myTXTColor myBGColor . dzenEscape
    , ppOutput          = hPutStrLn h 
    }

myStatus = "dzen2 -x '0' -y '0' -h '14' -w '1000' -ta 'l' -bg '" ++ myBGColor ++ "' -fn '" ++ myFont ++ "'"
myBottom = "conky | dzen2 -x '930' -y '0' -w '438' -h '14' -bg '" ++ myBGColor ++ "' -fg '" ++ myTXTColor ++ "' -fn '" ++ myFont ++ "'"

-- XP Config
myXPConfig = defaultXPConfig                                    
    { 
	 font			= "-*-gohufont-medium-*-*-*-11-*-*-*-*-*-iso10646-*" 
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
searchEngineMap method = M.fromList $
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
 
    -- launch dmenu
    --, ((modm,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
    , ((modm, 				xK_s 	 ), SM.submap $ searchEngineMap $ S.promptSearchBrowser myXPConfig "chromium-browser")
    , ((modm, 				xK_r	 ), shellPrompt myXPConfig) 
    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)
 
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

    -- brightness control
    , ((0		, 0x1008ff03 ), spawn "nvclock -S -5")
    , ((0		, 0x1008ff02 ), spawn "nvclock -S +5")
    
    -- Screenshot
    , ((0		, xK_Print), unsafeSpawn "scrot '%d-%m-%Y-%H%M_$wx$h.png' -e 'mv $f ~/screenshot'")

    -- Application KeyBind
    , ((modm .|. shiftMask, xK_u     ), spawn "uzbl-tabbed")
    , ((modm .|. shiftMask, xK_p     ), spawn "pidgin")
    , ((modm .|. shiftMask, xK_b     ), spawn "chromium-browser")

    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [ ((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (myWorkspaces) [xK_1 .. xK_8]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ]


-- }}}
-- Mouse bindings {{{

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))
    ]

-- }}}
-- Hooks & Layouts {{{

myLayoutHook = onWorkspace "2:web" (full ||| grid) $ onWorkspace "3:chat" (tiled ||| grid) $ onWorkspace "4:irssi" (full) standardLayouts
  where
    tiled 	= spacing 10 $ Tall nmaster delta ratio
    nmaster 	= 1
    ratio 	= 1/2
    delta	= 3/100
    grid 	= spacing 10 $ Grid
    full 	= noBorders $ Full
    standardLayouts = (tiled ||| grid ||| full)
    reflectTiled = (reflectHoriz tiled)

myManageHook = ( composeAll . concat $
    [[ className =? "Gimp"          --> doShift "8:IMG"
    , className =? "Zenity"         --> doCenterFloat
    , className =? "Xmessage"       --> doCenterFloat
    , className =? "MPlayer"        --> doCenterFloat
    , className =? "Uzbl-tabbed"    --> doShift "2:web" 
    , className =? "Minefield"      --> doShift "2:web"
    , className =? "Chrome"         --> doShift "2:web"
    , className =? "Pidgin"         --> doShift "3:chat"
    , className =? "MPlayer"        --> doShift "7:box"
    , resource  =? "desktop_window" --> doIgnore 
    , resource  =? "kdesktop"       --> doIgnore]
    ])

    where

        role    = stringProperty "WM_WINDOW_ROLE"
        name    = stringProperty "WM_NAME"

myLogHook = return ()

-- }}}
-- Main {{{

main = do
    dzen <- spawnPipe myStatus
    bottom <- spawnPipe myBottom
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
        , layoutHook = avoidStruts $ myLayoutHook
        , manageHook = manageHook defaultConfig <+> myManageHook
        , logHook = myLogHook >> (dynamicLogWithPP $ myDzenPP dzen) >> setWMName "LG3D"
    }

-- }}}
