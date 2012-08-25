local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local db

local MODNAME = "AuraWatch"
local AuraWatch = nibRealUI:NewModule(MODNAME, "AceEvent-3.0", "AceBucket-3.0", "AceTimer-3.0")

local _, uClass = UnitClass("player")

local SpecialIDTable = {
	["Main Hand Poison"] = 9999901,
	["Off Hand Poison"] = 9999902,
	["Weapon Enchant"] = 9999903,
}
local SpecialIDReverseTable = {
	[9999901] = "Main Hand Poison",
	[9999902] = "Off Hand Poison",
	[9999903] = "Weapon Enchant",
}

---------------------------------------------------------------------------------------------------
--**** If changing any defaults, make sure to reset the nibRealUI's AuraWatch savedvariables ****--
--**** Otherwise defaults will transfer to other aura groups ------------------------------- ****--
---------------------------------------------------------------------------------------------------
local Defaults = {
	profile = {
		icons = {
			size = 24,
			padding = 1,
			bordercolor = {0, 0, 0, 1},
			inactive = {
				desaturate = true,
				bordercolor = {0.4, 0, 0, 1},
			},
		},
		bargroups = {
			["DEATHKNIGHT"] = {
				enabled = true,
				configmode = false,
				position = {
					anchorfrom = "CENTER",
					anchorto = "CENTER",
					x = 0,
					y = -74,
					direction = "RIGHT",
				},
				warningbar = {
					enabled = true,
					side = "RIGHT",
				},
				auras = {
					[1] = {
						enabled = true,
						inactive = true,
						personal = false,
						incombat = true,
						level = 1,
						spells = {
							[57330] = true,	-- horn of winter
						},
						negspells = {
							[8076] = true,	-- strength of earth totem
							[6673] = true,	-- battle Shout
							[93435] = true,	-- roar of courage (hunter pet)			
						},
						show = {
							group = {
								party = true,
								raid = true,
								solo = false,
							},
							location = {
								instance = true,
								pvp = false,
								outinstance = false,
							},
							role = {
								enabled = false,
								dps = false,
								heal = false,
								tank = false,
							},
							spec = {
								[1] = true,
								[2] = true,
								[3] = true,
							},
						},
						expire = {
							enabled = true,
							time = 10,
						},
					},
					[2] = {
						enabled = true,
						inactive = true,
						personal = false,
						incombat = true,
						level = 1,
						spells = {
							[48263] = true,	-- blood presence
						},
						negspells = {},
						show = {
							group = {
								party = true,
								raid = true,
								solo = false,
							},
							location = {
								instance = true,
								pvp = false,
								outinstance = false,
							},
							role = {
								enabled = true,
								dps = false,
								heal = false,
								tank = true,
							},
							spec = {
								[1] = true,
								[2] = false,
								[3] = false,
							},
						},
						expire = {
							enabled = false,
							time = 10,
						},
					},
				},
			},
			["DRUID"] = {
				enabled = true,
				configmode = false,
				position = {
					anchorfrom = "CENTER",
					anchorto = "CENTER",
					x = 0,
					y = -118,
					direction = "RIGHT",
				},
				warningbar = {
					enabled = true,
					side = "RIGHT",
				},
				auras = {},
			},
			["HUNTER"] = {
				enabled = true,
				configmode = false,
				position = {
					anchorfrom = "CENTER",
					anchorto = "CENTER",
					x = 0,
					y = -118,
					direction = "RIGHT",
				},
				warningbar = {
					enabled = true,
					side = "RIGHT",
				},
				auras = {
					[1] = {
						enabled = true,
						inactive = false,
						incombat = true,
						level = 1,
						personal = true,
						spells = {
							[5118] = true,	-- aspect of the cheetah
						},
						negspells = {},
						show = {
							group = {
								party = true,
								raid = true,
								solo = false,
							},
							location = {
								instance = true,
								pvp = false,
								outinstance = false,
							},
							role = {
								enabled = false,
								dps = false,
								heal = false,
								tank = false,
							},
							spec = {
								[1] = true,
								[2] = true,
								[3] = true,
							},
						},
						expire = {
							enabled = false,
							time = 10,
						},
					},
					[2] = {
						enabled = true,
						inactive = true,
						incombat = true,
						level = 1,
						personal = true,
						spells = {
							[13165] = true,	-- hawk
							[20043] = true,	-- wild
							[82661] = true,	-- fox	
						},
						negspells = {},
						show = {
							group = {
								party = true,
								raid = true,
								solo = false,
							},
							location = {
								instance = true,
								pvp = false,
								outinstance = false,
							},
							role = {
								enabled = false,
								dps = false,
								heal = false,
								tank = false,
							},
							spec = {
								[1] = true,
								[2] = true,
								[3] = true,
							},
						},
						expire = {
							enabled = false,
							time = 10,
						},
					},
				},
			},
			["MAGE"] = {
				enabled = true,
				configmode = false,
				position = {
					anchorfrom = "CENTER",
					anchorto = "CENTER",
					x = 0,
					y = -118,
					direction = "RIGHT",
				},
				warningbar = {
					enabled = true,
					side = "RIGHT",
				},
				auras = {
					[1] = {
						enabled = true,
						inactive = true,
						personal = false,
						incombat = true,
						level = 1,
						spells = {
							[7302] = true,	-- frost armor
							[6117] = true,	-- mage armor
							[30482] = true,	-- molten armor	
						},
						negspells = {},
						show = {
							group = {
								party = true,
								raid = true,
								solo = false,
							},
							location = {
								instance = true,
								pvp = true,
								outinstance = false,
							},
							role = {
								enabled = false,
								dps = false,
								heal = false,
								tank = false,
							},
							spec = {
								[1] = true,
								[2] = true,
								[3] = true,
							},
						},
						expire = {
							enabled = true,
							time = 10,
						},
					},
				},
			},
			["MONK"] = {
				enabled = true,
				configmode = false,
				position = {
					anchorfrom = "CENTER",
					anchorto = "CENTER",
					x = 0,
					y = -118,
					direction = "RIGHT",
				},
				warningbar = {
					enabled = true,
					side = "RIGHT",
				},
				auras = {
					[1] = {
						enabled = true,
						inactive = false,
						incombat = true,
						level = 1,
						personal = true,
						spells = {
						--	[5118] = true,	-- aspect of the cheetah
						},
						negspells = {},
						show = {
							group = {
								party = true,
								raid = true,
								solo = false,
							},
							location = {
								instance = true,
								pvp = false,
								outinstance = false,
							},
							role = {
								enabled = false,
								dps = false,
								heal = false,
								tank = false,
							},
							spec = {
								[1] = true,
								[2] = true,
								[3] = true,
							},
						},
						expire = {
							enabled = false,
							time = 10,
						},
					},
					[2] = {
						enabled = true,
						inactive = true,
						incombat = true,
						level = 1,
						personal = true,
						spells = {
						--	[13165] = true,	-- hawk
						--	[20043] = true,	-- wild
						--	[82661] = true,	-- fox	
						},
						negspells = {},
						show = {
							group = {
								party = true,
								raid = true,
								solo = false,
							},
							location = {
								instance = true,
								pvp = false,
								outinstance = false,
							},
							role = {
								enabled = false,
								dps = false,
								heal = false,
								tank = false,
							},
							spec = {
								[1] = true,
								[2] = true,
								[3] = true,
							},
						},
						expire = {
							enabled = false,
							time = 10,
						},
					},
				},
			},
			["PALADIN"] = {
				enabled = true,
				configmode = false,
				position = {
					anchorfrom = "CENTER",
					anchorto = "CENTER",
					x = 0,
					y = -82,
					direction = "RIGHT",
				},
				warningbar = {
					enabled = true,
					side = "RIGHT",
				},
				auras = {
					[1] = {
						enabled = true,
						inactive = false,
						incombat = true,
						level = 1,
						personal = true,
						spells = {
							[32223] = true,	-- crusader aura
						},
						negspells = {},
						show = {
							group = {
								party = true,
								raid = true,
								solo = false,
							},
							location = {
								instance = true,
								pvp = false,
								outinstance = false,
							},
							role = {
								enabled = false,
								dps = false,
								heal = false,
								tank = false,
							},
							spec = {
								[1] = true,
								[2] = true,
								[3] = true,
							},
						},
						expire = {
							enabled = false,
							time = 10,
						},
					},
					[2] = {
						enabled = true,
						inactive = true,
						personal = false,
						incombat = true,
						level = 1,
						spells = {
							[25780] = true,	-- righteous fury
						},
						negspells = {},
						show = {
							group = {
								party = true,
								raid = true,
								solo = false,
							},
							location = {
								instance = true,
								pvp = false,
								outinstance = false,
							},
							role = {
								enabled = true,
								dps = false,
								heal = false,
								tank = true,
							},
							spec = {
								[1] = false,
								[2] = true,
								[3] = false,
							},
						},
						expire = {
							enabled = false,
							time = 10,
						},
					},
					[3] = {
						enabled = true,
						inactive = true,
						personal = false,
						incombat = true,
						level = 1,
						spells = {
							[20154] = true,	-- seal of righteousness
							[20164] = true,	-- seal of justice
							[20165] = true,	-- seal of insight
							[31801] = true,	-- seal of truth
						},
						negspells = {},
						show = {
							group = {
								party = true,
								raid = true,
								solo = false,
							},
							location = {
								instance = true,
								pvp = true,
								outinstance = false,
							},
							role = {
								enabled = false,
								dps = false,
								heal = false,
								tank = false,
							},
							spec = {
								[1] = true,
								[2] = true,
								[3] = true,
							},
						},
						expire = {
							enabled = true,
							time = 10,
						},
					},
					[4] = {
						enabled = true,
						inactive = true,
						incombat = true,
						level = 1,
						personal = true,
						spells = {
							[465] = true,	-- devotion
							[7294] = true,	-- retribution
							[19746] = true,	-- concentration
							[19891] = true,	-- resistance
						},
						negspells = {},
						show = {
							group = {
								party = true,
								raid = true,
								solo = false,
							},
							location = {
								instance = true,
								pvp = false,
								outinstance = false,
							},
							role = {
								enabled = false,
								dps = false,
								heal = false,
								tank = false,
							},
							spec = {
								[1] = true,
								[2] = true,
								[3] = true,
							},
						},
						expire = {
							enabled = false,
							time = 10,
						},
					},
				},
			},
			["PRIEST"] = {
				enabled = true,
				configmode = false,
				position = {
					anchorfrom = "CENTER",
					anchorto = "CENTER",
					x = 0,
					y = -118,
					direction = "RIGHT",
				},
				warningbar = {
					enabled = true,
					side = "RIGHT",
				},
				auras = {
					[1] = {
						enabled = true,
						inactive = true,
						personal = false,
						incombat = true,
						level = 1,
						spells = {
							[588] = true,	-- inner fire
							[73413] = true,	-- inner will
						},
						negspells = {},
						show = {
							group = {
								party = true,
								raid = true,
								solo = false,
							},
							location = {
								instance = true,
								pvp = true,
								outinstance = false,
							},
							role = {
								enabled = false,
								dps = false,
								heal = false,
								tank = false,
							},
							spec = {
								[1] = true,
								[2] = true,
								[3] = true,
							},
						},
						expire = {
							enabled = true,
							time = 10,
						},
					},
				},
			},
			["ROGUE"] = {
				enabled = true,
				configmode = false,
				position = {
					anchorfrom = "CENTER",
					anchorto = "CENTER",
					x = 0,
					y = -118,
					direction = "RIGHT",
				},
				warningbar = {
					enabled = true,
					side = "RIGHT",
				},
				auras = {
					[1] = {
						enabled = true,
						personal = false,
						incombat = true,
						level = 1,
						inactive = false,
						spells = {
							[13877] = true,	-- blade flurry
						},
						negspells = {},
						show = {
							group = {
								party = true,
								raid = true,
								solo = true,
							},
							location = {
								instance = true,
								pvp = true,
								outinstance = true,
							},
							role = {
								enabled = false,
								dps = false,
								heal = false,
								tank = false,
							},
							spec = {
								[1] = true,
								[2] = true,
								[3] = true,
							},
						},
						expire = {
							enabled = false,
							time = 10,
						},
					},
					[2] = {
						enabled = true,
						inactive = true,
						personal = false,
						incombat = true,
						level = 10,
						spells = {
							[SpecialIDTable["Main Hand Poison"]] = true,
						},
						negspells = {},
						show = {
							group = {
								party = true,
								raid = true,
								solo = false,
							},
							location = {
								instance = true,
								pvp = true,
								outinstance = false,
							},
							role = {
								enabled = false,
								dps = false,
								heal = false,
								tank = false,
							},
							spec = {
								[1] = true,
								[2] = true,
								[3] = true,
							},
						},
						expire = {
							enabled = true,
							time = 10,
						},
					},
					[3] = {
						enabled = true,
						inactive = true,
						personal = false,
						incombat = true,
						level = 10,
						spells = {
							[SpecialIDTable["Off Hand Poison"]] = true,
						},
						negspells = {},
						show = {
							group = {
								party = true,
								raid = true,
								solo = false,
							},
							location = {
								instance = true,
								pvp = true,
								outinstance = false,
							},
							role = {
								enabled = false,
								dps = false,
								heal = false,
								tank = false,
							},
							spec = {
								[1] = true,
								[2] = true,
								[3] = true,
							},
						},
						expire = {
							enabled = true,
							time = 10,
						},
					},
				},
			},
			["SHAMAN"] = {
				enabled = true,
				configmode = false,
				position = {
					anchorfrom = "CENTER",
					anchorto = "CENTER",
					x = 0,
					y = -118,
					direction = "RIGHT",
				},
				warningbar = {
					enabled = true,
					side = "RIGHT",
				},
				auras = {
					[1] = {
						enabled = true,
						inactive = true,
						personal = false,
						incombat = true,
						level = 10,
						spells = {
							[SpecialIDTable["Weapon Enchant"]] = true,
						},
						negspells = {},
						show = {
							group = {
								party = true,
								raid = true,
								solo = false,
							},
							location = {
								instance = true,
								pvp = true,
								outinstance = false,
							},
							role = {
								enabled = false,
								dps = false,
								heal = false,
								tank = false,
							},
							spec = {
								[1] = true,
								[2] = true,
								[3] = true,
							},
						},
						expire = {
							enabled = true,
							time = 10,
						},
					},
					[2] = {
						enabled = true,
						inactive = true,
						personal = false,
						incombat = true,
						level = 1,
						spells = {
							[52127] = true,	-- water shield
							[324] = true,	-- lightning shield	
						},
						negspells = {},
						show = {
							group = {
								party = true,
								raid = true,
								solo = false,
							},
							location = {
								instance = true,
								pvp = true,
								outinstance = false,
							},
							role = {
								enabled = false,
								dps = false,
								heal = false,
								tank = false,
							},
							spec = {
								[1] = true,
								[2] = true,
								[3] = true,
							},
						},
						expire = {
							enabled = true,
							time = 10,
						},
					},
				},
			},
			["WARLOCK"] = {
				enabled = true,
				configmode = false,
				position = {
					anchorfrom = "CENTER",
					anchorto = "CENTER",
					x = 0,
					y = -118,
					direction = "RIGHT",
				},
				warningbar = {
					enabled = true,
					side = "RIGHT",
				},
				auras = {
					[1] = {
						enabled = true,
						inactive = true,
						personal = false,
						incombat = true,
						level = 1,
						spells = {
							[28176] = true,	-- fel armor
							[687] = true,	-- demon armor
						},
						negspells = {},
						show = {
							group = {
								party = true,
								raid = true,
								solo = false,
							},
							location = {
								instance = true,
								pvp = true,
								outinstance = false,
							},
							role = {
								enabled = false,
								dps = false,
								heal = false,
								tank = false,
							},
							spec = {
								[1] = true,
								[2] = true,
								[3] = true,
							},
						},
						expire = {
							enabled = true,
							time = 10,
						},
					},
				},
			},
			["WARRIOR"] = {
				enabled = true,
				configmode = false,
				position = {
					anchorfrom = "CENTER",
					anchorto = "CENTER",
					x = 0,
					y = -118,
					direction = "RIGHT",
				},
				warningbar = {
					enabled = true,
					side = "RIGHT",
				},
				auras = {
					[1] = {
						enabled = true,
						inactive = true,
						personal = false,
						incombat = true,
						level = 1,
						spells = {
							[469] = true,	-- commanding shout
						},
						negspells = {
							[6307] = true,	-- blood pact
							[90364] = true,	-- qiraji fortitude
							[72590] = true,	-- drums of fortitude
							[21562] = true,	-- fortitude				
						},
						show = {
							group = {
								party = true,
								raid = true,
								solo = false,
							},
							location = {
								instance = true,
								pvp = false,
								outinstance = false,
							},
							role = {
								enabled = true,
								dps = false,
								heal = false,
								tank = true,
							},
							spec = {
								[1] = true,
								[2] = true,
								[3] = true,
							},
						},
						expire = {
							enabled = true,
							time = 10,
						},
					},
					[2] = {
						enabled = true,
						inactive = true,
						personal = false,
						incombat = true,
						level = 1,
						spells = {
							[6673] = true,	-- battle shout
						},
						negspells = {
							[8076] = true,	-- strength of earth
							[57330] = true,	-- horn of winter
							[93435] = true,	-- roar of courage (hunter pet)			
						},
						show = {
							group = {
								party = true,
								raid = true,
								solo = false,
							},
							location = {
								instance = true,
								pvp = false,
								outinstance = false,
							},
							role = {
								enabled = true,
								dps = true,
								heal = false,
								tank = false,
							},
							spec = {
								[1] = true,
								[2] = true,
								[3] = true,
							},
						},
						expire = {
							enabled = true,
							time = 10,
						},
					},
				},
			},
		},
	},
}

local tonumber = _G.tonumber

local LoggedIn = false
local FramesCreated = false
local Initalizing = false

local AWF = {
	BarGroups = {},
}

local SpellNames = {}
local SpellIcons = {}
local SpellKnown = {}
local AurasChanged = {}

local isResting = false
local inCombat = false
local inInstance, instanceType = false, ""
local inParty = false
local inRaid = false
local inVehicle = false
local playerRole = ""
local playerSpec = 1
local playerLevel = 1
local playerDualWielding = false

-- Options
local table_AnchorPoints = {
	"BOTTOM",
	"BOTTOMLEFT",
	"BOTTOMRIGHT",
	"CENTER",
	"LEFT",
	"RIGHT",
	"TOP",
	"TOPLEFT",
	"TOPRIGHT",
}

local table_Strata = {
	"BACKGROUND",
	"LOW",
	"MEDIUM",
	"HIGH",
	"DIALOG",
}

local table_Directions = {
	"LEFT",
	"RIGHT",
}

local function IsOriginalAuraGroup(class, auragroup)
	if Defaults.profile.bargroups[class].auras[auragroup] then return true else return false end
end

local function DeleteAuraGroup(class, auragroup)
	tremove(db.bargroups[class].auras, auragroup)
end

local function AddAuraGroup(class)
	local NewAuraGroup = {
		enabled = true,
		inactive = true,
		personal = false,
		incombat = true,
		level = 1,
		spells = {},
		negspells = {},
		show = {
			group = {
				party = true,
				raid = true,
				solo = false,
			},
			location = {
				instance = true,
				pvp = false,
				outinstance = false,
			},
			role = {
				enabled = false,
				dps = false,
				heal = false,
				tank = false,
			},
			spec = {
				[1] = true,
				[2] = true,
				[3] = true,
			},
		},
		expire = {
			enabled = true,
			time = 10,
		},
	}
	tinsert(db.bargroups[class].auras, NewAuraGroup)
end

local function ValidateSpell(spell)
	if spell == "" then return nil end
	spell = tonumber(spell)
	if not spell then return nil end
	local spellName = GetSpellInfo(spell)
	if spellName then
		return spell
	else
		return nil
	end
end

local curNAList, curNADList = {}, {}
local function GetOptNegAuraList(class, auragroup)
	local cnt = 0
	wipe(curNAList)
	wipe(curNADList)
	for k, v in pairs(db.bargroups[class].auras[auragroup].negspells) do
		cnt = cnt + 1
		curNAList[cnt] = k
		if SpecialIDReverseTable[k] then
			curNADList[cnt] = SpecialIDReverseTable[k]
		else
			curNADList[cnt] = SpellNames[k]
		end
	end
	return curNADList
end

local function GetOptNegAuraEnabled(class, auragroup, key)
	return db.bargroups[class].auras[auragroup].negspells[curNAList[key]]
end

local function SetOptNegAuraEnabled(class, auragroup, key, value)
	db.bargroups[class].auras[auragroup].negspells[curNAList[key]] = value
end

local function AddOptNegAura(class, auragroup, spell)
	if spell == "" then return end
	spell = ValidateSpell(spell)
	if not spell then 
		print("Invalid SpellID")
		return
	end
	db.bargroups[class].auras[auragroup].negspells[spell] = true
	AuraWatch:UpdateKnownSpells()
end

local curAList, curADList = {}, {}
local function GetOptAuraList(class, auragroup)
	wipe(curAList)
	wipe(curADList)
	local cnt = 0
	for k, v in pairs(db.bargroups[class].auras[auragroup].spells) do
		cnt = cnt + 1
		curAList[cnt] = k
		if SpecialIDReverseTable[k] then
			curADList[cnt] = SpecialIDReverseTable[k]
		else
			curADList[cnt] = SpellNames[k]
		end
	end
	return curADList
end

local function GetOptAuraEnabled(class, auragroup, key)
	return db.bargroups[class].auras[auragroup].spells[curAList[key]]
end

local function SetOptAuraEnabled(class, auragroup, key, value)
	db.bargroups[class].auras[auragroup].spells[curAList[key]] = value
end

local function AddOptAura(class, auragroup, spell)
	spell = ValidateSpell(spell)
	if not spell then 
		print("Invalid SpellID")
		return
	end
	db.bargroups[class].auras[auragroup].spells[spell] = true
	AuraWatch:UpdateKnownSpells()
end

local options
local function GetOptions()
	if not options then options = {
		type = "group",
		name = "Aura Watch",
		desc = "Keep track of specific buffs/debuffs.",
		childGroups = "tab",
		arg = MODNAME,
		order = 121,
		args = {
			header = {
				type = "header",
				name = "Aura Watch",
				order = 10,
			},
			desc = {
				type = "description",
				name = "Keep track of specific buffs/debuffs.",
				fontSize = "medium",
				order = 20,
			},
			enabled = {
				type = "toggle",
				name = "Enabled",
				desc = "Enable/Disable the Aura Watch module.",
				get = function() return nibRealUI:GetModuleEnabled(MODNAME) end,
				set = function(info, value) 
					nibRealUI:SetModuleEnabled(MODNAME, value)
				end,
				order = 30,
			},
			sep = {
				type = "description",
				name = " ",
				order = 40,
			},
			icons = {
				name = "Icons",
				type = "group",
				disabled = function() return not nibRealUI:GetModuleEnabled(MODNAME) end,
				order = 50,
				args = {
					size = {
						type = "range",
						name = "Size",
						min = 10, max = 50, step = 1,
						order = 10,
						get = function(info) return db.icons.size end,
						set = function(info, value)
							db.icons.size = value
							AuraWatch:UpdateBarGroupPositions()
							AuraWatch:UpdateBarGroups(true)
						end,
					},
					padding = {
						type = "range",
						name = "Padding",
						min = -10, max = 10, step = 1,
						order = 20,
						get = function(info) return db.icons.padding end,
						set = function(info, value)
							db.icons.padding = value
							AuraWatch:UpdateBarGroupPositions()
							AuraWatch:UpdateBarGroups(true)
						end,
					},
					sep1 = {
						type = "description",
						name = " ",
						order = 25,
					},
					bordercolor = {
						type = "color",
						name = "Border Color",
						hasAlpha = false,
						get = function(info,r,g,b,a)
							return db.icons.bordercolor[1], db.icons.bordercolor[2], db.icons.bordercolor[3], db.icons.bordercolor[4]
						end,
						set = function(info,r,g,b,a)
							db.icons.bordercolor[1] = r
							db.icons.bordercolor[2] = g
							db.icons.bordercolor[3] = b
							db.icons.bordercolor[4] = a
							AuraWatch:UpdateBarGroupPositions()
							AuraWatch:UpdateBarGroups(true)
						end,
						order = 30,
					},
					inactive = {
						type = "group",
						name = "In-active",
						inline = true,
						order = 40,
						args = {
							desaturate = {
								type = "toggle",
								name = "Desaturate",
								desc = "Grey out in-active auras.",
								get = function() return db.icons.inactive.desaturate end,
								set = function(info, value)
									db.icons.inactive.desaturate = value
									AuraWatch:UpdateBarGroupPositions()
									AuraWatch:UpdateBarGroups(true)
								end,
								order = 10,
							},
							bordercolor = {
								type = "color",
								name = "Border Color",
								desc = "In-active Border Color.",
								hasAlpha = false,
								get = function(info,r,g,b,a)
									return db.icons.inactive.bordercolor[1], db.icons.inactive.bordercolor[2], db.icons.inactive.bordercolor[3], db.icons.inactive.bordercolor[4]
								end,
								set = function(info,r,g,b,a)
									db.icons.inactive.bordercolor[1] = r
									db.icons.inactive.bordercolor[2] = g
									db.icons.inactive.bordercolor[3] = b
									db.icons.inactive.bordercolor[4] = a
									AuraWatch:UpdateBarGroupPositions()
									AuraWatch:UpdateBarGroups(true)
								end,
								order = 20,
							},
						},
					},
				},
			},
			bargroups = {
				type = "group",
				name = "Bar Groups",
				childGroups = "tree",
				disabled = function() return not nibRealUI:GetModuleEnabled(MODNAME) end,
				order = 60,
				args = {},
			},
		},
	}
	end
	
	local BarGroupOpts = {}
	local BarGroupCnt = 10
	for kg, vg in pairs(db.bargroups) do
		BarGroupOpts[kg] = {
			type = "group",
			name = kg,
			order = BarGroupCnt,
			args = {	
				enabled = {
					type = "toggle",
					name = "Enabled",
					desc = "Enable/Disable this Bar Group.",
					width = "full",
					get = function() return db.bargroups[kg].enabled end,
					set = function(info, value) 
						db.bargroups[kg].enabled = value
						nibRealUI:ReloadUIDialog()
					end,
					order = 10,
				},
				configmode = {
					type = "toggle",
					name = "Config Mode",
					desc = "Preview Auras for configuration.",
					width = "full",
					get = function() return db.bargroups[kg].configmode end,
					set = function(info, value) 
						db.bargroups[kg].configmode = value
						AuraWatch:UpdateBarGroups(true)
					end,
					disabled = function() return not db.bargroups[kg].enabled end,
					order = 20,
				},
				position = {
					name = "Position",
					type = "group",
					disabled = function() return not db.bargroups[kg].enabled end,
					order = 100,
					args = {
						x = {
							type = "input",
							name = "X Offset",
							width = "half",
							order = 10,
							get = function(info) return tostring(db.bargroups[kg].position.x) end,
							set = function(info, value)
								value = nibRealUI:ValidateOffset(value)
								db.bargroups[kg].position.x = value
								AuraWatch:UpdateBarGroupPositions()
							end,
						},
						y = {
							type = "input",
							name = "Y Offset",
							width = "half",
							order = 20,
							get = function(info) return tostring(db.bargroups[kg].position.y) end,
							set = function(info, value)
								value = nibRealUI:ValidateOffset(value)
								db.bargroups[kg].position.y = value
								AuraWatch:UpdateBarGroupPositions()
							end,
						},
						anchorfrom = {
							type = "select",
							name = "Anchor From",
							get = function(info) 
								for k,v in pairs(table_AnchorPoints) do
									if v == db.bargroups[kg].position.anchorfrom then return k end
								end
							end,
							set = function(info, value)
								db.bargroups[kg].position.anchorfrom = table_AnchorPoints[value]
								AuraWatch:UpdateBarGroupPositions()
							end,
							style = "dropdown",
							width = nil,
							values = table_AnchorPoints,
							order = 30,
						},
						anchorto = {
							type = "select",
							name = "Anchor To",
							get = function(info) 
								for k,v in pairs(table_AnchorPoints) do
									if v == db.bargroups[kg].position.anchorto then return k end
								end
							end,
							set = function(info, value)
								db.bargroups[kg].position.anchorto = table_AnchorPoints[value]
								AuraWatch:UpdateBarGroupPositions()
							end,
							style = "dropdown",
							width = nil,
							values = table_AnchorPoints,
							order = 40,
						},
						direction = {
							type = "select",
							name = "Direction",
							get = function(info) 
								for k,v in pairs(table_Directions) do
									if v == db.bargroups[kg].position.direction then return k end
								end
							end,
							set = function(info, value)
								db.bargroups[kg].position.direction = table_Directions[value]
								AuraWatch:UpdateBarGroups(true)
							end,
							style = "dropdown",
							width = nil,
							values = table_Directions,
							order = 50,
						},
					},
				},
				warningbar = {
					name = "Warning Bar",
					type = "group",
					disabled = function() return not db.bargroups[kg].enabled end,
					order = 110,
					args = {
						enabled = {
							type = "toggle",
							name = "Enabled",
							desc = "Enable/Disable the Warning Bar.",
							width = "full",
							get = function() return db.bargroups[kg].warningbar.enabled end,
							set = function(info, value) 
								db.bargroups[kg].warningbar.enabled = value
								AuraWatch:UpdateBarGroups(true)
							end,
							order = 10,
						},
						side = {
							type = "select",
							name = "Side",
							get = function(info) 
								for k,v in pairs(table_Directions) do
									if v == db.bargroups[kg].warningbar.side then return k end
								end
							end,
							set = function(info, value)
								db.bargroups[kg].warningbar.side = table_Directions[value]
								AuraWatch:UpdateBarGroups(true)
							end,
							style = "dropdown",
							width = nil,
							values = table_Directions,
							order = 20,
						},
					},
				},
				auras = {
					name = "Auras",
					type = "group",
					disabled = function() return not db.bargroups[kg].enabled end,
					order = 120,
					args = {
						info = {
							type = "description",
							fontSize = "medium",
							name = "This section allows you to configure which buffs to track within a Bar Group.\n\nEach Bar Group consists of multiple Aura Groups. An Aura Group occopies a single spot within the Bar Group, and can track multiple buffs.\n\nOnly one buff in an Aura Group will display at a time. If you wish to track more Auras separately, create a new Aura Group.\n",
							order = 10,
						},
						newauragroup = {
							type = "execute",
							name = "New Aura Group",
							confirm = function(info) return "ADD AURA GROUP\n\nAre you sure you want to add a new Aura Group?\n\nThis action will reload the UI to take effect." end,
							func = function(info) 
								AddAuraGroup(kg)
								ReloadUI()
							end,
						},
					},
				},
			},
		}
		
		---- Auras
		local AuraOpts = {}
		local AuraCnt = 30
		for ka,va in ipairs(db.bargroups[kg].auras) do
			AuraOpts[tostring(ka)] = {
				type = "group",
				name = "Group "..tostring(ka),
				childGroups = "tab",
				order = AuraCnt,
				args = {
					enabled = {
						type = "toggle",
						name = "Enabled",
						desc = "Enable/Disable this Aura Group.",
						width = "full",
						get = function() return db.bargroups[kg].auras[ka].enabled end,
						set = function(info, value) 
							db.bargroups[kg].auras[ka].enabled = value
							AuraWatch:UpdateBarGroups(true)
						end,
						order = 10,
					},
					deleteauragroup = {
						type = "execute",
						name = "Delete Aura Group",
						disabled = function(info) return IsOriginalAuraGroup(kg, ka) end,
						confirm = function(info) return "DELETE AURA GROUP\n\nAre you sure you want to delete this Aura Group? This cannot be undone.\n\nThis action will reload the UI to take effect." end,
						func = function(info) 
							DeleteAuraGroup(kg)
							ReloadUI()
						end,
					},
					general = {
						type = "group",
						name = "General",
						disabled = function() return not db.bargroups[kg].auras[ka].enabled end,
						order = 30,
						args = {
							inactive = {
								type = "toggle",
								name = "Inactive",
								desc = "Make this Aura Group track inactive buffs.",
								get = function() return db.bargroups[kg].auras[ka].inactive end,
								set = function(info, value) 
									db.bargroups[kg].auras[ka].inactive = value
									AuraWatch:UpdateAuras()
									AuraWatch:UpdateBarGroups(true)
								end,
								disabled = function() return not db.bargroups[kg].auras[ka].enabled end,
								order = 30,
							},
							personal = {
								type = "toggle",
								name = "Personal",
								desc = "Make this Aura Group track buffs that were cast by YOU.",
								get = function() return db.bargroups[kg].auras[ka].personal end,
								set = function(info, value) 
									db.bargroups[kg].auras[ka].personal = value
									AuraWatch:UpdateAuras()
									AuraWatch:UpdateBarGroups(true)
								end,
								disabled = function() return not db.bargroups[kg].auras[ka].enabled end,
								order = 40,
							},
							incombat = {
								type = "toggle",
								name = "In-combat",
								desc = "Show this Aura Group while in combat.",
								get = function() return db.bargroups[kg].auras[ka].incombat end,
								set = function(info, value) 
									db.bargroups[kg].auras[ka].incombat = value
									AuraWatch:UpdateAuras()
									AuraWatch:UpdateBarGroups(true)
								end,
								disabled = function() return not db.bargroups[kg].auras[ka].enabled end,
								order = 50,
							},
							level = {
								type = "range",
								name = "Min level",
								desc = "Character must be this level or higher for this Aura Frame to show.",
								min = 1, max = 85, step = 1,
								get = function(info) return db.bargroups[kg].auras[ka].level end,
								set = function(info, value)
									db.bargroups[kg].auras[ka].level = value
									AuraWatch:UpdateAuras()
									AuraWatch:UpdateBarGroups(true)	
								end,
								disabled = function() return not db.bargroups[kg].auras[ka].enabled end,
								order = 60,
							},
						},
					},
					auras = {
						name = "Auras",
						type = "group",
						disabled = function() return not db.bargroups[kg].auras[ka].enabled end,
						order = 40,
						args = {
							addaura = {
								type = "input",
								name = "Add Aura",
								desc = "Must use a SpellID. To find out a SpellID, look up the Spell on WoWHead and note the number it uses in the address bar.",
								disabled = function()
									if (kg == "ROGUE" and (ka == 2 or ka == 3)) or
									   (kg == "SHAMAN" and ka == 2) then
										return true
									end
								end,
								get = function(info) return nil end,
								set = function(info, value) 
									AddOptAura(kg, ka, value)
								end,
							},
							auralist = {
								type = "multiselect",
								name = "Aura List",
								get = function(info, key) return GetOptAuraEnabled(kg, ka, key) end,
								set = function(info, key, value) 
									SetOptAuraEnabled(kg, ka, key, value)
									AuraWatch:UpdateWeaponIcons()
									AuraWatch:UpdateAuras()
								end,
								values = function(info) return GetOptAuraList(kg, ka) end,
								order = 20,
							},
						},
					},
					negauras = {
						name = "Negate Auras",
						type = "group",
						disabled = function() return not db.bargroups[kg].auras[ka].enabled end,
						order = 50,
						args = {
							negdesc = {
								type = "description",
								fontSize = "medium",
								name = "Negate Auras: Hide this Aura Frame if any of the below auras are active.\n",
								order = 10,
							},
							addnegaura = {
								type = "input",
								name = "Add Negate Aura",
								desc = "Must use a SpellID. To find out a SpellID, look up the Spell on WoWHead and note the number it uses in the address bar.",
								get = function(info) return nil end,
								set = function(info, value) 
									AddOptNegAura(kg, ka, value)
								end,
							},
							negauralist = {
								type = "multiselect",
								name = "Negate Aura List",
								get = function(info, key) return GetOptNegAuraEnabled(kg, ka, key) end,
								set = function(info, key, value) 
									SetOptNegAuraEnabled(kg, ka, key, value)
									AuraWatch:UpdateAuras()
								end,
								values = function(info) return GetOptNegAuraList(kg, ka) end,
								order = 30,
							},
						},
					},
					show = {
						name = "Conditionals",
						type = "group",
						disabled = function() return not db.bargroups[kg].auras[ka].enabled end,
						order = 60,
						args = {
							desc = {
								type = "description",
								name = "Only show this Aura Group if all the below conditions are met.",
								order = 5,
							},
							group = {
								name = "Group",
								type = "group",
								inline = true,
								order = 10,
								args = {
									party = {
										type = "toggle",
										name = "Party",
										width = "full",
										get = function() return db.bargroups[kg].auras[ka].show.group.party end,
										set = function(info, value) 
											db.bargroups[kg].auras[ka].show.group.party = value
											AuraWatch:UpdateAuras()
										end,
										order = 10,
									},
									raid = {
										type = "toggle",
										name = "Raid",
										width = "full",
										get = function() return db.bargroups[kg].auras[ka].show.group.raid end,
										set = function(info, value) 
											db.bargroups[kg].auras[ka].show.group.raid = value
											AuraWatch:UpdateAuras()
										end,
										order = 20,
									},
									solo = {
										type = "toggle",
										name = "Solo",
										width = "full",
										get = function() return db.bargroups[kg].auras[ka].show.group.solo end,
										set = function(info, value) 
											db.bargroups[kg].auras[ka].show.group.solo = value
											AuraWatch:UpdateAuras()
										end,
										order = 30,
									},
								},
							},
							location = {
								name = "Location",
								type = "group",
								inline = true,
								order = 20,
								args = {
									instance = {
										type = "toggle",
										name = "Instance",
										width = "full",
										get = function() return db.bargroups[kg].auras[ka].show.location.instance end,
										set = function(info, value) 
											db.bargroups[kg].auras[ka].show.location.instance = value
											AuraWatch:UpdateAuras()
										end,
										order = 10,
									},
									pvp = {
										type = "toggle",
										name = "PvP",
										width = "full",
										get = function() return db.bargroups[kg].auras[ka].show.location.pvp end,
										set = function(info, value) 
											db.bargroups[kg].auras[ka].show.location.pvp = value
											AuraWatch:UpdateAuras()
										end,
										order = 20,
									},
									outinstance = {
										type = "toggle",
										name = "Non-Instance",
										width = "full",
										get = function() return db.bargroups[kg].auras[ka].show.location.outinstance end,
										set = function(info, value) 
											db.bargroups[kg].auras[ka].show.location.outinstance = value
											AuraWatch:UpdateAuras()
										end,
										order = 30,
									},
								},
							},
							role = {
								name = "Dungeon Role",
								type = "group",
								inline = true,
								order = 30,
								args = {
									enabled = {
										type = "toggle",
										name = "Enabled",
										desc = "Only show when you have a Role assigned (Damager, Healer, Tank).",
										width = "full",
										get = function() return db.bargroups[kg].auras[ka].show.role.enabled end,
										set = function(info, value) 
											db.bargroups[kg].auras[ka].show.role.enabled = value
											AuraWatch:UpdateAuras()
										end,
										order = 10,
									},
									rolegroup = {
										type = "group",
										name = "Roles",
										inline = true,
										disabled = function() return not db.bargroups[kg].auras[ka].show.role.enabled end,
										order = 20,
										args = {
											dps = {
												type = "toggle",
												name = "Damager",
												width = "full",
												get = function() return db.bargroups[kg].auras[ka].show.role.dps end,
												set = function(info, value) 
													db.bargroups[kg].auras[ka].show.role.dps = value
													AuraWatch:UpdateAuras()
												end,
												order = 10,
											},
											heal = {
												type = "toggle",
												name = "Healer",
												width = "full",
												get = function() return db.bargroups[kg].auras[ka].show.role.heal end,
												set = function(info, value) 
													db.bargroups[kg].auras[ka].show.role.heal = value
													AuraWatch:UpdateAuras()
												end,
												order = 20,
											},
											tank = {
												type = "toggle",
												name = "Tank",
												width = "full",
												get = function() return db.bargroups[kg].auras[ka].show.role.tank end,
												set = function(info, value) 
													db.bargroups[kg].auras[ka].show.role.tank = value
													AuraWatch:UpdateAuras()
												end,
												order = 30,
											},
										},
									},
								},
							},
							spec = {
								name = "Talent Tree",
								type = "group",
								inline = true,
								order = 40,
								args = {
									spec1 = {
										type = "toggle",
										name = "1",
										width = "full",
										get = function() return db.bargroups[kg].auras[ka].show.spec[1] end,
										set = function(info, value) 
											db.bargroups[kg].auras[ka].show.spec[1] = value
											AuraWatch:UpdateAuras()
										end,
										order = 10,
									},
									spec2 = {
										type = "toggle",
										name = "2",
										width = "full",
										get = function() return db.bargroups[kg].auras[ka].show.spec[2] end,
										set = function(info, value) 
											db.bargroups[kg].auras[ka].show.spec[2] = value
											AuraWatch:UpdateAuras()
										end,
										order = 20,
									},
									spec3 = {
										type = "toggle",
										name = "3",
										width = "full",
										get = function() return db.bargroups[kg].auras[ka].show.spec[3] end,
										set = function(info, value) 
											db.bargroups[kg].auras[ka].show.spec[3] = value
											AuraWatch:UpdateAuras()
										end,
										order = 30,
									},
								},
							},
						},
					},
					expire = {
						name = "Expire Flash",
						type = "group",
						disabled = function() return not db.bargroups[kg].auras[ka].enabled end,
						order = 70,
						args = {
							enabled = {
								type = "toggle",
								name = "Enabled",
								desc = "Show and flash Auras that are about to expire.",
								width = "full",
								get = function() return db.bargroups[kg].auras[ka].expire.enabled end,
								set = function(info, value) 
									db.bargroups[kg].auras[ka].expire.enabled = value
									AuraWatch:UpdateAuras()
								end,
								order = 10,
							},
							time = {
								type = "range",
								name = "Time (sec)",
								min = 5, max = 60, step = 1,
								order = 20,
								get = function(info) return db.bargroups[kg].auras[ka].expire.time end,
								set = function(info, value)
									db.bargroups[kg].auras[ka].expire.time = value
									AuraWatch:UpdateAuras()
								end,
							},
						},
					},
				},
			}
			AuraCnt = AuraCnt + 10
		end
		for key, val in pairs(AuraOpts) do
			BarGroupOpts[kg].args.auras.args[key] = (type(val) == "function") and val() or val
		end
		
		BarGroupCnt = BarGroupCnt + 10
	end
	
	for key, val in pairs(BarGroupOpts) do
		options.args.bargroups.args[key] = (type(val) == "function") and val() or val
	end
	
	return options
end

-------------------------
---- OTHER FUNCTIONS ----
-------------------------
local function SetAuraFrameCurrentSpell(frame, spell, class, id)
	if frame.currentSpell ~= spell then AurasChanged[class][id] = true end
	frame.currentSpell = spell
end

local function SetAuraFrameExpiration(frame, expire, class, id)
	expire = expire or 0
	local newExpire = (expire > 0) and expire or 0
	if frame.expire ~= newExpire then AurasChanged[class][id] = true end
	frame.expire = newExpire
end

local function SetAuraFrameActive(frame, active, class, id)
	if frame.active ~= active then AurasChanged[class][id] = true end
	frame.active = active
end

local function SetAuraFrameShown(frame, shown, class, id)
	if frame.shown ~= shown then AurasChanged[class][id] = true end
	frame.shown = shown
end

local function SetAuraFrameCondition(frame, class, id)
	local restingCheck, combatCheck, groupCheck, locationCheck, roleCheck, specCheck, levelCheck, result
	
	-- Resting
	restingCheck = not isResting
	
	-- Group
	if	(inParty and db.bargroups[class].auras[id].show.group.party) or
		(inRaid and db.bargroups[class].auras[id].show.group.raid) or
		(not(inParty) and not(inRaid) and db.bargroups[class].auras[id].show.group.solo) then
		
		groupCheck = true
	end
		
	-- Instance
	if	(inInstance and db.bargroups[class].auras[id].show.location.instance and ((instanceType == "party") or (instanceType == "raid"))) or
		(inInstance and db.bargroups[class].auras[id].show.location.pvp and ((instanceType == "pvp") or (instanceType == "arena"))) or
		(not(inInstance) and db.bargroups[class].auras[id].show.location.outinstance) then
		
		locationCheck = true
	end
	
	-- Role
	if not db.bargroups[class].auras[id].show.role.enabled then
		roleCheck = true
	elseif playerRole then
		if	(playerRole == "DAMAGER") and db.bargroups[class].auras[id].show.role.dps or
			(playerRole == "HEALER") and db.bargroups[class].auras[id].show.role.heal or
			(playerRole == "TANK") and db.bargroups[class].auras[id].show.role.tank then
		
			roleCheck = true
		end
	end
	
	-- Spec
	specCheck = db.bargroups[class].auras[id].show.spec[playerSpec]
	
	-- Combat
	combatCheck = (inCombat and db.bargroups[class].auras[id].incombat) or not(inCombat)
	
	-- Level
	levelCheck = (playerLevel >= db.bargroups[class].auras[id].level)
	
	-- Result
	result = restingCheck and groupCheck and locationCheck and roleCheck and specCheck and combatCheck and levelCheck
	if frame.condition ~= result then AurasChanged[class][id] = true end
	frame.condition = result
end

----------------------
---- AURA UPDATES ----
----------------------
-- Update Bar Group Auras
function AuraWatch:UpdateBarGroupAuras(id)
	if not db.bargroups[id].enabled then return end
	
	-- Update Aura visibility
	local ActiveAuras = {}
	local numAurasVisible = 0
	local numAurasInactive = 0
	local curAuraFrame
	local activeFrames = ""
	
	if db.bargroups[id].enabled then
		for ka, va in pairs(AWF.BarGroups[id].Auras) do
			curAuraFrame = AWF.BarGroups[id].Auras[ka]
			if db.bargroups[uClass].auras[ka].enabled then
				
				-- Aura state
				curAuraFrame.state = (curAuraFrame.active and not(db.bargroups[id].auras[ka].inactive)) and 1 or 
													(not(curAuraFrame.active) and db.bargroups[id].auras[ka].inactive) and 2 or 
													(curAuraFrame.expireShown and not(db.bargroups[id].auras[ka].inactive)) and 1 or
													(curAuraFrame.expireShown and db.bargroups[id].auras[ka].inactive) and 2 or 
													0
				
				if curAuraFrame.config or (curAuraFrame.state > 0 and curAuraFrame.condition and curAuraFrame.shown and not inVehicle) then
					numAurasVisible = numAurasVisible + 1
					ActiveAuras[numAurasVisible] = ka
					activeFrames = activeFrames..tostring(ka)
					if curAuraFrame.state == 2 then numAurasInactive = numAurasInactive + 1 end
					
					if AurasChanged[id][ka] then
						AurasChanged[id][ka] = false
						
						-- Show Aura
						curAuraFrame:Show()
						if not SpecialIDReverseTable[curAuraFrame.currentSpell] then
							local NewIcon = SpellIcons[curAuraFrame.currentSpell]
							if curAuraFrame.currentSpellIcon ~= NewIcon then
								curAuraFrame.icon:SetTexture(NewIcon)
								curAuraFrame.currentSpellIcon = NewIcon
							end
						end
						
						-- Inactive
						if curAuraFrame.state == 2 then
							if db.icons.inactive.desaturate then
								if not curAuraFrame.icon:IsDesaturated() then 
									curAuraFrame.icon:SetDesaturated(true)
								end
							else
								if curAuraFrame.icon:IsDesaturated() then 
									curAuraFrame.icon:SetDesaturated(false)
								end
							end
							curAuraFrame:SetBackdropBorderColor(unpack(db.icons.inactive.bordercolor))
							
						-- Active / Config
						else
							if curAuraFrame.icon:IsDesaturated() then 
								curAuraFrame.icon:SetDesaturated(false)
							end
							curAuraFrame:SetBackdropBorderColor(unpack(db.icons.bordercolor))
						end
					end
				else
					curAuraFrame:Hide()
				end
			else
				curAuraFrame:Hide()
			end
		end
		
		-- Update BarGroup size and Aura positions
		if numAurasVisible > 0 then
			-- If Aura frames have changed, update Aura positions
			if AWF.BarGroups[id].lastActiveFrames ~= activeFrames then
				AWF.BarGroups[id].lastActiveFrames = activeFrames
			
				local size, padding, x = db.icons.size, db.icons.padding
				
				AWF.BarGroups[id]:SetWidth((size + padding) * numAurasVisible)
				
				for i = 1, numAurasVisible do
					local auraID = ActiveAuras[i]
					AWF.BarGroups[id].Auras[auraID]:ClearAllPoints()
					if db.bargroups[id].position.direction == "RIGHT" then
						x = floor((size + padding) * (i - 1))
						AWF.BarGroups[id].Auras[auraID]:SetPoint("LEFT", AWF.BarGroups[id], "LEFT", x, 0)
					else
						x = floor(-(size + padding) * (i - 1))
						AWF.BarGroups[id].Auras[auraID]:SetPoint("RIGHT", AWF.BarGroups[id], "RIGHT", x, 0)
					end
				end
				AWF.BarGroups[id]:Show()
			end
		else
			AWF.BarGroups[id].lastActiveFrames = ""
			AWF.BarGroups[id]:Hide()
			AWF.Warning.glow.aniGroup:Stop()
			AWF.Warning:Hide()
		end
		
		-- Warning bar
		if numAurasInactive > 0 and db.bargroups[id].warningbar.enabled then
			if (AWF.Warning.parentBarGroup ~= id) then
				AWF.Warning.parentBarGroup = id
				AWF.Warning:ClearAllPoints()
				if db.bargroups[id].warningbar.side == "LEFT" then
					AWF.Warning:SetPoint("RIGHT", AWF.BarGroups[id], "LEFT", -1, 0)
				else
					AWF.Warning:SetPoint("LEFT", AWF.BarGroups[id], "RIGHT", 0, 0)
				end
				AWF.Warning:SetHeight(db.icons.size)
			end
			if not AWF.Warning.isVisible then
				AWF.Warning.isVisible = true
				AWF.Warning:Show()
				AWF.Warning.glow.aniGroup:Play()
			end
		else
			AWF.Warning.isVisible = false
			AWF.Warning.glow.aniGroup:Stop()
			AWF.Warning:Hide()
		end
	end
end

-- Update Bar Groups
local UpdateList
function AuraWatch:UpdateBarGroups(...)
	-- Get BarGroups to update
	local BarGroupConfig, BarGroupChanged = false, false

	if db.bargroups[uClass].enabled then
		if db.bargroups[uClass].configmode then BarGroupConfig = true end
		
		-- Get updated Aura info
		for ka, va in ipairs(AWF.BarGroups[uClass].Auras) do
			if db.bargroups[uClass].auras[ka].enabled or ... then
				-- Config Mode
				if AWF.BarGroups[uClass].Auras[ka].config ~= BarGroupConfig then 
					AWF.BarGroups[uClass].Auras[ka].config = BarGroupConfig
					AurasChanged[uClass][ka] = true
				end
				
				-- If full refresh, then make sure UBGA updates everything
				if ... then
					AurasChanged[uClass][ka] = true
					AWF.BarGroups[uClass].lastActiveFrames = ""
					AWF.Warning.parentBarGroup = ""
				end
				
				if AurasChanged[uClass][ka] then
					BarGroupChanged = true
				end
			end
		end
		
		-- Update changed BarGroups
		if BarGroupChanged then
			self:UpdateBarGroupAuras(uClass)
		end
	else
		AWF.BarGroups[uClass].lastActiveFrames = ""
		AWF.BarGroups[uClass]:Hide()
		AWF.Warning.isVisible = false
		AWF.Warning.glow.aniGroup:Stop()
		AWF.Warning:Hide()
	end
end

-- Expiration check
function AuraWatch:AuraExpirationCheck()
	if not db.bargroups[uClass].enabled then return end
	if not AWF.BarGroups[uClass] then return end
	if not AWF.BarGroups[uClass].Auras then return end
	
	local timeNow = GetTime()
	
	self.flashstate = not self.flashstate
	
	for ka, va in ipairs(AWF.BarGroups[uClass].Auras) do
		if db.bargroups[uClass].auras[ka].enabled then
			local isExpiring, expire, remaining, anyAuraChanged
			
			expire = AWF.BarGroups[uClass].Auras[ka].expire
			
			if expire and expire > 0 then
				remaining = expire - timeNow
				isExpiring = (((remaining > 0) and db.bargroups[uClass].auras[ka].expire.enabled) and (remaining <= db.bargroups[uClass].auras[ka].expire.time))
			end
			
			if isExpiring then
				AurasChanged[uClass][ka] = true
				anyAuraChanged = true
				AWF.BarGroups[uClass].Auras[ka].expireShown = true
				AWF.BarGroups[uClass].Auras[ka]:SetAlpha(self.flashstate and 1 or 0)
			else
				AurasChanged[uClass][ka] = AWF.BarGroups[uClass].Auras[ka].expireShown
				if AurasChanged[uClass][ka] then anyAuraChanged = true end
				AWF.BarGroups[uClass].Auras[ka].expireShown = false
				AWF.BarGroups[uClass].Auras[ka]:SetAlpha(1)
			end
		end
	end
	
	if anyAuraChanged then
		AuraWatch:UpdateBarGroupAuras(uClass)
	end
end

-- Retrieve Aura information
local function GetNegAuraList(list)
	local auraList = {}
	local auraCnt = 0
	for k, v in pairs(list) do
		if v then
			auraCnt = auraCnt + 1
			auraList[auraCnt] = k
		end
	end
	return auraList
end

local function GetAuraList(list)
	local auraList = {}
	local auraCnt = 0
	for k, v in pairs(list) do
		if v and (SpecialIDReverseTable[k] or SpellKnown[k]) then
			auraCnt = auraCnt + 1
			auraList[auraCnt] = k
		end
	end
	return auraList
end

local function GetAuraInfo(spellName, personal)
	local name,_,_, count,_, duration, expire = UnitAura("player", spellName, nil, personal and "PLAYER")
	return {["name"] = name, ["count"] = count, ["duration"] = duration, ["expire"] = expire}
end

local curAuraInfoTable, curNegAuraInfoTable, curAuraExpireTable, curAuraFrame, curAuraList, curNegAuraList, curAuraSetActive = {}, {}, {}
function AuraWatch:UpdateAuras(...)
	if Initalizing then return end
	
	local units = ...
	if (units and (not units.player)) then return end
	if not db.bargroups[uClass].enabled then return end
	
	local spellIDName
	local timeNow = GetTime()
	
	local curAuraHasNegative
	
	-- Cycle through Aura Groups
	for ka, va in ipairs(AWF.BarGroups[uClass].Auras) do
		if db.bargroups[uClass].auras[ka].enabled then
			curAuraFrame = AWF.BarGroups[uClass].Auras[ka]
			curAuraSetActive = false
			
			-- Determine if any Neg Spells are active
			curAuraHasNegative = false
			curNegAuraList = GetNegAuraList(db.bargroups[uClass].auras[ka].negspells)
			for kn, vn in ipairs(curNegAuraList) do
				spellIDName = SpellNames[vn]
				if spellIDName then
					curNegAuraInfoTable[kn] = GetAuraInfo(spellIDName, db.bargroups[uClass].auras[ka].personal)
					if curNegAuraInfoTable[kn].name then
						curAuraHasNegative = true
						break
					end
				end
			end
			
			if not curAuraHasNegative then
				curAuraList = GetAuraList(db.bargroups[uClass].auras[ka].spells)
				
				SetAuraFrameCondition(curAuraFrame, uClass, ka)
				
				-- Special
				if curAuraList[1] and SpecialIDReverseTable[curAuraList[1]] then
					if db.bargroups[uClass].auras[ka].spells[curAuraList[1]] == true then
						SetAuraFrameCurrentSpell(curAuraFrame, curAuraList[1], uClass, ka)
						SetAuraFrameShown(curAuraFrame, true, uClass, ka)
						
						local shamanEnchants
						local hasMainHandEnchant, mainHandExpiration, _, hasOffHandEnchant, offHandExpiration = GetWeaponEnchantInfo()
						mainHandExpiration = mainHandExpiration or 0
						offHandExpiration = offHandExpiration or 0
						
						-- Determine if all of a Shaman's equipped weapons are enchanted
						if curAuraList[1] == SpecialIDTable["Weapon Enchant"] then
							if playerDualWielding then
								shamanEnchants = (hasMainHandEnchant and hasOffHandEnchant)
							else
								shamanEnchants = (hasMainHandEnchant or hasOffHandEnchant)
							end
						end
						
						-- Set Aura Frame active/expire
						if 	(curAuraList[1] == SpecialIDTable["Main Hand Poison"] and hasMainHandEnchant) or 
							(curAuraList[1] == SpecialIDTable["Off Hand Poison"] and hasOffHandEnchant) or 
							(curAuraList[1] == SpecialIDTable["Weapon Enchant"] and shamanEnchants) then
								local specExpire = 0
								if (curAuraList[1] == SpecialIDTable["Main Hand Poison"]) then
									specExpire = (mainHandExpiration / 1000) + timeNow
								elseif (curAuraList[1] == SpecialIDTable["Off Hand Poison"]) then
									specExpire = (offHandExpiration / 1000) + timeNow
								elseif (curAuraList[1] == SpecialIDTable["Weapon Enchant"]) then
									if playerDualWielding then
										specExpire = (min(mainHandExpiration, offHandExpiration) / 1000) + timeNow
									else
										specExpire = (mainHandExpiration / 1000) + timeNow
									end
								end
								SetAuraFrameActive(curAuraFrame, true, uClass, ka)
								SetAuraFrameExpiration(curAuraFrame, specExpire, uClass, ka)
						else
							SetAuraFrameActive(curAuraFrame, false, uClass, ka)
							SetAuraFrameExpiration(curAuraFrame, 0, uClass, ka)
						end

					end
					
				-- Buffs
				else
					
					-- Gather information on all SpellIDs
					local firstAuraActive, anyAuraExpire
					curAuraExpireTable = {}
					for ks, vs in ipairs(curAuraList) do
						spellIDName = SpellNames[vs]
						if spellIDName then
							curAuraInfoTable[ks] = GetAuraInfo(spellIDName, db.bargroups[uClass].auras[ka].personal)
							
							-- Find the first active Aura, fill out Expiration table
							if curAuraInfoTable[ks].name then
								if not firstAuraActive then firstAuraActive = vs end
								if curAuraInfoTable[ks].expire and db.bargroups[uClass].auras[ka].expire.enabled then
									curAuraExpireTable[vs] = curAuraInfoTable[ks].expire
									anyAuraExpire = true
								end
							end
						end
					end
					
					-- Find which Aura to use
					local useAura, auraExpire
					if firstAuraActive then
						-- Do we alert on expiration?
						if db.bargroups[uClass].auras[ka].expire.enabled and anyAuraExpire then
							-- Show lowest expiration Aura
							local lowestExpire, lastLowestExpire, lowestAura = math.huge
							for ke, ve in pairs(curAuraExpireTable) do
								lastLowestExpire = lowestExpire
								lowestExpire = min(lowestExpire, ve)
								if lowestExpire < lastLowestExpire then
									lowestAura = ke
								end
							end
							useAura = lowestAura
							auraExpire = lowestExpire
						else
							-- Show first active Aura
							useAura = firstAuraActive
							auraExpire = 0
						end
						
					end
					
					-- Set AuraFrame info
					if useAura then
						curAuraSetActive = true
						SetAuraFrameActive(curAuraFrame, true, uClass, ka)
						SetAuraFrameExpiration(curAuraFrame, auraExpire, uClass, ka)
						SetAuraFrameShown(curAuraFrame, true, uClass, ka)
						SetAuraFrameCurrentSpell(curAuraFrame, useAura, uClass, ka)
					else
						if not curAuraSetActive then
							SetAuraFrameActive(curAuraFrame, false, uClass, ka)
							SetAuraFrameExpiration(curAuraFrame, 0, uClass, ka)
							SetAuraFrameCurrentSpell(curAuraFrame, curAuraList[1], uClass, ka)
							if #curAuraList > 0 then
								if db.bargroups[uClass].auras[ka].inactive then
									SetAuraFrameShown(curAuraFrame, true, uClass, ka)
								else
									SetAuraFrameShown(curAuraFrame, false, uClass, ka)
								end
							else
								SetAuraFrameShown(curAuraFrame, false, uClass, ka)
							end
						end
					end
					
				end
			
			-- Neg Spell exists
			else
				SetAuraFrameActive(curAuraFrame, false, uClass, ka)
				SetAuraFrameExpiration(curAuraFrame, 0, uClass, ka)
				SetAuraFrameShown(curAuraFrame, false, uClass, ka)
				SetAuraFrameCurrentSpell(curAuraFrame, 0, uClass, ka)
			end
		end
	end
	
	self:UpdateBarGroups()
end

-----------------------
---- FRAME UPDATES ----
-----------------------
function AuraWatch:UpdateWeaponIcons()
	for k, v in pairs(AWF.BarGroups) do
		for ka, va in ipairs(AWF.BarGroups[k].Auras) do
			local icon
			-- Find Icon to use
			if db.bargroups[k].auras[ka].spells[SpecialIDTable["Main Hand Poison"]] then
				icon = GetInventoryItemTexture("player", 16)
			elseif db.bargroups[k].auras[ka].spells[SpecialIDTable["Off Hand Poison"]] then
				icon = GetInventoryItemTexture("player", 17)
			elseif db.bargroups[k].auras[ka].spells[SpecialIDTable["Weapon Enchant"]] then
				_, _, icon = GetSpellInfo(8024)
			end
			
			-- Set Icon
			if icon then
				AWF.BarGroups[k].Auras[ka].icon:SetTexture(icon)
			end
		end
	end
end

-- Update BarGroup Positions/Sizes
function AuraWatch:UpdateBarGroupPositions()
	local size, padding
	for k, v in pairs(AWF.BarGroups) do
		size = db.icons.size
		padding = db.icons.padding
		
		AWF.BarGroups[k]:ClearAllPoints()
		AWF.BarGroups[k]:SetPoint(db.bargroups[k].position.anchorfrom, "UIParent", db.bargroups[k].position.anchorto, db.bargroups[k].position.x, db.bargroups[k].position.y)
		AWF.BarGroups[k]:SetHeight(size)
		
		for ka, va in ipairs(AWF.BarGroups[k].Auras) do
			AWF.BarGroups[k].Auras[ka]:SetHeight(size)
			AWF.BarGroups[k].Auras[ka]:SetWidth(size)
			AWF.BarGroups[k].Auras[ka].icon:SetHeight(size - 2)
			AWF.BarGroups[k].Auras[ka].icon:SetWidth(size - 2)
		end
	end
end

------------------------
---- FRAME CREATION ----
------------------------
local function CreateAuraFrame(BarGroupFrame)
	local NewFrame = CreateFrame("Frame", nil, BarGroupFrame)
	NewFrame:Hide()
	NewFrame.config = false
	NewFrame.currentSpell = ""
	NewFrame.currentSpellIcon = ""
	NewFrame:SetParent(BarGroupFrame)
	NewFrame.icon = NewFrame:CreateTexture()
	NewFrame.icon:SetPoint("CENTER", NewFrame, "CENTER")
	NewFrame.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	NewFrame:SetBackdrop({
		bgFile = nibRealUI.media.textures.plain,
		edgeFile = nibRealUI.media.textures.plain,
		tile = false, tileSize = 0, edgeSize = 1, 
		insets = { left = 1, right = 1, top = 1, bottom = 1}
	})
	NewFrame:SetBackdropColor(0, 0, 0, 0)
	NewFrame:SetBackdropBorderColor(0, 0, 0, 1)
	return NewFrame
end

local function CreateBarGroupFrame(name)
	local NewFrame = CreateFrame("Frame", "RealUI_AuraWatch_"..name, UIParent)
	NewFrame:Hide()
	NewFrame:SetFrameStrata("MEDIUM")
	NewFrame:SetFrameLevel(0)
	return NewFrame
end

local function CreateFrames()
	if FramesCreated then return end
	
	for k, v in pairs(db.bargroups) do
		-- Bar Group
		AWF.BarGroups[k] = CreateBarGroupFrame(k)
		AWF.BarGroups[k].lastActiveFrames = ""
		
		-- Auras
		AWF.BarGroups[k].Auras = {}
		if db.bargroups[k] then
			for ka, va in ipairs(db.bargroups[k].auras) do
				AWF.BarGroups[k].Auras[ka] = CreateAuraFrame(AWF.BarGroups[k])
				
				-- Set Active flag opposite of what it should be, to start Auras off properly
				AWF.BarGroups[k].Auras[ka].active = db.bargroups[k].auras[ka].inactive
			end
		end
	end
	
	-- Warning bar
	local classColor = nibRealUI:GetClassColor(uClass)
	
	AWF.Warning = CreateBarGroupFrame("RealUI_AuraWatch_Warning")
	nibRealUI:CreateBD(AWF.Warning, 0)
	AWF.Warning:SetBackdropColor(classColor[1] / 2, classColor[2] / 2, classColor[3] / 2)
	AWF.Warning:SetWidth(8)
	AWF.Warning.parentBarGroup = ""
	
	AWF.Warning.glow = CreateFrame("Frame", nil, AWF.Warning)
	AWF.Warning.glow:SetPoint("TOPLEFT", AWF.Warning, 2, -2)
	AWF.Warning.glow:SetPoint("BOTTOMRIGHT", AWF.Warning, -2, 2)
	AWF.Warning.glowtex = nibRealUI:CreateBG(AWF.Warning.glow)
	AWF.Warning.glowtex:SetVertexColor(unpack(classColor))
	
	AWF.Warning.glow.aniGroup = AWF.Warning.glow:CreateAnimationGroup() 
	AWF.Warning.glow.aniGroup:SetLooping("REPEAT")
	AWF.Warning.glow.aniin = AWF.Warning.glow.aniGroup:CreateAnimation("Alpha")
	AWF.Warning.glow.aniin:SetDuration(1)
	AWF.Warning.glow.aniin:SetChange(1)
	AWF.Warning.glow.aniin:SetOrder(2)
	AWF.Warning.glow.aniout = AWF.Warning.glow.aniGroup:CreateAnimation("Alpha")
	AWF.Warning.glow.aniout:SetDuration(1)
	AWF.Warning.glow.aniout:SetChange(-1)
	AWF.Warning.glow.aniout:SetOrder(1)
	
	FramesCreated = true
end

------------------------
function AuraWatch:UpdateSpellInfoTables()
	for k, v in pairs(db.bargroups) do
		local curAuraList, curNegAuraList
		local spellID
		for ka, va in ipairs(db.bargroups[k].auras) do
			-- Auras
			curAuraList = db.bargroups[k].auras[ka].spells
			if curAuraList and not(SpecialIDReverseTable[curAuraList[1]]) then
				for ks, vs in pairs(curAuraList) do
					spellID = ks
					if spellID then
						local SpellName, _, SpellIcon = GetSpellInfo(spellID)
						SpellNames[spellID] = SpellName
						SpellIcons[spellID] = SpellIcon
						
						if k == uClass and SpellName then
							if not SpellKnown[spellID] and GetSpellInfo(SpellName) then
								SpellKnown[spellID] = true
							end
						end
					end
				end
			end
			
			-- Negate Auras
			curNegAuraList = db.bargroups[k].auras[ka].negspells
			if curNegAuraList then
				for kn, vn in pairs(curNegAuraList) do
					spellID = kn
					if spellID then
						local SpellName, _, SpellIcon = GetSpellInfo(spellID)
						SpellNames[spellID] = SpellName
						SpellIcons[spellID] = SpellIcon
						
						if k == uClass and SpellName then
							if not SpellKnown[spellID] and GetSpellInfo(SpellName) then
								SpellKnown[spellID] = true
							end
						end
					end
				end
			end
		end
	end
end

function AuraWatch:UpdateKnownSpells()
	self:UpdateSpellInfoTables()
	self:UpdateAuras()
end

function AuraWatch:UpdatePlayerLevel()
	local _playerLevel = playerLevel
	playerLevel = UnitLevel("player")
	
	if playerLevel ~= _playerLevel then
		self:UpdateAuras()
	end
end

function AuraWatch:UpdateCombatStatus(event)
	inCombat = event == "PLAYER_REGEN_DISABLED"
	self:UpdateAuras()
end

function AuraWatch:UpdateWeapons(event, slot)
	-- Find out way to properly determine this. Off-hand frills exist which aren't yet classified
	-- if IsEquippedItemType("Shields") then
		playerDualWielding = false
	-- else
		-- playerDualWielding = (GetInventoryItemID("player", 16) ~= nil and GetInventoryItemID("player", 17) ~= nil)
	-- end
	self:UpdateWeaponIcons()
	self:UpdateAuras()
end

function AuraWatch:UpdateVehicleStatus(...)
	local units = ...
	if units and not(units.player) then return end
	
	local _inVehicle = inVehicle
	inVehicle = UnitInVehicle("player")
	
	if inVehicle ~= _inVehicle then
		self:UpdateAuras()
	end
end

function AuraWatch:UpdateConditionals()
	local _isResting, _inInstance, _instanceType, _inParty, _inRaid, _playerRole, _playerSpec = isResting, inInstance, instanceType, inParty, inRaid, playerRole, playerSpec
	
	isResting = IsResting()
	inInstance, instanceType = IsInInstance()
	inParty = GetNumSubgroupMembers() > 0
	inRaid = IsInRaid()
	playerRole = UnitGroupRolesAssigned("player")
	playerSpec = GetSpecialization()
	
	if (isResting ~= _isResting) or (inInstance ~= _inInstance) or (instanceType ~= _instanceType) or (inParty ~= _inParty) or (inRaid ~= _inRaid) or (playerRole ~= _playerRole) or (playerSpec ~= _playerSpec) then 
		self:UpdateAuras()
	end
end

function AuraWatch:RefreshMod()
	if not nibRealUI:GetModuleEnabled(MODNAME) then return end
	
	db = self.db.profile
	
	-- Refresh Mod
	Initalizing = true
	self:UpdateBarGroupPositions()
	self:UpdateWeapons("refresh", 16)
	self:UpdatePlayerLevel()
	self:UpdateVehicleStatus()
	self:UpdateConditionals()
	self:UpdateKnownSpells()
	Initalizing = false
	
	self:UpdateAuras()
end

function AuraWatch:PLAYER_LOGIN()
	LoggedIn = true
	
	if not nibRealUI:GetModuleEnabled(MODNAME) then return end
	
	if not FramesCreated then
		CreateFrames()
	end
	
	for k, v in pairs(db.bargroups) do
		db.bargroups[k].configmode = false
		
		AurasChanged[k] = {}
		for ka, va in ipairs(db.bargroups[k].auras) do
			AurasChanged[k][ka] = true
		end
	end
	
	self:RefreshMod()
	
	self.flashstate = false
	self:ScheduleRepeatingTimer("AuraExpirationCheck", 1)
end

function AuraWatch:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME)
	self.db:RegisterDefaults(Defaults)
	db = self.db.profile
	
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME))
	nibRealUI:RegisterPlainOptions(MODNAME, GetOptions)
	
	self:RegisterEvent("PLAYER_LOGIN")
end

function AuraWatch:OnEnable()
	if not FramesCreated then
		CreateFrames()
	end
	
	self:RegisterBucketEvent({"UNIT_AURA"}, 1/3, "UpdateAuras")
	self:RegisterBucketEvent({"PLAYER_UPDATE_RESTING", "PLAYER_ENTERING_WORLD", "GROUP_ROSTER_UPDATE", "PLAYER_ROLES_ASSIGNED"}, 2, "UpdateConditionals")
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED", "UpdateConditionals")
	self:RegisterEvent("PLAYER_TALENT_UPDATE", "UpdateConditionals")
	self:RegisterBucketEvent({"UNIT_ENTERING_VEHICLE", "UNIT_ENTERED_VEHICLE", "UNIT_EXITING_VEHICLE", "UNIT_EXITED_VEHICLE"}, 1, "UpdateVehicleStatus")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "UpdateCombatStatus")
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "UpdateCombatStatus")
	self:RegisterEvent("PLAYER_XP_UPDATE", "UpdatePlayerLevel")
	self:RegisterEvent("LEARNED_SPELL_IN_TAB", "UpdateKnownSpells")
	if uClass == "SHAMAN" or uClass == "ROGUE" then
		self:RegisterBucketEvent("UNIT_INVENTORY_CHANGED", 2, "UpdateAuras")
		self:RegisterBucketEvent("PLAYER_EQUIPMENT_CHANGED", 2, "UpdateWeapons")
	end
	
	if LoggedIn then self:RefreshMod() end
end

function AuraWatch:OnDisable()
	self:UnregisterEvent("PLAYER_LOGIN")
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	self:UnregisterEvent("PLAYER_REGEN_DISABLED")
	self:UnregisterEvent("PLAYER_XP_UPDATE")
	self:UnregisterEvent("LEARNED_SPELL_IN_TAB")
	self:UnregisterAllBuckets()
	self:CancelAllTimers()

	if not FramesCreated then return end
	for k, v in pairs(db.bargroups) do
		AWF.BarGroups[k]:Hide()
	end
end