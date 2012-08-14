local L,SN,ST = DXE.L,DXE.SN,DXE.ST

---------------------------------
-- ARGALOTH
---------------------------------

do
	local data = {
		version = 3,
		key = "argaloth",
		zone = L.zone["Baradin Hold"],
		category = L.zone["Baradin"],
		name = L.npc_baradin["Argaloth"],
		triggers = {
			scan = {
				47120, -- Argaloth
			},
		},
		onactivate = {
			tracing = {
				47120, -- Argaloth
			},
			tracerstart = true,
			combatstop = true,
			defeat = {
				47120, -- Argaloth
			},
		},
		--userdata = {},
		--onstart = {	},
		--windows = {		},
		alerts = {
			meteorcd = {
				varname = format(L.alert["%s Cooldown"],SN[95172]),
				type = "dropdown",
				text = format(L.alert["%s Cooldown"],SN[95172]),
				time = 16.5,
				flashtime = 5,
				color1 = "BLUE",
				icon = ST[95172],
			},
			meteorwarn = {
				varname = format(L.alert["%s Warning"],SN[95172]),
				type = "simple",
				text = format(L.alert["%s Warning"],SN[95172]),
				time = 3,
				flashtime = 3,
				color1 = "BLUE",
				sound = "ALERT1",
				icon = ST[95172],
			},
			firestormwarn = {
				varname = format(L.alert["%s Warning"],SN[88972]),
				type = "dropdown",
				text = format(L.alert["%s Warning"],SN[88972]),
				time = 18,
				flashtime = 5,
				color1 = "GREEN",
				sound = "ALERT2",
				icon = ST[88972],
			},
		},
		--timers = {		},
		events = {
			-- Meteor Slash
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 95172,
				execute = {
					{
						"quash","meteorcd",
						"alert","meteorcd",
						"alert","meteorwarn",
					},
				},
			},
			-- Fel Firestorm
			{
				type = "combatevent",
				eventtype = "SPELL_CAST_START",
				spellname = 88972,
				execute = {
					{
						"quash","meteorcd",
						"alert","firestormwarn",
					},
				},
			},
		},
	}

	DXE:RegisterEncounter(data)
end
