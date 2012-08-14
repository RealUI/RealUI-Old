local L,SN,ST,EJSN,EJST = DXE.L,DXE.SN,DXE.ST,DXE.EJSN,DXE.EJST

------------------------
-- Zon'ozz
------------------------
do
	local data = {
		version = 11,
		key = "Warlord Zon'ozz",
		zone = L.zone["Dragon Soul"],
		category = L.zone["Dragon Soul"],
		name = L.npc_dragonsoul["Warlord Zon'ozz"],
		triggers = {
			scan = {
				55308, --Warlord Zon'ozz
			},
		},
		onactivate = {
			tracing = {
				55308, --Warlord Zon'ozz
			},
			tracerstart = true,
			combatstop = true,
			defeat = 55308,
		},
		enrage = {
			time10n = 360,
			time25n = 360,
			time10h = 360,
			time25h = 360,
		},
		--userdata = {		},
		windows = {
			proxwindow = true,
			proxrange = 10,
			proxoverride = true,
		},
		announces = {
			shadowsay = {
				varname = format(L.alert["%s on self"],SN[104600]),
				type = "SAY",
				msg = format(L.alert["%s on Me"],SN[104600]),
			},
		},
		raidicons = {
			shadowicon = {
				varname = SN[104600],
				type = "MULTIFRIENDLY",
				persist = 10,
				reset = 2,
				unit = "#5#",
				icon = 1,
				total = 8,
			},
		},
		--arrows = {},
		--timers = {		},
		onstart = {
			{
				"alert",{"draincd",time = 2},
				"alert",{"voidcd",time = 2},
			},
		},
		alerts = {
			shadowcd = {
				varname = format(L.alert["%s Cooldown"],SN[104600]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[104600]),
				time = 26.5,
				flashtime = 5,
				color1 = "PURPLE",
				icon = ST[104600],
			},
			shadowwarn = {
				varname = format(L.alert["%s Warning"],SN[104600]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[104600]),
				time = 3,
				flashtime = 3,
				color1 = "PURPLE",
				icon = ST[104600],
			},
			shadowself = {
				varname = format(L.alert["%s on self"],SN[104600]),
				type = "simple",
				text = format(L.alert["%s on %s"],SN[104600],L.alert["YOU"]),
				time = 3,
				flashtime = 3,
				color1 = "PURPLE",
				icon = ST[104600],
				sound = "ALERT2",
			},
			voidcd = {
				varname = format(L.alert["%s Cooldown"],SN[104002]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[104002]),
				time = 45,
				time2 = 6,
				flashtime = 5,
				color1 = "BLUE",
				icon = ST[104002],
				throttle = 1,
			},
			voidwarn = {
				varname = format(L.alert["%s Warning"],SN[104002]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[104002]),
				time = 3,
				flashtime = 3,
				color1 = "BLUE",
				icon = ST[104002],
				sound = "ALERT3",
				throttle = 1,
			},
			draincd = {
				varname = format(L.alert["%s Cooldown"],SN[104322]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[104322]),
				time = 20,
				time2 = 15,
				flashtime = 5,
				color1 = "BROWN",
				icon = ST[104322],
			},
			blooddur = {
				varname = format(L.alert["%s Duration"],SN[104378]),
				type = "centerpopup",
				text = format(L.alert["%s Duration"],SN[104378]),
				time = 30,
				flashtime = 5,
				color1 = "BLACK",
				icon = ST[104378],
				sound = "ALERT1",
			},
			diffusiondur = {
				varname = format(L.alert["%s Duration"],SN[104031]),
				type = "dropdown",
				text = format(L.alert["%s Duration"],SN[104031]),
				time = 120,
				flashtime = 20,
				color1 = "BLACK",
				icon = ST[104031],
			},
			angerwarn ={
				varname = format(L.alert["%s Warning"],SN[109411]),
				type = "simple",
				text = format("%s x %s",SN[109411],"#11#"),
				time = 2,
				flashtime = 2,
				color1 = "ORANGE",
				icon = ST[109411],
				sound = "ALERT4",
			},

		},
		events = {
			-- Disrupting Shadows
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 104601,
				execute = {
					{
						"quash","shadowcd",
						"alert","shadowcd",
						"alert","shadowwarn",
					},
				},
			},
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 104601,
				execute = {
					{
						"raidicon","shadowicon",
					},
					{
						"expect",{"#4#","==","&playerguid&"},
						"announce","shadowsay",
						"alert","shadowself",
					},
				},
			},
			-- Drain
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 104322,
				execute = {
					{
						"quash","draincd",
						"alert","draincd",
					},
				},
			},
			-- Black blood
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_SUCCESS",
				spellname = 104378,
				execute = {
					{
						"alert","blooddur",
					},
				},
			},
			-- Diffusion
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED",
				spellname = 104031,
				dstnpcid = 55308, --only on Zon'ozz
				execute = {
					{
						"batchquash",{"draincd","shadowcd"},
						"quash","diffusiondur",
						"alert","diffusiondur",
						"alert","voidcd",
					},
				},
			},
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED_DOSE",
				spellname = 104031,
				dstnpcid = 55308, --only on Zon'ozz
				execute = {
					{
						"batchquash",{"draincd","shadowcd"},
						"quash","diffusiondur",
						"alert","diffusiondur",
						"alert","voidcd",
					},
				},
			},
			-- Void ball
			{
				type = "event",
				event = "UNIT_SPELLCAST_SUCCEEDED",
				execute = {
					{
						"expect",{"#5#","==","103571"},
						"alert","voidwarn",
					},
				},
			},
			-- Anger
			{
				type = "combatevent",
				eventtype = "SPELL_AURA_APPLIED_DOSE",
				spellname = 109411,
				dstnpcid = 55308, --only on Zon'ozz
				execute = {
					{
						"alert","angerwarn",
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end
