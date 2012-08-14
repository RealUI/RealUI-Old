
SkadaDB = {
	["profileKeys"] = {
		["Real - Zul'jin"] = "RealUI-HR",
	},
	["profiles"] = {
		["RealUI"] = {
			["modules"] = {
				["notankwarnings"] = true,
			},
			["windows"] = {
				{
					["point"] = "BOTTOMRIGHT",
					["barcolor"] = {
						["r"] = 0.1058823529411765,
						["g"] = 0.1058823529411765,
						["b"] = 0.1058823529411765,
					},
					["barfontsize"] = 8,
					["barslocked"] = true,
					["barorientation"] = 3,
					["mode"] = "DPS",
					["spark"] = false,
					["bartexture"] = "Plain_Dark",
					["barwidth"] = 190,
					["hidden"] = true,
					["y"] = 20.5,
					["x"] = 0,
					["title"] = {
						["color"] = {
							["a"] = 0,
							["r"] = 0.1058823529411765,
							["g"] = 0.1058823529411765,
							["b"] = 0.3019607843137255,
						},
						["font"] = "pixel_lr_small",
						["fontsize"] = 8,
						["texture"] = "Flat",
					},
					["classcolorbars"] = false,
					["barfont"] = "pixel_lr_small",
					["classcolortext"] = true,
					["background"] = {
						["color"] = {
							["a"] = 0,
							["b"] = 0.5019607843137255,
						},
						["height"] = 160,
					},
				}, -- [1]
			},
			["columns"] = {
				["Healing_Healing"] = false,
				["Damage_Damage"] = false,
			},
			["hidesolo"] = true,
			["onlykeepbosses"] = true,
			["hidedisables"] = false,
			["icon"] = {
				["hide"] = true,
			},
			["report"] = {
				["channel"] = "Guild",
			},
		},
		["Default"] = {
			["modules"] = {
				["notankwarnings"] = true,
			},
			["onlykeepbosses"] = true,
			["icon"] = {
				["hide"] = true,
			},
			["windows"] = {
				{
					["y"] = 175.5,
					["x"] = 0,
					["barslocked"] = true,
					["bartexture"] = "Flat",
					["set"] = "total",
					["point"] = "BOTTOMRIGHT",
				}, -- [1]
			},
		},
		["RealUI-HR"] = {
			["modules"] = {
				["notankwarnings"] = true,
			},
			["windows"] = {
				{
					["barheight"] = 16,
					["barfont"] = "pixel_hr_small",
					["barcolor"] = {
						["r"] = 0.1058823529411765,
						["g"] = 0.1058823529411765,
						["b"] = 0.1058823529411765,
					},
					["barfontsize"] = 8,
					["barslocked"] = true,
					["barorientation"] = 3,
					["mode"] = "DPS",
					["spark"] = false,
					["bartexture"] = "Plain_Dark",
					["barwidth"] = 190,
					["hidden"] = true,
					["y"] = 24.5,
					["x"] = 0,
					["title"] = {
						["font"] = "pixel_hr_small",
						["fontsize"] = 8,
						["color"] = {
							["a"] = 0,
							["r"] = 0.1058823529411765,
							["g"] = 0.1058823529411765,
							["b"] = 0.3019607843137255,
						},
						["texture"] = "Flat",
					},
					["classcolorbars"] = false,
					["classcolortext"] = true,
					["background"] = {
						["color"] = {
							["a"] = 0,
							["b"] = 0.5019607843137255,
						},
						["height"] = 160,
					},
					["point"] = "BOTTOMRIGHT",
				}, -- [1]
			},
			["icon"] = {
				["hide"] = true,
			},
			["report"] = {
				["channel"] = "Guild",
			},
			["columns"] = {
				["Healing_Healing"] = false,
				["Damage_Damage"] = false,
			},
			["hidesolo"] = true,
			["hidedisables"] = false,
			["onlykeepbosses"] = true,
		},
	},
}
