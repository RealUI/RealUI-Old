local L,SN,ST = DXE.L,DXE.SN,DXE.ST

---------------------------------
-- CONCLAVE OF WIND
---------------------------------
do
	local data = {
		version = 8,
		key = "windconclave",
		zone = L.zone["Throne of the Four Winds"],
		category = L.zone["Throne"],
		name = L.npc_throne["Conclave of Wind"],
		triggers = {
			scan = {
				45871, -- Nezir
				45872, -- Rohash
				45870, -- Anshal
			},
			yell = {
				L.chat_throne["shall be I that earns"],
				L.chat_throne["honor of slaying the interlopers"],
				L.chat_throne["strongest wind"],
			},
		},
		onactivate = {
			tracing = {
				45871, -- Nezir
				45872, -- Rohash
				45870, -- Anshal
			},
			tracerstart = true,
			combatstop = true,
			defeat = {
				45872, -- Rohash
				45870, -- Anshal
				45871, -- Nezir
			},
		},
		userdata = {
			-- All
			powercd = {93,98,loop = false,type = "series"},
			strengthtext = "",
			-- Rohash
			shieldcd = {30,113,loop = false,type = "series"},
			windblastcd = {30,82,60,loop = false,type = "series"},
			-- Anshal
			nurturecd = {30,113,loop = false,type = "series"},
			breezecd = {15,32.5,loop = false,type = "series"},
			-- Nezir
			chilltext = "",
		},
		onstart = {
			{
				"alert","powercd",
				"alert","berserk",
				"alert","windblastcd",
				"alert","shieldcd",
				"alert","nurturecd",
				"alert","breezecd",
			},
		},
		alerts = {
			-- All
			berserk = {
				varname = format(L.alert["Berserk Warning"]),
				type = "dropdown",
				text = format(L.alert["Berserk Warning"]),
				time = 480,
				flashtime = 15,
				color1 = "RED",
				sound = "ALERT1",
			},
			powercd = {
				varname = format(L.alert["Full Power CD"]),
				type = "dropdown",
				text = format(L.alert["Full Power CD"]),
				time = "<powercd>",
				flashtime = 20,
				color1 = "YELLOW",
				sound = "ALERT2",
			},
			powerwarn = {
				varname = format(L.alert["Full Power Duration"]),
				type = "centerpopup",
				text = format(L.alert["Full Power Duration"]),
				time = 15,
				flashtime = 15,
				color1 = "YELLOW",
				sound = "ALERT3",
				throttle = 1,
			},
			strengthwarn = {
				varname = format(L.alert["%s Warning"],SN[86307]),
				type = "centerpopup",
				text = "<strengthtext>",
				time = 120,
				flashtime = 15,
				color1 = "YELLOW",
				color2 = "RED",
				sound = "ALERT4",
			},
			-- Rohash
			shieldwarn = {
				varname = format(L.alert["%s Absorbs"],SN[95865]),
				text = SN[95865].."!",
				textformat = format("%s => %%s/%%s - %%d%%%%",L.alert["Shield"]),
				type = "absorb",
				time = 30,
				flashtime = 5,
				color1 = "BLUE",
				color2 = "TEAL",
				sound = "ALERT5",
				icon = ST[95865],
				npcid = 45872,
				values = {
					[95865] = 450000, --25h
					[93059] = 125000, --10h
				},
			},
			shieldcd = {
				varname = format(L.alert["%s Cooldown"],SN[95865]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[95865]),
				time = "<shieldcd>",
				color1 = "INDIGO",
				icon = ST[95865],
			},
			windblastwarn = {
				varname = format(L.alert["%s Warning"],SN[93138]),
				type = "centerpopup",
				text = format(L.alert["%s Warning"],SN[93138]),
				time = 5,
				color1 = "YELLOW",
				sound = "ALERT12",
				icon = ST[93138],
			},
			windblastdur = {
				varname = format(L.alert["%s Duration"],SN[93138]),
				type = "centerpopup",
				text = format(L.alert["%s Duration"],SN[93138]),
				time = 6,
				color1 = "YELLOW",
				icon = ST[93138],
			},
			windblastcd = {
				varname = format(L.alert["%s Cooldown"],SN[93138]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[93138]),
				time = "<windblastcd>",
				flashtime = 8,
				color1 = "YELLOW",
				icon = ST[93138],
			},
			-- Anshal
			breezecd = {
				varname = format(L.alert["%s Cooldown"],SN[86205]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[86205]),
				time = "<breezecd>",
				color1 = "GREEN",
				icon = ST[86205],
			},
			breezewarn = {
				varname = format(L.alert["%s Warning"],SN[86205]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[86205]),
				time = 3,
				color1 = "GREEN",
				icon = ST[86205],
				sound = "ALERT6"
			},
			nurturecd = {
				varname = format(L.alert["%s Cooldown"],SN[85422]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[85422]),
				time = "<nurturecd>",
				color1 = "CYAN",
				icon = ST[85422],
			},
			nurturewarn = {
				varname = format(L.alert["%s Warning"],SN[85422]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[85422]),
				time = 5,
				color1 = "CYAN",
				icon = ST[85422],
				sound = "ALERT7",
			},
			toxiccd = {
				varname = format(L.alert["%s Cooldown"],SN[86281]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[86281]),
				time = 21.5,
				flashtime = 5,
				color1 = "GREEN",
				icon = ST[86281],
				throttle = 2,
			},
			-- Nezir
			chillwarnself = {
				varname = format(L.alert["%s Warning on self"],SN[84645]),
				type = "simple",
				text = "<chilltext>",
				time = 3,
				color1 = "WHITE",
				icon = ST[84645],
				sound = "ALERT8",
			},
		},
		events = {
			-- All
			-- Ultimate Ability
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellid = {
					84638,
					84644,
					84643,
				},
				execute = {
					{
						"quash","powercd",
						"quash","breezecd",
						"alert","powerwarn",
						"schedulealert",{"powercd",15},
					},
				},
			},
			-- Gather Strength
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 86307,
				execute = {
					{
						"set",{strengthtext = format(L.alert["%s: %s"],"#2#",SN[86307])},
						"alert","strengthwarn",
					},
				},
			},
			-- Rohash
			-- Wind Blast
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 86193,
				execute = {
					{
						"quash","windblastcd",
						"alert","windblastwarn",
						"schedulealert",{"windblastdur",5},
						"alert","windblastcd",
					},
				},
			},
			-- Storm Shield
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellid = {
					95865,
					93059,
				},
				execute = {
					{
						"quash","shieldcd",
						"alert","shieldcd",
						"alert","shieldwarn",
					},
				},
			},
			-- Storm Shield
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellid = {
					95865,
					93059,
				},
				execute = {
					{
						"quash","shieldwarn",
					},
				},
			},
			-- Anshal
			-- Soothing Breeze
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 86205,
				execute = {
					{
						"quash","breezecd",
						"alert","breezecd",
						"alert","breezewarn",
					},
				},
			},
			-- Nurture
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 85422,
				execute = {
					{
						"quash","nurturecd",
						"alert","nurturecd",
						"alert","nurturewarn",
						"alert","toxiccd",
						"schedulealert",{"toxiccd",22},
					},
				},
			},
			-- Nezir
			-- Wind Chill Stacks
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED_DOSE",
				spellid = {
					84645,
					93124,
					93125,
					93123,
				},
				execute = {
					{
						"expect",{"#4#","==","&playerguid&"},
						"expect",{"#11#",">",5},
						"set",{chilltext = format("%s: %s! %s!",SN[84645],L.alert["YOU"],format(L.alert["%s Stacks"],"#11#"))},
						"alert","chillwarnself",
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end

---------------------------------
-- AL'AKIR
---------------------------------

do
	local data = {
		version = 9,
		key = "alakir",
		zone = L.zone["Throne of the Four Winds"],
		category = L.zone["Throne"],
		name = L.npc_throne["Al'Akir"],
		triggers = {
			scan = {
				46753, -- Al'Akir
			},
		},
		onactivate = {
			tracing = {
				46753, -- Al'Akir
			},
			tracerstart = true,
			combatstop = true,
			defeat = {
				46753, -- Al'Akir
			},
		},
		userdata = {
			phase = "1",
			raintext = "",
			stormlingtime = {10,20,loop = false, type = "series"},
			feedbackdur = 30,
		},
		onstart = {
			{
				"alert", "windburstcd",
				"alert","enrage",
			},
			{
				"expect",{"&difficulty&",">=","3"}, --10h&25h
				"set",{
					feedbackdur = 20,
				},
			},
		},
		timers = {
			clouds = {
				{
					"alert","cloudcd",
					"scheduletimer",{"clouds",10},
				},
			},
		},
		alerts = {
			enrage = {
				varname = format(L.alert["%s Warning"],SN[47008]),
				type = "dropdown",
				text = format("%s Warning",SN[47008]),
				time = 600,
				flashtime = 30,
				color1 = "RED",
				icon = ST[47008],
			},
			windburstcd = {
				varname = format(L.alert["%s Cooldown"],SN[87770]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[87770]),
				time = 25,
				flashtime = 5,
				color1 = "BLACK",
				icon = ST[87770],
			},
			windburst = {
				varname = format(L.alert["%s Warning"],SN[87770]),
				type = "centerpopup",
				text = format(L.alert["%s Warning"],SN[87770]),
				time = 4,
				flashtime = 4,
				color1 = "BLACK",
				sound = "ALERT1",
				icon = ST[87770],
			},
			stormlingcd = {
				varname = format(L.alert["%s Cooldown"],SN[87919]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[87919]),
				time = "<stormlingtime>",
				flashtime = 5,
				color1 = "ORANGE",
				icon = ST[87919],
			},
			feedbackdur = {
				varname = format(L.alert["%s Duration"],SN[87904]),
				type = "centerpopup",
				text = format(L.alert["%s Duration"],SN[87904]),
				time = "<feedbackdur>",
				flashtime = "<feedbackdur>",
				color1 = "BLUE",
				icon = ST[87904],
			},
			rodself = {
				varname = format(L.alert["%s Warning on self"],SN[93294]),
				type = "simple",
				text = format(L.alert["%s on %s"],SN[93294],L.alert["YOU"]),
				time = 5,
				flashtime = 5,
				color1 = "YELLOW",
				sound = "ALERT12",
				icon = ST[93294],
			},
			phasewarn = {
				varname = format(L.alert["Phase Warning"]),
				type = "simple",
				text = format(L.alert["Phase %s"],"<phase>"),
				time = 5,
				flashtime = 5,
				color1 = "RED",
				sound = "ALERT2",
			},
			raindur = {
				varname = format(L.alert["%s Duration"],SN[93281]),
				type = "dropdown",
				text = "<raintext>",
				time = 20,
				flashtime = 5,
				color1 = "GREEN",
				sound = "ALERT3",
				icon = ST[93281],
			},
			cloudcd = {
				varname = format(L.alert["%s Cooldown"],SN[89588]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[89588]),
				time = 10,
				time2 = 16,
				flashtime = 5,
				color1 = "BLUE",
				icon = ST[87919],
				sound = "ALERT4",
			},
		},
		raidicons = {
			rodmark = {
				varname = SN[93294],
				type = "FRIENDLY",
				persist = 10,
				unit = "#5#",
				icon = 1,
			},
		},
		announces = {
			rodsay = {
				varname = format(L.alert["Say %s on self"],SN[93294]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[93294]),
			},
		},
		events = {
			-- Wind Burst
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 87770,
				execute = {
					{
						"quash","windburstcd",
						"alert","windburstcd",
						"alert","windburst",
					},
				},
			},
			-- Feedback
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 87904,
				execute = {
					{
						"quash","feedbackdur",
						"alert","feedbackdur",
					},
				}
			},
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED_DOSE",
				spellname = 87904,
				execute = {
					{
						"quash","feedbackdur",
						"alert","feedbackdur",
					},
				}
			},
			-- Lightning Rod
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 93294,
				execute = {
					{
						"expect",{"#4#","==","&playerguid&"},
						"alert","rodself",
						"announce","rodsay",
					},
					{
						"raidicon","rodmark",
					},
				},
			},
			-- Acid Raid Duration
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 93281,
				execute = {
					{
						"expect",{"#4#","==","&playerguid&"},
						"quash","raindur",
						"set",{raintext = format("%s: %s!",SN[93281],L.alert["YOU"])},
						"alert","raindur",
					},
				},
			},
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED_DOSE",
				spellname = 93281,
				execute = {
					{
						"expect",{"#4#","==","&playerguid&"},
						"quash","raindur",
						"set",{raintext = format("%s: %s! %s!",SN[93281],L.alert["YOU"],format(L.alert["%s Stacks"],"#11#"))},
						"alert","raindur",
					},
				},
			},
			{
				type = "event",
				event = "YELL",
				execute = {
					-- Phase 2
					{
						"expect",{"#1#", "find", L.chat_throne["^Your futile persistance angers me!"]},
						"set", {phase = "2"},
						"quash", "windburstcd",
						"alert", "stormlingcd",
						"alert","phasewarn",
					},
					-- Phase 3
					{
						"expect",{"#1#", "find", L.chat_throne["^Enough! I will no longer be contained!"]},
						"quash", "stormlingcd",
						"set", {phase = "3"},
						"alert","phasewarn",
						"alert",{"cloudcd",time = 2},
						"scheduletimer",{"clouds",16},
					},
					-- Stormling Summon
					{
						"expect",{"#1#", "find", L.chat_throne["^Storms! I summon you to my side!"]},
						"quash", "stormlingcd",
						"alert", "stormlingcd",
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end


