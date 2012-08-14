local nibSpellAlertConfig = LibStub("AceAddon-3.0"):NewAddon("nibSpellAlertConfig", "AceConsole-3.0", "AceEvent-3.0");
local media = LibStub("LibSharedMedia-3.0");
local db;

local CustomShown = {
	[1] = false,
	[2] = false,
	[3] = false,
	[4] = false,
	[5] = false,
	[6] = false,
	[7] = false,
	[8] = false,
	[9] = false,
	[10] = false,
	[11] = false,
	[12] = false,
	[13] = false,
	[14] = false,
	[15] = false,
	[16] = false,
	[17] = false,
	[18] = false,
	[19] = false,
	[20] = false,
};

local CAF = {
	[1] = nil,
	[2] = nil,
	[3] = nil,
	[4] = nil,
	[5] = nil,
	[6] = nil,
	[7] = nil,
	[8] = nil,
	[9] = nil,
	[10] = nil,
	[11] = nil,
	[12] = nil,
	[13] = nil,
	[14] = nil,
	[15] = nil,
	[16] = nil,
	[17] = nil,
	[18] = nil,
	[19] = nil,
	[20] = nil,
}

local defaults = {
	profile = {
		configguide = {
			enabled = false,
			spells = {
				sides = "Clearcasting",
				top = "Shooting Stars",
				topleft = "Eclipse (Lunar)",
				topright = "Eclipse (Solar)",
			},
		},
		position = {
			x = 0,
			y = 0,
		},
		framelevel = {
			strata = "MEDIUM",
			level = 1,
		},		
		size = {
			scale = 1,
			width = 250,
			height = 250,
		},
		appearance = {
			opacity = 1,
		},
		custom = {
			enabled = false,
			["**"] = {
				enabled = false,
				configguide = false,
				aura = {
					auraname = "",
					isdebuff = false,
					unit = "player",
				},
				position = {
					positions = "Top",
					scale = 1,
				},
				texture = {
					texture = "",				
					color = {r = 255, g = 255, b = 255},
				},
				texts = {
					enabled = false,
					time = {
						enabled = true,
						font = {
							name = "Friz Quadrata TT",
							size = 12,
							color = {r = 1, g = 1, b = 1, a = 1},
							outline = "THINOUTLINE",
							justification = "CENTER",
							shadow = {
								useshadow = false,
								position = {x = 1, y = -1},
							},
						},
						position = {
							xofs = 0,
							yofs = 8,
						},
					},
					stacks = {
						enabled = true,
						font = {
							name = "Friz Quadrata TT",
							size = 12,
							color = {r = 1, g = 1, b = 1, a = 1},
							outline = "THINOUTLINE",
							justification = "CENTER",
							shadow = {
								useshadow = false,
								position = {x = 1, y = -1},
							},
						},
						position = {
							xofs = 0,
							yofs = -8,
						},
					},
				},
			},
			[1] = {},
			[2] = {},
			[3] = {},
			[4] = {},
			[5] = {},
			[6] = {},
			[7] = {},
			[8] = {},
			[9] = {},
			[10] = {},
			[11] = {},
			[12] = {},
			[13] = {},
			[14] = {},
			[15] = {},
			[16] = {},
			[17] = {},
			[18] = {},
			[19] = {},
			[20] = {},
		},
	},
};

local previewarea = {
	areas = {
		center = nil,
		outside = nil,
	},
	lines = {
		x = nil,
		y = nil,
		left = nil,
		right = nil,
		top = nil,
		bottom = nil,
	},
};

local SAScale = 0.8;
local LongWidth, ShortWidth = 256, 128;

local ClassAlerts_Sides = {
	["None"] = {
		id = 0,
		texture = "",
		positions = "Left + Right (Flipped)",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	-- Death Knight
	["Killing Machine"] = {
		id = 51124,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\KILLING_MACHINE.BLP",
		positions = "Left + Right (Flipped)",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	["Sudden Doom"] = {
		id = 81340,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\SUDDEN_DOOM.BLP",
		positions = "Left + Right (Flipped)",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	-- Druid
	["Clearcasting"] = {
		id = 16870,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\NATURES_GRACE.BLP",
		positions = "Left + Right (Flipped)",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	-- Hunter
	["Focus Fire"] = {
		id = 88843,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\FOCUS_FIRE.BLP",
		positions = "Left + Right (Flipped)",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	-- Mage
	["Arcane Missiles"] = {
		id = 5143,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\ARCANE_MISSILES.BLP",
		positions = "Left + Right (Flipped)",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	["Brain Freeze"] = {
		id = 57761,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\BRAIN_FREEZE.BLP",
		positions = "Left + Right (Flipped)",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	["Hot Streak"] = {
		id = 48108,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\HOT_STREAK.BLP",
		positions = "Left + Right (Flipped)",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	-- Paladin
	["Art of War"] = {
		id = 59578,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\ART_OF_WAR.BLP",
		positions = "Left + Right (Flipped)",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	["Daybreak"] = {
		id = 88819,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\DAYBREAK.BLP",
		positions = "Left + Right (Flipped)",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	["Grand Crusader"] = {
		id = 85416,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\GRAND_CRUSADER.BLP",
		positions = "Left + Right (Flipped)",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	-- Priest
	["Surge of Light"] = {
		id = 33151,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\SURGE_OF_LIGHT.BLP",
		positions = "Left + Right (Flipped)",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	-- Warlock
	["Nightfall"] = {
		id = 17941,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\NIGHTFALL.BLP",
		positions = "Left + Right (Flipped)",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	["Empowered Imp"] = {
		id = 47283,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\IMP_EMPOWERMENT.BLP",
		positions = "Left + Right (Flipped)",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	["Molten Core"] = {
		id = 71165,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\MOLTEN_CORE.BLP",
		positions = "Left + Right (Flipped)",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	-- Warrior
	["Bloodsurge"] = {
		id = 46916,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\BLOOD_SURGE.BLP",
		positions = "Left + Right (Flipped)",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	["Sudden Death"] = {
		id = 52437,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\SUDDEN_DEATH.BLP",
		positions = "Left + Right (Flipped)",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	["Sword and Board"] = {
		id = 50227,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\SWORD_AND_BOARD.BLP",
		positions = "Left + Right (Flipped)",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
};

local ClassAlerts_Top = {
	["None"] = {
		id = 0,
		texture = "",
		positions = "Top",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	-- Death Knight
	["Dark Transformation"] = {
		id = 93426,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\DARK_TRANSFORMATION.BLP",
		positions = "Top",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	["Freezing Fog"] = {
		id = 59052,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\RIME.BLP",
		positions = "Top",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	-- Druid
	["Fury of Stormrage"] = {
		id = 81093,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\FURY_OF_STORMRAGE.BLP",
		positions = "Top",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	["Shooting Stars"] = {
		id = 93400,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\SHOOTING_STARS.BLP",
		positions = "Top",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	-- Hunter
	["Lock and Load"] = {
		id = 56453,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\LOCK_AND_LOAD.BLP",
		positions = "Top",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	["Ready, Set, Aim"] = {
		id = 82926,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\MASTER_MARKSMAN.BLP",
		positions = "Top",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	-- Mage
	["Fingers of Frost"] = {
		id = 44544,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\FROZEN_FINGERS.BLP",
		positions = "Top",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	["Impact"] = {
		id = 64343,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\IMPACT.BLP",
		positions = "Top",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	-- Paladin
	["Hand of Light"] = {
		id = 90174,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\HAND_OF_LIGHT.BLP",
		positions = "Top",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	-- Shaman
	["Maelstrom Weapon"] = {
		id = 60349,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\MAELSTROM_WEAPON.BLP",
		positions = "Top",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	-- Warlock
	["Backlash"] = {
		id = 34936,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\BACKLASH.BLP",
		positions = "Top",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
};

local ClassAlerts_TopRight = {
	["None"] = {
		id = 0,
		texture = "",
		positions = "TopRight",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	-- Druid
	["Eclipse (Solar)"] = {
		id = 93430,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\ECLIPSE_SUN.BLP",
		positions = "TopRight",
		scale = 1,
		r = 244, g = 244, b = 244,
	},
};

local ClassAlerts_TopLeft = {
	["None"] = {
		id = 0,
		texture = "",
		positions = "TopLeft",
		scale = 1,
		r = 255, g = 255, b = 255,
	},
	-- Druid
	["Eclipse (Lunar)"] = {
		id = 93431,
		texture = "TEXTURES\\SPELLACTIVATIONOVERLAYS\\ECLIPSE_MOON.BLP",
		positions = "TopLeft",
		scale = 1,
		r = 244, g = 244, b = 244,
	},
};

-- Retrieve Font
local function RetrieveFont(font)
	font = media:Fetch("font", font) or GameFontNormalSmall:GetFont();
	return font
end

-- Retrieve SharedMedia backgound
local function RetrieveBackground(background)
	background = media:Fetch("background", background, true);
	return background
end

local function VerifyBackground(background)
	local newbackground = "";
	if background and strlen(background) > 0 then 
		newbackground = RetrieveBackground(background);
		if background ~= "None" then
			if not newbackground then
				print("Background "..background.." was not found in SharedMedia.");
				newbackground = "";
			end
		end
	end	
	return newbackground;
end

-------------------
-- CUSTOM ALERTS --
-------------------
-- Timer
local function CustomTimerOnUpdate(self)
	local CurTime = GetTime()
	local id = self.id

	if CurTime > self.lastupdate + 0.25 then
		local TimeLeft = self.remaining - CurTime
		if TimeLeft > 0 then
			local NewTimeString = string.format(SecondsToTimeAbbrev(TimeLeft))
			NewTimeString = gsub(NewTimeString, " ", "")
			self.text:SetText(NewTimeString)
			
			self.lastupdate = CurTime
		else
			self.text:SetText("")
			self.remaining = 0
			self:Hide()
		end
	end
end

-- Show Custom Alert
function nibSpellAlertConfig:ShowCustom(id)
	local Texture = VerifyBackground(db.custom[id].texture.texture);
	SpellActivationOverlay_ShowAllOverlays(SpellActivationOverlayFrame, 900000 + id, Texture, db.custom[id].position.positions, db.custom[id].position.scale, db.custom[id].texture.color.r * 255, db.custom[id].texture.color.g * 255, db.custom[id].texture.color.b * 255);
	
	if ( CAF[id] and db.custom[id].texts.enabled ) then
		-- Timer
		if db.custom[id].texts.time.enabled then
			CAF[id].Time:Show()
		end
		
		-- Stacks
		if db.custom[id].texts.stacks.enabled then
			CAF[id].Stacks:Show()
		end
	end
end

-- Hide Custom Alert
function nibSpellAlertConfig:HideCustom(id)
	-- Hide Overlay
	SpellActivationOverlay_HideOverlays(SpellActivationOverlayFrame, 900000 + id);
	
	-- Hide Texts
	if CAF[id] then
		CAF[id].Time:Hide()
		CAF[id].Time.remaining = 0
		CAF[id].Time.lastupdate = 0
		
		CAF[id].Stacks:Hide()
	end
end

-- Update Custom Alerts
function nibSpellAlertConfig:UpdateCustom(...)
	local event, arg1 = ...;
	
	-- Cycle through all Custom Alerts
	for i, v in ipairs(db.custom) do
		local ToShow = false;
		
		-- If Alert is valid, check if Aura is active
		if ( db.custom.enabled and db.custom[i].enabled and db.custom[i].aura.auraname ~= "" ) then			
			-- Retrieve Aura name
			local AuraID;
			if tonumber(db.custom[i].aura.auraname) == nil then
				AuraID = db.custom[i].aura.auraname;
			else
				AuraID = GetSpellInfo(tonumber(db.custom[i].aura.auraname));
			end
			
			local count, duration, expirationTime
			if AuraID ~= nil then
				-- Get Aura status
				if not db.custom[i].aura.isdebuff then
					-- Buff
					if UnitAura(db.custom[i].aura.unit, AuraID) then
						ToShow = true;
						_, _, _, count, _, duration, expirationTime = UnitAura(db.custom[i].aura.unit, AuraID)
					else
						ToShow = false;
					end
				else
					-- Debuff
					if UnitDebuff(db.custom[i].aura.unit, AuraID) then
						ToShow = true;
						_, _, _, count, _, duration, expirationTime = UnitDebuff(db.custom[i].aura.unit, AuraID)
					else
						ToShow = false;
					end
				end
				
				-- Set up Texts
				if ToShow then
					if ( CAF[i] and db.custom[i].texts.enabled ) then
						-- Timer
						if db.custom[i].texts.time.enabled then
							CAF[i].Time.remaining = expirationTime
							CAF[i].Time.lastupdate = 0
							CAF[i].Time:Show()
						else
							CAF[i].Time:Hide()
							CAF[i].Time.remaining = 0
							CAF[i].Time.lastupdate = 0
						end
						
						-- Stacks
						if db.custom[i].texts.stacks.enabled then
							if count > 0 then
								CAF[i].Stacks:Show()
								CAF[i].Stacks.text:SetText(tostring(count))
							else
								CAF[i].Stacks:Hide()
								CAF[i].Stacks.text:SetText("")
							end
						else
							CAF[i].Stacks:Hide()
							CAF[i].Stacks.text:SetText("")
						end
					end
				end
			end
			
			-- Config Guide
			if ( ToShow and db.custom[i].configguide ) then
				-- If aura is active, then disable config guide
				db.custom[i].configguide = false
			elseif ( (not ToShow) and db.custom[i].configguide ) then
				-- Show config guide
				ToShow = true;

				-- Set up Dummy values for texts
				if CAF[i] then
					if db.custom[i].texts.enabled then
						-- Timer
						if db.custom[i].texts.time.enabled then
							CAF[i].Time.remaining = GetTime() + 60
							CAF[i].Time.lastupdate = 0
						else
							CAF[i].Time:Hide()
						end
						
						-- Stacks
						if db.custom[i].texts.stacks.enabled then
							CAF[i].Stacks.text:SetText("5")
						else
							CAF[i].Stacks:Hide()
						end
					else
						CAF[i].Time:Hide()
						CAF[i].Time.remaining = 0
						
						CAF[i].Stacks:Hide()
						CAF[i].Stacks.text:SetText("")						
					end
				end
			end
		else
		-- Disabled / Unnamed Alert
			ToShow = false;
		end
		
		-- Show/Hide Alert
		if ToShow then
			if not CustomShown[i] then
				nibSpellAlertConfig:ShowCustom(i);
				CustomShown[i] = true;
			end
		else
			if CustomShown[i] then
				nibSpellAlertConfig:HideCustom(i);
				CustomShown[i] = false;
			end
		end
	end
end

-- CAF creation
local function CreateNewCAF(i)
	CAF[i] = {}
	
	-- Time
	CAF[i].Time = CreateFrame("Frame", nil, UIParent)
	CAF[i].Time:Hide()
	
	CAF[i].Time.text = CAF[i].Time:CreateFontString("")
	CAF[i].Time.text:SetFont(GameFontNormalSmall:GetFont(), 12)
	CAF[i].Time.text:SetAllPoints(CAF[i].Time)
	
	CAF[i].Time.id = i
	CAF[i].Time.remaining = 0
	CAF[i].Time.lastupdate = 0
	CAF[i].Time:SetScript("OnUpdate", CustomTimerOnUpdate)
	
	-- Stacks
	CAF[i].Stacks = CreateFrame("Frame", nil, UIParent)
	CAF[i].Stacks:Hide()
	
	CAF[i].Stacks.text = CAF[i].Stacks:CreateFontString("")
	CAF[i].Stacks.text:SetFont(GameFontNormalSmall:GetFont(), 12)
	CAF[i].Stacks.text:SetAllPoints(CAF[i].Stacks)
end

-- Update CAF settings
function nibSpellAlertConfig:UpdateCAFSettings()
	if db.custom.enabled then
		for i, v in ipairs(db.custom) do
			if ( db.custom[i].enabled and db.custom[i].aura.auraname ~= "" and db.custom[i].texts.enabled ) then
				if CAF[i] then
					-- Update CAF settings
					-- Position
					local xofs, yofs
					local baseofs = 10
					if db.custom[i].position.positions == "Top" then
						xofs = db.position.x
						yofs = db.position.y + (db.size.height / 2) + baseofs
					elseif db.custom[i].position.positions == "Left + Right (Flipped)" then
						xofs = db.position.x
						yofs = db.position.y - (db.size.height / 2) - baseofs + 40
					elseif db.custom[i].position.positions == "TopRight" then
						xofs = db.position.x + (db.size.width / 2) + baseofs
						yofs = db.position.y + (db.size.height / 2) + baseofs
					elseif db.custom[i].position.positions == "TopLeft" then
						xofs = db.position.x - (db.size.width / 2) - baseofs
						yofs = db.position.y + (db.size.height / 2) + baseofs
					elseif db.custom[i].position.positions == "Top + Bottom (Flipped)" then
						xofs = db.position.x
						yofs = db.position.y + (db.size.height / 2) + baseofs
					elseif db.custom[i].position.positions == "Bottom" then
						xofs = db.position.x
						yofs = db.position.y - (db.size.height / 2) - baseofs
					elseif db.custom[i].position.positions == "BottomRight" then
						xofs = db.position.x + (db.size.width / 2) + baseofs
						yofs = db.position.y - (db.size.height / 2) - baseofs
					elseif db.custom[i].position.positions == "BottomLeft" then
						xofs = db.position.x - (db.size.width / 2) - baseofs
						yofs = db.position.y - (db.size.height / 2) - baseofs
					elseif db.custom[i].position.positions == "Bottom (Flipped)" then
						xofs = db.position.x
						yofs = db.position.y - (db.size.height / 2) - baseofs
					end
					xofs = xofs * db.size.scale
					yofs = yofs * db.size.scale
					
					CAF[i].Time:SetPoint("CENTER", UIParent, "CENTER", (xofs + db.custom[i].texts.time.position.xofs), (yofs + db.custom[i].texts.time.position.yofs))
					CAF[i].Time:SetFrameStrata(db.framelevel.strata)
					CAF[i].Time:SetFrameLevel(db.framelevel.level + 1)
					CAF[i].Time:SetWidth(db.custom[i].texts.time.font.size * 4)
					CAF[i].Time:SetHeight(db.custom[i].texts.time.font.size + 2)
					
					CAF[i].Stacks:SetPoint("CENTER", UIParent, "CENTER", (xofs + db.custom[i].texts.stacks.position.xofs), (yofs + db.custom[i].texts.stacks.position.yofs))
					CAF[i].Stacks:SetFrameStrata(db.framelevel.strata)
					CAF[i].Stacks:SetFrameLevel(db.framelevel.level + 1)
					CAF[i].Stacks:SetWidth(db.custom[i].texts.stacks.font.size * 4)
					CAF[i].Stacks:SetHeight(db.custom[i].texts.stacks.font.size + 2)
					
					-- Font
					CAF[i].Time.text:SetFont(RetrieveFont(db.custom[i].texts.time.font.name), db.custom[i].texts.time.font.size, db.custom[i].texts.time.font.outline)
					if db.custom[i].texts.time.font.shadow.useshadow then
						CAF[i].Time.text:SetShadowColor(0, 0, 0, 1)
						CAF[i].Time.text:SetShadowOffset(db.custom[i].texts.time.font.shadow.position.x, db.custom[i].texts.time.font.shadow.position.y)
					else
						CAF[i].Time.text:SetShadowColor(0, 0, 0, 0)
					end
					CAF[i].Time.text:SetTextColor(db.custom[i].texts.time.font.color.r, db.custom[i].texts.time.font.color.g, db.custom[i].texts.time.font.color.b, db.custom[i].texts.time.font.color.a)
					
					CAF[i].Stacks.text:SetFont(RetrieveFont(db.custom[i].texts.stacks.font.name), db.custom[i].texts.stacks.font.size, db.custom[i].texts.stacks.font.outline)
					if db.custom[i].texts.stacks.font.shadow.useshadow then
						CAF[i].Stacks.text:SetShadowColor(0, 0, 0, 1)
						CAF[i].Stacks.text:SetShadowOffset(db.custom[i].texts.stacks.font.shadow.position.x, db.custom[i].texts.stacks.font.shadow.position.y)
					else
						CAF[i].Stacks.text:SetShadowColor(0, 0, 0, 0)
					end
					CAF[i].Stacks.text:SetTextColor(db.custom[i].texts.stacks.font.color.r, db.custom[i].texts.stacks.font.color.g, db.custom[i].texts.stacks.font.color.b, db.custom[i].texts.stacks.font.color.a)
				end
			end
		end
	end
end

-- Create/Destroy Custom Alert frames
function nibSpellAlertConfig:UpdateCAF()
	-- Cycle through all Custom Alerts
	for i, v in ipairs(db.custom) do
		if ( db.custom.enabled and db.custom[i].enabled and db.custom[i].texts.enabled ) then
			-- Valid Alert
			if not CAF[i] then
				-- Create frames
				CreateNewCAF(i)
			end
		else
			if CAF[i] then
				-- Destroy frames
				-- if CAF[i].Parent:IsShown() then CAF[i].Parent:Hide() end
				if type(CAF[i]) == "table" then
					CAF[i].Time:Hide()
					CAF[i].Stacks:Hide()
					wipe(CAF[i])
				end
				CAF[i] = nil
			end
		end
	end
	nibSpellAlertConfig:UpdateCAFSettings()
end

-- Enable / Disable the Custom Alerts
function nibSpellAlertConfig:UpdateCustomEnabled()
	if db.custom.enabled then
		self:RegisterEvent("UNIT_AURA", "UpdateCustom");
		self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateCustom");
		self:RegisterEvent("VEHICLE_UPDATE", "UpdateCustom");
	else
		self:UnregisterEvent("UNIT_AURA");
		self:UnregisterEvent("PLAYER_TARGET_CHANGED");
		self:UnregisterEvent("VEHICLE_UPDATE");
		
		for i, v in ipairs(db.custom) do
			db.custom[i].configguide = false
		end
	end
	
	nibSpellAlertConfig:UpdateCAF();
	nibSpellAlertConfig:UpdateCustom("_UPDATE");
end

---------------------
-- STANDARD ALERTS --
---------------------
-- Preview Area
-- Spell Alert refresh timer
local Timer_SendAlert = CreateFrame("FRAME")
local Timer_SendAlert_Int = 0;
Timer_SendAlert:Hide();
Timer_SendAlert:SetScript("OnUpdate", function(self, elapsed)
	Timer_SendAlert_Int = Timer_SendAlert_Int - elapsed;
	if (Timer_SendAlert_Int <= 0) then
		nibSpellAlertConfig:ShowPreviewAlerts("Sides");
		nibSpellAlertConfig:ShowPreviewAlerts("Top");		
		Timer_SendAlert_Int = 8;
	end
end);

-- Hide/Show Spell Alerts for Config Guide
function nibSpellAlertConfig:ShowPreviewAlerts(pos)
	local spellpos = {
		["Sides"] = ClassAlerts_Sides[db.configguide.spells.sides],
		["Top"] = ClassAlerts_Top[db.configguide.spells.top],
		["TopRight"] = ClassAlerts_TopRight[db.configguide.spells.topright],
		["TopLeft"] = ClassAlerts_TopLeft[db.configguide.spells.topleft],
	};
	SpellActivationOverlay_ShowAllOverlays(SpellActivationOverlayFrame, spellpos[pos].id, spellpos[pos].texture, spellpos[pos].positions, spellpos[pos].scale, spellpos[pos].r, spellpos[pos].g, spellpos[pos].b);
end

function nibSpellAlertConfig:HidePreviewAlerts(pos)
	local spellpos = {
		["Sides"] = ClassAlerts_Sides[db.configguide.spells.sides],
		["Top"] = ClassAlerts_Top[db.configguide.spells.top],
		["TopRight"] = ClassAlerts_TopRight[db.configguide.spells.topright],
		["TopLeft"] = ClassAlerts_TopLeft[db.configguide.spells.topleft],
	};
	SpellActivationOverlay_HideOverlays(SpellActivationOverlayFrame, spellpos[pos].id);
	Timer_SendAlert_Int = 0; -- Instantly refresh Alerts if in Config Guide
end

-- Toggle Config Guide
function nibSpellAlertConfig:ShowPreviewArea()
	if db.configguide.enabled then 
		-- Show Config Guide
		previewarea.areas.center:Show();
		-- previewarea.areas.outside:Show();
		
		nibSpellAlertConfig:ShowPreviewAlerts("Sides");
		nibSpellAlertConfig:ShowPreviewAlerts("Top");
		nibSpellAlertConfig:ShowPreviewAlerts("TopRight");
		nibSpellAlertConfig:ShowPreviewAlerts("TopLeft");
		
		Timer_SendAlert:Show();
	else
		-- Hide Config Guide
		Timer_SendAlert:Hide();
		
		previewarea.areas.center:Hide();
		-- previewarea.areas.outside:Hide();
		
		nibSpellAlertConfig:HidePreviewAlerts("Sides");
		nibSpellAlertConfig:HidePreviewAlerts("Top");
		nibSpellAlertConfig:HidePreviewAlerts("TopRight");
		nibSpellAlertConfig:HidePreviewAlerts("TopLeft");
	end
end

-- Position/Size
function nibSpellAlertConfig:UpdatePosition()
	-- Set standard Widths and Heights
	local swidth, sheight, scale = db.size.width, db.size.height, db.size.scale;
	local mwidth, mheight = swidth + (ShortWidth * SAScale), sheight + (ShortWidth * SAScale);
	local lwidth, lheight = swidth + (LongWidth * SAScale), sheight + (LongWidth * SAScale);
	local hwidth, hheight = (swidth / 2) + (64 * SAScale), (sheight / 2) + (64 * SAScale);

	-- Spell Alert frame
	SpellActivationOverlayFrame:ClearAllPoints();
	SpellActivationOverlayFrame:SetPoint("CENTER", UIParent, "CENTER", db.position.x, db.position.y);
	
	SpellActivationOverlayFrame:SetWidth(swidth);
	SpellActivationOverlayFrame:SetHeight(sheight);	
	SpellActivationOverlayFrame:SetScale(scale);
	
	SpellActivationOverlayFrame:SetFrameStrata(db.framelevel.strata);
	SpellActivationOverlayFrame:SetFrameLevel(db.framelevel.level);	
	
	-- Preview Area	
	previewarea.areas.center:ClearAllPoints();
	previewarea.areas.center:SetPoint("CENTER", UIParent, "CENTER", db.position.x, db.position.y);	
	previewarea.areas.center:SetWidth(swidth);
	previewarea.areas.center:SetHeight(sheight);	
	previewarea.areas.center:SetScale(db.size.scale);	
	previewarea.areas.center:SetFrameStrata(db.framelevel.strata);
	previewarea.areas.center:SetFrameLevel(db.framelevel.level);
	
	previewarea.areas.outside:ClearAllPoints();
	previewarea.areas.outside:SetPoint("CENTER", UIParent, "CENTER", db.position.x, db.position.y);	
	previewarea.areas.outside:SetWidth(lwidth);
	previewarea.areas.outside:SetHeight(lheight);	
	previewarea.areas.outside:SetScale(db.size.scale);	
	previewarea.areas.outside:SetFrameStrata(db.framelevel.strata);
	previewarea.areas.outside:SetFrameLevel(db.framelevel.level - 1);
	
	previewarea.lines.x:SetWidth(lwidth);
	previewarea.lines.y:SetHeight(lheight);
	
	previewarea.lines.left:SetPoint("CENTER", previewarea.areas.center, "CENTER", -hwidth, 0);
	previewarea.lines.left:SetHeight(mheight);
	
	previewarea.lines.right:SetPoint("CENTER", previewarea.areas.center, "CENTER", hwidth, 0);
	previewarea.lines.right:SetHeight(mheight);
	
	previewarea.lines.top:SetPoint("CENTER", previewarea.areas.center, "CENTER", 0, hheight);
	previewarea.lines.top:SetWidth(mwidth);
	
	previewarea.lines.bottom:SetPoint("CENTER", previewarea.areas.center, "CENTER", 0, -hheight);
	previewarea.lines.bottom:SetWidth(mwidth);
	
	-- Update Custom Alerts
	nibSpellAlertConfig:UpdateCAFSettings()
end

-- Appearance
function nibSpellAlertConfig:UpdateAppearance()
	SetCVar("spellActivationOverlayOpacity", db.appearance.opacity);
	SpellActivationOverlayFrame:SetAlpha(db.appearance.opacity);
end

function nibSpellAlertConfig:ProfChange()
	db = self.db.profile;
	nibSpellAlertConfig:ConfigRefresh();
	nibSpellAlertConfig:Refresh();
end

function nibSpellAlertConfig:Refresh()
	nibSpellAlertConfig:UpdatePosition();
	nibSpellAlertConfig:UpdateAppearance();
	nibSpellAlertConfig:UpdateCustomEnabled();
end

function nibSpellAlertConfig:PLAYER_LOGIN()
	-- Register textures with SharedMedia
	for i,v in pairs(ClassAlerts_Sides) do
		if i ~= "None" then media:Register("background", "SA - "..i, ClassAlerts_Sides[i].texture); end
	end	
	for i,v in pairs(ClassAlerts_Top) do
		if i ~= "None" then media:Register("background", "SA - "..i, ClassAlerts_Top[i].texture); end
	end
	for i,v in pairs(ClassAlerts_TopLeft) do
		if i ~= "None" then media:Register("background", "SA - "..i, ClassAlerts_TopLeft[i].texture); end
	end
	for i,v in pairs(ClassAlerts_TopRight) do
		if i ~= "None" then media:Register("background", "SA - "..i, ClassAlerts_TopRight[i].texture); end
	end
	media:Register("background", "SA - Generic Top 01", "TEXTURES\\SPELLACTIVATIONOVERLAYS\\GENERICTOP_01.BLP");
	media:Register("background", "SA - Generic Top 02", "TEXTURES\\SPELLACTIVATIONOVERLAYS\\GENERICTOP_02.BLP");
	media:Register("background", "SA - Generic Arc 01", "TEXTURES\\SPELLACTIVATIONOVERLAYS\\GENERICARC_01.BLP");
	media:Register("background", "SA - Generic Arc 02", "TEXTURES\\SPELLACTIVATIONOVERLAYS\\GENERICARC_02.BLP");
	media:Register("background", "SA - Generic Arc 03", "TEXTURES\\SPELLACTIVATIONOVERLAYS\\GENERICARC_03.BLP");
	media:Register("background", "SA - Generic Arc 04", "TEXTURES\\SPELLACTIVATIONOVERLAYS\\GENERICARC_04.BLP");
	media:Register("background", "SA - Generic Arc 05", "TEXTURES\\SPELLACTIVATIONOVERLAYS\\GENERICARC_05.BLP");
	media:Register("background", "SA - Generic Arc 06", "TEXTURES\\SPELLACTIVATIONOVERLAYS\\GENERICARC_06.BLP");

	-- Disable Config Guide
	db.configguide.enabled = false;
	db.configguide.spells = {sides = "Clearcasting", top = "Shooting Stars", topright = "Eclipse (Solar)", topleft = "Eclipse (Lunar)"};
	
	for i, v in ipairs(db.custom) do
		db.custom[i].configguide = false
	end
	
	-- hooksecurefunc("SpellActivationOverlay_ShowOverlay", function(self, spellID, texturePath, position, scale, r, g, b, vFlip, hFlip)
		-- print(spellID); print(texturePath); print(position); print(scale); print(r); print(g); print(b);
	-- end);
	
	-- Refresh Addon
	nibSpellAlertConfig:Refresh();
end

-- Create Frames that make up the Config Guide
local function CreatePreviewArea()
	-- Areas
	previewarea.areas.center = CreateFrame("Frame", nil, UIParent);
	previewarea.areas.center:SetBackdrop({bgFile = [=[Interface\ChatFrame\ChatFrameBackground]=], edgeFile = "", edgeSize = 0, tile = false, tileSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0}});
	previewarea.areas.center:SetBackdropColor(0, 1, 0, 0.4);
	previewarea.areas.center:Hide();
	
	previewarea.areas.outside = CreateFrame("Frame", nil, UIParent);
	previewarea.areas.outside:SetBackdrop({bgFile = [=[Interface\ChatFrame\ChatFrameBackground]=], edgeFile = "", edgeSize = 0, tile = false, tileSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0}});
	previewarea.areas.outside:SetBackdropColor(0, 0, 1, 0.1);
	previewarea.areas.outside:Hide();
	
	-- Lines
	local function CreateNewLine()
		local templine;
		templine = CreateFrame("Frame", nil, UIParent);
		templine:SetParent(previewarea.areas.center);
		templine:SetPoint("CENTER", previewarea.areas.center, "CENTER", 0, 0);
		templine:SetBackdrop({bgFile = [=[Interface\ChatFrame\ChatFrameBackground]=], edgeFile = "", edgeSize = 0, tile = false, tileSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0}});
		templine:SetBackdropColor(0.8, 0.8, 0.8, 0.6);
		templine:SetHeight(2);
		templine:SetWidth(2);
		return templine;
	end
	
	previewarea.lines.x = CreateNewLine();
	previewarea.lines.y = CreateNewLine();
	previewarea.lines.left = CreateNewLine();
	previewarea.lines.right = CreateNewLine();
	previewarea.lines.top = CreateNewLine();
	previewarea.lines.bottom = CreateNewLine();
end

function nibSpellAlertConfig:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("nibSpellAlertConfigDB", defaults, "Default");
		
	self.db.RegisterCallback(self, "OnProfileChanged", "ProfChange");
	self.db.RegisterCallback(self, "OnProfileCopied", "ProfChange");
	self.db.RegisterCallback(self, "OnProfileReset", "ProfChange");
	
	nibSpellAlertConfig:SetUpInitialOptions();
	
	db = self.db.profile;
	
	CreatePreviewArea();
	
	self:RegisterEvent("PLAYER_LOGIN");
end