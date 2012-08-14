local L,SN,ST = DXE.L,DXE.SN,DXE.ST

---------------------------------
-- ASCENDANT COUNCIL
---------------------------------
do
	local data = {
		version = 11,
		key = "ascendcouncil",
		zone = L.zone["The Bastion of Twilight"],
		category = L.zone["Bastion"],
		name = L.npc_bastion["The Ascendant Council"],
		triggers = {
			scan = {
				43687, -- Feludius
				43686, -- Ignacious
			},
			yell = L.chat_bastion["^You dare invade"],
		},
		onactivate = {
			tracing = {
				43687, -- Feludius
				43686, -- Ignacious
				43688, -- Arion
				43689, -- Terrastra
			},
			tracerstart = true,
			combatstop = true,
			defeat = {
				43735, -- Elementium Monstrosity
			},
		},
		userdata = {
			bloodtext = "",
			icetext = "",
			phase = 0,
		},
		onstart = {
			{
				"expect",{"&difficulty&",">=","3"}, --10h&25h
				"set",{
					coretext = "",
					overloadtext = "",
					beacontext = "",
				},
			},
			{
				"set",{phase = 1},
				"alert",{"aegiscd",time = 2},
				"alert",{"glaciatecd",time = 2},
			}
		},
		timers = {
			blink = {
				{
					"arrow","blinkarrow",
				},
			},
		},
		windows = {
			proxwindow = true,
		},
		alerts = {
			phasewarn = {
				varname = format(L.alert["Phase Warning"]),
				type = "simple",
				text = format(L.alert["Phase %s Warning"],"<phase>"),
				time = 3,
				flashtime = 3,
				color1 = "PURPLE",
				icon = ST[99259],
				sound = "ALERT1",
			},
			kicknow = {
				varname = format(L.alert["Interrupt Warning"]),
				type = "simple",
				text = format(L.alert["Interrupt NOW!"]),
				time = 2.5,
				flashtime = 2.5,
				color1 = "ORANGE",
				color2 = "RED",
				sound = "ALERT10",
			},
			bloodwarn = {
				varname = format(L.alert["%s Warning"],SN[82660]),
				type = "centerpopup",
				text = "<bloodtext>",
				time = 30,
				flashtime = 30,
				color1 = "ORANGE",
				sound = "ALERT3",
				icon = ST[82660],
			},
			aegiswarn = {
				varname = format(L.alert["%s Warning"],SN[82631]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[82631]),
				time = 10,
				flashtime = 10,
				color1 = "RED",
				sound = "ALERT1",
				icon = ST[82631],
			},
			aegiscd = {
				varname = format(L.alert["%s Cooldown"],SN[82631]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[82631]),
				time = 62,
				time2 = 30,
				flashtime = 5,
				color1 = "RED",
				icon = ST[82631],
			},
			icewarn = {
				varname = format(L.alert["%s Warning"],SN[82665]),
				type = "centerpopup",
				text = "<icetext>",
				time = 30,
				flashtime = 30,
				color1 = "BLUE",
				sound = "ALERT3",
				icon = ST[82665],
			},
			waterlogged = {
				varname = format(L.alert["%s Warning on self"],SN[82762]),
				type = "simple",
				text = format(L.alert["%s on %s"],SN[82762],L.alert["YOU"]),
				time = 5,
				flashtime = 5,
				color1 = "BLUE",
				color2 = "GREEN",
				sound = "ALERT6",
				icon = ST[82762],
			},
			glaciatewarn = {
				varname = format(L.alert["%s Casting"],SN[92506]),
				type = "centerpopup",
				text = format(L.alert["%s Casting"],SN[92506]),
				time = 2.5,
				flashtime = 2.5,
				color1 = "BLUE",
				sound = "ALERT5",
				icon = ST[92506],
			},
			glaciatecd = {
				varname = format(L.alert["%s Cooldown"],SN[92506]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[92506]),
				time = 33,
				time2 = 31,
				flashtime = 7.5,
				color1 = "BLUE",
				icon = ST[92506],
			},
			quakecd = {
				varname = format(L.alert["%s Cooldown"],SN[83565]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[83565]),
				time = 65,
				time2 = 25,
				flashtime = 7.5,
				color1 = "BROWN",
				icon = ST[83565],
			},
			hardencd = {
				varname = format(L.alert["%s Cooldown"],SN[92541]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[92541]),
				time = 45,
				time2 = 27,
				flashtime = 7.5,
				color1 = "CYAN",
				icon = ST[92541],
			},
			shockcd = {
				varname = format(L.alert["%s Cooldown"],SN[83067]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[83067]),
				time = 65,
				time2 = 60,
				flashtime = 7.5,
				color1 = "GREY",
				icon = ST[83067],
			},
			rodwarn = {
				varname = format(L.alert["%s Warning"],SN[83099]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[83099]),
				time = 5,
				color1 = "YELLOW",
				icon = ST[83099],
				throttle = 2,
			},
			rodself = {
				varname = format(L.alert["%s Warning on self"],SN[83099]),
				type = "centerpopup",
				text = format(L.alert["%s on %s"],SN[83099],L.alert["YOU"]),
				time = 15,
				flashtime = 15,
				color1 = "YELLOW",
				sound = "ALERT12",
				icon = ST[83099],
				flashscreen = true,
			},
			crushcd = {
				varname = format(L.alert["%s Cooldown"],SN[92488]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[92488]),
				time = 25,
				flashtime = 5,
				color1 = "TAN",
				icon = ST[92488],
				throttle = 2,
			},
			-- Heroic Alerts
			overloadwarn = {
				varname = format(L.alert["%s Warning"],SN[92067]),
				type = "centerpopup",
				text = "<overloadtext>",
				time = 10,
				color1 = "YELLOW",
				icon = ST[92067],
				sound = "ALERT4",
			},
			overloadself = {
				varname = format(L.alert["%s on self"],SN[92067]),
				type = "centerpopup",
				text = format(L.alert["%s on %s"],SN[92067],L.alert["YOU"]),
				time = 10,
				color1 = "YELLOW",
				icon = ST[92067],
				sound = "ALERT12",
				flashscreen = true,
			},
			corewarn = {
				varname = format(L.alert["%s Warning"],SN[92075]),
				type = "centerpopup",
				text = "<coretext>",
				time = 10,
				color1 = "WHITE",
				icon = ST[92075],
				sound = "ALERT5",
			},
			coreself = {
				varname = format(L.alert["%s on self"],SN[92075]),
				type = "centerpopup",
				text = format(L.alert["%s on %s"],SN[92075],L.alert["YOU"]),
				time = 10,
				color1 = "WHITE",
				icon = ST[92075],
				sound = "ALERT12",
				flashscreen = true,
			},
			beaconwarn = {
				varname = format(L.alert["%s Warning"],SN[92307]),
				type = "simple",
				text = "<beacontext>",
				time = 5,
				color1 = "BLUE",
				icon = ST[92307],
				sound = "ALERT5",
			},
			beaconself = {
				varname = format(L.alert["%s on self"],SN[92307]),
				type = "simple",
				text = format(L.alert["%s on %s"],SN[92307],L.alert["YOU"]),
				time = 5,
				color1 = "BLUE",
				icon = ST[92307],
				sound = "ALERT12",
				flashscreen = true,
			},
		},
		arrows = {
			blinkarrow = {
				varname = format("%s %s",L.npc_bastion["Arion"],SN[92456]),
				unit = "&tft3_unitname&",
				persist = 6,
				action = "TOWARD",
				msg = L.alert["Interrupt!"],
				spell = SN[92456],
				sound = "ALERT5",
			},
		},
		raidicons = {
			bloodmark = {
				varname = SN[82660],
				type = "FRIENDLY",
				persist = 15,
				unit = "#5#",
				icon = 5,
			},
			icemark = {
				varname = SN[82665],
				type = "FRIENDLY",
				persist = 15,
				unit = "#5#",
				icon = 3,
			},
			rodmark = {
				varname = SN[83099],
				type = "MULTIFRIENDLY",
				persist = 15,
				unit = "#5#",
				icon = 4,
				reset = 3,
				total = 3,
			},
			crushmark = {
				varname = SN[92486],
				type = "MULTIFRIENDLY",
				persist = 6.5,
				unit = "#5#",
				icon = 4,
				reset = 5,
				total = 4,
			},
			overloadmark = {
				varname = SN[92067],
				type = "FRIENDLY",
				persist = 10,
				unit = "#5#",
				icon = 1,
			},
			coremark = {
				varname = SN[92075],
				type = "FRIENDLY",
				persist = 5,
				unit = "#5#",
				icon = 2,
			},
			beaconmark = {
				varname = SN[92307],
				type = "FRIENDLY",
				persist = 20,
				unit = "#5#",
				icon = 1,
			},
		},
		announces = {
			rodsay = {
				varname = format(L.alert["Say %s on self"],SN[83099]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[83099]),
			},
			coresay = {
				varname = format(L.alert["Say %s on self"],SN[92075]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[92075]),
			},
			overloadsay = {
				varname = format(L.alert["Say %s on self"],SN[92067]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[92067]),
			},
			beaconsay = {
				varname = format(L.alert["Say %s on self"],SN[92307]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[92307]),
			},
		},
		events = {
			-- Ignacius
			-- Burning Blood
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 82660,
				execute = {
					{
						"raidicon","bloodmark",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"set",{bloodtext = format(L.alert["%s on %s"],SN[82660],L.alert["YOU"])},
						"alert","bloodwarn",
					},
					{
						"expect",{"#4#","~=","&playerguid&"},
						"set",{bloodtext = format(L.alert["%s on %s"],SN[82660],"#5#")},
						"alert","bloodwarn",
					},
				},
			},
			-- Burning Blood removed
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 82660,
				execute = {
					{
						"removeraidicon","#5#",
						"quash","bloodwarn",
					},
				},
			},
			-- Aegis (Shield)
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 92512,
				execute = {
					{
						"alert","aegiswarn",
						"alert","aegiscd",
					},
				},
			},
			-- Aegis removed -> Kick
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 92512,
				execute = {
					{
						"quash","aegiswarn",
						"alert","kicknow",
					},
				},
			},
			-- Feludius
			-- Heart of Ice
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 82665,
				execute = {
					{
						"raidicon","icemark",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"set",{icetext = format(L.alert["%s on %s"],SN[82665],L.alert["YOU"])},
						"alert","icewarn",
					},
					{
						"expect",{"#4#","~=","&playerguid&"},
						"set",{icetext = format(L.alert["%s on %s"],SN[82665],"#5#")},
						"alert","icewarn",
					},
				},
			},
			-- Heart of Ice removed
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 82665,
				execute = {
					{
						"removeraidicon","#5#",
						"quash","icewarn",
					},
				},
			},
			-- Waterlogged self
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 82762,
				execute = {
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert","waterlogged",
					},
				},
			},
			-- Glaciate
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 82746,
				execute = {
					{
						"quash","glaciatecd",
						"alert","glaciatewarn",
						"alert","glaciatecd",
					},
				},
			},
			-- Phase 2 Trigger
			{
				type = "event",
				event = "YELL",
				execute = {
					{
						"expect",{"#1#","find",L.chat_bastion["^Enough of this foolishness"]},
						"set",{phase = 2},
						"alert","phasewarn",
						"quash","aegiscd",
						"quash","glaciatecd",
						"alert",{"quakecd",time = 2},
						"alert",{"hardencd",time = 2},
						"alert",{"shockcd",time = 2},
					},
				},
			},
			-- Terrestra
			-- Harden Skin
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 92541,
				execute = {
					{
						"alert","kicknow",
						"alert","hardencd",
					},
				},
			},
			-- Quake
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 92544,
				execute = {
					{
						"quash","quakecd",
						"alert","quakecd",
					},
				},
			},
			-- Arion
			-- Lightning Rod
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 83099,
				execute = {
					{
						"raidicon","rodmark",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"announce","rodsay",
						"alert","rodself",
					},
					{
						"expect",{"#4#","~=","&playerguid&"},
						"alert","rodwarn",--throttle this
					},
				},
			},
			-- Lightning Rod removed
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 83099,
				execute = {
					{
						"removeraidicon","#5#",
					},
				},
			},
			-- Thundershock
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 92469,
				execute = {
					{
						"quash","shockcd",
						"alert","shockcd",
					},
				},
			},
			-- Lightning Blast (only Arrow)
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 83087,
				execute = {
					{
						"scheduletimer",{"blink",2},
					},
				},
			},
			-- Phase 3 Trigger
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 82285,
				execute = {
					{
						"quashall",true,
						"set",{phase = 3},
						"alert","phasewarn",
						"schedulealert",{"crushcd",17},
						"tracing",{43735}, -- Monstrosity
					},
				},
			},
			-- Gravity Crush
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 92486,
				execute = {
					{
						"quash","crushcd",
						"raidicon","crushmark",
						"alert","crushcd", --throttle this!
					},
				},
			},
			-- Gravity crush removed
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 92486,
				execute = {
					{
						"removeraidicon","#5#",
					},
				},
			},
			-- Heroic Events
			-- Static Overload
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 92067,
				srcisnpctype = true,
				execute = {
					{
						"raidicon","overloadmark",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert","overloadself",
						"announce","overloadsay",
					},
					{
						"expect",{"#4#","~=","&playerguid&"},
						"set",{overloadtext = format("%s: #5#!",SN[92067])},
						"alert","overloadwarn",
					},
				},
			},
			-- Static Overload removed
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 92067,
				execute = {
					{
						"removeraidicon","#5#",
						"quash","overloadwarn",
					},
				},
			},
			-- Gravity Core
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 92075,
				srcisnpctype = true,
				execute = {
					{
						"raidicon","coremark",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert","coreself",
						"announce","coresay",
					},
					{
						"expect",{"#4#","~=","&playerguid&"},
						"set",{coretext = format("%s: #5#!",SN[92075])},
						"alert","corewarn",
					},
				},
			},
			-- Gravity Core removed
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 92075,
				execute = {
					{
						"removeraidicon","#5#",
						"quash","corewarn",
					},
				},
			},
			-- Frost Beacon
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 92307,
				execute = {
					{
						"raidicon","beaconmark",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert","beaconself",
						"announce","beaconsay",
					},
					{
						"expect",{"#4#","~=","&playerguid&"},
						"set",{beacontext = format("%s: #5#!",SN[92307])},
						"alert","beaconwarn",
					},
				},
			},
			-- Frost Beacon removed
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 92307,
				execute = {
					{
						"removeraidicon","#5#",
						"quash","beaconwarn",
						"quash","beaconself",
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end

---------------------------------
-- VALIONA & THERALION
---------------------------------

do
	local data = {
		version = 16,
		key = "valther",
		zone = L.zone["The Bastion of Twilight"],
		category = L.zone["Bastion"],
		name = L.npc_bastion["Valiona & Theralion"],
		triggers = {
			scan = {
				45992, -- Valiona
				45993, -- Theralion
			},
		},
		onactivate = {
			tracing = {
				45992, -- Valiona
				45993, -- Theralion
			},
			tracerstart = true,
			combatstop = true,
			defeat = {
				45992, -- Valiona
				45993, -- Theralion
			},
		},
		userdata = {
			blackoutcd = {45,192,45, loop = true, type = "series"},
			shifttext = "",
			breathwarned = "no",
			meteoritewarned = "no",
		},
		onstart = {
			{
				"alert",{"blackoutcd",time = 2},
			},
		},
		alerts = {
			flamewarn = {
				varname = format(L.alert["%s Casting"],SN[86840]),
				type = "centerpopup",
				text = format(L.alert["%s Casting"],SN[86840]),
				time = 2.5,
				flashtime = 2.5,
				color1 = "ORANGE",
				sound = "ALERT12",
				icon = ST[86840],
			},
			dazzlewarn = {
				varname = format(L.alert["%s Casting"],SN[86408]),
				type = "centerpopup",
				text = format(L.alert["%s Casting"],SN[86408]),
				time = 4,
				flashtime = 4,
				color1 = "GREEN",
				sound = "ALERT2",
				icon = ST[86408],
			},
			engulfcd = {
				varname = format(L.alert["%s Cooldown"],SN[95639]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[95639]),
				time = 20,
				flashtime = 5,
				color1 = "CYAN",
				icon = ST[95639],
			},
			engulfself = {
				varname = format(L.alert["%s on self"],SN[95639]),
				type = "centerpopup",
				text = format("%s: %s!",SN[95639],L.alert["YOU"]),
				time = 20,
				color1 = "CYAN",
				icon = ST[95639],
				flashscreen = true,
				sound = "ALERT9",
			},
			blackoutself = {
				varname = format(L.alert["%s on self"],SN[92876]),
				type = "centerpopup",
				text = format("%s: %s!",SN[92876],L.alert["YOU"]),
				time = 15,
				color1 = "BLACK",
				sound = "ALERT1",
				icon = ST[92876],
				flashscreen = true,
			},
			blackoutwarn = {
				varname = format(L.alert["%s Warning"],SN[92876]),
				type = "centerpopup",
				text = format("%s: #5#!",SN[92876]),
				time = 15,
				color1 = "BLACK",
				icon = ST[92876],
			},
			blackoutcd = {
				varname = format(L.alert["%s Cooldown"],SN[92876]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[92876]),
				time = "<blackoutcd>",
				time2 = 10,
				flashtime = 5,
				color1 = "BLACK",
				icon = ST[92876],
			},
			meteoriteself = {
				varname = format(L.alert["%s on self"],SN[88518]),
				type = "centerpopup",
				text = format(L.alert["%s on %s"],SN[88518],L.alert["YOU"]),
				time = 6,
				flashtime = 6,
				color1 = "PURPLE",
				icon = ST[88518],
				sound = "ALERT2",
				flashscreen = true,
			},
			blastself = {
				varname = format(L.alert["%s on self"],SN[92898]),
				type = "simple",
				text = format(L.alert["%s on %s"],SN[92898],L.alert["YOU"]),
				time = 6,
				flashtime = 6,
				color1 = "PURPLE",
				icon = ST[92898],
				sound = "ALERT2",
			},
			shiftcd = {
				varname = format(L.alert["%s Cooldown"],SN[93051]),
				type = "dropdown",
				text = "<shifttext>",
				time = 20,
				flashtime = 5,
				color1 = "PINK",
				icon = ST[93051],
			},
			breathcd = {
				varname = format(L.alert["%s Cooldown"],SN[86059]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[86059]),
				time = 113,
				flashtime = 10,
				color1 = "YELLOW",
				icon = ST[86059],
				sound = "ALERT4",
			},
		},
		arrows = {
			blackoutarrow = {
				varname = SN[92876],
				unit = "#5#",
				persist = 15,
				action = "TOWARD",
				msg = L.alert["MOVE TOWARD"],
				spell = SN[92876],
			},
		},
		raidicons = {
			blackoutmark = {
				varname = SN[92876],
				type = "FRIENDLY",
				persist = 15,
				unit = "#5#",
				icon = 1,
			},
			engulfmark = {
				varname = SN[95639],
				type = "MULTIFRIENDLY",
				persist = 20,
				unit = "#5#",
				icon = 2,
				reset = 3, -- Looks like 2 on 25 man, TODO: Check for 10 man count
				total = 3,
			},
		},
		timers = {
			firemeteorite = {
				{
					"expect",{"&playerdebuff|"..SN[88518].."&","==","true"},
					"expect",{"<meteoritewarned>","==","no"},
					"alert","meteoriteself",
					"set",{meteoritewarned = "yes"},
					"scheduletimer",{"teardownmeteorite",6},
				},
			},
			teardownmeteorite = {
				{
					"set",{meteoritewarned = "no"},
				},
			},
			fireblast = {
				{
					"expect",{"&tft2_unitexists& &tft2_isplayer&","==","true true"},
					"alert","blastself",
				},
			},
		},
		events = {
			-- Twilight Shift on Tanks
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellid = 93051,
				execute = {
					{
						"quash","shiftcd",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"set",{shifttext = format("%s: %s!",SN[93051],L.alert["YOU"])},
						"alert","shiftcd",
					},
					{
						"expect",{"#4#","~=","&playerguid&"},
						"set",{shifttext = format("%s: #5#!",SN[93051])},
						"alert","shiftcd",
					},
				},
			},
			-- Twilight Shift Dose on Tanks
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED_DOSE",
				spellid = 93051,
				execute = {
					{
						"quash","shiftcd",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"set",{shifttext = format("%s: %s! %s!",SN[93051],L.alert["YOU"],format(L.alert["%s Stacks"],"#11#"))},
						"alert","shiftcd",
					},
					{
						"expect",{"#4#","~=","&playerguid&"},
						"set",{shifttext = format("%s: #5#! %s!",SN[93051],format(L.alert["%s Stacks"],"#11#"))},
						"alert","shiftcd",
					},
				},
			},
			-- Devouring Flames
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 86840,
				execute = {
					{
						"alert","flamewarn",
						"set",{breathwarned = "no"},
					}
				},
			},
			-- Dazzling Destruction
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 86408,
				execute = {
					{
						"alert","dazzlewarn",
						"expect",{"<breathwarned>","==","no"},
						"alert","breathcd",
						"set",{breathwarned = "yes"},
					}
				},
			},
			-- Engulfing Magic
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 95639,
				execute = {
					{
						"raidicon","engulfmark",
						"quash","engulfcd",
						"alert","engulfcd",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert","engulfself",
					},
				},
			},
			-- Blackout
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 92876,
				execute = {
					{
						"quash","engulfcd",
						"raidicon","blackoutmark",
						"quash","blackoutcd",
						"alert","blackoutcd",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert","blackoutself",
					},
					{
						"expect",{"#4#","~=","&playerguid&"},
						"alert","blackoutwarn",
						"arrow","blackoutarrow",
					},
				},
			},
			-- Blackout removal
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 92876,
				execute = {
					{
						"quash","blackoutwarn",
						"quash","blackoutself",
						"removeraidicon","#5#",
						"removearrow","#5#",
					},
				},
			},
			-- Twilight Meteorite
			{
                type = "event",
                event = "UNIT_AURA",
                execute = {
                    {
                        "expect",{"#1#","==","player"},
						"scheduletimer",{"firemeteorite",0.1},
                    },
                },
            },
			-- Twilight Blast
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 92898,
				execute = {
					{
						"scheduletimer",{"fireblast",0.2},
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end

---------------------------------
-- HALFUS WYRMBREAKER
---------------------------------

do
	local data = {
		version = 4,
		key = "halfus",
		zone = L.zone["The Bastion of Twilight"],
		category = L.zone["Bastion"],
		name = L.npc_bastion["Halfus Wyrmbreaker"],
		triggers = {
			scan = {
				44600, -- Halfus Wyrmbreaker
				44650, -- Storm Rider
				44645, -- Nether Scion
				44797, -- Time Warden
				44652, -- Slate Dragon
			},
		},
		onactivate = {
			tracing = {44600},
			tracerstart = true,
			combatstop = true,
			defeat = 44600,
		},
		userdata = {
			furioustime = 25,
			novacd = 10,
			phase = 0,
		},
		onstart = {
			{
				"set",{phase = 1},
			},
			{
				"alert","enragecd",
			},
			{
				"expect",{"&difficulty&",">=","3"}, --10h&25h
				"set",{
					novacd = 7,
				},
			},
		},
		alerts = {
			enragecd = {
				varname = L.alert["Enrage"],
				type = "dropdown",
				text = L.alert["Enrage"],
				time = 360,
				flashtime = 10,
				color1 = "RED",
				icon = ST[12317],
			},
			novacd = {
				varname = format(L.alert["%s CD"],SN[86168]),
				type = "dropdown",
				text = format(L.alert["%s CD"],SN[86168]),
				time = "<novacd>",
				flashtime = 3,
				color1 = "BLUE",
				sound = "ALERT10",
				icon = ST[86168],
			},
			furiouscd = {
				varname = format(L.alert["%s Cooldown"],SN[86169]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[86169]),
				time = 30,
				flashtime = 10,
				color1 = "MAGENTA",
				sound = "ALERT3",
				throttle = 5,
				icon = ST[86169],
			},
			furiouswarn = {
				varname = format(L.alert["%s Cast"],SN[86169]),
				type = "simple",
				text = format(L.alert["%s Cast"],SN[86169]),
				time = 3,
				sound = "ALERT1",
				color1 = "GOLD",
				throttle = 5,
				icon = ST[86169],
			},			
			scorchingbreathdur = {
				varname = format(L.alert["%s Duration"], SN[83707]),
				type = "dropdown",
				text = format(L.alert["%s Duration"], SN[83707]),
				time = 6,
				flashtime  = 6,
				color1 = "ORANGE",
				icon = ST[83707],
				throttle = 6,			
			},
			scorchingbreathcd = {
				varname = format(L.alert["%s Cooldown"], SN[83707]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"], SN[83707]),
				time = "<scorchingbreathtime>",
				flashtime = 15,
				color1 = "RED",
				icon = ST[83707],
				throttle = 7,
			},
		},
		events = {
			-- Scorching Breath
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellid = {83707, 83855, 86163, 86164, 86165},
				execute = {
					{
						"quash", "scorchingbreathcd",
						"alert", "scorchingbreathcd",
						"alert", "scorchingbreathdur",
					},
				},
			},
			-- Furious Roar
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 86169,
				execute = {
					{
						"set", {phase = 2},
						"quash","furiouscd",
						"alert","furiouscd",
						"alert","furiouswarn",
					},
				},
			},
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 86168,
				execute = {
					{
						"alert","novacd",
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end

---------------------------------
-- CHO'GALL
---------------------------------

do
	local data = {
		version = 5,
		key = "chogall",
		zone = L.zone["The Bastion of Twilight"],
		category = L.zone["Bastion"],
		name = L.npc_bastion["Cho'gall"],
		triggers = {
			scan = {
				43324, -- Cho'gall
			},
		},
		onactivate = {
			tracing = {43324},
			tracerstart = true,
			combatstop = true,
			defeat = 43324,
		},
		windows = {
			apbwindow = true,
		},
		userdata = {
			phase = 1,
			conversiontime = 11,
			adherenttime = {57,91,loop = false, type = "series"},
			furytime = {50,47,loop = false, type = "series"},
			creationstime = {30,40,loop = false, type = "series"},
			warned = "no",
		},
		onstart = {
			{
				"set",{phase = 1},
			},
			{
				"expect",{"&difficulty&",">=","3"}, --10h&25h
				"set",{
					adherenttime = {80,91,loop = false, type = "series"},
					furytime = {75,47,loop = false, type = "series"},
				},
			},
			{
				"alert","furycd",
				"alert","conversioncd",
				"set",{conversiontime = 24},
				"alert","adherentcd",
				"scheduletimer",{"checkhp",5},
			},
		},
		timers = {
			checkhp = {
				{
					"expect",{"&gethp|boss1&","<","88"},
					"expect",{"<warned>","==","no"},
					"alert","furysoon",
					"set",{warned = "yes"},
				},
				{
					"scheduletimer",{"checkhp",1},
				},
			},
		},
		alerts = {
			phasewarn = {
				varname = format(L.alert["Phase Warning"]),
				type = "simple",
				text = format(L.alert["Phase %s Warning"],"<phase>"),
				time = 3,
				flashtime = 3,
				color1 = "PURPLE",
				icon = ST[99259],
				sound = "ALERT1",
			},
			-- Phase 1
			conversioncd = {
				varname = format(L.alert["%s Cooldown"],SN[91303]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[91303]),
				time = "<conversiontime>",
				flashtime = 5,
				color1 = "YELLOW",
				icon = ST[91303],
			},
			conversionwarn = {
				varname = format(L.alert["%s Warning"],SN[91303]),
				type = "simple",
				text = SN[91303].."!",
				time = 3,
				flashtime = 3,
				color1 = "YELLOW",
				sound = "ALERT1",
				icon = ST[91303],
			},
			adherentcd = {
				varname = format(L.alert["%s Cooldown"],SN[81628]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[81628]),
				time = "<adherenttime>",
				flashtime = 5,
				color1 = "BLUE",
				icon = ST[81628],
			},
			adherentwarn = {
				varname = format(L.alert["%s Warning"],SN[81628]),
				type = "simple",
				text = SN[81628].."!",
				time = 3,
				flashtime = 3,
				color1 = "BLUE",
				sound = "ALERT2",
				icon = ST[81628],
			},
			furysoon = {
				varname = format(L.alert["%s soon"],SN[82524]),
				type = "simple",
				text = format(L.alert["%s soon"],SN[82524]),
				time = 5,
				flashtime = 5,
				color1 = "CYAN",
				sound = "ALERT3",
				icon = ST[82524],
			},
			furycd = {
				varname = format(L.alert["%s Cooldown"],SN[82524]),
				type = "dropdown",
				text = SN[82524].."!",
				time = "<furytime>",
				flashtime = 5,
				color1 = "CYAN",
				icon = ST[82524],
			},
			furywarn = {
				varname = format(L.alert["%s Warning"],SN[82524]),
				type = "simple",
				text = SN[82524].."!",
				time = 3,
				flashtime = 3,
				color1 = "CYAN",
				sound = "ALERT3",
				icon = ST[82524],
			},
			festerbloodcd = {
				varname = format(L.alert["%s Cooldown"],SN[82299]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[82299]),
				time = 38,
				flashtime = 5,
				color1 = "MAGENTA",
				icon = ST[82299],
			},
			festerbloodwarn = {
				varname = format(L.alert["%s Warning"],SN[82299]),
				type = "simple",
				text = SN[82299].."!",
				color1 = "MAGENTA",
				sound = "ALERT4",
				time = 3,
				flashtime = 3,
			},
			blazewarnself = {
				varname = format(L.alert["%s on self"],SN[81538]),
				type = "simple",
				text = format("%s: %s! %s!",SN[81538],L.alert["YOU"],L.alert["MOVE AWAY"]),
				time = 3,
				flashtime = 3,
				throttle = 3,
				flashscreen = true,
				color1 = "ORANGE",
				sound = "ALERT12",
				icon = ST[81538],
			},
			crashwarn = {
				varname = format(L.alert["%s Casting"],SN[93180]),
				type = "simple",
				text = format("%s: %s!",SN[93180],L.alert["YOU"]),
				text2 = format("%s: &upvalue&!",SN[93180]),
				text3 = format(L.alert["%s Casting"],SN[93180]),
				time = 4,
				color1 = "PINK",
				sound = "ALERT10",
				icon = ST[93180],
			},
			crashcd = {
				varname = format(L.alert["%s Cooldown"],SN[93180]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[93180]),
				time = 10,
				flashtime = 3,
				color1 = "PINK",
				icon = ST[93180],
			},
			-- Phase 2
			creationscd = {
				varname = format(L.alert["%s Cooldown"],SN[82414]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[82414]),
				time = "<creationstime>",
				flashtime = 5,
				color1 = "PURPLE",
				icon = ST[82414],
			},
			creationswarn = {
				varname = format(L.alert["%s Warning"],SN[82414]),
				type = "simple",
				text = SN[82414].."!",
				time = 3,
				flashtime = 3,
				color1 = "PURPLE",
				sound = "ALERT5",
				icon = ST[82414],
			},
			-- Adds (Heroic)
			fireaddwarn = {
				varname = format(L.alert["%s Warning"],SN[93266]),
				type = "centerpopup",
				text = SN[93266].." inc",
				time = 20.5,
				flashtime = 5,
				color1 = "ORANGE",
				sound = "ALERT5",
				icon = ST[93266],
			},
			shadowaddwarn = {
				varname = format(L.alert["%s Warning"],SN[93220]),
				type = "centerpopup",
				text = SN[93220].." inc",
				time = 21.4,
				flashtime = 5,
				color1 = "PURPLE",
				sound = "ALERT5",
				icon = ST[93220],
			},
		},
		raidicons = {
			worshipmark = {
				varname = SN[91317],
				type = "MULTIFRIENDLY",
				persist = 5,
				reset = 5,
				unit = "#5#",
				icon = 1,
				total = 4,
			},
			crashmark = {
				varname = SN[93180],
				type = "MULTIFRIENDLY",
				persist = 6,
				reset = 5,
				unit = "&upvalue&",
				icon = 5,
				total = 2,
			},
		},
		announces = {
			crashsay = {
				varname = format(L.alert["Say %s on self"],SN[93180]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[93180]).."!",
			},
		},
		arrows = {
			crasharrow = {
				varname = SN[93180],
				unit = "&upvalue&",
				persist = 6,
				action = "AWAY",
				msg = L.alert["MOVE AWAY"],
				spell = SN[93180],
				range1 = 5,
				range2 = 8,
				range3 = 12,
			},
		},
		events = {
			-- Summon Corrupting Adherent
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 81628,
				execute = {
					{
						"quash","adherentcd",
						"alert","adherentcd",
						"alert","adherentwarn",
						"alert","festerbloodcd",
						"set",{conversiontime = 37},
					},
				},
			},
			-- Shadow Crash
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 93180,
				execute = {
					{
						"target",{
							source = "#1#", -- Corrupting Adherent
							wait = 0.3,
							announce = "crashsay",
							raidicon = "crashmark",
							arrow = "crasharrow",
							alerts = {
								self = "crashwarn",
								other = {"crashwarn",text = 2},
								unknown = {"crashwarn",text = 3},
							},
						},
						"alert","crashcd",
					},
				},
			},
			-- Adherent Death
			{
				type = "combatevent",
				eventtype = "UNIT_DIED",
				execute = {
					{
						"expect",{"&npcid|#4#&","==","43622"},
						"quash","crashcd",
					},
				},
			},
			-- Fury of Cho'gall
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 82524,
				execute = {
					{
						"alert","furycd",
						"alert","furywarn",
						"canceltimer","checkhp",
					},
				},
			},
			-- Festerblood
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 82299,
				execute = {
					{
						"quash","festerbloodcd",
						"alert","festerbloodwarn",
					},
				}
			},
			-- Conversion
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 91303,
				execute = {
					{
						"alert","conversioncd",
						"alert","conversionwarn",
					},
				},
			},
			-- Worshipping
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 91317,
				execute = {
					{
						"raidicon","worshipmark",
					},
				},
			},
			-- Blaze on self
			{
				type = "combatevent",
				eventtype = "SPELL_DAMAGE",
				spellname = 81538,
				execute = {
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert","blazewarnself",
					},
				},
			},
			-- Consume Blood of the Old God
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 82630,
				execute = {
					{
						"quashall",true,
						"set",{phase = 2},
						"alert","phasewarn",
						"alert","creationscd",
					},
				},
			},
			-- Darkened Creations
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 82414,
				execute = {
					{
						"quash","creationscd",
						"alert","creationscd",
						"alert","creationswarn",
					},
				},
			},
			-- Flame Orders
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 81171,
				execute = {
					{
						"alert","fireaddwarn",
					},
				},
			},
			-- Shadow Orders
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 81556,
				execute = {
					{
						"alert","shadowaddwarn",
					},
				},
			},
		},
	}


	DXE:RegisterEncounter(data)
end

---------------------------------
-- Lady Sinestra
---------------------------------

do
	local data = {
		version = 3,
		key = "sinestra",
		zone = L.zone["The Bastion of Twilight"],
		category = L.zone["Bastion"],
		name = L.npc_bastion["Lady Sinestra"],
		triggers = {
			scan = {
				45213, -- Sinestra
			},
		},
		onactivate = {
			tracing = {45213},
			tracerstart = true,
			combatstop = true,
			defeat = 45213,
		},
		userdata = {
			breathcd = {21,23, loop = false, type = "series"},
			slicercd = 29.5,
			wrackcd = {15,62.5, loop = false, type = "series"},
			wracktext = "",
			phase = "",
			warned = "no",
		},
		onstart = {
			{
				"alert",{"whelpscd",time = 2},
				"alert","breathcd",
				"alert","slicercd",
				"scheduletimer",{"slicer","<slicercd>"},
				"alert","wrackcd",
				"set",{phase = "1"},
			},
		},
		timers = {
			slicer = {
				{
					"alert","slicercd",
					"alert","slicerwarn",
					"scheduletimer",{"slicer","<slicercd>"},
				},
			},
			spitecaller = {
				{
					"alert","spiteinc",
					"scheduletimer",{"spitecaller",22},
				},
			},
		},
		alerts = {
			breathcd = {
				varname = format(L.alert["%s Cooldown"],SN[92944]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[92944]),
				time = "<breathcd>",
				time2 = 10,
				flashtime = 5,
				color1 = "ORANGE",
				icon = ST[92944],
			},
			breathwarn = {
				varname = format(L.alert["%s Warning"],SN[92944]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[92944]),
				time = 3,
				flashtime = 3,
				color1 = "ORANGE",
				icon = ST[92944],
				sound = "ALERT1",
			},
			slicercd = {
				varname = format(L.alert["%s Cooldown"],SN[92954]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[92954]),
				time = "<slicercd>",
				time2 = 10,
				flashtime = 5,
				color1 = "PURPLE",
				icon = ST[92954],
			},
			slicerwarn = {
				varname = format(L.alert["%s Warning"],SN[92954]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[92954]),
				time = 3,
				flashtime = 3,
				color1 = "PURPLE",
				icon = ST[92954],
				sound = "ALERT2",
			},
			wrackcd = {
				varname = format(L.alert["%s Cooldown"],SN[92955]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[92955]),
				time = "<wrackcd>",
				flashtime = 5,
				color1 = "BLACK",
				icon = ST[92955],
			},
			wrackwarn = {
				varname = format(L.alert["%s Warning"],SN[92955]),
				type = "simple",
				text = "<wracktext>",
				time = 3,
				flashtime = 3,
				color1 = "BLACK",
				icon = ST[92955],
				sound = "ALERT3",
			},
			phasewarn = {
				varname = format(L.alert["Phase Warnings"]),
				type = "simple",
				text = format(L.alert["Phase %s Warning"],"<phase>"),
				time = 5,
				flashtime = 5,
				color1 = "WHITE",
				sound = "ALERT6",
			},
			eggshield = {
				varname = format(L.alert["%s Cooldown"],SN[87654]),
				type = "centerpopup",
				text = format(L.alert["%s Cooldown"],SN[87654]),
				time = 4.5,
				flashtime = 4.5,
				color1 = "PURPLE",
				icon = ST[87654],
				sound = "ALERT1",
			},
			eggwarn = {
				varname = format(L.alert["Eggs vulnerable"]),
				type = "centerpopup",
				text = format(L.alert["Eggs vulnerable"]),
				time = 30,
				flashtime = 5,
				color1 = "PURPLE",
				sound = "ALERT5",
				throttle = 2,
			},
			whelpscd = {
				varname = format(L.alert["Whelps incoming"]),
				type = "dropdown",
				text = format(L.alert["Whelps incoming"]),
				time = 50,
				time2= 15,
				flashtime = 5,
				color1 = "PURPLE",
				sound = "ALERT4",
			},
			essencewarn = {
				varname = format(L.alert["%s Warning"],SN[87946]),
				type = "dropdown",
				text = format(L.alert["%s"],SN[87946]),
				time = 180,
				flashtime = 20,
				color1 = "RED",
				icon = ST[87946],
			},
		},
		events = {
			-- Flame Breath
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 92944,
				execute = {
					{
						"alert","breathcd",
						"alert","breathwarn",
					},
				},
			},
			-- Wrack
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 92955,
				execute = {
					{
						"alert","wrackcd",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"set",{wracktext = format(L.alert["%s on "],SN[92955],L.alert["YOU"])},
						"alert","wrackwarn",
					},
					{
						"expect",{"#4#","~=","&playerguid&"},
						"set",{wracktext = format(L.alert["%s on %s"],SN[92955],"#5#")},
						"alert","wrackwarn",
					},
				},
			},
			-- Mana Barrier == Phase 2 starting
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 87299,
				execute = {
					{
						"batchquash",{"wrackcd","breathcd","slicercd","whelpscd"},
						"canceltimer","slicer",
						"set",{phase = "2"},
						"alert","phasewarn",
					},
				},
			},
			-- Eggs vulnerable
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 87654,
				execute = {
					{
						"alert","eggwarn",
					},
				},
			},
			-- Essence of the Red
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 87946,
				execute = {
					{
						"alert","essencewarn",
					},
				},
			},
			-- Yells
			{
				type = "event",
				event = "YELL",
				execute = {
					{
						"expect",{"#1#","find",L.chat_bastion["^Feed, children"]},
						"alert","whelpscd",
					},
					{
						"expect",{"#1#","find",L.chat_bastion["^You mistake this for weakness?"]},
						"alert","eggshield",
					},
					{
						"expect",{"#1#","find",L.chat_bastion["^Enough!"]},
						"quash","eggwarn",
						"set",{phase = "3"},
						"alert","phasewarn",
						"set",{slicercd = 29},
						"alert","slicercd",
						"scheduletimer",{"slicer","<slicercd>"},
						"set",{slicercd = 28},
						"alert","breathcd",
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end
