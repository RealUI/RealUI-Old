local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI");
local db;
local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

local MODNAME = "JunkSeller";
local JunkSeller = nibRealUI:NewModule(MODNAME, "AceEvent-3.0");

-- Options
local function ValidateLevel(value)
	val = tonumber(value);
	if val == nil then val = 1; end;
	if val < 1 then val = 1 elseif val > 85 then val = 85; end;
	return val
end

local options;
local function GetOptions()
	if not options then options = {
		type = "group",
		name = "Junk Seller",
		desc = "Automatic selling of grey quality items.",
		arg = MODNAME,
		order = 1021,
		args = {
			header = {
				type = "header",
				name = "Junk Seller",
				order = 10,
			},
			desc = {
				type = "description",
				name = "Automatic selling of grey quality items.",
				fontSize = "medium",
				order = 20,
			},
			enabled = {
				type = "toggle",
				name = "Enabled",
				desc = "Enable/Disable the Junk Seller module.",
				get = function() return nibRealUI:GetModuleEnabled(MODNAME) end,
				set = function(info, value) 
					nibRealUI:SetModuleEnabled(MODNAME, value)
					if ( nibRealUI:GetModuleEnabled(MODNAME) ) then
						JunkSeller:AtMerchant()
					end
				end,
				order = 30,
			},
			level = {
				type = "group",
				name = "Level",
				inline = true,
				disabled = function() if nibRealUI:GetModuleEnabled(MODNAME) then return false else return true end end,
				order = 40,
				args = {
					minlevel = {
						type = "input",
						name = "Minimum",
						desc = "JunkSeller won't sell Junk items below this level.",
						width = "half",
						order = 10,
						get = function(info) return tostring(db.minlevel) end,
						set = function(info, value)
							value = ValidateLevel(value)
							db.minlevel = value
						end,
					},
				},
			},
		},
	};
	end
	return options;
end

-- Sell Junk
function JunkSeller:AtMerchant()
	if UnitLevel("player") < db.minlevel then return end
	local profit = 0;
	for bag = 0, 4 do
		for slot = 0, GetContainerNumSlots(bag) do
			local link = GetContainerItemLink(bag, slot)
			if link then
				local sellprice = select(11, GetItemInfo(link))*select(2, GetContainerItemInfo(bag, slot))
				if select(3, GetItemInfo(link)) == 0 then
					ShowMerchantSellCursor(1);
					UseContainerItem(bag, slot);
					profit = profit + sellprice;
				end
			end
		end
	end
	if profit > 0 then
		local g, s, c = math.floor(profit / 10000) or 0, math.floor((profit%10000) / 100) or 0, profit%100
		print("Vendor trash sold: Profit - |cffffffff"..g.."|cffffd700g |cffffffff"..s.."|cffc7c7cfs|cffffffff "..c.."|cffeda55fc|r.")
	end
end

function JunkSeller:OnInitialize()
	self.db = nibRealUI.db:RegisterNamespace(MODNAME);
	self.db:RegisterDefaults({
		profile = {
			minlevel = 5,
			shortenloot = true,
		},
	});
	db = self.db.profile;
	
	self:SetEnabledState(nibRealUI:GetModuleEnabled(MODNAME));
	nibRealUI:RegisterExtrasOptions(MODNAME, GetOptions);
end

function JunkSeller:OnEnable()
	self:RegisterEvent("MERCHANT_SHOW", "AtMerchant");
end

function JunkSeller:OnDisable()
	self:UnregisterEvent("MERCHANT_SHOW");
end