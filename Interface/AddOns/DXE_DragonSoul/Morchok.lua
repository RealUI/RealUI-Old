local L,SN,ST,EJSN,EJST = DXE.L,DXE.SN,DXE.ST,DXE.EJSN,DXE.EJST

------------------------
-- Morchok
------------------------
do
	local data = {
		version = 8,
		key = "Morchok",
		zone = L.zone["Dragon Soul"],
		category = L.zone["Dragon Soul"],
		name = L.npc_dragonsoul["Morchok"],
		triggers = {
			scan = {
				55265, --Morchok
			},
		},
		onactivate = {
			tracing = {
				55265, --Morchok
			},
			tracerstart = true,
			combatstop = true,
			defeat = 55265, --Morchok
		},
		enrage = {
			time10n = 420,
			time25n = 420,
			time10h = 420,
			time25h = 420,
		},
		userdata = {
			crushtext = "",
			heroic = "false",
		},
		--[[windows = {
		},
		timers = {
		},
		announces = {
		},
		raidicons = {
		},
		arrows = {
		},]]
		onstart = {
			{
				"alert",{"bloodcd",time = 2},
				"alert","stompcd",
			},
		},
		alerts = {
			crushwarn = {
				varname = format(L.alert["%s Warning"],SN[103687]),
				type = "simple",
				text = "<crushtext>",
				time = 3,
				color1 = "WHITE",
				icon = ST[103687],
			},
			stompwarn = {
				varname = format(L.alert["%s Warning"],SN[103414]),
				type = "simple",
				text = format("%s %s","#2#",SN[103414]),
				time = 3,
				flashtime = 3,
				color1 = "GREEN",
				icon = ST[103414],
				sound = "ALERT1",
			},
			stompcd = {
				varname = format(L.alert["%s Cooldown"],SN[103414]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[103414]),
				text2 = L.npc_dragonsoul["Morchok"].." "..format(L.alert["%s Cooldown"],SN[103414]),
				text3 = L.npc_dragonsoul["Kohcrom"].." "..format(L.alert["%s Cooldown"],SN[103414]),
				time = 12,
				time2 = 6,
				time3 = 18.5,
				flashtime = 5,
				color1 = "GREEN",
				icon = ST[103414],
			},
			orbwarn = {
				varname = format(L.alert["%s Casting"],SN[103640]),
				type = "centerpopup",
				text = format("%s %s","#2#",SN[103640]),
				time = 12,
				color1 = "PURPLE",
				icon = ST[103640],
				sound = "ALERT2",
			},
			bloodcd = {
				varname = format(L.alert["%s Cooldown"],SN[35331]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[35331]),
				time = 98,
				time2 = 54,
				flashtime = 5,
				color1 = "BLACK",
				icon = ST[103851],
			},
			bloodwarn = {
				varname = format(L.alert["%s Warning"],SN[35331]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[35331]),
				time = 3,
				flashtime = 3,
				color1 = "BLACK",
				icon = ST[103851],
				sound = "ALERT12",
			},
			blooddur = {
				varname = format(L.alert["%s Duration"],SN[35331]),
				type = "dropdown",
				text = format(L.alert["%s Duration"],SN[35331]),
				time = 15,
				flashtime = 5,
				color1 = "BLACK",
				icon = ST[103851],
			},
		},
		events = {
			-- Heroic
			{
				type = "combatevent",
				eventtype = "SPELL_SUMMON",
				spellname = 109017,
				execute = {
					{
						"set",{heroic = "true"},
						"tracing",{
							55265, --Morchok
							57773, --Kohcrom
						},
					},
				},
			},
			-- Crush Armor on Tanks
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED_DOSE",
				spellname = 103687,
				execute = {
					{
						"expect",{"#11#",">=","2"},
						"set",{crushtext = format("%s: %s x %s","#5#",SN[103687],"#11#")},
						"alert","crushwarn",
					},
				},
			},
			-- Stomp
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname= 103414,
				srcnpcid = 55265,
				execute = {
					{
						"alert","stompwarn",
					},
					{
						"expect",{"#2#","==",L.npc_dragonsoul["Morchok"]},
						"alert",{"stompcd",text = 2},
					},
					{
						"expect",{"<heroic>","==","true"},
						"alert",{"stompcd",text = 3, time = 2},
					},
				},
			},
			-- Twilight Orb Summon
			{
				type = "combatevent",
				eventtype = "SPELL_SUMMON",
				spellname = 103639,
				execute = {
					{
						"alert","orbwarn",
					},
				},
			},
			-- Falling Fragments +stompcd after
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 103176,
				dstnpcid = 55265, -- once is enough
				execute = {
					{
						"alert","bloodwarn",
						"alert","bloodcd",
						"schedulealert",{"blooddur",7}
					},
				},
			},
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 103851,
				dstnpcid = 55265, -- once is enough
				execute = {
					{
						"alert",{"stompcd",text = 2,time = 3},
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end
