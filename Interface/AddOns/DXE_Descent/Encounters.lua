local L,SN,ST = DXE.L,DXE.SN,DXE.ST

---------------------------------
-- OMNITRON DEFENSE SYSTEM
---------------------------------

do
	local data = {
		version = 9,
		key = "omnitron",
		zone = L.zone["Blackwing Descent"],
		category = L.zone["Descent"],
		name = L.npc_descent["Omnitron Defense System"],
		triggers = {
			scan = {
				42166, -- Arcanotron
				42179, -- Electron
				42178, -- Magmatron
				42180, -- Toxitron
			},
			yell = L.chat_descent["unit activated"],
		},
		onactivate = {
			tracing = {
				42166, -- Arcanotron
				42179, -- Electron
				42178, -- Magmatron
				42180, -- Toxitron
			},
			tracerstart = true,
			combatstop = true,
			defeat = {
				42166, -- Arcanotron
				42179, -- Electron
				42178, -- Magmatron
				42180, -- Toxitron
			},
		},
		userdata = {
			activetime = 45,
			activetext = "",
			encasingtext = "",
			conductortext = "",
			infusiontext = "",
			incinerationcd = {10,25,32, loop = true, type = "series"},
			flamethrowercd = {20,40, loop = true, type = "series"},
			generatorcd = {11,30,30, loop = true, type = "series"},
			conductorcd = {12,25,25, loop = true, type = "series"},
			conductordur = 10,
			poisonbombcd = {10,30,35, loop = true, type = "series"},
			addscd = {20,45, loop = true, type = "series"},
			started = "no",
		},
		onstart = {
			{
				"expect",{"<started>","==","no"},
				"expect",{"&difficulty&",">=","3"}, --10h&25h
				"set",{
					activetime = 30,
					incinerationcd = {10,30, loop = true, type = "series"},
					flamethrowercd = {20,25, loop = true, type = "series"},
					generatorcd = {15,20,20, loop = true, type = "series"},
					conductorcd = {15,20,20, loop = true, type = "series"},
					conductordur = 16,
					poisonbombcd = {25,30, loop = true, type = "series"},
					addscd = {15,20, loop = true, type = "series"},
					neftime = 32,
				},
			},
			{
				"expect",{"<started>","==","no"},
				"expect",{"#1#","find",L.chat_descent["^Toxitron"]},
				"alert","poisonbombcd",
				"alert","addscd",
				"set",{activetext = format("%s %s",L.npc_descent["Toxitron"],SN[95018])},
				"alert","activedur",
				"set",{neftime = 30},
				"alert","nef",
			},
			{
				"expect",{"<started>","==","no"},
				"expect",{"#1#","find",L.chat_descent["^Arcanotron"]},
				"alert","generatorcd",
				"set",{activetext = format("%s %s",L.npc_descent["Arcanotron"],SN[95018])},
				"alert","activedur",
				"set",{neftime = 20},
				"alert","nef",
			},
			{
				"expect",{"<started>","==","no"},
				"expect",{"#1#","find",L.chat_descent["^Magmatron"]},
				"alert","incinerationcd",
				"alert","flamethrowercd",
				"set",{activetext = format("%s %s",L.npc_descent["Magmatron"],SN[95018])},
				"alert","activedur",
				"set",{neftime = 20},
				"alert","nef",
			},
			{
				"expect",{"<started>","==","no"},
				"expect",{"#1#","find",L.chat_descent["^Electron"]},
				"alert","conductorcd",
				"set",{activetext = format("%s %s",L.npc_descent["Electron"],SN[95018])},
				"alert","activedur",
				"set",{neftime = 15},
				"alert","nef",
			},
			{
				"expect",{"<started>","==","no"},
				"set",{neftime = 32},
				"alert","berserk",
				"set",{started = "yes"},
			},
		},
		--windows = {
		--},
		alerts = {
			berserk = {
				varname = format(L.alert["Berserk Timer"]),
				type = "dropdown",
				text = format(L.alert["Berserk Timer"]),
				time = 600,
				flashtime = 30,
				color1 = "RED",
			},
			activedur = {
				varname = format(L.alert["%s Duration"],SN[95016]),
				type = "dropdown",
				text = "<activetext>",
				time = "<activetime>",
				flashtime = 5,
				color1 = "MAGENTA",
				sound = "ALERT1",
				icon = ST[95016]
			},
			incinerationcd = {
				varname = format(L.alert["%s Cooldown"],L.alert["Incineration"]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],L.alert["Incineration"]),
				time = "<incinerationcd>",
				flashtime = 5,
				color1 = "ORANGE",
				icon = ST[91521]
			},
			incinerationwarn = {
				varname = format(L.alert["%s Warning"],L.alert["Incineration"]),
				type = "simple",
				text = format("%s Casting!",L.alert["Incineration"]),
				time = 5.5,
				color1 = "ORANGE",
				sound = "ALERT2",
				icon = ST[91521],
			},
			flamethrowercd = {
				varname = format(L.alert["%s Cooldown"],SN[91533]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[91533]),
				time = "<flamethrowercd>",
				flashtime = 5,
				color1 = "RED",
				icon = ST[91533]
			},
			flamethrowerwarn = {
				varname = format(L.alert["%s Warning"],SN[91533]),
				type = "centerpopup",
				text = "<flamethrowertext>",
				time = 8,
				color1 = "RED",
				sound = "ALERT3",
				icon = ST[91533],
			},
			flamethrowerself = {
				varname = format(L.alert["%s on self"],SN[91533]),
				type = "centerpopup",
				text = format(L.alert["%s on %s"],SN[91533],L.alert["YOU"]),
				time = 8,
				color1 = "RED",
				sound = "ALERT12",
				icon = ST[91533],
				flashscreen = true,
			},
			encasingwarn = {
				varname = format(L.alert["%s Warning"],SN[92023]),
				type = "centerpopup",
				text = "<encasingtext>",
				time = 8,
				color1 = "BROWN",
				sound = "ALERT12",
				icon = ST[92023],
			},
			encasingself = {
				varname = format(L.alert["%s on self"],SN[92023]),
				type = "centerpopup",
				text = format(L.alert["%s on %s"],SN[92023],L.alert["YOU"]),
				time = 8,
				color1 = "BROWN",
				sound = "ALERT10",
				icon = ST[92023],
				flashscreen = true,
			},
			generatorcd = {
				varname = format(L.alert["%s Cooldown"],SN[79624]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[79624]),
				time = "<generatorcd>",
				flashtime = 5,
				color1 = "WHITE",
				icon = ST[79624]
			},
			overcharged = {
				varname = format(L.alert["Overcharged Zone"]),
				type = "dropdown",
				text = format(L.alert["Overcharged Zone, get out!"]),
				time = 8,
				flashtime = 8,
				color1 = "WHITE",
				sound = "ALERT12",
				icon = ST[91857]
			},
			conductorcd = {
				varname = format(L.alert["%s Cooldown"],SN[91433]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[91433]),
				time = "<conductorcd>",
				flashtime = 5,
				color1 = "BLUE",
				icon = ST[91433]
			},
			conductorwarn = {
				varname = format(L.alert["%s Warning"],SN[91433]),
				type = "centerpopup",
				text = "<conductortext>",
				time = "<conductordur>",
				flashtime = 16,
				color1 = "CYAN",
				sound = "ALERT6",
				icon = ST[91433]
			},
			infusionwarn = {
				varname = format(L.alert["%s Warning"],SN[92048]),
				type = "centerpopup",
				text = "<infusiontext>",
				time = 16,
				flashtime = 16,
				color1 = "PURPLE",
				sound = "ALERT7",
				icon = ST[92048]
			},
			poisonbombcd = {
				varname = format(L.alert["%s Cooldown"],SN[80157]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[80157]),
				time = "<poisonbombcd>",
				flashtime = 5,
				color1 = "GREEN",
				icon = ST[80157]
			},
			addscd = {
				varname = format(L.alert["%s Cooldown"],SN[91515]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[91515]),
				time = "<addscd>",
				flashtime = 5,
				color1 = "TEAL",
				icon = ST[91515]
			},
			addswarn = {
				varname = format(L.alert["%s Warning"],SN[91515]),
				type = "simple",
				text = format(L.alert["Adds incoming!"]),
				time = 9,
				color1 = "TEAL",
				sound = "ALERT8",
				icon = ST[91515]
			},
			fixateself = {
				varname = format(L.alert["%s on self"],SN[80094]),
				type = "simple",
				text = format(L.alert["%s on %s"],SN[80094],L.alert["YOU"]),
				time = 3,
				color1 = "GREEN",
				sound = "ALERT12",
				icon = ST[80094],
				flashscreen = true,
			},
			nef = {
				varname = format(L.alert["Nefarian Ability CD"]),
				type = "dropdown",
				text = format(L.alert["Next Nefarian Action!"]),
				time = "<neftime>",
				flashtime = 7.5,
				color1 = "YELLOW",
				sound = "ALERT9",
			},
		},
		--timers = {
		--},
		raidicons = {
			flamethrowermark = {
				varname = SN[92035],
				type = "FRIENDLY",
				persist = 4,
				unit = "#5#",
				icon = 1,
			},
			infusionmark = {
				varname = SN[92048],
				type = "FRIENDLY",
				persist = 16,
				unit = "#5#",
				icon = 2,
			},
			conductormark = {
				varname = SN[91431],
				type = "FRIENDLY",
				persist = 16,
				unit = "#5#",
				icon = 3,
			},
		},
		arrows = {
			flames = {
				varname = SN[92023],
				unit = "#5#",
				persist = 8,
				action = "AWAY",
				msg = L.alert["MOVE AWAY"],
				spell = SN[92023],
			},
		},
		announces = {
			encasingsay = {
				varname = format(L.alert["Say %s on self"],SN[92023]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[92023]).."!",
			},
			infusionsay = {
				varname = format(L.alert["Say %s on self"],SN[92048]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[92048]).."!",
			},
			lightconductorsay = {
				varname = format(L.alert["Say %s on self"],SN[91433]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[91433]).."!",
			},
		},
		events = {
			-- Activated
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 95018,
				execute = {
					{
						"quash","activedur",
						"set",{activetext = format("%s %s","#5#",SN[95018]) },
						"alert","activedur",
					},
					{
						"expect",{"&npcid|#4#&","==","42178"}, -- Magmatron
						"alert","incinerationcd",
						"alert","flamethrowercd",
					},
					{
						"expect",{"&npcid|#4#&","==","42166"}, -- Arcanotron
						"alert","generatorcd",
					},
					{
						"expect",{"&npcid|#4#&","==","42179"}, -- Electron
						"alert","conductorcd",
					},
					{
						"expect",{"&npcid|#4#&","==","42180"}, --Toxitron
						"alert","poisonbombcd",
						"alert","addscd",
					},
				}
			},
			-- Deactivated
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 95018,
				execute = {
					{
						"expect",{"&npcid|#4#&","==","42178"}, -- Magmatron
						"quash","incinerationcd",
						"quash","flamethrowercd",
					},
					{
						"expect",{"&npcid|#4#&","==","42166"}, -- Arcanotron
						"quash","generatorcd",
					},
					{
						"expect",{"&npcid|#4#&","==","42179"}, -- Electron
						"quash","conductorcd",
					},
					{
						"expect",{"&npcid|#4#&","==","42180"}, --Toxitron
						"quash","poisonbombcd",
						"quash","addscd",
					},
				},
			},
			-- Incineration
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 91521,
				execute = {
					{
						"quash","incinerationcd",
						"alert","incinerationcd",
						"alert","incinerationwarn",
					},
				},
			},
			-- Flame Thrower
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 92037, -- it's actually Acquiring Target
				execute = {
					{
						"quash","flamethrowercd",
						"alert","flamethrowercd",
						"raidicon","flamethrowermark",
					},
					{
						"expect",{"#4#","~=","&playerguid&"},
						"set",{ flamethrowertext = format(L.alert["%s on %s"],SN[91533],"#5#") },
						"alert","flamethrowerwarn",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert","flamethrowerself",
					},
				},
			},
			-- Encasing Shadows
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 92023,
				execute = {
					{
						"quash","nef",
						"alert","nef",
						"arrow","flames",
					},
					{
						"expect",{"#4#","~=","&playerguid&"},
						"set",{ encasingtext = format(L.alert["%s on %s"],SN[92023],"#5#") },
						"alert","encasingwarn",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert","encasingself",
						"announce","encasingsay",
					},
				},
			},
			-- Power Generator
			{
				type ="combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellid = 79624, -- there are more spells named "power generator", so we need the id
				execute = {
					{
						"quash","generatorcd",
						"alert","generatorcd",
					},
				},
			},
			-- Overcharged Power Generator
			{
				type ="combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 91857,
				execute = {
					{
						"alert","overcharged",
						"quash","nef",
						"alert","nef",
					},
				},
			},
			-- Lightning Conductor
			{
				type ="combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 91433,
				execute = {
					{
						"quash","conductorcd",
						"alert","conductorcd",
						"set",{ conductortext = format("%s on %s",SN[91433],"#5#") },
						"alert","conductorwarn",
						"raidicon","conductormark",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"announce","lightconductorsay",
					},
				},
			},
			-- Shadow Infusion
			{
				type ="combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellid = 92048,
				execute = {
					{
						"quash","conductorwarn",
						"removeraidicon","#5#",
						"raidicon","infusionmark",
						"set",{ infusiontext = format("%s on %s",SN[92048],"#5#") },
						"alert","infusionwarn",
						"quash","nef",
						"alert","nef",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"announce","infusionsay",
					},
				},
			},
			-- Posion Cloud
			{
				type ="combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 80157,
				execute = {
					{
						"quash","poisonbombcd",
						"alert","poisonbombcd",
					},
				},
			},
			-- Poison Adds
			{
				type ="combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 91515,
				execute = {
					{
						"alert","addswarn",
						"alert","addscd",
					},
				},
			},
			{
				type ="combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 80094,
				execute = {
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert","fixateself",
					},
				},
			},
			-- Grip of Death
			{
				type ="combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 91849,
				execute = {
					{
						"quash","nef",
						"alert","nef",
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end


---------------------------------
-- MAGMAW
---------------------------------

do
	local data = {
		version = 4,
		key = "magmaw",
		zone = L.zone["Blackwing Descent"],
		category = L.zone["Descent"],
		name = L.npc_descent["Magmaw"],
		triggers = {
			scan = {
				41570, -- Magmaw
			},
		},
		onactivate = {
			tracing = {41570},
			tracerstart = true,
			combatstop = true,
			defeat = 41570,
		},
		userdata = {
			mangletext = "",
			manglecd = {90,95, loop = false, type = "series"},
			slumpcd = {100,95, loop = false, type = "series"},
			constructcd = {30,35, loop = false, type = "series"}, --heroic only
		},
		onstart = {
			{
				"alert","manglecd",
				"alert","slumpcd",
				"alert","pillarcd",
				"alert","enrage",
			},
			{
				"expect",{"&difficulty&",">=","3"}, --10h&25h
				"alert","constructcd",
			}
		},
		windows = {
		},
		alerts = {
			enrage = {
				varname = format(L.alert["%s Cooldown"],SN[26662]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[26662]),
				time = 600,
				flashtime = 30,
				color1 = "RED",
				icon = ST[26662],
			},
			manglewarn = {
				varname = format(L.alert["%s Warning"],SN[91912]),
				type = "centerpopup",
				text = "<mangletext>",
				time = 30,
				flashtime = 30,
				color1 = "GREEN",
				sound = "ALERT2",
				icon = ST[91912],
			},
			manglecd = {
				varname = format(L.alert["%s Cooldown"],SN[91912]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[91912]),
				time = "<manglecd>",
				flashtime = 6,
				color1 = "GREEN",
				icon = ST[91912],
			},
			pillarcd = {
				varname = format(L.alert["%s Cooldown"],SN[78006]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[78006]),
				time = 30,
				flashtime = 5,
				color1 = "CYAN",
				icon = ST[78006],
			},
			pillarwarn = {
				varname = format(L.alert["%s Warning"],SN[78006]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[78006]),
				time = 5,
				flashtime = 5,
				color1 = "CYAN",
				sound = "ALERT3",
				icon = ST[78006],
			},
			slumpcd = {
				varname = format(L.alert["Magmaw Slump Cooldown"]),
				type = "dropdown",
				text = format(L.alert["Magmaw Slumping"]),
				time = "<slumpcd>",
				flashtime = 5,
				color1 = "YELLOW",
			},
			slumpwarn = {
				varname = format(L.alert["Magmaw Slump Warning"]),
				type = "simple",
				text = format(L.alert["Mount him like you mean it!"]),
				time = 5,
				flashtime = 5,
				color1 = "YELLOW",
				sound = "ALERT4",
			},
			exposeddur = {
				varname = format(L.alert["Exposed Head Warning"]),
				type = "centerpopup",
				text = format(L.alert["Exposed Head!"]),
				time = 30,
				flashtime = 30,
				color1 = "RED",
			},
			constructcd = {
				varname = format(L.alert["%s Cooldown"],SN[92192]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[92192]),
				time = "<constructcd>",
				flashtime =7.5,
				color1 = "ORANGE",
				sound = "ALERT5",
			},
			p2warn = {
				varname = format(L.alert["Phase 2 Heroic Warning"]),
				type = "simple",
				text = format(L.alert["Phase 2 started!"]),
				time = 5,
				flashtime = 5,
				color1 = "PURPLE",
				sound = "ALERT1",
			},
			armageddonwarn = {
				varname = format(L.alert["%s Warning"],SN[92177]),
				type = "centerpopup",
				text = format(L.alert["%s Warning"],SN[92177]),
				time = 8,
				flashtime = 8,
				color1 = "RED",
				sound = "ALERT12",
				icon = ST[92177],
			},
		},
		timers = {
		},
		events = {
			-- Summon Add heroic only
			{
				type = "combatevent",
				eventtype = "SPELL_SUMMON",
				spellname = 92192,
				execute = {
					{
						"quash","constructcd",
						"alert","constructcd",
					},
				},
			},
			-- Armageddon (heroic)
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 92177,
				execute = {
					{
						"alert","armageddonwarn",
					},
				},
			},
			-- Mangle
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellid = {
					91912,
					94616,
					94617,
					89773,
				},
				execute = {
					{
						"set",{mangletext = format(L.alert["%s on %s"],SN[91912],"#5#")},
						"alert","manglewarn",
						"alert","manglecd",
					},
				},
			},
			-- Mangle removed
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellid = 91912,
				execute = {
					{
						"quash","manglewarn",
					},
				},
			},
			-- Pillar
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 78006,
				dstnpcid = 41570,
				execute = {
					{
						"alert","pillarwarn",
						"alert","pillarcd",
					},
				},
			},
			-- Emotes
			{
				type = "event",
				event = "EMOTE",
				execute = {
					{
						"expect",{"#1#","find",L.chat_descent["slumps forward"]},
						"quash","pillarcd",
						"alert","slumpwarn",
						"alert","slumpcd",
					},
					{
						"expect",{"#1#","find",L.chat_descent["becomes impaled"]},
						"alert","exposeddur",
						"schedulealert",{"pillarcd",10},
					},
				},
			},
			-- P2 Yell heroic only
			{
				type = "event",
				event = "YELL",
				execute = {
					{
						"expect",{"#1#","find",L.chat_descent["^Inconceivable"]},
						"quash","constructcd",
						"alert","p2warn",
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end

---------------------------------
-- ATRAMEDES
---------------------------------

do
	local data = {
		version = 8,
		key = "atramedes",
		zone = L.zone["Blackwing Descent"],
		category = L.zone["Descent"],
		name = L.npc_descent["Atramedes"],
		triggers = {
			scan = {
				41442, -- Atramedes
			},
		},
		onactivate = {
			tracing = {41442},
			tracerstart = true,
			combatstop = true,
			defeat = 41442,
		},
		windows = {
			apbwindow = true,
		},
		userdata = {
			grounddur = {90,85, loop = false, type = "series"},
			flamescd = 45,
			trackingtext = "",
			airyell = L.chat_descent["^Yes, run!"],
			fiendwarned = "no",
		},
		timers = {
			fiend = {
				{
					"expect",{"&playerdebuff|"..SN[92685].."&","==","true"},
					"expect",{"<fiendwarned>","==","no"},
					"anounce","fiendsay",
					"set",{fiendwarned = "yes"},
				},
			},
		},
		onstart = {
			{
				"alert","grounddur",
				"alert","flamescd",
			},
			{
				"expect",{"&difficulty&",">=","3"}, --10h&25h
				"alert","enrage",
			},
		},
		raidicons = {
			trackingmark = {
				varname = SN[78092],
				type = "FRIENDLY",
				persist = 8,
				unit = "#5#",
				icon = 1,
			},
			fiendmark = {
				varname = L.npc_descent["Obnoxious Fiend"],
				type = "ENEMY",
				persist = 30,
				unit = "#1#",
				icon = 2,
			},
		},
		announces = {
			trackingsay = {
				varname = format(L.alert["Say %s on self"],SN[78092]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[78092]).."!",
			},
			fiendsay = {
				varname = format(L.alert["Say %s on self"],SN[92685]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],L.npc_descent["Obnoxious Fiend"]),
			},
		},
		alerts = {
			enrage = {
				varname = format(L.alert["%s Warning"],SN[72147]),
				type = "dropdown",
				text = format(L.alert["%s Warning"],SN[72147]),
				time = 600,
				flashtime = 30,
				color1 = "RED",
			},
			grounddur = {
				varname = format(L.alert["Ground Phase Duration"]),
				type = "dropdown",
				text = format(L.alert["Ground Phase"]),
				time = "<grounddur>",
				flashtime = 5,
				color1 = "BLUE",
				sound = "ALERT2",
			},
			airdur = {
				varname = format(L.alert["Air Phase Duration"]),
				type = "dropdown",
				text = format(L.alert["Air Phase"]),
				time = 35,
				flashtime = 5,
				color1 = "BLUE",
				sound = "ALERT2",
			},
			flamescd = {
				varname = format(L.alert["%s Cooldown"],SN[77840]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[77840]),
				time = "<flamescd>",
				flashtime = 5,
				color1 = "ORANGE",
				icon = ST[77840],
			},
			flameswarn = {
				varname = format(L.alert["%s Warning"],SN[77840]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[77840]),
				time = 3,
				flashtime = 3,
				color1 = "ORANGE",
				icon = ST[77840],
				sound = "ALERT1",
			},
			trackingwarn = {
				varname = format(L.alert["%s Warning"],SN[78092]),
				type = "dropdown",
				text = "<trackingtext>",
				time = 8,
				flashtime = 8,
				color1 = "YELLOW",
				icon = ST[78092],
				sound = "ALERT3",
			},
			trackingself = {
				varname = format(L.alert["%s on self"],SN[78092]),
				type = "dropdown",
				text = "<trackingtext>",
				time = 8,
				flashtime = 8,
				color1 = "YELLOW",
				icon = ST[78092],
				sound = "ALERT12",
				flashscreen = true,
			},
			fiendwarn = {
				varname = format(L.alert["%s Warning"],L.npc_descent["Obnoxious Fiend"]),
				type = "simple",
				text = format(L.alert["%s Warning"],L.npc_descent["Obnoxious Fiend"]),
				time = 5,
				flashtime = 5,
				color1 = "GREEN",
				icon = ST[92685],
				sound = "ALERT4",
			},
		},
		arrows = {
			fiendarrow = {
				varname = L.npc_descent["Obnoxious Fiend"],
				unit = "#2#",
				persist = 20,
				action = "TOWARDS",
				msg = L.alert["KILL IT!"],
				spell = L.npc_descent["Obnoxious Fiend"],
			},
		},
		events = {
			-- heroic Fiend
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellid = 92681,
				execute = {
					{
						"alert","fiendwarn",
					},
				},
			},
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 92702,
				execute = {
					{
						"arrow","fiendarrow",
						"raidicon","fiendmark",
					},
				},
			},
			{
                type = "event",
                event = "UNIT_AURA",
                execute = {
                    {
                        "expect",{"#1#","==","player"},
						"scheduletimer",{"fiend",0.1},
                    },
                },
            },
			{
				type = "combatevent",
				eventtype = "UNIT_DIED",
				execute = {
					{
						"expect",{"&npcid|#4#&","==","49740"},
						"removearrow","#5#",
						"set",{fiendwarned = "no"},
					},
				},
			},
			-- Searing Flames
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 77840,
				execute = {
					{
						"alert","flameswarn",
					},
				},
			},
			-- Tracking
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 78092,
				execute = {
					{
						"raidicon","trackingmark",
					},
					{
						"expect",{"#4#","~=","&playerguid&"},
						"set",{trackingtext = format(L.alert["%s on %s"],SN[78092],"#5#")},
						"alert","trackingwarn",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"set",{trackingtext = format(L.alert["%s on %s"],SN[78092],L.alert["YOU"])},
						"announce","trackingsay",
						"alert","trackingself",
					},
				},
			},
			-- Tracking removed
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 78092,
				execute = {
					{
						"quash","trackingwarn",
						"quash","trackingself",
						"removeraidicon","#5#",
					},
				},
			},
			-- Air Phase
			{
				type = "event",
				event = "YELL",
				execute = {
					{
						"expect",{"#1#","find","<airyell>"},
						"alert","airdur",
						"schedulealert",{"grounddur",35},
						"schedulealert",{"flamescd",35},
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end

---------------------------------
-- MALORIAK
---------------------------------
do
	local data = {
		version = 13,
		key = "maloriak",
		zone = L.zone["Blackwing Descent"],
		category = L.zone["Descent"],
		name = L.npc_descent["Maloriak"],
		triggers = {
			scan = {
				41378, -- Maloriak
			},
		},
		onactivate = {
			tracing = {41378},
			tracerstart = true,
			combatstop = true,
			defeat = 41378,
		},
		userdata = {
			jetscd = 10,
			phase = 0,
		},
		onstart = {
			{
				"set",{phase=1},
				"alert","firstphase",
				"alert","berserk",
			},
			{
				"expect",{"&difficulty&",">=","3"}, --10h&25h
				"set",{jetscd = 6},
			},
		},
		windows = {
			proxwindow = true,
		},
		raidicons = {
			flamesmark = {
				varname = SN[92971],
				type = "FRIENDLY",
				persist = 10,
				unit = "#5#",
				icon = 1,
			},
			freezemark = {
				varname = SN[92978],
				type = "FRIENDLY",
				persist = 10,
				unit = "#5#",
				icon = 2,
			},
		},
		alerts = {
			berserk = {
				varname = format(L.alert["%s Warning"],SN[26662]),
				type = "dropdown",
				text = format(L.alert["%s Warning"],SN[26662]),
				time10n = 480,
				time25n = 480,
				time10h = 720,
				time25h = 720,
				color1 = "RED",
				flashtime = 15,
				icon = ST[26662],
			},
			firstphase = {
				varname = format(L.alert["%s Timer"],L.alert["First Phase"]),
				type = "centerpopup",
				text = format(L.alert["First Phase incoming"]),
				time = 15,
				flashtime = 5,
				color1 = "MIDGREY",
				sound = "ALERT2",
			},
			redphase = {
				varname = format(L.alert["Red Phase Duration"]),
				type = "dropdown",
				text = format(L.alert["Red Phase"]),
				time = 50,
				color1 = "RED",
				flashtime = 5,
				sound = "ALERT2",
			},
			bluephase = {
				varname = format(L.alert["Blue Phase Duration"]),
				type = "dropdown",
				text = format(L.alert["Blue Phase"]),
				time = 50,
				color1 = "BLUE",
				flashtime = 5,
				sound = "ALERT2",
			},
			greenphase = {
				varname = format(L.alert["Green Phase Duration"]),
				type = "dropdown",
				text = format(L.alert["Green Phase"]),
				time = 50,
				color1 = "GREEN",
				flashtime = 5,
				sound = "ALERT2",
			},
			nefphase = {
				varname = format(L.alert["Nefarian Phase Duration"]),
				type = "dropdown",
				text = format(L.alert["Nefarian Phase"]),
				time = 100,
				color1 = "PURPLE",
				flashtime = 10,
				sound = "ALERT2",
			},
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
			breathcd = {
				varname = format(L.alert["%s Cooldown"],SN[92968]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[92968]),
				time = 15,
				time2 = 8,
				color1 = "ORANGE",
				flashtime = 5,
				icon = ST[92968],
				sound = "ALERT3",
			},
			chillwarn = {
				varname = format(L.alert["%s Warning"],SN[77760]),
				type = "dropdown",
				text = format(L.alert["%s Warning"],SN[77760]),
				time = 10,
				flashtime = 5,
				color1 = "CYAN",
				icon = ST[77760],
				sound = "ALERT3",
				throttle = 2,
			},
			chillself = {
				varname = format(L.alert["%s Warning on self"],SN[77760]),
				type = "centerpopup",
				text = format(L.alert["%s on %s"],SN[77760],L.alert["YOU"]),
				time = 10,
				flashtime = 10,
				color1 = "CYAN",
				icon = ST[77760],
				sound = "ALERT4",
				flashscreen = true,
			},
			slimewarn = {
				varname = format(L.alert["%s Warning"],SN[77615]),
				type = "centerpopup",
				text = format(L.alert["%s Warning"],SN[77615]),
				time = 15,
				flashtime = 15,
				color1 = "GREEN",
				icon = ST[77615],
				sound = "ALERT4",
			},
			darknesswarn = {
				varname = format(L.alert["%s Warning"],SN[92754]),
				type = "centerpopup",
				text = format(L.alert["%s Warning"],SN[92754]),
				time = 8,
				flashtime = 8,
				color1 = "PINK",
				icon = ST[92754],
				sound = "ALERT9",
				throttle = 5,
			},
			flameswarn = {
				varname = format(L.alert["%s Warning"],SN[92971]),
				type = "centerpopup",
				text = format(L.alert["%s Warning"],SN[92971]),
				time = 10,
				flashtime = 10,
				color1 = "PINK",
				icon = ST[92971],
				sound = "ALERT11",
			},
			flamesself = {
				varname = format(L.alert["%s Warning on self"],SN[92971]),
				type = "centerpopup",
				text = format(L.alert["%s on %s"],SN[92971],L.alert["YOU"]),
				time = 10,
				flashtime = 10,
				color1 = "PINK",
				icon = ST[92971],
				sound = "ALERT4",
				flashscreen = true,
			},
			jetscd = {
				varname = format(L.alert["%s Cooldown"],SN[78194]),
				type = "centerpopup",
				text = format(L.alert["%s Cooldown"],SN[78194]),
				time = "<jetscd>",
				time2 = 12,
				flashtime = 5,
				color1 = "RED",
				sound = "ALERT7",
			},
			-- Remedy buff
            remedywarn = {
				varname = format(L.alert["%s Warning"],SN[77912]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[77912]),
                time = 5,
                color1 = "GREEN",
                sound = "ALERT2",
				icon = ST[77912],
            },
		},
		announces = {
			flamessay = {
				varname = format(L.alert["Say %s on self"],SN[92971]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[92971]),
			},
		},
		timers = {
		},
		events = {
			-- Phases
			{
				type = "event",
				event = "EMOTE",
				execute = {
					-- Red Phase
					{
						"expect",{"#1#","find",L.chat_descent["red|r vial"]},
						"alert","redphase",
						"alert","breathcd",
					},
					-- Blue Phase
					{
						"expect",{"#1#","find",L.chat_descent["blue|r vial"]},
						"alert","bluephase",
					},
					-- Green Phase
					{
						"expect",{"#1#","find",L.chat_descent["green|r vial"]},
						"alert","greenphase",
					},
					-- Nefarian Phase
					{
						"expect",{"#1#","find",L.chat_descent["magic"]},
						"alert","nefphase",
					},
				},
			},
			-- Last Phase
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 77991,
				execute = {
					{
						"batchquash",{"redphase","bluephase","greenphase","nefphase"},
						"set",{phase=2},
						"alert","phasewarn",
						"alert",{"jetscd",time = 2},
					},
				},
			},
			-- Magma Jets
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 78194,
				execute = {
					{
						"quash","jetscd",
						"alert","jetscd",
					},
				},
			},
			-- Consuming Flames
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 92971,
				execute = {
					{
						"raidicon","flamesmark",
					},
					{
						"expect",{"#4#","~=","&playerguid&"},
						"alert","flameswarn",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"announce","flamessay",
						"alert","flamesself",
					},
				},
			},
			-- Scorching Blast
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 92970,
				execute = {
					{
						"alert",{"breathcd",time = 2},
					},
				},
			},
			-- Flash Freeze
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 92978,
				execute = {
					{
						"raidicon","freezemark",
					},
				},
			},
			-- Flash Freeze removed
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 92978,
				execute = {
					{
						"removeraidicon","#5#",
					},
				},
			},
			-- Biting Chill
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 77760,
				execute = {
					{
						"expect",{"#4#","~=","&playerguid&"},
						"alert","chillwarn",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert","chillself",
					},
				},
			},
			-- Biting Chill removed
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 77760,
				execute = {
					{
						"expect",{"#4#","~=","&playerguid&"},
						"quash","chillwarn",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"quash","chillself",
					},
				},
			},
			-- Debilitating Slime
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 77615,
				dstnpcid = 41378, --Maloriak
				execute = {
					{
						"alert","slimewarn",
					},
				},
			},
			-- Remedy
            {
                type = "combatevent",
                eventtype = "SPELL_AURA_APPLIED",
                spellname = 77912,
				dstnpcid = 41378,
                execute = {
					{
						"alert", "remedywarn",
					}
                },
            },
			-- Engulfing Darkness (10h/25h)
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 92754,
				execute = {
					{
						"schedulealert",{"darknesswarn",4},
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end


---------------------------------
-- CHIMAERON
---------------------------------

do
	local data = {
		version = 5,
		key = "chimaeron",
		zone = L.zone["Blackwing Descent"],
		category = L.zone["Descent"],
		name = L.npc_descent["Chimaeron"],
		triggers = {
			scan = {
				43296, -- Chimaeron
			},
		},
		onactivate = {
			tracing = {43296},
			tracerstart = true,
			combatstop = true,
			defeat = 43296,
		},
		userdata = {
			enragetimer = 450, -- 25h
			massacrecd = {26,30, loop = false, type = "series"},
			feuddur = 26,
			iconenabled = "yes",
			phase = 0,
		},
		onstart = {
			{
				"set",{phase=1},
				"alert","massacrecd",
			},
			{
				"expect",{"&difficulty&",">=","3"}, --10h&25h
				"alert","berserk",
				"set",{ feuddur = 5 },
			},
		},
		timers = {
			enableicon = {
				{
					"set",{iconenabled,"yes"},
				},
			},
		},
		windows = {
			proxwindow = true,
			proxrange = 15,
			proxoverride = true,
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
			berserk = {
				varname = format(L.alert["%s Warning"],SN[26662]),
				type = "dropdown",
				text = format(L.alert["%s Warning"],SN[26662]),
				time = "<enragetimer>",
				color1 = "RED",
				flashtime = 10,
				icon = ST[26662],
			},
			massacrecd = {
				varname = format(L.alert["%s Cooldown"],SN[82848]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[82848]),
				time = "<massacrecd>",
				color1 = "BROWN",
				flashtime = 7,
				icon = ST[82848],
			},
			doubleattackwarn = {
				varname = format(L.alert["%s Warning"],SN[88826]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[88826]),
				time = 5,
				color1 = "YELLOW",
				flashtime = 5,
				icon = ST[88826],
				sound = "ALERT1",
			},
			feudwarn = {
				varname = format(L.alert["%s Warning"],SN[88872]),
				type = "dropdown",
				text = format(L.alert["%s Warning"],SN[88872]),
				time = "<feuddur>",
				color1 = "WHITE",
				flashtime = 5,
				icon = ST[88872],
			},
			mortalitywarn = {
				varname = format(L.alert["%s Warning"],SN[82890]),
				type = "centerpopup",
				text = format(L.alert["%s! Burn him!"],SN[82890]),
				time = 5,
				color1 = "GREEN",
				flashtime = 5,
				icon = ST[82890],
			},
			feudblobs = {
				varname = format(L.alert["%s Warn when Feud"],SN[88917]),
				type = "centerpopup",
				text = format(L.alert["%s incoming!"],SN[88917]),
				time = 15,
				color1 = "GREEN",
				flashtime = 15,
				icon = ST[88917],
				sound = "ALERT8",
			},
		},
		raidicons = {
			slimemark = {
				varname = SN[88917],
				type = "MULTIFRIENDLY",
				persist = 5,
				reset = 5,
				unit = "#5#",
				icon = 2,
				total = 5,
			},
		},
		events = {
			-- Massacre
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 82848,
				execute = {
					{
						"quash","massacrecd",
						"alert","massacrecd",
					},
					{
						"expect",{"<iconenabled>","==","no"},
						"set",{iconenabled = "yes"},
					},
				},
			},
			-- Double Attack
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 88826,
				execute = {
					{
						"alert","doubleattackwarn",
					},
				},
			},
			-- Feud
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 88872,
				execute = {
					{
						"alert","feudwarn",
						"alert","feudblobs",
						"set",{iconenabled = "no"},
					},
				},
			},
			-- Caustic Slime Debuff
			{
				 type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 88917,
				execute = {
					{
						"expect",{"<iconenabled>","==","yes"},
						"raidicon","slimemark",
					},
				},
			},
			-- Caustic Slime removed
			{
				 type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 88917,
				execute = {
					{
						"removeraidicon","#5#",
					},
				},
			},
			-- Mortality
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 82890,
				execute = {
					{
						"set", {phase = 2},
						"alert","phasewarn",
						"alert","mortalitywarn",
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end

---------------------------------
-- NEFARIAN
---------------------------------

do
	local data = {
		version = 10,
		key = "nefarian",
		zone = L.zone["Blackwing Descent"],
		category = L.zone["Descent"],
		name = L.npc_descent["Nefarian"],
		triggers = {
			scan = {
				41270, -- Onyxia
				41376, -- Nef
			},
			yell = L.chat_descent["^See how the shadowflame animates the bones"],
		},
		onactivate = {
			tracing = {41270,41376},
			tracerstart = true,
			combatstop = true,
			defeat = 41376,
		},
		userdata = {
			phase2timer = 180, -- 25n
			nefarianlanding = 30,
			blazecd = 30,
			addsdead = 0,
			phase = "0",
		},
		onstart = {
			{
				"alert","nefarianlands",
				"alert","berserk",
			},
			{
				"expect",{"&difficulty&",">=","3"},
				"set",{
					cindertext = "",
				},
			},
		},
		timers = {
			blaze = {
				{
					"alert","blazewarn",
					"scheduletimer",{"blaze","<blazecd>"},
				},
				{
					"expect",{"<blazecd>",">","15"},
					"set",{blazecd = "DECR|5"},
				},
			},
		},
		windows = {
			proxwindow = true,
			proxrange = 10,
			proxoverride = true,
		},
		alerts = {
			berserk = {
				varname = format(L.alert["%s Warning"],SN[26662]),
				type = "dropdown",
				text = format(L.alert["%s Warning"],SN[26662]),
				time = 630,
				flashtime = 30,
				color1 = "RED",
				icon = ST[26662],
			},
			nefarianlands = {
				varname = format(L.alert["Nefarian landing"]),
				type = "dropdown",
				text = format(L.alert["Nefarian landing"]),
				time = "<nefarianlanding>",
				flashtime = 5,
				color1 = "TEAL",
			},
			phase2timer = {
				varname = format(L.alert["Phase 2 Timer"]),
				type = "dropdown",
				text = format(L.alert["Phase 2"]),
				time = "<phase2timer>",
				flashtime = 5,
				color1 = "MIDGREY",
			},
			electrocutewarn = {
				varname = format(L.alert["%s Warning"],SN[94088]),
				type = "centerpopup",
				text = format(L.alert["%s incoming"],SN[94088]),
				time = 5,
				flashtime = 5,
				color1 = "BLUE",
				icon = ST[94088],
				sound = "ALERT1",
			},
			phase3warn = {
				varname = format(L.alert["Phase 3 Warning"]),
				type = "simple",
				text = format(L.alert["Phase 3 incoming"]),
				time = 5,
				color1 = "MIDGREY",
			},
			blazewarn = {
				varname = format(L.alert["%s Warning"],SN[94085]),
				type = "dropdown",
				text = format(L.alert["%s incoming"],SN[94085]),
				time = "<blazecd>",
				time2 = 28,
				time3 = 13,
				flashtime = 5,
				color1 = "PURPLE",
				icon = ST[94085],
				sound = "ALERT8",
			},
			-- heroic
			cinderwarn = {
				varname = format(L.alert["%s Duration"],SN[79339]),
				type = "centerpopup",
				text = format(L.alert["%s Duration"],SN[79339]),
				time = 8,
				color1 = "ORANGE",
				icon = ST[79339],
				throttle = 2,
			},
			cinderself = {
				varname = format(L.alert["%s on self"],SN[79339]),
				type = "simple",
				text = format(L.alert["%s on %s"],SN[79339],L.alert["YOU"]),
				time = 3,
				color1 = "ORANGE",
				icon = ST[79339],
				sound = "ALERT12",
				flashscreen = true,
			},
			dominionwarn = {
				varname = format(L.alert["%s Warning"],SN[79318]),
				type = "simple",
				text = format(L.alert["%s incoming"],SN[79318]),
				time = 3,
				flashtime = 3,
				color1 = "PURPLE",
				icon = ST[79318],
			},
			dominionself = {
				varname = format(L.alert["%s on self"],SN[79318]),
				type = "centerpopup",
				text = format(L.alert["%s on %s"],SN[79318],L.alert["YOU"]),
				time = 20,
				flashtime = 5,
				color1 = "PURPLE",
				icon = ST[79318],
				sound = "ALERT2",
			},
		},
		raidicons = {
			cindermark = {
				varname = SN[79339],
				type = "MULTIFRIENDLY",
				persist = 8,
				reset = 3,
				unit = "#5#",
				icon = 2,
				total = 3,
			},
		},
		announces = {
			cindersay = {
				varname = format(L.alert["Say %s on self"],SN[79339]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[79339]),
			},
		},
		events = {
			-- Phase 2 + 3
			{
				type = "combatevent",
				eventtype = "UNIT_DIED",
				execute = {
					{
						"expect",{"&npcid|#4#&","==","41270"},
						"alert","phase2timer",
						"schedulealert",{"phase3warn","<phase2timer>"},
					},
					{
						"expect",{"&npcid|#4#&","==","41948"},
						"set",{addsdead = "INCR|1"},
						"invoke",{
							{
								"expect",{"&difficulty&",">=","3"},
								"expect",{"<phase>","~=","3"},
								"quash","phase2timer",
								"cancelalert","phase3warn",
								"alert","phase3warn",
								"alert",{"blazewarn",time = 2},
								"scheduletimer",{"blaze",27},
								"set",{phase = "3"},
							},
							{
								"expect",{"&difficulty&","<","3"},
								"expect",{"<addsdead>","==","3"},
								"quash","phase2timer",
								"cancelalert","phase3warn",
								"alert","phase3warn",
								"alert",{"blazewarn",time = 2},
								"scheduletimer",{"blaze",28},
								"set",{phase = "3"},
							},
						},
					},
				},
			},
			-- P3 YELL
			{
				type = "event",
				event ="YELL",
				msg = L.chat_descent["^I have tried to be an accomodating host"],
				execute = {
					{
						"alert",{"blazewarn",time = 3},
						"tracing",{41376},
					},
				},
			},
			-- Electrocute
			{
				type = "event",
				event = "EMOTE",
				execute = {
					{
						"expect",{"#1#","find",L.chat_descent["^The air crackles"]},
						"alert","electrocutewarn",
					},
				},
			},
			-- heroic
			-- Explosive Cinders
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 79339,
				execute = {
					{
						"raidicon","cindermark",
						"alert","cinderwarn",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"announce","cindersay",
						"alert","cinderself",
					},
				},
			},
			-- Explosive Cinders
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 79339,
				execute = {
					{
						"removeraidicon","#5#",
					},
				},
			},
			-- Dominion
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 79318,
				execute = {
					{
						"alert","dominionwarn",
					},
				},
			},
			-- Dominion Aura
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 79318,
				execute = {
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert","dominionself",
					},
				},
			},
			-- Dominion Aura
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 79318,
				execute = {
					{
						"expect",{"#4#","==","&playerguid&"},
						"quash","dominionself",
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end
