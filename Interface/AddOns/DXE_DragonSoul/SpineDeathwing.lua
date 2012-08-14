local L,SN,ST,EJSN,EJST = DXE.L,DXE.SN,DXE.ST,DXE.EJSN,DXE.EJST

------------------------
-- Spine of Deathwing
------------------------
do
	local data = {
		version = 7,
		key = "Spine of Deathwing",
		zone = L.zone["Dragon Soul"],
		category = L.zone["Dragon Soul"],
		name = L.npc_dragonsoul["Spine of Deathwing"],
		triggers = {
			scan = {
				53879, --Spine
			},
		},
		onactivate = {
			tracing = {
				"boss1",
			},
			tracerstart = true,
			combatstop = true,
			defeat = 53879,
		},
		--[[enrage = {
			time10n = 1080,
			time25n = 1080,
			time10h = 1080,
			time25h = 1080,
		},]]
		userdata = {
			bloodtext = "",
			deadbloods = 0,
			griptext = "",
			activemobs = {type="container"},
		},
		--windows = {},
		timers = {
			rollcheck = {
				{
					"expect",{"&playerdebuff|"..SN[109455].."&","==","false"},
					"alert","graspwarn",
					"scheduletimer",{"rollcheck",1}
				},
			},
			rolldone = {
				{
					"canceltimer","rollcheck",
				},
			},
		},
		--announces = {},
		raidicons = {
			heated = {
				varname = SN[105834],
				type = "ENEMY",
				persist = 10,
				reset = 1,
				unit = "#5#",
				icon = 1,
				total = 1,
			},
		},
		--arrows = {},
		--onstart = {},
		alerts = {
			breachwarn = {
				varname = format(L.alert["%s Warning"],SN[105847]),
				type = "centerpopup",
				text =  format(L.alert["%s Warning"],SN[105847]),
				time = 23,
				flashtime = 5,
				color1 = "RED",
				icon = ST[105847],
				sound = "ALERT1",
			},
			superheatwarn = {
				varname = format(L.alert["%s Warning"],SN[105834]),
				type = "simple",
				text =  format(L.alert["%s Warning"],SN[105834]),
				time = 3,
				color1 = "PURPLE",
				icon = ST[105834],
				sound = "ALERT2",
			},
			rollwarn = {
				varname = format(L.alert["%s Warning"],EJSN[4050]),
				type = "centerpopup",
				text =  format(L.alert["%s Warning"],EJSN[4050]),
				time = 5,
				color1 = "GOLD",
				icon = EJST[4050],
				sound = "ALERT3",
			},
			graspwarn = {
				varname = format(L.alert["%s Missing"],SN[109455]),
				type = "simple",
				text =  format(L.alert["%s Missing"],SN[109455]),
				time = 1,
				color1 = "RED",
				icon = ST[109455],
				sound = "ALERT4",
			},
			bloodwarn = {
				varname = format(L.alert["%s Warning"],SN[105248]),
				type = "simple",
				text = "<bloodtext>",
				time = 2,
				color1 = "RED",
				icon = ST[105248],
				sound = "ALERT5",
			},
			blooddeaths = {
				varname = format(L.alert["%s Warning"],EJSN[4055]),
				type = "simple",
				text = format(L.alert["%s dead"],"<deadbloods>"),
				time = 2,
				color1 = "GREEN",
				icon = EJST[4056],
				sound = "ALERT6",
			},
			gripwarn = {
				varname = format(L.alert["%s Warning"],SN[109457]),
				type = "simple",
				text =  format(L.alert["%s Warning"],SN[109457]),
				time = 2,
				color1 = "YELLOW",
				icon = ST[109457],
				sound = "ALERT7",
			},
			gripcd = {
				varname = format(L.alert["%s Cooldown"],SN[109457]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[109457]),
				time = 32,
				time10n = 32,
				time10h = 32,
				time25n = 16,
				time25h = 16,
				color1 = "YELLOW",
				icon = ST[109457],
				tag = "#1#",
			},
		},
		events = {
			-- Seal Armor Breach
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 105847,
				execute = {
					{
						"alert","breachwarn",
						"set",{deadbloods = "0"},
					},
				},
			},
			-- Grip
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 109379, -- Plasma
				execute = {
					{
						"expect",{"&tabread|activemobs|#1#&","~=","true"},
						"tabinsert",{"activemobs","#1#","true"},
						"alert","gripcd",
					},
				},
			},
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 109457, -- Grip
				execute = {
					{
						"tabupdate",{"activemobs","#1#","false"},
						"alert","gripwarn",
					},
				},
			},
			{
				type = "combatevent",
				eventtype = "UNIT_DIED",
				execute = {
					{
						"expect",{"&npcid|#4#&","==","53891"},
						"quashpattern","#4#",
					},
					{
						"expect",{"&npcid|#4#&","==","56162"},
						"quashpattern","#4#",
					},
					{
						"expect",{"&npcid|#4#&","==","56161"},
						"quashpattern","#4#",
					},
				},
			},

			-- Absorb Blood Stacks
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED_DOSE",
				spellname = 105248,
				execute = {
					{
						"expect",{"#11#",">=","2"},
						"set",{bloodtext = format("%s x %s",SN[105248],"#11#")},
						"alert","bloodwarn",
					},
				},
			},
			-- Superheated
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 105834,
				execute = {
					{
						"alert","superheatwarn",
						"raidicon","heated",
					},
				},
			},
			-- Barrel Roll
			{
				type = "event",
				event = "EMOTE",
				execute = {
					{
						"expect",{"#1#","find",L.chat_dragonsoul["He's about to roll"]},
						"alert","rollwarn",
						"scheduletimer",{"rollcheck",0.1},
						"scheduletimer",{"rolldone",7},
					},
				},
			},
			-- Levels out
			{
				type = "event",
				event = "EMOTE",
				execute = {
					{
						"expect",{"#1#","find",L.chat_dragonsoul["levels out"]},
						"canceltimer","rollcheck",
					},
				},
			},
			-- Blood dies = Burst cast
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 109373,
				execute = {
					{
						"set",{deadbloods = "INCR|1"},
						"alert","blooddeaths",
					},
				},
			},

		},
	}

	DXE:RegisterEncounter(data)
end
