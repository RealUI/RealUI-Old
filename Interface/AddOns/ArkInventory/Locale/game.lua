local L = LibStub( "AceLocale-3.0" ):NewLocale( "ArkInventory", "enUS", true, false )
if not L then return end

-- game client based localisations and internal stuff


-- class names
L["WOW_CLASS_DRUID"] = LOCALIZED_CLASS_NAMES_MALE["DRUID"] or true
L["WOW_CLASS_HUNTER"] = LOCALIZED_CLASS_NAMES_MALE["HUNTER"] or true
L["WOW_CLASS_MAGE"] = LOCALIZED_CLASS_NAMES_MALE["MAGE"] or true
L["WOW_CLASS_PALADIN"] = LOCALIZED_CLASS_NAMES_MALE["PALADIN"] or true
L["WOW_CLASS_PRIEST"] = LOCALIZED_CLASS_NAMES_MALE["PRIEST"] or true
L["WOW_CLASS_ROGUE"] = LOCALIZED_CLASS_NAMES_MALE["ROGUE"] or true
L["WOW_CLASS_SHAMAN"] = LOCALIZED_CLASS_NAMES_MALE["SHAMAN"] or true
L["WOW_CLASS_WARLOCK"] = LOCALIZED_CLASS_NAMES_MALE["WARLOCK"] or true
L["WOW_CLASS_WARRIOR"] = LOCALIZED_CLASS_NAMES_MALE["WARRIOR"] or true
L["WOW_CLASS_DEATHKNIGHT"] = LOCALIZED_CLASS_NAMES_MALE["DEATHKNIGHT"] or true
L["WOW_CLASS_MONK"] = LOCALIZED_CLASS_NAMES_MALE["MONK"] or true


--	periodictable: set names for default class categories
L["PT_CLASS_DRUID"] = "Misc.Reagent.Class.Druid"
L["PT_CLASS_HUNTER"] = "Misc.Reagent.Class.Hunter"
L["PT_CLASS_MAGE"] = "Misc.Reagent.Class.Mage"
L["PT_CLASS_PALADIN"] = "Misc.Reagent.Class.Paladin"
L["PT_CLASS_PRIEST"] = "Misc.Reagent.Class.Priest"
L["PT_CLASS_ROGUE"] = "Misc.Reagent.Class.Rogue"
L["PT_CLASS_SHAMAN"] = "Misc.Reagent.Class.Shaman"
L["PT_CLASS_WARLOCK"] = "Misc.Reagent.Class.Warlock"
L["PT_CLASS_WARRIOR"] = "Misc.Reagent.Class.Warrior"
L["PT_CLASS_DEATHKNIGHT"] = "Misc.Reagent.Class.DeathKnight"
L["PT_CLASS_MONK"] = "Misc.Reagent.Class.Monk"


--	periodictable3: set names for default skill categories
L["PT_SKILL_ALCHEMY"] = "Tradeskill.Mat.ByProfession.Alchemy,Tradeskill.Tool.Alchemy"
L["PT_SKILL_BLACKSMITHING"] = "Tradeskill.Mat.ByProfession.Blacksmithing,Tradeskill.Tool.Blacksmithing"
L["PT_SKILL_COOKING"] = "Tradeskill.Mat.ByProfession.Cooking"
L["PT_SKILL_ENCHANTING"] = "Tradeskill.Mat.ByProfession.Enchanting,Tradeskill.Tool.Enchanting,Tradeskill.Gather.Disenchant"
L["PT_SKILL_ENGINEERING"] = "Tradeskill.Mat.ByProfession.Engineering,Tradeskill.Tool.Engineering"
L["PT_SKILL_FIRST_AID"] = "Tradeskill.Mat.ByProfession.First Aid"
L["PT_SKILL_FISHING"] = "Tradeskill.Gather.Fishing,Tradeskill.Tool.Fishing"
L["PT_SKILL_HERBALISM"] = "Tradeskill.Mat.ByType.Herb"
L["PT_SKILL_INSCRIPTION"] = "Tradeskill.Mat.ByType.Inscription"
L["PT_SKILL_JEWELCRAFTING"] = "Tradeskill.Mat.ByProfession.Jewelcrafting,Tradeskill.Tool.Jewelcrafting"
L["PT_SKILL_LEATHERWORKING"] = "Tradeskill.Mat.ByProfession.Leatherworking"
L["PT_SKILL_MINING"] = "Tradeskill.Gather.Mining,Tradeskill.Tool.Mining,Tradeskill.Mat.ByType.Ore,Tradeskill.Mat.ByType.Bar"
L["PT_SKILL_RIDING"] = ""
L["PT_SKILL_SKINNING"] = "Tradeskill.Gather.Skinning,Tradeskill.Tool.Skinning"
L["PT_SKILL_TAILORING"] = "Tradeskill.Mat.ByProfession.Tailoring"
L["PT_SKILL_ARCHAEOLOGY"] = ""


--	periodictable: other
L["PT_CATEGORY_CONSUMABLE_FOOD"] = "Consumable.Food.Edible"
L["PT_CATEGORY_CONSUMABLE_DRINK"] = "Consumable.Water"
L["PT_CATEGORY_CONTAINER"] = "Misc.Bag"
L["PT_CATEGORY_MOUNT"] = "Misc.Mount"
L["PT_CATEGORY_POTION"] = "Consumable.Potion"
L["PT_CATEGORY_POTION_HEAL"] = "Consumable.Potion.Recovery.Healing,Consumable.Warlock.Healthstone"
L["PT_CATEGORY_POTION_MANA"] = "Consumable.Potion.Recovery.Mana"
L["PT_CATEGORY_QUEST"] = "Misc.QuestMats"
L["PT_CATEGORY_REPUTATION"] = "Reputation.Turnin"
L["PT_CATEGORY_PET"] = "Misc.Minipet"


-- skills that we dont need to lookup, but can if they dont exist
L["WOW_SKILL_ARCHAEOLOGY"] = PROFESSIONS_ARCHAEOLOGY or true
L["WOW_SKILL_COOKING"] = PROFESSIONS_COOKING or true
L["WOW_SKILL_FIRST_AID"] = PROFESSIONS_FIRST_AID or true
L["WOW_SKILL_FISHING"] = PROFESSIONS_FISHING or true


-- locations
L["LOCATION_MOUNT"] = MOUNT or true
L["LOCATION_PET"] = PET or true


--	category descriptions
L["CATEGORY_CLASS"] = CLASS or true
L["CATEGORY_CUSTOM"] = CUSTOM or true
L["CATEGORY_EMPTY"] = EMPTY or true
L["CATEGORY_SKILL"] = SKILL or true
L["CATEGORY_SYSTEM"] = CHAT_MSG_SYSTEM or true
L["CATEGORY_SYSTEM_DEFAULT"] = SYSTEM_DEFAULT or true
L["CATEGORY_SYSTEM_REPUTATION"] = REPUTATION or true
L["CATEGORY_SYSTEM_SOULBOUND"] = ITEM_SOULBOUND or true


-- generic words
L["ACCEPT"] = ACCEPT or true
L["ADD"] = ADD or true
L["BACKGROUND"] = EMBLEM_BACKGROUND or true
L["BORDER"] = EMBLEM_BORDER or true
L["CANCEL"] = CANCEL or true
L["COLOUR"] = COLOR or true
L["DISABLED"] = ADDON_DISABLED or true
L["CLOSE"] = CLOSE or true
L["COMPLETE"] = COMPLETE or true
L["DEFAULT"] = DEFAULT or true
L["DELETE"] = DELETE or true
L["GENERAL"] = GENERAL or true
L["LOCK"] = LOCK or true
L["NAME"] = NAME or true
L["NEW"] = NEW or true
L["NONE"] = NONE or true
L["REMOVE"] = REMOVE or true
L["RENAME"] = PET_RENAME or true
L["SEARCH"] = SEARCH or true
L["START"] = START or true
L["STATUS"] = STATUS or true
L["UNKNOWN"] = UNKNOWNOBJECT or true
L["YES"] = YES or true
L["NO"] = NO or true
L["PET"] = PET or true
L["MOUNT"] = MOUNT or true


-- calculated
local text = ITEM_MIN_SKILL
text = string.gsub( text, "1%$", "", 1 )  -- remove 1$
text = string.gsub( text, "2%$", "", 1 ) -- remove 2$
text = string.gsub( text, "%(", "%%%(", 1 ) -- replace ( with %(
text = string.gsub( text, "%)", "%%%)", 1 ) -- replace ) with %)
text = string.gsub( text, "%%s", "(.+)", 1 ) -- replace %s with (.+)
text = string.gsub( text, "%%d", "%(%%d+%)", 1 ) -- replace %d with (%d+)
L["WOW_TOOLTIP_SKILL"] = string.format( "^%s", text )

L["WOW_TOOLTIP_CLASS"] = string.format( "^%s", string.gsub( ITEM_CLASSES_ALLOWED, "%%s", "(.+)", 1 ) )


-- generated from auction house categories

local auctionTable = {
	{ "WOW_ITEM_TYPE_WEAPON", 1 },
	{ "WOW_ITEM_TYPE_ARMOR", 2 },
	{ "WOW_ITEM_TYPE_CONSUMABLE", 4 },
	{ "WOW_ITEM_TYPE_CONSUMABLE_BANDAGE", 4, 5 },
	{ "WOW_ITEM_TYPE_CONSUMABLE_ELIXIR", 4, 3 },
	{ "WOW_ITEM_TYPE_CONSUMABLE_FLASK", 4, 4 },
	{ "WOW_ITEM_TYPE_CONSUMABLE_FOOD_AND_DRINK", 4, 1 },
	{ "WOW_ITEM_TYPE_CONSUMABLE_ITEM_ENHANCEMENT", 4, 6 },
	{ "WOW_ITEM_TYPE_CONSUMABLE_POTION", 4, 2 },
	{ "WOW_ITEM_TYPE_CONSUMABLE_SCROLL", 4, 7 },
	{ "WOW_ITEM_TYPE_CONTAINER", 3 },
	{ "WOW_ITEM_TYPE_CONTAINER_BAG", 3, 1 },
	{ "WOW_ITEM_TYPE_CONTAINER_ENCHANTING", 3, 3 },
	{ "WOW_ITEM_TYPE_CONTAINER_ENGINEERING", 3, 4 },
	{ "WOW_ITEM_TYPE_CONTAINER_GEM", 3, 5 },
	{ "WOW_ITEM_TYPE_CONTAINER_HERB", 3, 2 },
	{ "WOW_ITEM_TYPE_CONTAINER_INSCRIPTION", 3, 8 },
	{ "WOW_ITEM_TYPE_CONTAINER_LEATHERWORKING", 3, 7 },
	{ "WOW_ITEM_TYPE_CONTAINER_MINING", 3, 6 },
	{ "WOW_ITEM_TYPE_CONTAINER_TACKLE", 3, 9 },
	{ "WOW_ITEM_TYPE_GEM", 8 },
	{ "WOW_ITEM_TYPE_GLYPH", 5 },
	{ "WOW_ITEM_TYPE_MISC", 9 },
	{ "WOW_ITEM_TYPE_MISC_MOUNT", 9, 6 },
	{ "WOW_ITEM_TYPE_MISC_PET", 9, 3 },
	{ "WOW_ITEM_TYPE_MISC_REAGENT", 9, 2 },
	{ "WOW_ITEM_TYPE_QUEST", 10 },
	{ "WOW_ITEM_TYPE_RECIPE", 7 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS", 6 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_CLOTH", 6, 2 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_DEVICES", 6, 10 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_ELEMENTAL", 6, 1 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_EXPLOSIVES", 6, 11 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_HERB", 6, 6 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_ITEM_ENCHANTMENT", 6, 14 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_LEATHER", 6, 3 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_MATERIALS", 6, 12 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_MEAT", 6, 5 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_METAL_AND_STONE", 6, 4 },
	{ "WOW_ITEM_TYPE_TRADE_GOODS_PARTS", 6, 9 },
	
	{ "WOW_SKILL_ALCHEMY", 7, 7 },
	{ "WOW_SKILL_BLACKSMITHING", 7, 5 },
	{ "WOW_SKILL_COOKING", 7, 6 },
	{ "WOW_SKILL_ENCHANTING", 7, 9 },
	{ "WOW_SKILL_ENGINEERING", 7, 4 },
	{ "WOW_SKILL_FIRST_AID", 7, 8 },
	{ "WOW_SKILL_FISHING", 7, 10 },
	{ "WOW_SKILL_JEWELCRAFTING", 7, 11 },
	{ "WOW_SKILL_LEATHERWORKING", 7, 2 },
	{ "WOW_SKILL_TAILORING", 7, 3 },
	
	{ "LOCATION_MOUNT", 9, 6 },
	{ "CATEGORY_SYSTEM_BATTLEPET", 11 },
	
	{ "CATEGORY_CONSUMABLE", 4 },
	{ "CATEGORY_TRADE_GOODS", 6 },
	{ "CATEGORY_OTHER", 4, 8 },
	
}

for _, v in ipairs( auctionTable ) do
	
	local key, i1, i2 = v[1], v[2], v[3]
	
	if key then
		
		local text = nil
		
		if i2 then
			text = select( i2, GetAuctionItemSubClasses( i1 ) )
		else
			text = select( i1, GetAuctionItemClasses( ) )
		end
		
		if text then
			L[key] = text
		end
		
		--print( string.format( "%s (%s-%s) = %s", key, i1, i2 or 0, text or "nil" ) )
		
	end
	
end

table.wipe( auctionTable )
auctionTable = nil


-- set all to true so that they exist and can be over-ridden by the translation update code, wont get over-ridden here because the api wont allow it

L["WOW_ITEM_TYPE_WEAPON"] = true
L["WOW_ITEM_TYPE_ARMOR"] = true
L["WOW_ITEM_TYPE_CONSUMABLE"] = true
L["WOW_ITEM_TYPE_CONSUMABLE_BANDAGE"] = true
L["WOW_ITEM_TYPE_CONSUMABLE_ELIXIR"] = true
L["WOW_ITEM_TYPE_CONSUMABLE_FLASK"] = true
L["WOW_ITEM_TYPE_CONSUMABLE_FOOD_AND_DRINK"] = true
L["WOW_ITEM_TYPE_CONSUMABLE_ITEM_ENHANCEMENT"] = true
L["WOW_ITEM_TYPE_CONSUMABLE_POTION"] = true
L["WOW_ITEM_TYPE_CONSUMABLE_SCROLL"] = true
L["WOW_ITEM_TYPE_CONTAINER"] = true
L["WOW_ITEM_TYPE_CONTAINER_BAG"] = true
L["WOW_ITEM_TYPE_CONTAINER_ENCHANTING"] = true
L["WOW_ITEM_TYPE_CONTAINER_ENGINEERING"] = true
L["WOW_ITEM_TYPE_CONTAINER_GEM"] = true
L["WOW_ITEM_TYPE_CONTAINER_HERB"] = true
L["WOW_ITEM_TYPE_CONTAINER_INSCRIPTION"] = true
L["WOW_ITEM_TYPE_CONTAINER_LEATHERWORKING"] = true
L["WOW_ITEM_TYPE_CONTAINER_MINING"] = true
L["WOW_ITEM_TYPE_CONTAINER_TACKLE"] = true
L["WOW_ITEM_TYPE_GEM"] = true
L["WOW_ITEM_TYPE_GLYPH"] = true
L["WOW_ITEM_TYPE_MISC"] = true
L["WOW_ITEM_TYPE_MISC_MOUNT"] = true
L["WOW_ITEM_TYPE_MISC_PET"] = true
L["WOW_ITEM_TYPE_MISC_REAGENT"] = true
L["WOW_ITEM_TYPE_QUEST"] = true
L["WOW_ITEM_TYPE_RECIPE"] = true
L["WOW_ITEM_TYPE_TRADE_GOODS"] = true
L["WOW_ITEM_TYPE_TRADE_GOODS_CLOTH"] = true
L["WOW_ITEM_TYPE_TRADE_GOODS_DEVICES"] = true
L["WOW_ITEM_TYPE_TRADE_GOODS_ELEMENTAL"] = true
L["WOW_ITEM_TYPE_TRADE_GOODS_EXPLOSIVES"] = true
L["WOW_ITEM_TYPE_TRADE_GOODS_HERB"] = true
L["WOW_ITEM_TYPE_TRADE_GOODS_LEATHER"] = true
L["WOW_ITEM_TYPE_TRADE_GOODS_MATERIALS"] = true
L["WOW_ITEM_TYPE_TRADE_GOODS_MEAT"] = true
L["WOW_ITEM_TYPE_TRADE_GOODS_METAL_AND_STONE"] = true
L["WOW_ITEM_TYPE_TRADE_GOODS_PARTS"] = true
	
L["WOW_SKILL_ALCHEMY"] = true
L["WOW_SKILL_BLACKSMITHING"] = true
L["WOW_SKILL_COOKING"] = true
L["WOW_SKILL_ENCHANTING"] = true
L["WOW_SKILL_ENGINEERING"] = true
L["WOW_SKILL_FIRST_AID"] = true
L["WOW_SKILL_FISHING"] = true
L["WOW_SKILL_HERBALISM"] = true
L["WOW_SKILL_INSCRIPTION"] = true
L["WOW_SKILL_JEWELCRAFTING"] = true
L["WOW_SKILL_LEATHERWORKING"] = true
L["WOW_SKILL_MINING"] = true
L["WOW_SKILL_SKINNING"] = true
L["WOW_SKILL_TAILORING"] = true

L["CATEGORY_CONSUMABLE"] = true
L["CATEGORY_TRADE_GOODS"] = true
L["CATEGORY_OTHER"] = true
L["CATEGORY_SYSTEM_BATTLEPET"] = true
