local L,SN,ST,EJSN,EJST = DXE.L,DXE.SN,DXE.ST,DXE.EJSN,DXE.EJST

------------------------
-- Ultraxion
------------------------
do
	local data = {
		version = 5,
		key = "Ultraxion",
		zone = L.zone["The Dragon Wastes"],
		category = L.zone["Dragon Soul"],
		name = L.npc_dragonsoul["Ultraxion"],
		triggers = {
			scan = {
				55294, --Ultraxion
				56667, --Thrall
			},
		},
		onactivate = {
			tracing = {
				55294, --Ultraxion
			},
			tracerstart = true,
			combatstop = true,
			defeat = 55294,
		},
		enrage = {
			time10n = 360,
			time25n = 360,
			time10h = 360,
			time25h = 360,
		},
		userdata = {
			lightdur = "",
		},
		--windows = {},
		--timers = {},
		--announces = {},
		raidicons = {
			lighticon = {
				varname = SN[105925],
				type = "MULTIFRIENDLY",
				persist = 10,
				reset = 2,
				unit = "#5#",
				icon = 1,
				total = 6,
			},
		},
		--arrows = {},
		onstart = {
			{
				"alert","hourcd",
				"alert","unstablecd",
				"alert","crystalcd",
			},
		},
		alerts = {
			hourcd = {
				varname = format(L.alert["%s Cooldown"],SN[103327]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[103327]),
				time = 45,
				flashtime = 10,
				color1 = "BLUE",
				icon = ST[103327],
			},
			hourwarn = {
				varname = format(L.alert["%s Casting"],SN[103327]),
				type = "centerpopup",
				text = format(L.alert["%s Casting"],SN[103327]),
				time = 5,
				time10n = 5,
				time10h = 3, -- ???
				time25n = 5,
				time25h = 3, -- ???
				color1 = "BLUE",
				icon = ST[103327],
				sound = "ALERT12",
			},
			lightself = {
				varname = format(L.alert["%s on self"],SN[105925]),
				type = "centerpopup",
				text = format(L.alert["%s on %s"],SN[105925],L.alert["YOU"]),
				time = "<lightdur>",
				flashtime = 5,
				color1 = "GOLD",
				icon = ST[105925],
				flashscreen = true,
			},
			lightwarn = {
				varname = format(L.alert["%s Warning"],SN[105925]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[105925]),
				time = 3,
				flashtime = 3,
				color1 = "GOLD",
				icon = ST[105925],
				sound = "ALERT1",
				throttle = 1.5,
			},
			unstablecd = {
				varname = format(L.alert["%s Cooldown"],SN[106377]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[106377]),
				time = 60,
				flashtime = 5,
				color1 = "PURPLE",
				icon = ST[106377],
			},
			unstablewarn = {
				varname = format(L.alert["%s Warning"],SN[106377]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[106377]),
				time = 3,
				color1 = "PURPLE",
				icon = ST[106377],
				sound = "ALERT2",
			},
			crystalcd = {
				varname = format(L.alert["%s Cooldown"],EJSN[4346]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[109345]),
				text2 = format(L.alert["%s Cooldown"],SN[109358]),
				text3 = format(L.alert["%s Cooldown"],SN[109353]),
				text4 = format(L.alert["%s Cooldown"],SN[105984]),
				time = 80,
				time2 = 75,
				time3 = 60,
				time4 = 75,
				flashtime = 5,
				color1 = "GREEN",
			},
		},
		events = {
			-- Hour of Twilight Cast
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 103327,
				execute = {
					{
						"quash","hourcd",
						"alert","hourcd",
						"alert","hourwarn",
					},
				},
			},
			-- Fading Light
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 105925,
				execute = {
					{
						"alert","lightwarn",
						"raidicon","lighticon",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"set",{lightdur = "&playerdebuffdur|"..SN[105925].."&"},
						"alert","lightself",
					},
				},
			},
			-- Unstable Monster
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 106377,
				execute = {
					{
						"quash","unstablecd",
						"alert","unstablecd",
						"alert","unstablewarn",
					},
				},
			},
			-- Crystal Spawn
			{
				type = "event",
				event = "EMOTE",
				execute = {
					{
						"expect",{"#1#","find",EJSN[4234]},
						"alert",{"crystalcd",text = 2,time = 2},
					},
					{
						"expect",{"#1#","find",EJSN[4236]},
						"alert",{"crystalcd",text = 3,time = 3},
					},
					{
						"expect",{"#1#","find",EJSN[4238]},
						"alert",{"crystalcd",text = 4,time = 4},
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end
