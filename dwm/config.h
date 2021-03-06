/* See LICENSE file for copyright and license details. */

/* appearance */
static const char font[]            	= "-*-snap-*-*-*-*-10-100-*-*-*-*-iso10646-*";
static const char normbordercolor[] 	= "#555753";
static const char normbgcolor[]     	= "#2e3436";
static const char normfgcolor[]     	= "#d3d7cf";
static const char selbordercolor[]  	= "#555753";
static const char selbgcolor[]      	= "#000000";
static const char selfgcolor[]      	= "#d3d7cf";
static const char urgbordercolor[]	= "#ff0066";
static const char urgbgcolor[]		= "#ff0066";
static const char urgfgcolor[]		= "#ffffff";
static const unsigned int borderpx  	= 1;        /* border pixel of windows */
static const unsigned int snap      	= 24;       /* snap pixel */
static const Bool showbar           	= True;     /* False means no bar */
static const Bool topbar            	= True;     /* False means bottom bar */
static const unsigned int titlemaxw	= 230;      /* Maximum title widh in px*/

/* tagging */
static const char *tags[] = { "C", "WWW", "Irssi", "IM", "Mail", "FM", "Box" };

static const Rule rules[] = {
	/* class     	 instance    title       	tags mask     isfloating   monitor */
	{ "Gimp",     	 NULL,       NULL,       	 0,              True,         -1 },
	{ "Chrome",   	 NULL,       NULL,       	 1 << 1,         False,        -1 },
	{ "Uzbl", 	 NULL, 	     NULL, 		 1 << 1, 	 False 	       -1 },
	{ "Pidgin",     "Pidgin",    "Buddy List",       1 << 3,         False,        -1 },
	{ "URxvt", 	"irssi",     "irssi",       	 1 << 2,         False,        -1 },
	{ "Pcmanfm",     NULL,       NULL,		 1 << 5,	 False,        -1 },
	{ "MPlayer",	 NULL,	     NULL,		 1 << 6,	 True,	       -1 },
};

/* layout(s) */
static const float mfact      = 0.55; /* factor of master area size [0.05..0.95] */
static const Bool resizehints = False; /* True means respect size hints in tiled resizals */
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[T]=",      tile },    /* first entry is default */
	{ "[G]",      grid },
	{ "[F]",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "[S]",      bstack },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *dmenucmd[] = { "dmenu_run", "-fn", font, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]  = { "urxvtc", NULL };
static const char *browser[]  = { "chromium-browser", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_r,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,			XK_c,      spawn,	   {.v = browser } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,			XK_Left,   cycle,	   {.i = -1 } },
	{ MODKEY,			XK_Right,  cycle,	   {.i = +1 } },
	{ MODKEY|ControlMask,		XK_Left,   tagcycle,	   {.i = -1 } },
	{ MODKEY|ControlMask,           XK_Right,  tagcycle,	   {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
