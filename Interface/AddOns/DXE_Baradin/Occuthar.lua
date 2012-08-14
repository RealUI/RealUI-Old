local L,SN,ST = DXE.L,DXE.SN,DXE.ST
---------------------------------
-- OCCU'THAR
---------------------------------
do
	local data = {
		version = 3,
		key = "occuthar",
		zone = L.zone["Baradin Hold"],
		category = L.zone["Baradin"],
		name = L.npc_baradin["Occu'thar"],
		triggers = {
			scan = {
				52363, -- Occu'thar
			},
		},
		onactivate = {
			tracing = {
				52363, -- Occu'thar
			},
			tracerstart = true,
			combatstop = true,
			defeat = {
				52363, -- Occu'thar
			},
		},
		userdata = {
			firecd = 0,
		},
		onstart = {
			{
				"alert",{"searingshadowscd", time = 2},
				"alert",{"focusfirecd", time = 2},
				"alert",{"eyescd", time = 2},
			},
		},
		--windows = {		},
		alerts = {
			searingshadowscd = {
				varname = format(L.alert["%s Cooldown"],SN[96913]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[96913]),
				time = 22,
				time2 = 5,
				flashtime = 5,
				color1 = "BLUE",
				icon = ST[96913],
			},
			searingshadowswarn = {
				varname = format(L.alert["%s Warning"],SN[96913]),
				type = "centerpopup",
				text = format(L.alert["%s Warning"],SN[96913]),
				time = 2.5,
				flashtime = 2.5,
				color1 = "BLUE",
				sound = "ALERT1",
				icon = ST[96913],
			},
			focusfirecd = {
				varname = format(L.alert["%s Cooldown"],SN[101004]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[101004]),
				time = 30,
				time2 = 15,
				flashtime = 5,
				color1 = "PURPLE",
				icon = ST[101004],
			},
			focusfirewarn = {
				varname = format(L.alert["%s Warning"],SN[101004]),
				type = "centerpopup",
				text = format(L.alert["%s Warning"],SN[101004]),
				time = 2.5,
				flashtime = 2.5,
				color1 = "PURPLE",
				sound = "ALERT2",
				icon = ST[101004],
			},
			eyescd = {
				varname = format(L.alert["%s Cooldown"],SN[101006]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[101006]),
				time = 60,
				time2 = 30,
				flashtime = 5,
				color1 = "YELLOW",
				icon = ST[101006],
			},
			eyeswarn = {
				varname = format(L.alert["%s Warning"],SN[101006]),
				type = "centerpopup",
				text = format(L.alert["%s Warning"],SN[101006]),
				time = 2,
				flashtime = 2,
				color1 = "YELLOW",
				sound = "ALERT2",
				icon = ST[101006],
			},
		},
		--timers = {		},
		events = {
			-- Searing Shadows
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 96913,
				execute = {
					{
						"quash","searingshadowscd",
						"alert","searingshadowscd",
						"alert","searingshadowswarn",
					},
				},
			},
			-- Focused Fire
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 101004,
				execute = {
					{
						"quash","focusfirecd",
						"alert","focusfirecd",
						"alert","focusfirewarn",
					},
				},
			},
			-- Eyes of Occu'thar
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 101006,
				execute = {
					{
						"quash","focusfirecd",
						"quash","eyescd",
						"alert","eyescd",
						"alert","eyeswarn",
						"set",{
							firecd = {12,15, loop = false, type = "series"},
						},
						"alert","focusfirecd",
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end

