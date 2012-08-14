
OmniCC4Config = {
	["version"] = "4.2.muffins1",
	["groups"] = {
		{
			["id"] = "Totems",
			["rules"] = {
				"MultiCast", -- [1]
			},
			["enabled"] = true,
		}, -- [1]
	},
	["groupSettings"] = {
		["base"] = {
			["xOff"] = 2,
			["fontSize"] = 16,
			["styles"] = {
				["hours"] = {
					["scale"] = 1,
				},
			},
		},
		["Totems"] = {
			["fontSize"] = 16,
			["yOff"] = 1,
			["xOff"] = 1,
			["anchor"] = "TOP",
			["styles"] = {
				["hours"] = {
					["scale"] = 1,
				},
			},
		},
	},
}
