 local addon, ns = ...
 local cfg = CreateFrame("Frame")

 
-----------------------------
-- Unit Frames
-----------------------------

cfg.size = "small"		-- Chose between small and large layouts
						-- nibRealUI will control the size if it's installed

cfg.focus = true 		-- Set/Clear focus with focuskey + left click
cfg.focuskey = "shift"	-- shift / alt / ctrl

cfg.arena = false 		-- Enable Arena frames
cfg.showtank = false 	-- Enable MainTank frame

-- Unit Frames Positions
cfg.unit_positions = { 				
	small = {
		player = 		{ x = -287,	y = -38},
		pet = 			{ x = 11, 	y = 0},		-- Anchored to Player
		focus = 		{ x = 0,	y = -51},	-- Anchored to Player
		focustarget = 	{ x = 0,	y = -10},	-- Anchored to Focus
		target = 		{ x = 287,	y = -38},
		targettarget = 	{ x = 0,	y = -51},	-- Anchored to Target
		tank = 			{ x = 0,	y = -10},	-- Anchored to TargetTarget
	},
	large = {
		player = 		{ x = -307,	y = -38},
		pet = 			{ x = 11, 	y = 0},		-- Anchored to Player
		focus = 		{ x = 0,	y = -51},	-- Anchored to Player
		focustarget = 	{ x = 0,	y = -10},	-- Anchored to Focus
		target = 		{ x = 307,	y = -38},
		targettarget = 	{ x = 0,	y = -51},	-- Anchored to Target
		tank = 			{ x = 0,	y = -10},	-- Anchored to TargetTarget
	},
}

-----------------------------
-- Overlay
-----------------------------

cfg.overlay = {
	-- Font
	font = {
		small = {"Interface\\AddOns\\oUF_RealUI\\media\\pixel_lr_small.ttf", 8, "MONOCHROMEOUTLINE"},
		large = {"Interface\\AddOns\\oUF_RealUI\\media\\pixel_hr_small.ttf", 8, "MONOCHROMEOUTLINE"},
	},
	-- Bars
	bar = {
		opacity = {
			surround = 1,			-- Border of objects
			background = 0.5,		-- Background of unit frame
			status = 0.8,			-- Background of objects (arrow, end box, etc)
			bar = {0.0, 0.4},		-- Health/Power gradient {start, end}
			bar2 = {0.4, 0.9},		-- Pet/Vehicle Health/Power gradient {start, end}
			steps = 0.7,			-- Tiny step indicator
		},
		colors = {
			byhostility = true,
			byclass = true,
		},
	},
	-- Arrows
	arrow = {
		opacity = {
			surround = 1,
			background = 0.8,
		},
		colors = {
			[1] = {1, 1, 1},
			[2] = {1, 1, 0},
			[3] = {1, 0, 0},
			[4] = {1, 0.5, 0},
		},
	},
}

-----------------------------
-- Handover
-----------------------------

ns.cfg = cfg