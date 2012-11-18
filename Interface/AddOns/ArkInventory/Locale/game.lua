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


-- skills that we dont need to lookup
L["WOW_SKILL_ARCHAEOLOGY"] = PROFESSIONS_ARCHAEOLOGY or true
L["WOW_SKILL_COOKING"] = PROFESSIONS_COOKING or true
L["WOW_SKILL_FIRSTAID"] = PROFESSIONS_FIRST_AID or true
L["WOW_SKILL_FISHING"] = PROFESSIONS_FISHING or true


-- locations
L["LOCATION_BAG"] = INVTYPE_BAG or true



--	category descriptions
L["CATEGORY_CLASS"] = CLASS or true -- calculated keyword
L["CATEGORY_CUSTOM"] = CUSTOM or true -- calculated keyword
L["CATEGORY_EMPTY"] = EMPTY or true -- calculated keyword
L["CATEGORY_SKILL"] = SKILL or true -- calculated keyword
L["CATEGORY_SYSTEM"] = CHAT_MSG_SYSTEM or true -- calculated keyword

L["CATEGORY_SYSTEM_SOULBOUND"] = ITEM_SOULBOUND or true
L["CATEGORY_CONSUMABLE_FOOD"] = TUTORIAL_TITLE11 or true
L["CATEGORY_CONSUMABLE_DRINK"] = TUTORIAL_TITLE12 or true

L["CATEGORY_SYSTEM_EQUIPMENT"] = TUTORIAL_TITLE24 or true
L["CATEGORY_SYSTEM_EQUIPMENT_SOULBOUND"] = ( TUTORIAL_TITLE24 and ITEM_SOULBOUND and string.format( "%s (%s)", TUTORIAL_TITLE24, ITEM_SOULBOUND ) ) or true
L["CATEGORY_SYSTEM_EQUIPMENT_ACCOUNTBOUND"] = ( TUTORIAL_TITLE24 and ITEM_ACCOUNTBOUND and string.format( "%s (%s)", TUTORIAL_TITLE24, ITEM_ACCOUNTBOUND ) ) or true

-- ldb
L["LDB_MOUNTS_TYPE_A"] = BATTLE_PET_NAME_3 or true -- calculated keyword
L["LDB_MOUNTS_TYPE_X"] = VIDEO_QUALITY_LABEL6 or true -- calculated keyword


-- generic words
L["ACCEPT"] = ACCEPT or true
L["ADD"] = ADD or true
L["AQUATIC"] = BATTLE_PET_NAME_9 or true
L["BACKGROUND"] = EMBLEM_BACKGROUND or true
L["BORDER"] = EMBLEM_BORDER or true
L["CANCEL"] = CANCEL or true
L["CLOSE"] = CLOSE or true
L["COLOUR"] = COLOR or true
L["COMPLETE"] = COMPLETE or true
L["CURRENCY"] = CURRENCY or true
L["DEFAULT"] = DEFAULT or true
L["DELETE"] = DELETE or true
L["DESCRIPTION"] = QUEST_DESCRIPTION or true
L["DISABLED"] = ADDON_DISABLED or true
L["GENERAL"] = GENERAL or true
L["ITEMS"] = ITEMS or true
L["LOCK"] = LOCK or true
L["MOUNT"] = MOUNT or true
L["NAME"] = NAME or true
L["NEW"] = NEW or true
L["NO"] = NO or true
L["NONE"] = NONE or true
L["PET"] = PET or true
L["REMOVE"] = REMOVE or true
L["RENAME"] = PET_RENAME or true
L["REPUTATION"] = REPUTATION or true
L["SEARCH"] = SEARCH or true
L["START"] = START or true
L["STATUS"] = STATUS or true
L["TOTAL"] = TOTAL or true
L["TRACKING"] = TRACKING or true
L["UNKNOWN"] = UNKNOWNOBJECT or true
L["YES"] = YES or true
L["BATTLEPET"] = TOOLTIP_BATTLE_PET or true
L["ALL"] = ALL or true
L["CATEGORY"] = CATEGORY or true
L["CATEGORIES"] = CATEGORIES or true
L["CHARACTER"] = CHARACTER or true
L["CUSTOM"] = CUSTOM or true


local function ConvertToCapture( text )
	text = string.gsub( text, "%d%$", "" ) -- remove 1$ / 2$
	text = string.gsub( text, "%(", "%%%(" ) -- replace ( with %(
	text = string.gsub( text, "%)", "%%%)" ) -- replace ) with %)
	text = string.gsub( text, "%%s", "(.+)" ) -- replace %s with (.+)
	text = string.gsub( text, "%%d", "%(%%d+%)" ) -- replace %d with (%d+)
	return string.format( "^%s$", text )
end

-- calculated
L["WOW_TOOLTIP_REQUIRES_SKILL"] = ConvertToCapture( ITEM_MIN_SKILL )
L["WOW_TOOLTIP_REQUIRES_LEVEL"] = ConvertToCapture( ITEM_MIN_LEVEL )
L["WOW_TOOLTIP_REQUIRES_CLASS"] = ConvertToCapture( ITEM_CLASSES_ALLOWED )
L["WOW_TOOLTIP_REQUIRES"] = ConvertToCapture( ITEM_REQ_SKILL )

L["WOW_TOOLTIP_CLASS"] = string.format( "^%s", string.gsub( ITEM_CLASSES_ALLOWED, "%%s", "(.+)", 1 ) )
L["PET_BATTLE_BOUND"] = string.format( "%s (%s)", TOOLTIP_BATTLE_PET, ITEM_ACCOUNTBOUND )
L["PET_COMPANION_BOUND"] = string.format( "%s (%s)", PET, ITEM_ACCOUNTBOUND )
L["PET_CANNOT_BATTLE"] = string.gsub( BATTLE_PET_CANNOT_BATTLE, "\n", " " )


-- generated from auction house categories

local auctionTable = {
	
	{ "WOW_AH_WEAPON", 1 },
	
	{ "WOW_AH_ARMOR", 2 },
	
	{ "WOW_AH_CONTAINER", 3 },
	{ "WOW_AH_CONTAINER_BAG", 3, 1 },
	{ "WOW_AH_CONTAINER_HERB", 3, 2 },
	{ "WOW_AH_CONTAINER_ENCHANTING", 3, 3 },
	{ "WOW_AH_CONTAINER_ENGINEERING", 3, 4 },
	{ "WOW_AH_CONTAINER_GEM", 3, 5 },
	{ "WOW_AH_CONTAINER_MINING", 3, 6 },
	{ "WOW_AH_CONTAINER_LEATHERWORKING", 3, 7 },
	{ "WOW_AH_CONTAINER_INSCRIPTION", 3, 8 },
	{ "WOW_AH_CONTAINER_TACKLE", 3, 9 },
	
	{ "WOW_AH_CONSUMABLE", 4 },
	{ "WOW_AH_CONSUMABLE_FOOD+DRINK", 4, 1 },
	{ "WOW_AH_CONSUMABLE_POTION", 4, 2 },
	{ "WOW_AH_CONSUMABLE_ELIXIR", 4, 3 },
	{ "WOW_AH_CONSUMABLE_FLASK", 4, 4 },
	{ "WOW_AH_CONSUMABLE_BANDAGE", 4, 5 },
	{ "WOW_AH_CONSUMABLE_ENHANCEMENT", 4, 6 },
	{ "WOW_AH_CONSUMABLE_SCROLL", 4, 7 },
	{ "WOW_AH_CONSUMABLE_OTHER", 4, 8 },
	
	{ "WOW_AH_GLYPH", 5 },
	
	{ "WOW_AH_TRADEGOODS", 6 },
	{ "WOW_AH_TRADEGOODS_ELEMENTAL", 6, 1 },
	{ "WOW_AH_TRADEGOODS_CLOTH", 6, 2 },
	{ "WOW_AH_TRADEGOODS_LEATHER", 6, 3 },
	{ "WOW_AH_TRADEGOODS_METALSTONE", 6, 4 },
	{ "WOW_AH_TRADEGOODS_COOKING", 6, 5 },
	{ "WOW_AH_TRADEGOODS_HERB", 6, 6 },
	{ "WOW_AH_TRADEGOODS_ENCHANTING", 6, 7 },
	{ "WOW_AH_TRADEGOODS_JEWELCRAFTING", 6, 8 },
	{ "WOW_AH_TRADEGOODS_PARTS", 6, 9 },
	{ "WOW_AH_TRADEGOODS_DEVICES", 6, 10 },
	{ "WOW_AH_TRADEGOODS_EXPLOSIVES", 6, 11 },
	{ "WOW_AH_TRADEGOODS_MATERIALS", 6, 12 },
	{ "WOW_AH_TRADEGOODS_OTHER", 6, 13 },
	{ "WOW_AH_TRADEGOODS_ENCHANTMENT", 6, 14 },
	
	{ "WOW_AH_RECIPE", 7 },
	{ "WOW_AH_RECIPE_LEATHERWORKING", 7, 2 },
	{ "WOW_AH_RECIPE_TAILORING", 7, 3 },
	{ "WOW_AH_RECIPE_ENGINEERING", 7, 4 },
	{ "WOW_AH_RECIPE_BLACKSMITHING", 7, 5 },
	{ "WOW_AH_RECIPE_ALCHEMY", 7, 7 },
	{ "WOW_AH_RECIPE_INSCRIPTION", 7, 12 },
	
	{ "WOW_AH_GEM", 8 },
	
	{ "WOW_AH_MISC", 9 },
	{ "WOW_AH_MISC_JUNK", 9, 1 },
	{ "WOW_AH_MISC_REAGENT", 9, 2 },
	{ "WOW_AH_MISC_PET", 9, 3 },
	{ "WOW_AH_MISC_MOUNT", 9, 6 },
	
	{ "WOW_AH_QUEST", 10 },
	
	
	{ "CATEGORY_CONSUMABLE", 4 }, -- calculated keyword
	{ "CATEGORY_TRADEGOODS", 6 }, -- calculated keyword
	
	
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

L["WOW_AH_WEAPON"] = true

L["WOW_AH_ARMOR"] = true

L["WOW_AH_CONSUMABLE"] = true
L["WOW_AH_CONSUMABLE_BANDAGE"] = true
L["WOW_AH_CONSUMABLE_ELIXIR"] = true
L["WOW_AH_CONSUMABLE_FLASK"] = true
L["WOW_AH_CONSUMABLE_FOOD+DRINK"] = true
L["WOW_AH_CONSUMABLE_ENHANCEMENT"] = true
L["WOW_AH_CONSUMABLE_POTION"] = true
L["WOW_AH_CONSUMABLE_SCROLL"] = true
L["WOW_AH_CONSUMABLE_OTHER"] = true

L["WOW_AH_CONTAINER"] = true
L["WOW_AH_CONTAINER_BAG"] = true
L["WOW_AH_CONTAINER_ENCHANTING"] = true
L["WOW_AH_CONTAINER_ENGINEERING"] = true
L["WOW_AH_CONTAINER_GEM"] = true
L["WOW_AH_CONTAINER_HERB"] = true
L["WOW_AH_CONTAINER_INSCRIPTION"] = true
L["WOW_AH_CONTAINER_LEATHERWORKING"] = true
L["WOW_AH_CONTAINER_MINING"] = true
L["WOW_AH_CONTAINER_TACKLE"] = true

L["WOW_AH_GEM"] = true

L["WOW_AH_GLYPH"] = true

L["WOW_AH_MISC"] = true
L["WOW_AH_MISC_MOUNT"] = true
L["WOW_AH_MISC_PET"] = true
L["WOW_AH_MISC_REAGENT"] = true
L["WOW_AH_MISC_JUNK"] = true

L["WOW_AH_QUEST"] = true

L["WOW_AH_TRADEGOODS"] = true
L["WOW_AH_TRADEGOODS_ELEMENTAL"] = true
L["WOW_AH_TRADEGOODS_CLOTH"] = true
L["WOW_AH_TRADEGOODS_LEATHER"] = true
L["WOW_AH_TRADEGOODS_METALSTONE"] = true
L["WOW_AH_TRADEGOODS_COOKING"] = true
L["WOW_AH_TRADEGOODS_HERB"] = true
L["WOW_AH_TRADEGOODS_ENCHANTING"] = true
L["WOW_AH_TRADEGOODS_JEWELCRAFTING"] = true
L["WOW_AH_TRADEGOODS_PARTS"] = true
L["WOW_AH_TRADEGOODS_DEVICES"] = true
L["WOW_AH_TRADEGOODS_EXPLOSIVES"] = true
L["WOW_AH_TRADEGOODS_MATERIALS"] = true
L["WOW_AH_TRADEGOODS_OTHER"] = true
L["WOW_AH_TRADEGOODS_ENCHANTMENT"] = true

L["WOW_AH_RECIPE"] = true
L["WOW_AH_RECIPE_ALCHEMY"] = true
L["WOW_AH_RECIPE_BLACKSMITHING"] = true
L["WOW_AH_RECIPE_ENGINEERING"] = true
L["WOW_AH_RECIPE_INSCRIPTION"] = true
L["WOW_AH_RECIPE_LEATHERWORKING"] = true
L["WOW_AH_RECIPE_TAILORING"] = true

L["WOW_SKILL_HERBALISM"] = true
L["WOW_SKILL_MINING"] = true
L["WOW_SKILL_SKINNING"] = true

L["CATEGORY_CONSUMABLE"] = true
L["CATEGORY_TRADEGOODS"] = true
