local L,SN,ST = DXE.L,DXE.SN,DXE.ST
---------------------------------
-- ALIZABAL
---------------------------------

do
	local data = {
		version = 3,
		key = "Alizabal",
		zone = L.zone["Baradin Hold"],
		category = L.zone["Baradin"],
		name = L.npc_baradin["Alizabal"],
		triggers = {
			scan = {
				55869, -- Alizabal
			},
		},
		onactivate = {
			tracing = {
				55869, -- Alizabal
			},
			tracerstart = true,
			combatstop = true,
			defeat = {
				55869, -- Alizabal
			},
		},
		userdata = {
			skewertext = "",
			justdanced = "true"
		},
		onstart = {
			{
				"alert",{"dancecd", time = 2},
				"alert","firstcd",
			}
		},
		--windows = {},
		alerts = {
			firstcd = {
				varname = format(L.alert["%s/%s Cooldown"],SN[104936],SN[105067]),
				type = "dropdown",
				text = format(L.alert["%s/%s Cooldown"],SN[104936],SN[105067]),
				time = 8,
				flashtime = 5,
				color1 = "BLUE",
				icon = ST[104936],
			},
			skewercd = {
				varname = format(L.alert["%s Cooldown"],SN[104936]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[104936]),
				time = 20,
				time2 = 8,
				flashtime = 5,
				color1 = "YELLOW",
				icon = ST[104936],
			},
			skewerwarn = {
				varname = format(L.alert["%s Warning"],SN[104936]),
				type = "simple",
				text = "<skewertext>",
				time = 3,
				flashtime = 3,
				color1 = "YELLOW",
				icon = ST[104936],
			},
			hatecd = {
				varname = format(L.alert["%s Cooldown"],SN[105067]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[105067]),
				time = 20,
				time2 = 8,
				flashtime = 5,
				color1 = "GREEN",
				icon = ST[105067],
			},
			hatewarn = {
				varname = format(L.alert["%s Warning"],SN[105067]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[105067]),
				time = 3,
				flashtime = 3,
				color1 = "GREEN",
				icon = ST[105067],
			},
			dancecd = {
				varname = format(L.alert["%s Cooldown"],SN[104995]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[104995]),
				time = 60,
				time2 = 28, --seen 27 to 30 to first
				flashtime = 5,
				color1 = "ORANGE",
				icon = ST[104995],
			},
			dancedur = {
				varname = format(L.alert["%s Duration"],SN[104995]),
				type = "centerpopup",
				text = format(L.alert["%s Duration"],SN[104995]),
				time = 15,
				flashtime = 5,
				color1 = "ORANGE",
				sound = "ALERT12",
				icon = ST[104995],
			},
		},
		--timers = {},
		events = {
			-- Skewer on Tank
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 104936,
				execute = {
					{
						"quash","skewercd",
						"set",{skewertext = format(L.alert["%s on %s"],SN[104936],"#5#")},
						"alert","skewerwarn",
					},
					{
						"expect",{"<justdanced>","==","false"},
						"alert","skewercd",
					},
					{
						"expect",{"<justdanced>","==","true"},
						"set",{justdanced = "false"},
						"alert",{"hatecd",time = 2},
						"alert","skewercd",
					},
					{
						"expect",{"&timeleft|dancecd&","<","25"},
						"quash","skewercd",
					},
				},
			},
			-- Seething Hate
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 105067,
				execute = {
					{
						"quash","hatecd",
						"alert","hatewarn",
					},
					{
						"expect",{"<justdanced>","==","false"},
						"alert","hatecd",
					},
					{
						"expect",{"<justdanced>","==","true"},
						"set",{justdanced = "false"},
						"alert",{"skewercd",time = 2},
						"alert","hatecd",
					},
					{
						"expect",{"&timeleft|dancecd&","<","25"},
						"quash","hatecd",
					},
				},
			},
			-- Blade Dance
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 105738,
				execute = {
					{
						"batchquash",{"dancecd","skewercd","hatecd"},
						"alert","dancecd",
						"alert","dancedur",
					},
				},
			},
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_REMOVED",
				spellname = 105738,
				execute = {
					{
						"quash","dancedur",
						"alert","firstcd",
						"set",{justdanced = "true"},
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end
