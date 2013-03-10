local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")
local db, dbc, dbg

-- Primary Options table
local Options = {
	settings = nil,
	modules = {},
}
-- Extras
local ExtrasOptions = {
	settings = nil,
	modules = {},
}
-- Misc
local MiscOptions = {
	settings = nil,
}
-- Skins
local SkinsOptions = {
	settings = nil,
}
-- RealUI Core
local CoreOptions = {
	settings = nil,
}

local CloneProfileNewName = ""

-- Re-install RealUI
local function ReInstall()
	nibRealUI.db = {}
	
	-- Run Install Procedure
	nibRealUI:CloseOptions()
	nibRealUI:InstallProcedure()
end

-- Re-initialize Character
local function ResetChar()
	-- Set all Char settings to default
	nibRealUICharacter = nil
	dbc.layout.current = 1
	dbc.installation.stage = 0
	
	-- Run Install Procedure
	nibRealUI:CloseOptions()
	nibRealUI:InstallProcedure()
end

-- Options
local function GetOptions()
	-- Primary Options
	if not Options.settings then
		Options.settings = {
			type = "group",
			name = "|cffffffffRealUI|r "..nibRealUI:GetVerString(true),
			childGroups = "tree",
			args = {},
		}
	end
	
	-- Misc
	if not MiscOptions.settings then MiscOptions.settings = {
		name = "Misc Features",
		desc = "Miscellaneous Features",
		type = "group",
		args = {
			header = {
				type = "header",
				name = "Misc Features",
				order = 10,
			},
			dragemall = {
				type = "toggle",
				name = "Draggable Windows",
				desc = "Allows the dragging of most windows.",
				get = function() return nibRealUI:GetModuleEnabled("DragEmAll") end,
				set = function(info, value) 
					nibRealUI:SetModuleEnabled("DragEmAll", value)
					nibRealUI:ReloadUIDialog()
				end,
				order = 20,
			},
			itemquality = {
				type = "toggle",
				name = "Item Quality",
				desc = "Adds colored item borders and durability to the Character window.",
				get = function() return nibRealUI:GetModuleEnabled("ItemQuality") end,
				set = function(info, value) 
					nibRealUI:SetModuleEnabled("ItemQuality", value)
					nibRealUI:ReloadUIDialog()
				end,
				order = 30,
			},
		},
	}
	end
	
	-- Skins
	if not SkinsOptions.settings then SkinsOptions.settings = {
		name = "Skins",
		desc = "Toggle skinning of UI frames.",
		type = "group",
		args = {
			header = {
				type = "header",
				name = "Skins",
				order = 10,
			},
			timertrackers = {
				type = "toggle",
				name = "Timer Trackers",
				desc = "The timers display top-center for BGs, Arenas, etc.",
				get = function() return nibRealUI:GetModuleEnabled("TimerTrackers") end,
				set = function(info, value) 
					nibRealUI:SetModuleEnabled("TimerTrackers", value)
					nibRealUI:ReloadUIDialog()
				end,
				order = 20,
			},
		},
	}
	end
	
	-- Core
	if not CoreOptions.settings then CoreOptions.settings = {
		name = "RealUI Core",
		desc = "Core RealUI functions.",
		type = "group",
		args = {
			header = {
				type = "header",
				name = "RealUI Core",
				order = 10,
			},
			corenote = {
				type = "description",
				name = "Note: Only use these features if you need to. They may change or revert settings.",
				fontSize = "medium",
				order = 20,
			},
			sep = {
				type = "description",
				name = " ",
				order = 30,
			},
			reinstall = {
				type = "execute",
				name = "Reset RealUI",
				func = ReInstall,
				order = 40,
			},
			character = {
				type = "group",
				name = "Character",
				inline = true,
				order = 50,
				args = {
					resetchar = {
						type = "execute",
						name = "Re-initialize Character",
						func = ResetChar,
						order = 10,
					},
					sep = {
						type = "description",
						name = " ",
						order = 20,
					},
					resetnote = {
						type = "description",
						name = "This will flag the current Character as being new to RealUI, and RealUI will run through the initial installation procedure for this Character. Use only if you experienced a faulty installation for this character. Not guaranteed to actually fix anything.",
						fontSize = "medium",
						order = 30,
					},
				},
			},
			uiscaler = {
				type = "group",
				name = "UI Scaler",
				inline = true,
				order = 50,
				args = {
					enabled = {
						type = "toggle",
						name = "Enabled",
						desc = "Enable/Disable the UI Scaler. The UI Scaler automatically adjusts the UI scale for Pixel Perfect interface elements.",
						get = function() return db.other.uiscaler end,
						set = function(info, value) 
							db.other.uiscaler = value
							nibRealUI:ReloadUIDialog()
						end,
						order = 10,
					},
				},
			},
		},
	}
	end
	
	-- Plain Options
	for key, val in pairs(Options.modules) do
		Options.settings.args[key] = (type(val) == "function") and val() or val
	end
	
	-- Extras
	if not ExtrasOptions.settings then ExtrasOptions.settings = {
		type = "group",
		name = "Extras",
		desc = "Extra features to make life better.",
		childGroups = "tree",
		args = {},
	}
	end	
	for key, val in pairs(ExtrasOptions.modules) do
		ExtrasOptions.settings.args[key] = (type(val) == "function") and val() or val
	end
end

-- Add a small panel to the Interface - Addons options
local intoptions = nil
local function GetIntOptions()
	if not intoptions then
		intoptions = {
			name = "RealUI",
			handler = nibRealUI,
			type = "group",
			args = {
				note = {
					type = "description",
					name = "You can access the RealUI Options by clicking the icon beneath the Chat window, or typing: /realui",
					fontSize = "medium",
					order = 10,
				},
				openoptions = {
					type = "execute",
					name = "Open RealUI Options",
					func = function() 
						nibRealUI:OpenOptions()
					end,
					order = 20,
				},
			},
		}
	end
	return intoptions
end

function nibRealUI:CloseOptions()
	LibStub("AceConfigDialog-3.0"):Close("nibRealUI")
end

function nibRealUI:OpenOptions()
	if not Options.settings then nibRealUI:SetUpOptions() end
	LibStub("AceConfigDialog-3.0"):Open("nibRealUI")
end

function nibRealUI:ChatCommand()
	nibRealUI:OpenOptions()
end

function nibRealUI:ConfigRefresh()
	db = self.db.profile
	dbc = self.db.char
	dbg = self.db.global
	self.media = db.media
end

function nibRealUI:SetUpInitialOptions()
	-- Create Interface - Addons panel
	LibStub("AceConfig-3.0"):RegisterOptionsTable("nibRealUI-Int", GetIntOptions)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("nibRealUI-Int", "RealUI")
	
	-- Chat command
	nibRealUI:RegisterChatCommand("realui", "ChatCommand")
	
	nibRealUI:ConfigRefresh()
end

function nibRealUI:SetUpOptions()
	db = self.db.profile
	dbc = self.db.char
	dbg = self.db.global
	self.media = db.media
	
	-- Fill out Options table
	GetOptions()
	
	Options.settings.args.extras = ExtrasOptions.settings
	Options.settings.args.extras.order = 9800
	
	Options.settings.args.misc = MiscOptions.settings
	Options.settings.args.misc.order = 9850
	
	Options.settings.args.skins = SkinsOptions.settings
	Options.settings.args.skins.order = 9860
	
	Options.settings.args.core = CoreOptions.settings
	Options.settings.args.core.order = 9950
	
	Options.settings.args.profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
	Options.settings.args.profiles.order = -1
	
	-- Create RealUI Options window
	LibStub("AceConfig-3.0"):RegisterOptionsTable("nibRealUI", Options.settings)
	LibStub("AceConfigDialog-3.0"):SetDefaultSize("nibRealUI", 870, 600)
end

function nibRealUI:RegisterPlainOptions(name, optionTbl)
	Options.modules[name] = optionTbl
end

function nibRealUI:RegisterButtonsOptions(name, optionTbl)
	ButtonsOptions.modules[name] = optionTbl
end

function nibRealUI:RegisterExtrasOptions(name, optionTbl)
	ExtrasOptions.modules[name] = optionTbl
end