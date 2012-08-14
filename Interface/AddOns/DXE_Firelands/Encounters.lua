local L,SN,ST = DXE.L,DXE.SN,DXE.ST

------------------------
-- Alysrazor
------------------------
do
	local data = {
		version = 17,
		key = "Alysrazor",
		zone = L.zone["Firelands"],
		category = L.zone["Firelands"],
		name = L.npc_firelands["Alysrazor"],
		triggers = {
			scan = {
				52530, -- Alysrazor
				54015, -- Staghelm (to trigger first encounter)
			},
			yell = L.chat_firelands["^I serve a new master now"],
		},
		onactivate = {
			tracing = {52530}, -- Alysrazor
			tracerstart = true,
			combatstop = true,
			defeat = 52530,
		},
		userdata = {
			imprintedtext = "",
			phase = 0,
			phasedur = 166,
			firestormcd = { 84,226, loop = true, type = "series"},
			cataclysmcd = { 31,54,31,61, loop = true, type = "series"},
			woundtext = "",
			woundremovedtext = "",
		},
		onstart = {
			{
				"set",{phase = 1},
				"alert","phasewarn",
			},
			{
				"expect",{"&difficulty&","<=","2"}, --10n&25n
				"alert",{"phasedur",time = 2},
			},
			{
				"expect",{"&difficulty&",">=","3"}, --10h&25h
				"set",{
					phasedur = 250,
				},
				"alert",{"firestormcd", time = 2},
				"alert",{"cataclysmcd", time = 2},
				"alert","phasedur",
			},
		},
		--windows = {		},
		--timers = {		},
		alerts = {
			phasedur = {
				varname = format(L.alert["Phase Duration"]),
				type = "dropdown",
				text = format(L.alert["Phase %s Duration"],"<phase>"),
				time = "<phasedur>",
				time2 = 189,
				flashtime = 10,
				color1 = "BLUE",
			},
			phasewarn = {
				varname = format(L.alert["Phase Warning"]),
				type = "simple",
				text = format(L.alert["Phase %s Warning"],"<phase>"),
				time = 3,
				color1 = "BLUE",
				sound = "ALERT1",
			},
			firestormcd = {
				varname = format(L.alert["%s Cooldown"],SN[100744]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[100744]),
				time = "<firestormcd>",
				time2 = 95,
				flashtime = 5,
				color1 = "YELLOW",
				icon = ST[100744],
			},
			firestormwarn = {
				varname = format(L.alert["%s Casting"],SN[100744]),
				type = "centerpopup",
				text = format(L.alert["%s Casting"],SN[100744]),
				time = 5,
				flashtime = 5,
				color1 = "YELLOW",
				color2 ="RED",
				icon = ST[100744],
				sound = "ALERT12",
			},
			imprinted = {
				varname = format(L.alert["%s Warning"],SN[100360]),
				type = "simple",
				text = format(L.alert["%s on %s"],SN[100360],"<imprintedtext>"),
				time = 3,
				flashtime = 3,
				color1 = "GREY",
				icon = ST[100360],
				sound = "ALERT3",
			},
			tantrumcd = {
				varname = format(L.alert["%s Cooldown"],SN[100852]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[100852]),
				time = 15,
				flashtime = 5,
				color1 = "ORANGE",
				icon = ST[100852],
				throttle = 2, --possbily
			},
			vortexinc = {
				varname = format(L.alert["%s Incoming"],SN[99794]),
				type = "centerpopup",
				text = format(L.alert["%s Incoming"],SN[99794]),
				time = 10,
				flashtime = 5,
				icon = ST[99794],
				color1 = "ORANGE",
			},
			vortexdur = {
				varname = format(L.alert["%s Duration"],SN[99794]),
				type = "centerpopup",
				text = format(L.alert["%s Duration"],SN[99794]),
				time = 22,
				flashtime = 5,
				icon = ST[99794],
				color1 = "ORANGE",
			},
			igniteddur = {
				varname = format(L.alert["%s Duration"],SN[99922]),
				type = "dropdown",
				text = format(L.alert["%s Duration"],SN[99922]),
				time = 19,
				flashtime = 5,
				color1 = "YELLOW",
				icon = ST[99922],
			},
			wingsself = {
				varname = format(L.alert["%s Duration"],SN[98619]),
				type = "dropdown",
				text = format(L.alert["%s Duration"],SN[98619]),
				time = 15,
				time2 = 20,
				flashtime = 5,
				color1 = "CYAN",
				icon = ST[98619],
			},
			eggscd = {
				varname = format(SN[100363]),
				type = "centerpopup",
				text = format(SN[100363]),
				time = 6,
				flashtime = 6,
				color1 = "TAN",
				icon = ST[98725],
				sound = "ALERT7",
			},
			cataclysmwarn = {
				varname = format(L.alert["%s Casting"],SN[100761]),
				type = "centerpopup",
				text = format(L.alert["%s Casting"],SN[100761]),
				time = 5,
				flashtime = 5,
				color1 = "WHITE",
				icon = ST[100761],
				sound = "ALERT8",
			},
			cataclysmcd = {
				varname = format(L.alert["%s Cooldown"],SN[100761]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[100761]),
				time = "<cataclysmcd>",
				time2 = 29,
				time3 = 45,
				flashtime = 5,
				color1 = "WHITE",
				icon = ST[100761],
			},
		},
		--announces = {		},
		--raidicons = {		},
		events = {
			-- Phase 1
			-- Wings of Flame (self only)
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname= 98619,
				execute = {
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert",{"wingsself",time=2},
					},
				},
			},
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REFRESH",
				spellname= 98619,
				execute = {
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert",{"wingsself"},
					},
				},
			},

			-- Hatchling
			-- Imprinted
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname= 100360,
				execute = {
					{
						"set",{imprintedtext = "#5#"},
						"alert","imprinted",
					},
				},
			},
			-- Satiated
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname= 100852,
				execute = {
					{
						"expect",{"&guidisplayertarget|#1#&","==","true"},
						"alert","tantrumcd",
					},
				},
			},
			-- Herald (heroic)
			-- Firestorm heroic only
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellid= 100744,
				execute = {
					{
						"alert","firestormwarn",
						"alert","firestormcd",
					},
				},
			},
			-- Cataclysm heroic only
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellid= 100761,
				srcisnpctype = true,
				execute = {
					{
						"alert","cataclysmwarn",
						"alert","cataclysmcd",
					},
				},
			},
			-- Phase 3
			-- Ignited
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname= 99922,
				execute = {
					{
						"alert","igniteddur",
					},
				},
			},
			--[[ Burnout
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname= 99432,
				execute = {
					{

					},
				},
			},]]
			-- Burnout removed
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname= 99432,
				execute = {
					{
						"expect",{"&difficulty&",">=","3"}, --10h&25h
						"alert",{"cataclysmcd",time = 3},
					},
				},
			},
			-- Yells
			{
				type = "event",
				event = "YELL",
				execute = {
					-- Phase 1
					{
						"expect",{"#1#","find",L.chat_firelands["^Reborn in flame"]},
						"set",{phase = 1},
						"schedulealert",{"phasewarn",25},
						"schedulealert",{"phasedur",25},
					},
					-- Phase 2
					{
						"expect",{"#1#","find",L.chat_firelands["^These skies are MINE!"]},
						"alert","vortexinc",
						"schedulealert",{"vortexdur",10},
						"set",{phase = 2},
						"alert","phasewarn",
					},
					-- Phase 3
					{
						"expect",{"#1#","find",L.chat_firelands["^Fire..."]},
						"set",{phase = 3},
						"alert","phasewarn",
					},
				},
			},
			-- Emotes
			{
				type = "event",
				event = "EMOTE",
				execute = {
					-- Eggs
					{
						"expect",{"#1#","find",L.chat_firelands["^The Molten Eggs begin to hatch"]},
						"alert","eggscd",
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end

------------------------
-- Baleroc
------------------------
do
	local data = {
		version = 10,
		key = "Baleroc",
		zone = L.zone["Firelands"],
		category = L.zone["Firelands"],
		name = L.npc_firelands["Baleroc"],
		triggers = {
			scan = {
				53494, -- Baleroc
			},
		},
		onactivate = {
			tracing = {53494}, -- Baleroc
			tracerstart = true,
			combatstop = true,
			defeat = 53494,
		},
		userdata = {
			tormenttext = "",
			blazetext = "",
			countdownunits = {type = "container", wipein = 3},
			countdownother = "",
		},
		enrage = {
			time10n = 360,
			time25n = 360,
			time10h = 360,
			time25h = 360,
		},
		onstart = {
			{
				"expect",{"&difficulty&",">=","3"}, --10h&25h
				"alert",{"countdowncd",time = 2},
			},
			{
				"alert",{"bladecd",time = 2},
				"alert",{"shardcd",time = 2},
			},
		},
		windows = {
			proxwindow = true,
			proxrange = 15,
			proxoverride = true,
		},
		timers = {
			countdown = {
				{
					"quash","countdowncd",
					"alert","countdowncd",
					"alert","countdownwarn",
				},
			},
			firearrow = {
				{
					"arrow","countdownarrow",
				},
			},
		},
		alerts = {
			bladecd = {
				varname = format(L.alert["%s Cooldown"],SN[99342]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[99342]),
				time = 47,
				time2 = 30,
				flashtime = 10,
				color1 = "BLUE",
				icon = ST[99352],
				sound = "ALERT5",
			},
			decimationbladewarn = {
				varname = format(L.alert["%s Warning"],SN[99352]),
				type = "dropdown",
				text = format(L.alert["%s Warning"],SN[99352]),
				time = 3,
				flashtime = 3,
				color1 = "PURPLE",
				icon = ST[99352],
				sound = "ALERT2",
			},
			decimationbladedur = {
				varname = format(L.alert["%s Duration"],SN[99352]),
				type = "dropdown",
				text = format(L.alert["%s Duration"],SN[99352]),
				time = 15,
				flashtime = 5,
				color1 = "PURPLE",
				icon = ST[99352],
			},
			infernobladewarn = {
				varname = format(L.alert["%s Warning"],SN[99350]),
				type = "dropdown",
				text = format(L.alert["%s Warning"],SN[99350]),
				time = 3,
				flashtime = 3,
				color1 = "YELLOW",
				icon = ST[99350],
				sound = "ALERT2",
			},
			infernobladedur = {
				varname = format(L.alert["%s Duration"],SN[99350]),
				type = "dropdown",
				text = format(L.alert["%s Duration"],SN[99350]),
				time = 15,
				flashtime = 5,
				color1 = "YELLOW",
				icon = ST[99350],
			},
			shardwarn = {
				varname = format(L.alert["%s Warning"],SN[99259]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[99259]),
				time = 3,
				flashtime = 3,
				color1 = "PURPLE",
				icon = ST[99259],
				sound = "ALERT3",
			},
			shardcd = {
				varname = format(L.alert["%s Cooldown"],SN[99259]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[99259]),
				time = 33,
				time2 = 5,
				flashtime = 5,
				color1 = "PURPLE",
				icon = ST[99259],
				sound = "ALERT3",
			},
			tormentwarn = {
				varname = format(L.alert["%s Warning"],SN[99256]),
				type = "simple",
				text = "<tormenttext>",
				time = 3,
				icon = ST[99256],
				color1 = "MIDGREY",
			},
			-- heroic
			countdowncd = {
				varname = format(L.alert["%s Cooldown"],SN[99516]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[99516]),
				time = 46,
				time2 = 25,
				flashtime = 10,
				color1 = "ORANGE",
				icon = ST[99516],
				sound = "ALERT4",
			},
			countdownwarn = {
				varname = format(L.alert["%s Warning"],SN[99516]),
				type = "simple",
				text = format(L.alert["%s on %s"],SN[99516],"&list|countdownunits&"),
				time = 3,
				flashtime = 3,
				color1 = "ORANGE",
				icon = ST[99516],
				sound = "ALERT5",
			},
			countdownself = {
				varname = format(L.alert["%s Warning on self"],SN[99516]),
				type = "centerpopup",
				text = format(L.alert["%s on %s"],SN[99516],L.alert["YOU"]),
				time = 8,
				flashtime = 8,
				color1 = "ORANGE",
				icon = ST[99516],
				sound = "ALERT1",
				flashscreen = true,
			},
		},
		announces = {
			countdownsay = {
				varname = format(L.alert["%s on self"],SN[99516]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[99516]),
			},
		},
		raidicons = {
			countdownicon = {
				varname = SN[99516],
				type = "MULTIFRIENDLY",
				persist = 8,
				reset = 2,
				unit = "#5#",
				icon = 1,
				total = 2,
			},
		},
		arrows = {
			countdownarrow = {
				varname = format("%s",SN[99516]),
				unit = "<countdownother>",
				persist = 10,
				action = "TOWARD",
				msg = L.alert["MOVE TOWARD"],
				spell = SN[99516],
			},
		},
		events = {
			-- Decimation Blade
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 99352,
				execute = {
					{
						"quash","bladecd",
						"alert","bladecd",
						"alert","decimationbladewarn",
						"schedulealert",{"decimationbladedur",1.5},
					},
				},
			},
			-- Inferno Blade
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 99350,
				execute = {
					{
						"quash","bladecd",
						"alert","bladecd",
						"alert","infernobladewarn",
						"schedulealert",{"infernobladedur",1.5},
					},
				},
			},
			-- Shards of Torment
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 99259,
				execute = {
					{
						"quash","shardcd",
						"alert","shardcd",
						"alert","shardwarn",
					},
				},
			},
			-- Torment
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED_DOSE",
				spellid = {99256,100230,100231},
				execute = {
					{
						"expect",{"#4#","==","&playerguid&"},
						"set",{tormenttext = format("%s: %s! %s!",SN[99256],L.alert["YOU"],format(L.alert["%s Stacks"],"#11#"))},
						"quash", "tormentwarn",
						"alert","tormentwarn",
					},
				},
			},
			-- Countdown heroic
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 99516,
				execute = {
					{
						"insert",{"countdownunits","#5#"},
						"canceltimer","countdown",
						"scheduletimer",{"countdown",0.2},
						"raidicon","countdownicon",

					},
					{
						"expect",{"#4#","~=","&playerguid&"},
						"set",{countdownother = "#5#"},
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"announce","countdownsay",
						"alert","countdownself",
						"scheduletimer",{"firearrow",0.2},
					},
				},
			},
			-- Countdown removed
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 99516,
				execute = {
					{
						"removeraidicon","#5#",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"quash","countdownself",
						"removearrow","#5#",
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end


------------------------
-- Beth'tilac
------------------------
do
	local data = {
		version = 11,
		key = "Beth'tilac",
		zone = L.zone["Firelands"],
		category = L.zone["Firelands"],
		name = L.npc_firelands["Beth'tilac"],
		triggers = {
			scan = {
				52498, -- Beth'tilac
			},
		},
		onactivate = {
			tracing = {52498,powers={true}}, -- Beth'tilac
			tracerstart = true,
			combatstop = true,
			defeat = 52498,
		},
		userdata = {
			devastationcount = 0,
			devastationwarned = "no",
			kisstext = "",
			fixatetext = "",
			phase = 0,
			spinnerscd = {11,15, loop = false, type = "series"},
			spiderlingscd = {12,30, loop = false, type = "series"},
			dronescd = {45,60, loop = false, type = "series"},
			--broodlingcd = 5,
		},
		onstart = {
			{
				"scheduletimer",{"energy",15},
				"set",{phase = 1},
				"batchalert",{"spinnerscd","dronescd","spiderlingscd"},
				"scheduletimer",{"dronescd",45},
			},
		},
		--windows = {		},
		timers = {
			energy = {
				{
					"expect",{"&getup|boss1&","<","13"},
					"expect",{"<devastationwarned>","==","no"},
					"alert","devastationsoon",
					"set",{devastationwarned = "yes"},
				},
				{
					"scheduletimer",{"energy",1},
				},
			},
			dronescd = {
				{
					"alert","dronescd",
					"scheduletimer",{"dronescd",60},
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
			devastationwarn = {
				varname = format(L.alert["%s Casting"],SN[99048]),
				type = "centerpopup",
				text = format(L.alert["%s Casting"],SN[99048]),
				time = 8,
				flashtime = 8,
				color1 = "RED",
				icon = ST[99048],
				sound = "ALERT12",
			},
			devastationsoon = {
				varname = format(L.alert["%s Soon"],SN[99048]),
				type = "simple",
				text = format(L.alert["%s Soon"],SN[99048]),
				time = 3,
				flashtime = 3,
				color1 = "RED",
				icon = ST[99048],
				sound = "ALERT2",
			},
			kisswarn = {
				varname = format(L.alert["%s Warning"],SN[99476]),
				type = "simple",
				text = "<kisstext>",
				time = 3,
				color1 = "GREEN",
				icon = ST[99476],
				sound = "ALERT3",
			},
			kisscd = {
				varname = format(L.alert["%s Cooldown"],SN[99476]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[99476]),
				time = 30,
				flashtime = 5,
				color1 = "GREEN",
				icon = ST[99476],
			},
			spinnerscd = {
				varname = format(L.npc_firelands["Cinderweb Spinner"]),
				type = "dropdown",
				text = format(L.npc_firelands["Cinderweb Spinner"]),
				time = "<spinnerscd>",
				flashtime = 5,
				color1 = "BLUE",
				sound = "ALERT4",
			},
			spiderlingscd = {
				varname = format(L.npc_firelands["Cinderweb Spiderling"]),
				type = "dropdown",
				text = format(L.npc_firelands["Cinderweb Spiderling"]),
				time = "<spiderlingscd>",
				flashtime = 5,
				color1 = "TEAL",
				sound = "ALERT5",
			},
			dronescd = {
				varname = format(L.npc_firelands["Cinderweb Drone"]),
				type = "dropdown",
				text = format(L.npc_firelands["Cinderweb Drone"]),
				time = "<dronescd>",
				flashtime = 5,
				color1 = "YELLOW",
				sound = "ALERT6",
			},
			fixatewarn = {
				varname = format(L.alert["%s Warning"],SN[99559]),
				type = "simple",
				text = "<fixatetext>",
				time = 3,
				flashtime = 3,
				color1 = "BROWN",
				icon = ST[99559],
				sound = "ALERT7",
			},
			fixateself = {
				varname = format(L.alert["%s on self"],SN[99559]),
				type = "simple",
				text = format(L.alert["%s on %s"],SN[99559],L.alert["YOU"]),
				time = 3,
				flashtime = 3,
				color1 = "BROWN",
				icon = ST[99559],
				sound = "ALERT7",
				flashscreen = true,
			},
			flarecd = {
				varname = format(L.alert["%s Cooldown"],SN[100936]),
				type = "centerpopup",
				text = format(L.alert["%s Cooldown"],SN[100936]),
				time = 6,
				flashtime = 6,
				color1 = "ORANGE",
				icon = ST[100936],
			},
		},
		announces = {
			fixatesay = {
				varname = format(L.alert["%s on self"],SN[99559]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[99559]).."!",
			},
		},
		raidicons = {
			fixateicon = {
				varname = SN[99559],
				type = "FRIENDLY",
				persist = 10, --???
				reset = 9,
				unit = "#5#",
				icon = 1,
			},
		},
		events = {
			-- Stage 1
			-- Smoldering Devastation
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 99048,
				execute = {
					{
						"canceltimer","energy",
						"alert","devastationwarn",
						"set",{devastationcount = "INCR|1"},
						"set",{devastationwarned = "no"},
						"scheduletimer",{"energy",15},
						"alert","spinnerscd",
					},
					{
						"expect",{"<devastationcount>","==","3"}, --perhaps better yell?
						"canceltimer","energy",
						"canceltimer","dronescd",
						"quashall",true,
						"set",{phase = 2},
						"alert","phasewarn",
					},
				},
			},
			-- Fixate (heroic)
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 99559,
				srcisnpctype = true,
				execute = {
					{
						"raidicon","fixateicon",
					},
					{
						"expect",{"#4#","~=","&playerguid&"},
						"set",{fixatetext = format(L["%s on %s"],SN[99559],"#5#")},
						"alert","fixatewarn",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert","fixateself",
						"announce","fixatesay",
					},
				},
			},
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 99559,
				execute = {
					{
						"removeraidicon","#5#",
					},
				},
			},
			-- Stage 2
			-- The Widow's Kiss
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 99476,
				dstisplayertype = true,
				execute = {
					{
						"set",{kisstext = format(L["%s on %s"],SN[99506],"#5#")},
						"alert","kisswarn",
						"alert","kisscd",
					},
				},
			},
			-- Flare
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 100936,
				execute = {
					{
						"expect",{"<phase>","==","2"},
						"alert","flarecd",
					},
				},
			},
			--[[ Emotes
			{
				type = "event",
				event = "EMOTE",
				execute = {
					-- Spiderlings
					{
						"expect",{"#1#","find",L.chat_firelands["^Spiderlings have been roused from their nest"]},
						"alert","spiderlingscd",
					},
				},
			},]]
		},
	}

	DXE:RegisterEncounter(data)
end


------------------------
-- Lord Rhyolith
------------------------
do
	local data = {
		version = 10,
		key = "Rhyolith",
		zone = L.zone["Firelands"],
		category = L.zone["Firelands"],
		name = L.npc_firelands["Lord Rhyolith"],
		triggers = {
			scan = {
				52577, -- Left
				53087, -- Right
			},
			yell = L.chat_firelands["^Hah? Hruumph?"],
		},
		onactivate = {
			tracing = {
				52577, -- Left foot
				53087, -- Right foot
				52558, -- Lord Rhyolith
			},
			tracerstart = true,
			combatstop = true,
			defeat = 52558,
		},
		userdata = {
			stompcd = {10,30, loop = false, type = "series"},
			fragmentcd = {21,45, loop = true, type = "series"},
			sparkcd = {45,70, loop = false, type = "series"},
			phase = "0",
			volcanocd = {20,25, loop = false, type = "series"},
		},
		onstart = {
			{
				"alert",{"fragmentcd",time = 2},
				"alert","sparkcd",
				"alert","stompcd",
				"alert","superheatedcd",
				"alert","volcanocd",
			},
		},
		--windows = {},
		--timers = {		},
		alerts = {
			phasewarn = {
				varname = format(L.alert["Phase Warning"]),
				type = "simple",
				text = format(L.alert["Phase %s Warning"],"<phase>"),
				time = 3,
				flashtime = 3,
				color1 = "PURPLE",
				sound = "ALERT1",
			},
			stompcd = {
				varname = format(L.alert["%s Cooldown"],SN[100411]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[100411]),
				time = "<stompcd>",
				flashtime = 5,
				color1 = "ORANGE",
				icon = ST[100411],
			},
			stompwarn = {
				varname = format(L.alert["%s Casting"],SN[100411]),
				type = "centerpopup",
				text = format(L.alert["%s Casting"],SN[100411]),
				time = 3,
				flashtime = 3,
				color1 = "ORANGE",
				icon = ST[100411],
				sound = "ALERT2",
			},
			fragmentcd = {
				varname = format(L.alert["%s Cooldown"],SN[98136]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[98136]),
				time = "<fragmentcd>",
				flashtime = 5,
				color1 = "BROWN",
				icon = ST[98136],
				sound = "ALERT3",
			},
			sparkcd = {
				varname = format(L.alert["%s Cooldown"],SN[98552]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[98552]),
				time = "<sparkcd>",
				flashtime = 5,
				color1 = "YELLOW",
				icon = ST[99262],
				sound = "ALERT3",
			},
			sparkwarn = {
				varname = format(L.alert["%s Warning"],SN[98552]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[98552]),
				time = 3,
				flashtime = 3,
				color1 = "YELLOW",
				icon = ST[99262],
				sound = "ALERT6",
			},
			lavawarn = {
				varname = format(L.alert["%s Casting"],SN[100650]),
				type = "simple",
				text = format(L.alert["%s Casting"],SN[100650]),
				time = 3,
				flashtime = 3,
				color1 = "PEACH",
				icon = ST[100650],
				sound = "ALERT4",
			},
			superheatedcd = {
				varname = format(L.alert["%s Cooldown"],SN[101305]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[101305]),
				time = 300,
				flashtime = 10,
				color1 = "RED",
				icon = ST[101305],
				sound = "ALERT9",
			},
			volcanocd = {
				varname = format(L.alert["%s"],SN[98493]),
				type = "dropdown",
				text = format(L.alert["%s"],SN[98493]),
				time = "<volcanocd>",
				flashtime = 3,
				color1 = "WHITE",
				icon = ST[98493],
				sound = "ALERT11",
			},
		},
		--announces = {},
		--raidicons = {},
		events = {
			-- Stomp
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 100411,
				execute = {
					{
						"quash","stompcd",
						"alert","stompcd",
						"alert","stompwarn",
					},
				},
			},
			-- Fragment
			{
				type = "combatevent",
				eventtype = "SPELL_SUMMON",
				spellname = 98136,
				execute = {
					{
						"quash","fragmentcd",
						"alert","fragmentcd",
					},
				},
			},
			-- Spark
			{
				type = "combatevent",
				eventtype = "SPELL_SUMMON",
				spellname = 98552,
				execute = {
					{
						"quash","sparkcd",
						"alert","sparkcd",
						"alert","sparkwarn",
					},
				},
			},
			-- Lava Line
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 100650,
				execute = {
					{
						"alert","lavawarn",
					},
				},
			},
			-- Heated Volcano
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 98493,
				execute = {
					{
						"quash","volcanocd",
						"alert","volcanocd",
					},
				},
			},
			-- Emotes
			{
				type = "event",
				event = "EMOTE",
				execute = {
					{
						"expect",{"#1#","find",L.chat_firelands["stumbles as his armor is shattered"]},
						"batchquash",{"sparkcd","fragmentcd"},
						"set",{phase = "2"},
						"alert","phasewarn",
						"set",{
							stompcd = {13, loop = false, type = "series"},
						},
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end


------------------------
-- Majordomo Fandral Staghelm
------------------------
do
	local data = {
		version = 10,
		key = "Staghelm",
		zone = L.zone["Firelands"],
		category = L.zone["Firelands"],
		name = L.npc_firelands["Majordomo Fandral Staghelm"],
		triggers = {
			scan = {
				52571, -- Majordomo Fandral Staghelm
			},
		},
		onactivate = {
			tracing = {52571,powers={true}}, -- Majordomo Fandral Staghelm
			tracerstart = true,
			combatstop = true,
			defeat = 52571,
		},
		enrage = {
			time10n = 600,
			time25n = 600,
			time10h = 600,
			time25h = 600,
		},
		userdata = {
			seedtime = 0,
			abilitycd = {17.5, 13.5, 11, 8.5, 7.5, 7.2, 6.0, 6.0, 5, 5, 5, 3.6, loop = false, type = "series"},
			adrenalinetext = "",
			form = "",
		},
		--onstart = {		},
		windows = {
			proxwindow = true,
			proxrange = 12,
			proxoverride = true,
		},
		--timers = {},
		alerts = {
			catwarn = {
				varname = format(L.alert["%s Warning"],SN[98374]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[98374]),
				time = 3,
				flashtime = 3,
				color1 = "YELLOW",
				icon = ST[98374],
				sound = "ALERT1",
			},
			scorpionwarn = {
				varname = format(L.alert["%s Warning"],SN[98379]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[98379]),
				time = 3,
				flashtime = 3,
				color1 = "BROWN",
				icon = ST[98379],
				sound = "ALERT2",
			},
			adrenalinewarn = {
				varname = format(L.alert["%s Warning"],SN[97238]),
				type = "simple",
				text = "<adrenalinetext>",
				time = 2,
				flashtime = 2,
				color1 = "GREEN",
				icon = ST[97238],
				sound = "ALERT5",
			},
			orbswarn = {
				varname = format(L.alert["%s Warning"],SN[98451]),
				type = "centerpopup",
				text = format(L.alert["%s Warning"],SN[98451]),
				time = 4,
				flashtime = 4,
				color1 = "ORANGE",
				icon = ST[98451],
				sound = "ALERT3",
			},
			orbsdur = {
				varname = format(L.alert["%s Duration"],SN[98451]),
				type = "dropdown",
				text = format(L.alert["%s Duration"],SN[98451]),
				time = 60,
				flashtime = 10,
				color1 = "ORANGE",
				icon = ST[98451],
			},
			seedswarn = {
				varname = format(L.alert["%s Warning"],SN[98450]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[98450]),
				time = 3,
				flashtime = 3,
				color1 = "PURPLE",
				icon = ST[98450],
				sound = "ALERT4",
			},
			seedsself = {
				varname = format(L.alert["%s on self"],SN[98450]),
				type = "dropdown",
				text = format(L.alert["%s on %s"],SN[98450],L.alert["YOU"]),
				time = "<seedtime>",
				flashtime = 4,
				color1 = "PURPLE",
				icon = ST[98450],
				sound = "ALERT12",
			},
			leapingflamesself = {
				varname = format(L.alert["%s Warning on self"],SN[100207]),
				type = "simple",
				text = format(L.alert["%s on %s"],SN[100207],L.alert["YOU"]),
				time = 3,
				flashtime = 3,
				color1 = "YELLOW",
				icon = ST[100207],
				sound = "ALERT12",
				flashscreen = true,
			},
			jumpcd = {
				varname = format(L.alert["Next %s"],SN[98535]),
				type = "centerpopup",
				text = format(L.alert["Next %s"],SN[98535]),
				time = "<abilitycd>",
				color1 = "ORANGE",
				icon = ST[98535],
				sound = "ALERT7",
			},
			cleavecd = {
				varname = format(L.alert["Next %s"],SN[100213]),
				type = "centerpopup",
				text = format(L.alert["Next %s"],SN[100213]),
				time = "<abilitycd>",
				color1 = "YELLOW",
				icon = ST[100213],
				sound = "ALERT7",
			},
		},
		--announces = {},
		--raidicons = {},
		events = {
			--Orbs
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 98451,
				execute = {
					{
						"alert","orbswarn",
						"schedulealert",{"orbsdur",4}
					},
				},
			},
			-- Seeds
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 98450,
				execute = {
					{
						"alert","seedswarn",
					},
				},
			},
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 98450,
				execute = {
					{
						"expect",{"#4#","==","&playerguid&"},
						"set",{seedtime = "&playerdebuffdur|"..SN[98450].."&"},
						"alert","seedsself",
					},
				},
			},
			-- Leaping Flames
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 100207,
				execute = {
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert","leapingflamesself",
					},
				},
			},
			-- Cat Form
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 98374,
				srcnpcid = 52571, -- Staghelm
				execute = {
					{
						"set",{
							abilitycd = {17.4, 13.4, 11, 8.5, 7.5, 7.2, 6.0, 6.0, 5, 5, 5, 3.6, loop = false, type = "series"},
							form = "kitty",
						},
						"quash","cleavecd",
						"alert","catwarn",
						"alert","jumpcd",
					},
				},
			},
			-- Scorpion Form
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 98379,
				srcnpcid = 52571, -- Staghelm
				execute = {
					{
						"set",{
							abilitycd = {17.5, 13.5, 11, 8.5, 7.5, 7.2, 6.0, 6.0, 5, 5, 5, 3.6, loop = false, type = "series"},
							form = "scorpion",
						},
						"quash","jumpcd",
						"alert","scorpionwarn",
						"alert","cleavecd",
					},
				},
			},
			-- adrenaline
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 97238,
				srcnpcid = 52571, -- Staghelm
				execute = {
					{
						"set",{adrenalinetext = format(L.alert["%s"],SN[97238])},
						"alert","adrenalinewarn",
						"invoke",{
							{
								"expect",{"<form>","==","kitty"},
								"alert","jumpcd",
							},
							{
								"expect",{"<form>","==","scorpion"},
								"alert","cleavecd",
							},
						},
					},
				},
			},
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED_DOSE",
				spellname = 97238,
				srcnpcid = 52571, -- Staghelm
				execute = {
					{
						"set",{adrenalinetext = format(L.alert["%s %s"],SN[97238],"#11#")},
						"alert","adrenalinewarn",
						"invoke",{
							{
								"expect",{"<form>","==","kitty"},
								"alert","jumpcd",
							},
							{
								"expect",{"<form>","==","scorpion"},
								"alert","cleavecd",
							},
						},
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end


------------------------
-- Shannox
------------------------
do
	local data = {
		version = 7,
		key = "Shannox",
		zone = L.zone["Firelands"],
		category = L.zone["Firelands"],
		name = L.npc_firelands["Shannox"],
		triggers = {
			scan = {
				53691, -- Shannox
			},
			yell = L.chat_firelands["Aha! The interlopers"],
		},
		onactivate = {
			tracing = {
				53691, -- Shannox
				53694, -- Riplimb
				53695, -- Rageface
			},
			tracerstart = true,
			combatstop = true,
			defeat = 53691,
		},
		enrage = {
			time10n = 600,
			time25n = 600,
			time10h = 600,
			time25h = 600,
		},
		userdata = {
			jaggedtext = "",
			traptext = "",
			traptype = "",
			crystaltrapcd = {9,25, loop = false, type = "series"},
			spearcd = {18,41, loop = false, type = "series"},
		},
		onstart = {
			{
				"alert","spearcd",
				"alert","crystaltrapcd",
			},
		},
		--windows = {		},
		arrows = {
			crystaltraparrow = {
				varname = format(L.npc_firelands["Crystal Prison"]),
				unit = "#5#",
				persist = 30,
				action = "TOWARD",
				msg = L.alert["Free him!"],
				spell = SN[98159],
				sound = "ALERT5",
			},
		},
		--timers = {		},
		alerts = {
			ragedur = {
				varname = format(L.alert["%s Duration"],SN[99947]),
				type = "centerpopup",
				text = format(L.alert["%s on %s"],SN[99947],"#5#"),
				time = 30,
				flashtime = 5,
				color1 = "YELLOW",
				icon = ST[99947],
			},
			spearcd = {
				varname = format(L.alert["%s Cooldown"],SN[100002]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[100002]),
				time = "<spearcd>",
				flashtime = 5,
				color1 = "GREEN",
				icon = ST[100002],
			},
			spearwarn = {
				varname = format(L.alert["%s Warning"],SN[100002]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[100002]),
				time = 3,
				flashtime = 3,
				color1 = "GREEN",
				sound = "ALERT1",
				icon = ST[100002],
			},
			immotrapcd = {
				varname = format(L.alert["%s Cooldown"],SN[99839]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[99839]),
				time = 8,
				flashtime = 5,
				color1 = "ORANGE",
				icon = ST[99839],
			},
			crystaltrapcd = {
				varname = format(L.alert["%s Cooldown"],SN[99836]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[99836]),
				time = "<crystaltrapcd>",
				flashtime = 5,
				color1 = "BLUE",
				icon = ST[99836],
			},
			crystaltrapwarn = {
				varname = format(L.alert["%s Warning"],SN[99836]),
				type = "simple",
				text = "<traptext>",
				time = 5,
				flashtime = 5,
				color1 = "BLUE",
				sound = "ALERT3",
				icon = ST[99836],
			},
			crystaltrapself = {
				varname = format(L.alert["%s Warning on self"],SN[99836]),
				type = "simple",
				text = format(L.alert["%s on %s"],SN[99836],L.alert["YOU"]),
				time = 5,
				flashtime = 5,
				color1 = "BLUE",
				sound = "ALERT3",
				icon = ST[99836],
			},
			trapwarn = {
				varname = format(L.alert["Trap Warning"]),
				type = "simple",
				text = format(L.alert["%s on %s"],"<traptype>",L.alert["YOU"]),
				text2 = format("%s","<traptype>"),
				time = 3,
				flashtime = 3,
				color1 = "RED",
				sound = "ALERT7",
				icon = ST[99836],
			},
			riplimbcd = {
				varname = format(L.alert["%s Resurrection"],L.npc_firelands["Riplimb"]),
				type = "dropdown",
				text = format(L.alert["%s Resurrection"],L.npc_firelands["Riplimb"]),
				time = 30,
				flashtime = 5,
				color1 = "PURPLE",
				icon = ST[38601],
				sound = "ALERT6",
			},
			magmacd = {
				varname = format(L.alert["%s Cooldown"],SN[99840]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[99840]),
				time = 17,
				flashtime = 5,
				color1 = "GREEN",
				icon = ST[99840],
			},
			magmawarn = {
				varname = format(L.alert["%s Warning"],SN[99840]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[99840]),
				time = 3,
				flashtime = 3,
				color1 = "GREEN",
				sound = "ALERT1",
				icon = ST[99840],
			},
			separationAnxietywarn = {
				varname = format(L.alert["%s Warning"],SN[99835]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[99835]),
				time = 5,
				color1 = "RED",
				icon = ST[99835],
				throttle = 5,
			},
		},
		announces = {
			immotrapsay = {
				varname = format(L.alert["%s on self"],SN[99839]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[99839]).."!",
			},
			crystaltrapsay = {
				varname = format(L.alert["%s on self"],SN[99836]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[99836]).."!",
			},
		},
		raidicons = {
			crystaltrapicon = {
				varname = SN[99836],
				type = "FRIENDLY",
				persist = 30,
				reset = 29,
				unit = "#5#",
				icon = 2,
			},
			rageicon = {
				varname = SN[99947],
				type = "FRIENDLY",
				persist = 15,
				reset = 2,
				unit = "#5#",
				icon = 1,
			},
		},
		events = {
			-- Face Rage
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 99947,
				dstisplayertype = true,
				execute = {
					{
						"raidicon","rageicon",
						"alert","ragedur",
					},
				},
			},
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 99947,
				execute = {
					{
						"removeraidicon","#5#",
						"quash","ragedur",
					},
				},
			},
			-- Hurl Spear
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 100002,
				execute = {
					{
						"quash","spearcd",
						"alert","spearwarn",
						"alert","spearcd",
					},
				},
			},
			-- Riplimb dies
			{
				type = "combatevent",
				eventtype = "UNIT_DIED",
				execute = {
					{
						"expect",{"&npcid|#4#&","==","53694"},
						"expect",{"&difficulty&",">=","3"}, --10h&25h
						"quash","spearcd",
						"alert","riplimbcd",
					},
				},
			},
			-- Immolation Trap (possibly target function, could be spammy)
			{
				type = "combatevent",
				eventtype = "SPELL_SUMMON",
				spellname = 99839,
				srcnpcid = 53691, -- Shannox
				execute = {
					{
						"set",{traptype = L.npc_firelands["Immolation Trap"]},
					},
					{
						"target",{
							source = "#1#",
							wait = 0.2,
							announce = "immotrapsay",
							alerts = {
								self = "trapwarn",
								unknown = {"trapwarn",text = 2},
							},
						},
					},
				},
			},
			-- Crystal Prison Trap (possibly target function, could be spammy)
			{
				type = "combatevent",
				eventtype = "SPELL_SUMMON",
				spellname = 99836,
				srcnpcid = 53691, -- Shannox
				execute = {
					{
						"quash","crystaltrapcd",
						"alert","crystaltrapcd",
						"alert","immotrapcd",
						"schedulealert",{"immotrapcd",8},
						"set",{traptype = L.npc_firelands["Crystal Prison Trap"]},
					},
					{
						"target",{
							source = "#1#",
							wait = 0.2,
							announce = "crystaltrapsay",
							alerts = {
								self = "trapwarn",
								unknown = {"trapwarn",text = 2},
							},
						},
					},
				},
			},
			-- Crystal Prison Trap Effect
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 99837,
				dstisplayertype = true,
				execute = {
					{
						"raidicon","crystaltrapicon",
						"arrow","crystaltraparrow",
					},
					{
						"expect",{"#4#","~=","&playerguid&"},
						"set",{traptext = format(L.alert["%s on %s"],SN[99836],"#5#")},
						"alert","crystaltrapwarn",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert","crystaltrapself",
					},
				},
			},
			-- Crystal Prison Trap Effect removed
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 99837,
				dstisplayertype = true,
				execute = {
					{
						"removeraidicon","#5#",
						"removearrow","#5#",
					},
					{
						"expect",{"#4#","~=","&playerguid&"},
						"quash","crystaltrapwarn",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"quash","crystaltrapself",
					},
				},
			},
			-- Magma Rupture
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 99840,
				execute = {
					{
						"quash","spearcd",
						"alert","magmacd",
						"alert","magmawarn",
					},
				},
			},
			-- Separation Anxiety
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 99835,
				dstnpcid = 53691, -- Shannox
				execute = {
					{
						"alert","separationAnxietywarn",
					},
				},
			},
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 99835,
				dstnpcid = 53691, -- Shannox
				execute = {
					{
						"quash","separationAnxietywarn",
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end


------------------------
-- Ragnaros
------------------------
do
	local data = {
		version = 27,
		key = "Ragnaros",
		zone = L.zone["Firelands"],
		category = L.zone["Firelands"],
		name = L.npc_firelands["Ragnaros"],
		triggers = {
			scan = {
				52409 , -- Ragnaros
			},
		},
		onactivate = {
			tracing = {52409 }, -- Ragnaros
			tracerstart = true,
			combatstop = true,
			defeat = {52409,L.chat_firelands["^Too soon!"]},
		},
		enrage = {
			time10n = 1080,
			time25n = 1080,
			time10h = 1080,
			time25h = 1080,
		},
		userdata = {
			phase = 0,
			trapcd = {15,25,25,30, loop = false, type = "series"},
			smashcd = {30, loop = false, type = "series"},
			flamescd = {45,40, loop = false, type = "series"},
			wrathcd = {5,36,30, loop = false, type = "series"},
			empowercd = {50,55, loop = false, type = "series"},
			rootscd = {35,57,55,55,58, loop = false, type = "series"},
			heattext = "",
			woundtext = "",
			engulfingspecial = "",
			flameswarned = "no",
			seedwarned = "no",
			meteorwarned = "no",
			phaseactivated = "no",
		},
		onstart = {
			{
				"set",{
					phase = 1,
				},
				"alert","smashcd",
				"alert","trapcd",
				"alert","handcd",
				"alert","wrathcd",
			},
		},
		windows = {
			proxwindow = true,
			proxrange = 6,
			proxoverride = true,
		},
		timers = {
			seedreset = {
				{
					"set",{seedwarned = "no"},
				},
			},
			flamewarnreset = {
				{
					"set",{flameswarned = "no"},
				},
			},
			meteor = {
				{
					"expect",{"&playerdebuff|"..SN[99849].."&","==","true"},
					"expect",{"<meteorwarned>","==","no"},
					"alert","meteorself",
					"announce","meteorsay",
					"set",{meteorwarned = "yes"},
				},
				{
					"expect",{"&playerdebuff|"..SN[99849].."&","==","false"},
					"expect",{"<meteorwarned>","==","yes"},
					"set",{meteorwarned = "no"},
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
				sound = "ALERT11",
			},
			phasedur = {
				varname = format(L.alert["Phase Duration"]),
				type = "dropdown",
				text = format(L.alert["Phase %s Duration"],"<phase>"),
				time = 45,
				time10h = 48,
				time25h = 48,
				flashtime = 5,
				color1 = "PURPLE",
			},
			trapwarn = {
				varname = format(L.alert["%s Casting"],SN[101233]),
				type = "simple",
				text = format("%s: &upvalue&!",SN[101233]),
				text2 = format(L.alert["%s Casting"],SN[101233]),
				time = 3,
				color1 = "ORANGE",
				sound = "ALERT1",
				icon = ST[101233],
			},
			trapself = {
				varname = format(L.alert["%s on self"],SN[101233]),
				type = "simple",
				text = format("%s: %s!",SN[101233],L.alert["YOU"]),
				time = 3,
				color1 = "ORANGE",
				sound = "ALERT12",
				icon = ST[101233],
				flashscreen = true,
			},
			trapcd = {
				varname = format(L.alert["%s Cooldown"],SN[101233]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[101233]),
				time = "<trapcd>",
				flashtime = 5,
				color1 = "ORANGE",
				icon = ST[101233],
			},
			smashwarn = {
				varname = format(L.alert["%s Warning"],SN[100258]),
				type = "centerpopup",
				text = format(L.alert["%s Warning"],SN[100258]),
				time = 2.5,
				flashtime = 2.5,
				color1 = "BROWN",
				icon = ST[100258],
				sound = "ALERT2",
			},
			smashcd = {
				varname = format(L.alert["%s Cooldown"],SN[100258]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[100258]),
				time = "<smashcd>",
				flashtime = 5,
				color1 = "BROWN",
				icon = ST[100258],
			},
			flameswarn = {
				varname = format(L.alert["%s Warning"],SN[100172]),
				type = "centerpopup",
				text = format(L.alert["%s Warning"],SN[100172]),
				time = 3,
				time10h = 2.5,
				time25h = 2.5,
				flashtime = 5,
				color1 = "YELLOW",
				icon = ST[100172],
			},
			flamescd = {
				varname = format(L.alert["%s Cooldown"],SN[100172]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[100172]),
				time = "<flamescd>",
				flashtime = 5,
				color1 = "YELLOW",
				icon = ST[100172],
			},
			seedwarn = {
				varname = format(L.alert["%s Warning"],SN[98333]),
				type = "centerpopup",
				text = format(L.alert["%s Warning"],SN[98333]),
				time = 12,
				flashtime = 5,
				color1 = "ORANGE",
				icon = ST[98333],
			},
			seedcd = {
				varname = format(L.alert["%s Cooldown"],SN[98333]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[98333]),
				time = 60,
				time2 = 24,
				time3 = 15,
				flashtime = 5,
				color1 = "ORANGE",
				icon = ST[98333],
			},
			heatwarn = {
				varname = format(L.alert["%s Warning"],SN[100981]),
				type = "simple",
				text = format(L.alert["%s on %s"],SN[100981],"<heattext>"),
				time = 3,
				color1 = "RED",
				sound = "ALERT1",
				icon = ST[100981],
			},
			heatself = {
				varname = format(L.alert["%s on self"],SN[100981]),
				type = "centerpopup",
				text = format("%s: %s!",SN[100981],L.alert["YOU"]),
				time = 13,
				flashtime = 13,
				color1 = "RED",
				sound = "ALERT12",
				icon = ST[100981],
				flashscreen = true,
			},
			-- meteor
			meteorwarn = {
				varname = format(L.alert["%s Warning"],SN[100989]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[100989]),
				time = 3,
				color1 = "ORANGE",
				sound = "ALERT1",
				icon = ST[100989],
				throttle = 1,
			},
			meteorcd = {
				varname = format(L.alert["%s Cooldown"],SN[100989]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[100989]),
				time = 45,
				time2 = 37,
				flashtime = 5,
				color1 = "ORANGE",
				icon = ST[100989],
				throttle = 1,
			},
			meteorself = {
				varname = format(L.alert["%s on self"],SN[100989]),
				type = "simple",
				text = format("%s: %s!",SN[100989],L.alert["YOU"]),
				time = 3,
				flashtime = 3,
				color1 = "RED",
				sound = "ALERT12",
				icon = ST[100989],
				flashscreen = true,
			},
			handcd = {
				varname = format(L.alert["%s Cooldown"],SN[100383]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[100383]),
				time = 25,
				flashtime = 5,
				color1 = "BLUE",
				icon = ST[100383],
			},
			woundwarn = {
				varname = format(L.alert["%s Warning"],SN[101238]),
				type = "simple",
				text = "<woundtext>",
				time = 3,
				color1 = "BLACK",
				sound = "ALERT10",
				icon = ST[101238],
			},
			wrathwarn = {
				varname = format(L.alert["%s Warning"],SN[100115]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[100115]),
				time = 3,
				flashtime = 3,
				color1 = "YELLOW",
				icon = ST[100115],
				sound = "ALERT4",
				throttle = 1,
			},
			wrathcd = {
				varname = format(L.alert["%s Cooldown"],SN[100115]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[100115]),
				time = "<wrathcd>",
				flashtime = 5,
				color1 = "YELLOW",
				icon = ST[100115],
			},
			empowercd = {
				varname = format(L.alert["%s Cooldown"],SN[100997]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[100997]),
				time = "<empowercd>",
				flashtime = 10,
				color1 = "ORANGE",
				icon = ST[100997],
			},
			empowerwarn = {
				varname = format(L.alert["%s Warning"],SN[100997]),
				type = "centerpopup",
				text = format(L.alert["%s Warning"],SN[100997]),
				time = 5,
				flashtime = 5,
				color1 = "ORANGE",
				icon = ST[100997],
				sound = "ALERT1",
			},
			empowerdur = {
				varname = format(L.alert["%s Duration"],SN[100997]),
				type = "centerpopup",
				text = format(L.alert["%s Duration"],SN[100997]),
				time = 10,
				flashtime = 10,
				color1 = "ORANGE",
				icon = ST[100997],
			},
			frostcd = {
				varname = format(L.alert["%s Cooldown"],SN[100479]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[100479]),
				time = 45,
				flashtime = 5,
				color1 = "BLUE",
				icon = ST[100479],
			},
			frostwarn = {
				varname = format(L.alert["%s Warning"],SN[100479]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[100479]),
				time = 3,
				flashtime = 3,
				color1 = "BLUE",
				sound = "ALERT2",
				icon = ST[100479],
			},
			rootscd = {
				varname = format(L.alert["%s Cooldown"],SN[100646]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[100646]),
				time = "<rootscd>",
				flashtime = 5,
				color1 = "GREEN",
				icon = ST[100646],
			},
			rootswarn = {
				varname = format(L.alert["%s Warning"],SN[100646]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[100646]),
				time = 3,
				flashtime = 3,
				color1 = "GREEN",
				sound = "ALERT3",
				icon = ST[100646],
			},
		},
		announces = {
			trapsay = {
				varname = format(L.alert["%s on self"],SN[98159]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[98159]).."!",
			},
			heatsay = {
				varname = format(L.alert["%s on self"],SN[100981]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[100981]).."!",
			},
			meteorsay = {
				varname = format(L.alert["%s on self"],SN[99849]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[99849]).."!",
			},
		},
		raidicons = {
			trapmark = {
				varname = SN[98159],
				type = "FRIENDLY",
				persist = 6,
				reset = 5,
				unit = "&upvalue&",
				icon = 1,
				total = 1,
			},
			heatmark = {
				varname = SN[100981],
				type = "MULTIFRIENDLY",
				persist = 10,
				reset = 9,
				unit = "#5#",
				icon = 2,
				total = 2,
			},
		},
		events = {
			-- Burning Wound on tanks
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED_DOSE",
				spellname = 101238,
				execute = {
					{
						"expect",{"#11#",">=","4"},
						"set",{woundtext = format(L.alert["%s: %s x %s"],"#5#",SN[101238],"#11#")},
						"alert","woundwarn",
					},
				},
			},
			-- Magma Trap
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 98159,
				execute = {
					{
						"target",{
							source = "#1#", -- Ragnaros
							wait = 0.2,
							announce = "trapsay",
							raidicon = "trapmark",
							alerts = {
								self = "trapself",
								other = "trapwarn",
								unknown = {"trapwarn",text = 2},
							},
						},
						"alert","trapcd",
					},
				},
			},
			-- Sulfuras Smash
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 100258,
				execute = {
					{
						"quash","smashcd",
						"alert","smashwarn",
						"alert","smashcd",
					},
				},
			},
			-- Wrath of Ragnaros
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 100115,
				execute = {
					{
						"quash","wrathcd",
						"alert","wrathwarn",
						"alert","wrathcd",
					},
				},
			},
			-- Hand of Ragnaros
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 100383,
				execute = {
					{
						"quash","handcd",
						"alert","handcd",
					},
				},
			},
			-- Splitting Blow == Intermission
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 100885,
				execute = {
					{
						"batchquash",{"smashcd","trapcd","flamescd","seedcd","handcd","wrathcd"},
						"set",{phase = "INCR|1"},
						"alert","phasewarn",
						"schedulealert",{"phasedur",10},
						"set",{
							phaseactivated = "no",
						},
					},
				},
			},
			-- Seeds
			{
				type = "event",
				event = "UNIT_SPELLCAST_SUCCEEDED",
				execute = {
					{
						"expect",{"#2#","==",SN[98498]}, --"Molten Seed"
						"quash","seedwarn",
						"quash","seedcd",
						"alert","seedwarn",
						"alert","seedcd",
					},
				},
			},
			-- Engulfing Flames
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 100172,
				execute = {
					{
						"expect",{"&difficulty&","<","3"}, --10n&25n
						"quash","flamescd",
						"alert","flamescd",
						"alert","flameswarn",
					},
					{
						"expect",{"&difficulty&",">=","3"}, --10h&25h
						"expect",{"<flameswarned>","==","no"},
						"quash","flamescd",
						"alert","flamescd",
						"alert","flameswarn",
						"set",{flameswarned = "yes"},
						"scheduletimer",{"flamewarnreset",15},
					},
				},
			},
			-- Blazing Heat
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 100981,
				srcisnpctype = true,
				execute = {
					{
						"raidicon","heatmark",
					},
					{
						"expect",{"#4#","~=","&playerguid&"},
						"set",{heattext = "#5#"},
						"alert","heatwarn",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert","heatself",
						"announce","heatsay",
					},
				},
			},
			-- Blazing Heat removed
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 100981,
				srcisnpctype = false,
				execute = {
					{
						"removeraidicon","#5#",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"quash","heatself",
					},
				},
			},
			-- Meteor Summon
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 100989,
				execute = {
					{
						"quash","meteorcd",
						"alert","meteorcd",
						"alert","meteorwarn",
					},
				},
			},
			-- Meteor fixate
			{
				type = "event",
				event = "UNIT_AURA",
				execute = {
					{
						"expect",{"#1#","==","player"},
						"scheduletimer",{"meteor",0.2},
					},
				},
			},
			-- Superheated on Raggi
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 100593,
				dstnpcid = 52409,
				execute = {
					{
						"alert","rootscd", --ca 35,57,55,55,58
						"alert","empowercd",
					},
				},
			},
			-- Empower Sulfuras
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 100997,
				execute = {
					{
						"quash","empowercd",
						"alert","empowercd",
						"alert","empowerwarn",
						"schedulealert",{"empowerdur",5},
					},
				},
			},
			-- Breadth of Frost
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 100479,
				execute = {
					{
						"quash","frostcd",
						"alert","frostcd",
						"alert","frostwarn",
					},
				},
			},
			-- Entrapping Roots
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 100646,
				execute = {
					{
						"quash","rootscd",
						"alert","rootscd",
						"alert","rootswarn",
					},
				},
			},
			-- Yells
			{
				type = "event",
				event = "YELL",
				execute = {
					--Intermission ends
					{
						"expect",{"#1#","find",L.chat_firelands["^Enough"]},
						"set",{
							phase = "INCR|1",
							phaseactivated = "yes",
						},
						"quash","phasedur",
					},
					{
						"expect",{"#1#","find",L.chat_firelands["^Fall to your knees"]},
						"set",{
							phase = "INCR|1",
							phaseactivated = "yes",
						},
						"quash","phasedur",
					},
					{
						"expect",{"#1#","find",L.chat_firelands["^Sulfuras will be your end"]},
						"set",{
							phase = "INCR|1",
							phaseactivated = "yes",
						},
						"quash","phasedur",
					},
					{
						"expect",{"#1#","find",L.chat_firelands["^No, fiend"]},
						"set",{
							phase = "INCR|1",
							phaseactivated = "yes",
						},
						"quash","phasedur",
					},
					{
						"expect",{"<phase>","==","3"},
						"expect",{"<phaseactivated>","==","yes"},
						"invoke",{
							{
								"expect",{"&difficulty&","<","3"},
								"set",{
									smashcd = {55,40, loop = false, type = "series"},
								},
								"alert","smashcd",
								"alert","flamescd",
								"alert",{"seedcd",time = 2},
							},
							{
								"expect",{"&difficulty&",">=","3"},
								"set",{
									smashcd = {7.5,40, loop = false, type = "series"},
									flamescd = {45,60, loop = false, type = "series"},
								},
								"alert","smashcd",
								"alert","flamescd",
								"alert",{"seedcd",time = 3},
							},
						},
						"set",{
							phaseactivated = "no",
						},
					},
					{
						"expect",{"<phase>","==","5"},
						"expect",{"<phaseactivated>","==","yes"},
						"set",{
							smashcd = {10,30, loop = false, type = "series"},
							flamescd = 30,
						},
						"alert","smashcd",
						"alert","flamescd",
						"alert",{"meteorcd", time = 2},
						"set",{
							phaseactivated = "no",
						},
					},
					{
						"expect",{"<phase>","==","6"},
						"expect",{"<phaseactivated>","==","yes"},
						"quashall",true,
						"alert","phasewarn",
						"set",{
							phaseactivated = "no",
						},
						-- dur to phase alert?
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end

