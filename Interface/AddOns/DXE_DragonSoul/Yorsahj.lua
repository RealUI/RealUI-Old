local L,SN,ST,EJSN,EJST = DXE.L,DXE.SN,DXE.ST,DXE.EJSN,DXE.EJST

------------------------
-- Yor'sahj
------------------------
do
	local data = {
		version = 7,
		key = "Yor'sahj",
		zone = L.zone["Dragon Soul"],
		category = L.zone["Dragon Soul"],
		name = L.npc_dragonsoul["Yor'sahj the Unsleeping"],
		triggers = {
			scan = {
				55312, --Yor'sahj
			},
		},
		onactivate = {
			tracing = {
				55312, --Yor'sahj
			},
			tracerstart = true,
			combatstop = true,
			defeat = 55312,
		},
		enrage = {
			time10n = 600,
			time25n = 600,
			time10h = 600,
			time25h = 600,
		},
		userdata = {
			voidtext = "",
			slimetext = "",
		},
		windows = {
			proxwindow = true,
			proxrange = 4,
			proxoverride = true,
		},
		--timers = {},
		--announces = {},
		--raidicons = {},
		--arrows = {},
		onstart = {
			{
				"alert",{"slimecd",time = 2},
			},
		},
		alerts = {
			slimecd = {
				varname = format(L.alert["%s Cooldown"],SN[104999]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[104999]),
				time = 90,
				time10h = 75,
				time25h = 75,
				time2 = 22,
				flashtime = 5,
				color1 = "BLUE",
				icon = ST[104999],
				throttle = 1,
			},
			slimewarn = {
				varname = format(L.alert["%s Warning"],SN[104999]),
				type = "centerpopup",
				text = "<slimetext>",
				text7 = format(L.alert["Colors: %s %s %s %s"],L.alert["Purple"], L.alert["Green"], L.alert["Black"], L.alert["Blue"]),
				text2 = format(L.alert["Colors: %s %s %s %s"],L.alert["Green"], L.alert["Red"], L.alert["Blue"], L.alert["Black"]),
				text3 = format(L.alert["Colors: %s %s %s %s"],L.alert["Green"], L.alert["Yellow"], L.alert["Black"], L.alert["Red"]),
				text4 = format(L.alert["Colors: %s %s %s %s"],L.alert["Blue"], L.alert["Purple"], L.alert["Green"], L.alert["Yellow"]),
				text5 = format(L.alert["Colors: %s %s %s %s"],L.alert["Blue"], L.alert["Black"], L.alert["Purple"], L.alert["Yellow"]),
				text6 = format(L.alert["Colors: %s %s %s %s"],L.alert["Purple"], L.alert["Red"], L.alert["Yellow"], L.alert["Black"]),
				time = 35,
				flashtime = 5,
				color1 = "BLUE",
				icon = ST[104999],
				throttle = 1,
			},
			voidwarn = {
				varname = format(L.alert["%s Warning"],SN[109550]),
				type = "dropdown",
				text = "<voidtext>",
				time = 20,
				color1 = "PURPLE",
				icon = ST[109550],
			},
		},
		events = {
			-- Void Bolt
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED_DOSE",
				spellname = 104849,
				execute = {
					{
						"expect",{"#11#",">=","2"},
						"quash","voidwarn",
						"set",{voidtext = format("%s: %s x %s","#5#",SN[104849],"#11#")},
						"alert","voidwarn",
					},
				},
			},
			-- Oozes
			{
				type = "event",
				event = "UNIT_SPELLCAST_SUCCEEDED",
				execute = {
					{
						"expect",{"#5#","==","105420"},
						"alert","slimecd",
						"invoke",{
							{
								"expect",{"&difficulty&","<","3"},
								"set",{slimetext = format(L.alert["Colors: %s %s %s"],L.alert["Purple"], L.alert["Green"], L.alert["Blue"])},
							},
							{
								"expect",{"&difficulty&",">=","3"},
								"set",{slimetext = format(L.alert["Colors: %s %s %s %s"],L.alert["Purple"], L.alert["Green"], L.alert["Black"], L.alert["Blue"])},
							},
						},
						"alert","slimewarn",
					},
					{
						"expect",{"#5#","==","105435"},
						"alert","slimecd",
						"invoke",{
							{
								"expect",{"&difficulty&","<","3"},
								"set",{slimetext = format(L.alert["Colors: %s %s %s"],L.alert["Green"], L.alert["Red"], L.alert["Black"])},
							},
							{
								"expect",{"&difficulty&",">=","3"},
								"set",{slimetext = format(L.alert["Colors: %s %s %s %s"],L.alert["Green"], L.alert["Red"], L.alert["Blue"], L.alert["Black"])},
							},
						},
						"alert","slimewarn",
					},
					{
						"expect",{"#5#","==","105436"},
						"alert","slimecd",
						"invoke",{
							{
								"expect",{"&difficulty&","<","3"},
								"set",{slimetext = format(L.alert["Colors: %s %s %s"],L.alert["Green"], L.alert["Yellow"], L.alert["Red"])},
							},
							{
								"expect",{"&difficulty&",">=","3"},
								"set",{slimetext = format(L.alert["Colors: %s %s %s %s"],L.alert["Green"], L.alert["Yellow"], L.alert["Black"], L.alert["Red"])},
							},
						},
						"alert","slimewarn",
					},
					{
						"expect",{"#5#","==","105437"},
						"alert","slimecd",
						"invoke",{
							{
								"expect",{"&difficulty&","<","3"},
								"set",{slimetext = format(L.alert["Colors: %s %s %s"],L.alert["Purple"], L.alert["Blue"], L.alert["Yellow"])},
							},
							{
								"expect",{"&difficulty&",">=","3"},
								"set",{slimetext = format(L.alert["Colors: %s %s %s %s"],L.alert["Purple"], L.alert["Blue"], L.alert["Green"], L.alert["Yellow"])},
							},
						},
						"alert","slimewarn",
					},
					{
						"expect",{"#5#","==","105439"},
						"alert","slimecd",
						"invoke",{
							{
								"expect",{"&difficulty&","<","3"},
								"set",{slimetext = format(L.alert["Colors: %s %s %s"],L.alert["Blue"], L.alert["Black"], L.alert["Yellow"])},
							},
							{
								"expect",{"&difficulty&",">=","3"},
								"set",{slimetext = format(L.alert["Colors: %s %s %s %s"],L.alert["Blue"], L.alert["Black"], L.alert["Purple"], L.alert["Yellow"])},
							},
						},
						"alert","slimewarn",
					},
					{
						"expect",{"#5#","==","105440"},
						"alert","slimecd",
						"invoke",{
							{
								"expect",{"&difficulty&","<","3"},
								"set",{slimetext = format(L.alert["Colors: %s %s %s"],L.alert["Purple"], L.alert["Red"], L.alert["Black"])},
							},
							{
								"expect",{"&difficulty&",">=","3"},
								"set",{slimetext = format(L.alert["Colors: %s %s %s %s"],L.alert["Purple"], L.alert["Red"], L.alert["Yellow"], L.alert["Black"])},
							},
						},
						"alert","slimewarn",
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end
