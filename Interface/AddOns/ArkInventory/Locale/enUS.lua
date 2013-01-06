local L = LibStub( "AceLocale-3.0" ):NewLocale( "ArkInventory", "enUS", true, false )
if not L then return end

-- post updated translations at http://groups.google.com/group/wow-arkinventory (modify this file and include as an attachment)
-- note: when creating a new locale do not leave any english translations in your file, comment them out by placing -- at the start of the line


-- Translated by: <insert your name here>











--	wow zone names - must match exactly what is in game
	L["WOW_ZONE_AHNQIRAJ"] = "Ahn'Qiraj"
	L["WOW_ZONE_VASHJIR"] = "Vashj'ir"
	L["WOW_ZONE_KELPTHAR_FOREST"] = "Kelp'thar Forest"
	L["WOW_ZONE_SHIMMERING_EXPANSE"] = "Shimmering Expanse"
	L["WOW_ZONE_ABYSSAL_DEPTHS"] = "Abyssal Depths"
	
	
--	wow tooltip text - must match exactly what is in game
	L["WOW_ITEM_TOOLTIP_FOOD"] = "Must remain seated while eating"
	L["WOW_ITEM_TOOLTIP_DRINK"] = "Must remain seated while drinking"
	L["WOW_ITEM_TOOLTIP_POTION_HEAL"] = "Restores %d+ to %d+ health"
	L["WOW_ITEM_TOOLTIP_POTION_MANA"] = "Restores %d+ to %d+ mana"
	L["WOW_ITEM_TOOLTIP_ELIXIR_BATTLE"] = "Battle Elixir"
	L["WOW_ITEM_TOOLTIP_ELIXIR_GUARDIAN"] = "Guardian Elixir"
	
	
--	location names
	L["LOCATION_ACCOUNT"] = "Account"
	L["LOCATION_BANK"] = "Bank"
	L["LOCATION_WEARING"] = "Wearing"
	
	
--	subframe names
	L["SUBFRAME_NAME_TITLE"] = "Title"
	L["SUBFRAME_NAME_BAGCHANGER"] = "Bag Changer"
	
	
--	status bar/bag text
	L["STATUS_NO_DATA"] = "???"
	L["STATUS_FULL"] = "Full"
	L["STATUS_PURCHASE"] = "Buy" --PURCHASE
	
	
--	restack
	L["RESTACK"] = "Restack"
	L["RESTACK_TEXT"] = "consolidate items into as few stacks as possible and then try to fill up any empty slots in special bags where possible"
	L["RESTACK_FAIL_WAIT"] = "A restack operation is already in progress please wait for completion"
	L["RESTACK_FAIL_ACCESS"] = "You don't have enough authority to restack tab %2$s in the %1$s" -- %1$s = guild bank, %2$s = tab number
	
	
--	vault tab tooltips
	L["VAULT_TAB_ACCESS_NONE"] = "No Access"
	L["VAULT_TAB_NAME"] = "Tab: |cffffffff%1$s - %2$s|r" --%1$s = tab number, %2$s = tab name
	L["VAULT_TAB_ACCESS"] = "Access: |cffffffff%1$s|r"
	L["VAULT_TAB_REMAINING_WITHDRAWALS"] = "Remaining Daily Withdrawals: |cffffffff%1$s|r"
	
	
--	category "header" descriptions
	L["CATEGORY_RULE"] = "Rule"
	
	
--	system category descriptions
	L["CATEGORY_SYSTEM_CORE_MATS"] = "Core Mats"
	
	
--	consumable category descriptions
	L["CATEGORY_CONSUMABLE_FOOD_PET"] = "Pet Food"
	L["CATEGORY_CONSUMABLE_POTION_HEAL"] = "Health (Potion/Stone)"
	L["CATEGORY_CONSUMABLE_POTION_MANA"] = "Mana (Potion/Gem)"
	L["CATEGORY_CONSUMABLE_ELIXIR_BATTLE"] = "Elixir (Battle)"
	L["CATEGORY_CONSUMABLE_ELIXIR_GUARDIAN"] = "Elixir (Guardian)"
	
	
--	bag names - used to name the empty slots in the status frame (and LDB)
	L["STATUS_NAME_BAG"] = "Bag"
	L["STATUS_NAME_CRITTER"] = "Pet"
	L["STATUS_NAME_ENCHANTING"] = "Ench"
	L["STATUS_NAME_ENGINEERING"] = "Eng"
	L["STATUS_NAME_GEAR"] = "Gear"
	L["STATUS_NAME_GEM"] = "Gem"
	L["STATUS_NAME_HERB"] = "Herb"
	L["STATUS_NAME_INSCRIPTION"] = "Insc"
	L["STATUS_NAME_KEY"] = "Key"
	L["STATUS_NAME_LEATHERWORKING"] = "Lthr"
	L["STATUS_NAME_MAIL"] = "Mail"
	L["STATUS_NAME_MINING"] = "Ore"
	L["STATUS_NAME_MOUNT"] = "Mount"
	L["STATUS_NAME_TOKEN"] = "Tkn"
	L["STATUS_NAME_TACKLE"] = "Tkl"
	L["STATUS_NAME_COOKING"] = "Cook"
	
	
--	main menu
	L["MENU"] = "Menu"
	
	L["MENU_CHARACTER_SWITCH"] = "Switch Character"
	L["MENU_CHARACTER_SWITCH_TEXT"] = "Switches the display to another character"
	L["MENU_CHARACTER_SWITCH_CHOOSE_NONE"] = "no other character data to choose from"
	L["MENU_CHARACTER_SWITCH_CHOOSE_TEXT"] = "Switches the current display to %1$s"
	L["MENU_CHARACTER_SWITCH_ERASE"] = "Erase %s data"
	L["MENU_CHARACTER_SWITCH_ERASE_TEXT"] = "Erase %1$s data for %2$s"
	
	L["MENU_LOCATION_SWITCH"] = "Toggle Location"
	L["MENU_LOCATION_SWITCH_TEXT"] = "toggles the display of the %1$s window"
	
	
--	actions menu
	L["MENU_ACTION"] = "Actions"
	L["MENU_ACTION_REFRESH"] = "Refresh"
	L["MENU_ACTION_REFRESH_TEXT"] = "refreshes the window"
	L["MENU_ACTION_RELOAD_TEXT"] = "reloads the window. use when you change items in outfit sets"
	L["MENU_ACTION_EDITMODE"] = "Edit Mode"
	L["MENU_ACTION_EDITMODE_TEXT"] = "toggles edit mode on and off so you can customise item layout"
	L["MENU_ACTION_BAGCHANGER"] = "Bag Changer"
	L["MENU_ACTION_BAGCHANGER_TEXT"] = "toggles the display of the BagChanger frame so you can add or replace bags"
	
	
--	item menu
	L["MENU_ITEM_TITLE"] = "Item Information"
	L["MENU_ITEM_ITEM"] = "Item"
	L["MENU_ITEM_DEFAULT_RESET"] = "Reset to default"
	L["MENU_ITEM_DEFAULT_RESET_TEXT"] = "click to reset the category for this item back to it's default value (does not reset rules)"
	L["MENU_ITEM_ASSIGN_CHOICES"] = "Assignable Categories"
	L["MENU_ITEM_ASSIGN_THIS"] = "Assign Category"
	L["MENU_ITEM_ASSIGN_THIS_TEXT"] = "assign this item to a specific category"
	L["MENU_ITEM_RULE_NEW"] = "Create a new rule"
	L["MENU_ITEM_RULE_ADD"] = "Add item to rule"
	L["MENU_ITEM_CUSTOM_NEW"] = "Create a new custom category"
	L["MENU_ITEM_DEBUG"] = "Debug Info"
	L["MENU_ITEM_DEBUG_BAG"] = "Bag"
	L["MENU_ITEM_DEBUG_SLOT"] = "Slot"
	L["MENU_ITEM_DEBUG_BAG_TYPE"] = "Type"
	L["MENU_ITEM_DEBUG_PET_ID"] = "Pet ID"
	L["MENU_ITEM_DEBUG_PET_SPECIES"] = "Pet Species"
	L["MENU_ITEM_DEBUG_AI_ID_SHORT"] = "Short ID"
	L["MENU_ITEM_DEBUG_CACHE"] = "Cache ID"
	L["MENU_ITEM_DEBUG_AI_ID_RULE"] = "Rule ID"
	L["MENU_ITEM_DEBUG_AI_ID_CATEGORY"] = "Category ID"
	L["MENU_ITEM_DEBUG_LVL_ITEM"] = "Item Level (Stat)"
	L["MENU_ITEM_DEBUG_LVL_USE"] = "Item Level (Use)"
	L["MENU_ITEM_DEBUG_TYPE"] = "Type"
	L["MENU_ITEM_DEBUG_SUBTYPE"] = "Sub Type"
	L["MENU_ITEM_DEBUG_EQUIP"] = "Equip"
	L["MENU_ITEM_DEBUG_ID"] = "Blizzard ID"
	L["MENU_ITEM_DEBUG_FAMILY"] = "Family"
	L["MENU_ITEM_DEBUG_PT"] = "PT Sets"
	L["MENU_ITEM_DEBUG_PT_TEXT"] = "Lists which PT Sets this item is in"
	L["MENU_ITEM_DEBUG_PT_NONE"] = "this item is currently not in any PT set"
	L["MENU_ITEM_DEBUG_PT_TITLE"] = "PT Sets this item is in"
	
	
--	bar menu
	L["MENU_BAR_TITLE"] = "Bar %1$s"
	L["MENU_BAR_CATEGORY_TEXT"] = "assign category %1$s to this bar"
	L["MENU_BAR_CATEGORY_CURRENT"] = "Categories assigned"
	L["MENU_BAR_CATEGORY_ASSIGN"] = "Assignable Categories"
	L["MENU_BAR_CATEGORY_REMOVE_TEXT"] = "click to remove %1$s from bar %2$s\n\nthe category will revert to the default bar" -- 1 is the category name, 2 is the bar number
	L["MENU_BAR_CATEGORY_HIDDEN_TEXT"] = "click to toggle this categorys hidden status.\n\nitems in a hidden category will not display in normal mode"
	L["MENU_BAR_CATEGORY_MOVE_START_TEXT"] = "click to move %1$s\n\nyou then need to click on the bar or an item in that bar where you want it to go and choose the complete option"
	L["MENU_BAR_CATEGORY_MOVE_COMPLETE_TEXT"] = "click to move %1$s from bar %2$s to here (bar %3$s)"
	L["MENU_BAR_OPTIONS"] = "Bar Options"
	L["MENU_BAR_CLEAR_TEXT"] = "removes all categories (except the default category) and any sort method currently assigned to this bar"
	L["MENU_BAR_INSERT_TEXT"] = "inserts a new empty bar here"
	L["MENU_BAR_REMOVE_TEXT"] = "removes this bar\n\nany categories assigned to this bar will revert back to the default bar.\n\nIf the default category is on this bar it will be moved to bar 1"
	L["MENU_BAR_MOVE_START_TEXT"] = "click to move bar %1$s\n\nyou then need to click on another bar and chose the complete option"
	L["MENU_BAR_MOVE_COMPLETE_TEXT"] = "click to move bar %1$s to here\n\nbars between here and the original location will be reordered"
	L["MENU_BAR_SORTKEY_TEXT"] = "assign the sort method %1$s to this bar"
	L["MENU_BAR_SORTKEY_DEFAULT_RESET_TEXT"] = "click to reset the sort method for this bar back to the default value"
	
	
--	changer bag menu
	L["MENU_BAG_TITLE"] = "Bag Options"
	L["MENU_BAG_SHOW"] = "Display"
	L["MENU_BAG_SHOW_TEXT"] = "display the contents of this bag"
	L["MENU_BAG_ISOLATE"] = "Isolate"
	L["MENU_BAG_ISOLATE_TEXT"] = "only display the contents of this bag"
	L["MENU_BAG_SHOWALL"] = "Display All"
	L["MENU_BAG_SHOWALL_TEXT"] = "display the contents of all bags for this location"
	L["MENU_BAG_EMPTY"] = "Empty"
	L["MENU_BAG_EMPTY_TEXT"] = "moves the contents of this bag to your other bags"
	
	
--	configuration options
	L["CONFIG"] = "Config"
	L["CONFIG_TEXT"] = "Configuration Options"
	
--	configuration options > system
	L["CONFIG_SYSTEM"] = "Display"
	L["CONFIG_SYSTEM_TEXT"] = "Display Options"
	
	L["CONFIG_SYSTEM_FONT_TEXT"] = "select the font to use"
	
	L["CONFIG_SYSTEM_FRAMESTRATA"] = "Frame Strata"
	L["CONFIG_SYSTEM_FRAMESTRATA_TEXT"] = "select the frameStrata for the windows to be drawn on."
	L["CONFIG_SYSTEM_FRAMESTRATA_LEVEL_LOW"] = "LOW"
	L["CONFIG_SYSTEM_FRAMESTRATA_LEVEL_MEDIUM"] = "MEDIUM"
	L["CONFIG_SYSTEM_FRAMESTRATA_LEVEL_HIGH"] = "HIGH"
	
	L["CONFIG_SYSTEM_TOOLTIP"] = "Tooltips"
	L["CONFIG_SYSTEM_TOOLTIP_ENABLE_TEXT"] = "display tooltips"
	L["CONFIG_SYSTEM_TOOLTIP_EMPTY_ADD"] = "Empty Line"
	L["CONFIG_SYSTEM_TOOLTIP_EMPTY_ADD_TEXT"] = "show an empty line between the basic tooltip text and any custom text to be added"
	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_ADD"] = "Item counts"
	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_ADD_TEXT"] = "show item counts in tooltips"
	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_COLOUR_TEXT"] = "set the colour of the item count tooltip text"
	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_VAULT_TABS"] = "Show tabs"
	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_VAULT_TABS_TEXT"] = "show tab numbers for items found in a %1$s" -- %1$s = vault
	L["CONFIG_SYSTEM_TOOLTIP_SCALE_TEXT"] = "scales the game, reference and comparison tooltips (game wide)"
	L["CONFIG_SYSTEM_TOOLTIP_CLASSCOLOUR_TEXT"] = "use class colours to colour player names"
	L["CONFIG_SYSTEM_TOOLTIP_SELF_ONLY"] = "Self only"
	L["CONFIG_SYSTEM_TOOLTIP_SELF_ONLY_TEXT"] = "only show data for the current character"
	L["CONFIG_SYSTEM_TOOLTIP_FACTION_ONLY"] = "Faction only"
	L["CONFIG_SYSTEM_TOOLTIP_FACTION_ONLY_TEXT"] = "only show data for the current faction"
	L["CONFIG_SYSTEM_TOOLTIP_VAULT_TEXT"] = "include data from %1$s" -- %1$s = vault
	L["CONFIG_SYSTEM_TOOLTIP_BATTLEPET_SOURCE_TEXT"] = "include source text in tooltip"
	L["CONFIG_SYSTEM_TOOLTIP_BATTLEPET_DESCRIPTION_TEXT"] = "include description text in tooltip"
	L["CONFIG_SYSTEM_TOOLTIP_BATTLEPET_CUSTOM_ENABLE_TEXT"] = "replace the in-built battlepet tooltip with custom tooltip to allow for item counts"
	L["CONFIG_SYSTEM_TOOLTIP_BATTLEPET_MOUSEOVER_ENABLE_TEXT"] = "include extra text in mouseover tooltips for player, npc and wild battlepets"
	
	L["CONFIG_SYSTEM_BUGFIX"] = "Bug Fixes / Workarounds"
	L["CONFIG_SYSTEM_BUGFIX_TEXT"] = "toggle the code to fix or work around this issue"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL"] = "Frame Level"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_TEXT"] = "A bug in the blizzard CreateFrame API which can cause a frames background to appear above the foreground, item tooltips won't appear and it's impossible to click on anything in the window."
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_TEXT"] = "set how framelevel bug fix alerts are displayed"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE0"] = "Disabled"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE0_TEXT"] = "disables bug fix alerts from being displayed"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE1"] = "Short"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE1_TEXT"] = "displays the short text for bug fix alerts"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE2"] = "Full"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE2_TEXT"] = "displays the full text for bug fix alerts"
	L["CONFIG_SYSTEM_BUGFIX_ZEROSIZEBAG"] = "Zero Size Bag"
	L["CONFIG_SYSTEM_BUGFIX_ZEROSIZEBAG_TEXT"] = "A potential bug where zero or nil is returned for the size of a bag instead of it's correct size."
	L["CONFIG_SYSTEM_BUGFIX_ZEROSIZEBAG_ALERT_TEXT"] = "display alerts for this bug"
	L["BUGFIX_TAINTED_ALERT_MOUSEOVER_TEXT"] = "this item frame was created while you\nwere in combat which has caused\nit to be tainted and cannot\nbe used until you leave combat"
	L["BUGFIX_TAINTED_ALERT_OPEN_TEXT"] = "some of the item frames for this window were created while you were in combat which has caused them to be tainted and cannot be used until you leave combat"
	
	L["CONFIG_SYSTEM_MESSAGES"] = "Messages / Alerts"
	L["CONFIG_SYSTEM_MESSAGES_TRANSLATION"] = "Translation"
	L["CONFIG_SYSTEM_MESSAGES_TRANSLATION_INTERIM"] = "Interim"
	L["CONFIG_SYSTEM_MESSAGES_TRANSLATION_INTERIM_TEXT"] = "Show message for each translation attempt"
	L["CONFIG_SYSTEM_MESSAGES_TRANSLATION_FINAL"] = "Final"
	L["CONFIG_SYSTEM_MESSAGES_TRANSLATION_FINAL_TEXT"] = "Show final message for successful translation"
	L["CONFIG_SYSTEM_MESSAGES_BATTLEPET_OPPONENT"] = "Opponent Details"
	L["CONFIG_SYSTEM_MESSAGES_BATTLEPET_OPPONENT_TEXT"] = "Display Opponent Details upon entering a pet battle"
	
	
--	configuration options > auto
	L["CONFIG_AUTO"] = "Auto open/close"
	
	L["CONFIG_AUTO_OPEN"] = "Open the %1$s %2$s when you %3$s" -- %1$s = program, %2$s = bag, %3$s = action
	L["CONFIG_AUTO_OPEN_BANK"] = "open the bank"
	L["CONFIG_AUTO_OPEN_VAULT"] = "open the guild bank"
	L["CONFIG_AUTO_OPEN_MAIL"] = "open a mailbox"
	L["CONFIG_AUTO_OPEN_MERCHANT"] = "open a merchant/vendor"
	L["CONFIG_AUTO_OPEN_TRADE"] = "open a trade"
	L["CONFIG_AUTO_OPEN_AUCTION"] = "open the auction house"
	L["CONFIG_AUTO_OPEN_VOID"] = "open the void storage"
	
	L["CONFIG_AUTO_CLOSE"] = "Close the %1$s %2$s when you %3$s" -- %1$s = program, %2$s = bag, %3$s = action
	L["CONFIG_AUTO_CLOSE_BANK"] = "close the bank"
	L["CONFIG_AUTO_CLOSE_VAULT"] = "close the guild bank"
	L["CONFIG_AUTO_CLOSE_MAIL"] = "close the mailbox"
	L["CONFIG_AUTO_CLOSE_MERCHANT"] = "close a merchant/vendor"
	L["CONFIG_AUTO_CLOSE_TRADE"] = "close a trade"
	L["CONFIG_AUTO_CLOSE_AUCTION"] = "close the auction house"
	L["CONFIG_AUTO_CLOSE_VOID"] = "close the void storage"
	L["CONFIG_AUTO_CLOSE_COMBAT"] = "enter combat"
	
	
--	configuration options > control
	L["CONFIG_CONTROL"] = "Controls"
	
	L["CONFIG_CONTROL_MONITOR"] = "Monitor"
	L["CONFIG_CONTROL_MONITOR_TEXT"] = "monitor changes to %1$s data for this character (%2$s)." -- %1$s = location name, %2$s = chacracter name
	L["CONFIG_CONTROL_SAVE_TEXT"] = "save %1$s data for this character (%2$s) so that you can view it while on another character (or offline)." -- %1$s = location name, %2$s = chacracter name
	L["CONFIG_CONTROL_NOTIFY_ERASE"] = "Notify"
	L["CONFIG_CONTROL_NOTIFY_ERASE_TEXT"] = "generate a notification when erasing %s data"
	L["CONFIG_CONTROL_OVERRIDE"] = "Override"
	L["CONFIG_CONTROL_OVERRIDE_TEXT"] = "override the original Blizzard %2$s so that %1$s controls it instead.\n\ndisabling this option will return the standard Blizzard %2$s functionality.\n\nyou will still be able to open the %1$s %2$s when this is disabled but you will need to configure and use a keybinding instead." -- %1$s = program, %2$s = location
	L["CONFIG_CONTROL_ANCHOR_LOCK_TEXT"] = "lock the %1$s window so it can't be moved" -- %1$s = location name
	L["CONFIG_CONTROL_REPOSITION_NOW"] = "Reposition Now"
	L["CONFIG_CONTROL_REPOSITION_NOW_TEXT"] = "Repositions the %1$s window back onto the screen now" -- %1$s = location name
	L["CONFIG_CONTROL_REPOSITION_ONLOAD"] = "Reposition on Load"
	L["CONFIG_CONTROL_REPOSITION_ONLOAD_TEXT"] = "Repositions the %1$s window back onto the screen on the first viewing" -- %1$s = location name
	L["CONFIG_CONTROL_SETTINGS_TEXT"] = "select which settings to use when generating the %1$s window" -- %1$s = location name
	
	
--	configuration options > settings
	L["CONFIG_SETTINGS"] = "Settings"
	
	L["CONFIG_SETTINGS_FRAME"] = "Window"
	
	L["CONFIG_SETTINGS_FRAME_HIDE_TEXT"] = "Do not display the %2$s frame when viewing the %1$s window"
	
	L["CONFIG_SETTINGS_FRAME_SCALE_TEXT"] = "set the scale, making the window larger or smaller"
	L["CONFIG_SETTINGS_FRAME_PADDING_TEXT"] = "set the amount of space to add between the window edge and the bars"
	L["CONFIG_SETTINGS_FRAME_WIDTH_TEXT"] = "set the maximum number of items to display in a single row"
	L["CONFIG_SETTINGS_FRAME_BACKGROUND_COLOUR_TEXT"] = "set the background colour of the main window"
	L["CONFIG_SETTINGS_FRAME_BORDER_SHOW_TEXT"] = "display a border around the main window"
	L["CONFIG_SETTINGS_FRAME_BORDER_STYLE_TEXT"] = "set the border style for the main window"
	L["CONFIG_SETTINGS_FRAME_BORDER_COLOUR_TEXT"] = "set the border colour for the main window"
	
	L["CONFIG_SETTINGS_FRAME_CHANGER_HIGHLIGHT"] = "Highlight Colour"
	L["CONFIG_SETTINGS_FRAME_CHANGER_HIGHLIGHT_TEXT"] = "Highlight all slots belonging to a bag when you mouseover it's icon"
	L["CONFIG_SETTINGS_FRAME_CHANGER_HIGHLIGHT_COLOUR_TEXT"] = "Sets the colour used for the highlight"
	L["CONFIG_SETTINGS_FRAME_CHANGER_FREE"] = "Free Bag Slots"
	L["CONFIG_SETTINGS_FRAME_CHANGER_FREE_TEXT"] = "Display the number of free slots available on the bag icon"
	L["CONFIG_SETTINGS_FRAME_CHANGER_FREE_COLOUR_TEXT"] = "Sets the colour of the free slot count text"
	
	L["CONFIG_SETTINGS_FRAME_STATUS_EMPTY"] = "Empty slot text"
	L["CONFIG_SETTINGS_FRAME_STATUS_EMPTY_TEXT"] = "Display the empty slot text"
	
	L["CONFIG_SETTINGS_FRAME_TITLE_SIZE_NORMAL"] = "Normal"
	L["CONFIG_SETTINGS_FRAME_TITLE_SIZE_THIN"] = "Thin"
	
	L["CONFIG_SETTINGS_BARS"] = "Bars"
	L["CONFIG_SETTINGS_BARS_PER_ROW"] = "Per Row"
	L["CONFIG_SETTINGS_BARS_PER_ROW_TEXT"] = "set the number of bars to display in each row"
	L["CONFIG_SETTINGS_BARS_BACKGROUND_TEXT"] = "set the background colour for bars"
	L["CONFIG_SETTINGS_BARS_COMPACT"] = "Compact"
	L["CONFIG_SETTINGS_BARS_COMPACT_TEXT"] = "display all non empty bars in sequential order"
	L["CONFIG_SETTINGS_BARS_SHOW_EMPTY"] = "Show empty"
	L["CONFIG_SETTINGS_BARS_SHOW_EMPTY_TEXT"] = "display empty bars"
	L["CONFIG_SETTINGS_BARS_PADDING_INTERNAL_TEXT"] = "the amount of space to add between the bars and the items"
	L["CONFIG_SETTINGS_BARS_PADDING_EXTERNAL_TEXT"] = "the amount of space to add between bars"
	L["CONFIG_SETTINGS_BARS_BORDER_TEXT"] = "display a border around each bar"
	L["CONFIG_SETTINGS_BARS_BORDER_STYLE_TEXT"] = "set the border style for bars"
	L["CONFIG_SETTINGS_BARS_BORDER_COLOUR_TEXT"] = "set the colour for the border around the bars"
	L["CONFIG_SETTINGS_BARS_NAME_TEXT"] = "set the name for this bar"
	L["CONFIG_SETTINGS_BARS_NAME_SHOW_TEXT"] = "display bar names"
	L["CONFIG_SETTINGS_BARS_NAME_COLOUR_TEXT"] = "set the colour of the bar name"
	L["CONFIG_SETTINGS_BARS_NAME_HEIGHT_TEXT"] = "set the amount of space allocated to display the bar name in"
	L["CONFIG_SETTINGS_BARS_NAME_ANCHOR_TEXT"] = "set the anchor point of the bar name"
	
	L["CONFIG_SETTINGS_ITEMS"] = "Items"
	L["CONFIG_SETTINGS_ITEMS_PADDING_TEXT"] = "set the amount of space to add between item slots"
	L["CONFIG_SETTINGS_ITEMS_HIDDEN"] = "Show hidden"
	L["CONFIG_SETTINGS_ITEMS_HIDDEN_TEXT"] = "show hidden categories"
	L["CONFIG_SETTINGS_ITEMS_FADE"] = "Fade offline"
	L["CONFIG_SETTINGS_ITEMS_FADE_TEXT"] = "fade offline items"
	L["CONFIG_SETTINGS_ITEMS_TINT_USABLE"] = "Tint Unusable"
	L["CONFIG_SETTINGS_ITEMS_TINT_USABLE_TEXT"] = "tint unusable items red"
	L["CONFIG_SETTINGS_ITEMS_ITEMLEVEL_SHOW"] = "Item Level"
	L["CONFIG_SETTINGS_ITEMS_ITEMLEVEL_SHOW_TEXT"] = "show item level for equippable items"
	L["CONFIG_SETTINGS_ITEMS_BORDER_SHOW_TEXT"] = "show borders around items or not"
	L["CONFIG_SETTINGS_ITEMS_BORDER_STYLE_TEXT"] = "set the border style for items"
	L["CONFIG_SETTINGS_ITEMS_BORDER_RARITY"] = "Rarity coloured border"
	L["CONFIG_SETTINGS_ITEMS_BORDER_RARITY_TEXT"] = "colour the border around each item slot to match it's rarity (Common, Rare, Epic, etc)"
	L["CONFIG_SETTINGS_ITEMS_BORDER_RARITY_CUTOFF"] = "Rarity Cutoff"
	L["CONFIG_SETTINGS_ITEMS_BORDER_RARITY_CUTOFF_TEXT"] = "only colour the item border if the item rarity is equal to or above %s"
	L["CONFIG_SETTINGS_ITEMS_BORDER_TEXTURE_OFFSET_TEXT"] = "the number pixels from the outside of the image to the inside edge of the border itself (used to realign the border to the item texture)"
	L["CONFIG_SETTINGS_ITEMS_AGE"] = "Item Age"
	L["CONFIG_SETTINGS_ITEMS_AGE_SHOW_TEXT"] = "toggles the display of the item age text"
	L["CONFIG_SETTINGS_ITEMS_AGE_COLOUR_TEXT"] = "sets the colour of the item age text"
	L["CONFIG_SETTINGS_ITEMS_AGE_CUTOFF"] = "Cutoff (minutes)"
	L["CONFIG_SETTINGS_ITEMS_AGE_CUTOFF_TEXT"] = "display the items age if they are less than this value.  use 0 to always display the age"
	L["CONFIG_SETTINGS_ITEMS_AGE_RESET_TEXT"] = "clears the new item status for all items in this location"
	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_SHOW_TEXT"] = "Display cooldowns for items in the %1$s window"
	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_GLOBAL"] = "Update on GCD"
	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_GLOBAL_TEXT"] = "Refresh the %1$s window to show cooldowns when a Global Cooldown event is triggered"
	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_COMBAT"] = "Refresh in combat"
	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_COMBAT_TEXT"] = "Refresh the %1$s window to show cooldowns while in combat, or wait until combat has ended"
	
	L["CONFIG_SETTINGS_SORTING_OPEN"] = "On window open"
	L["CONFIG_SETTINGS_SORTING_OPEN_TEXT"] = "toggles whether a resort is done when you open the window."
	L["CONFIG_SETTINGS_SORTING_INSTANT"] = "Instant"
	L["CONFIG_SETTINGS_SORTING_INSTANT_TEXT"] = "toggles instant sort mode.\n\nenabled: sorting is done instantly when something changes\n\ndisabled: sorting is done only when the window is opened, or you refresh."
	
	L["CONFIG_SETTINGS_EMPTY"] = "Empty slots"
	L["CONFIG_SETTINGS_EMPTY_ICON"] = "Use Icon"
	L["CONFIG_SETTINGS_EMPTY_ICON_TEXT"] = "use an icon for empty slot backgrounds"
	L["CONFIG_SETTINGS_EMPTY_CLUMP"] = "Clump"
	L["CONFIG_SETTINGS_EMPTY_CLUMP_TEXT"] = "clump empty slots in with their non-empty type slots"
	L["CONFIG_SETTINGS_EMPTY_BORDER"] = "Coloured borders"
	L["CONFIG_SETTINGS_EMPTY_BORDER_TEXT"] = "colour empty slot borders according to their bag type"
	L["CONFIG_SETTINGS_EMPTY_COLOUR"] = "Slot colours"
	L["CONFIG_SETTINGS_EMPTY_COLOUR_TEXT"] = "set the border and background colour for empty %1$s slots" -- %1$s = slot name
	L["CONFIG_SETTINGS_EMPTY_STATUS"] = "Display Format"
	
	
-- sorting
	L["CONFIG_SORTMETHOD"] = "Sort Methods"
	
	L["CONFIG_SORTMETHOD_SORT"] = "Sorting"
	
	L["CONFIG_SORTMETHOD_STYLE_TEXT"] = "choose how you want your items sorted"
	L["CONFIG_SORTMETHOD_STYLE_BAGSLOT"] = "Bag / Slot"
	L["CONFIG_SORTMETHOD_STYLE_BAGSLOT_TEXT"] = "sorts your items by bag and slot numbers"
	L["CONFIG_SORTMETHOD_STYLE_USER"] = "User Defined"
	L["CONFIG_SORTMETHOD_STYLE_USER_TEXT"] = "sorts your items the way you order it"
	
	L["CONFIG_SORTMETHOD_INCLUDE_NAME"] = "item name"
	L["CONFIG_SORTMETHOD_INCLUDE_NAME_TEXT"] = "include item name when sorting"
	L["CONFIG_SORTMETHOD_INCLUDE_NAME_REVERSE"] = "Use reversed names"
	L["CONFIG_SORTMETHOD_INCLUDE_NAME_REVERSE_TEXT"] = "use reversed names when sorting.\n\neg Super Mana Potion becomes Potion Mana Super"
	L["CONFIG_SORTMETHOD_INCLUDE_QUALITY"] = "item rarity"
	L["CONFIG_SORTMETHOD_INCLUDE_QUALITY_TEXT"] = "include item rarity when sorting"
	L["CONFIG_SORTMETHOD_INCLUDE_LOCATION"] = "item equip location"
	L["CONFIG_SORTMETHOD_INCLUDE_LOCATION_TEXT"] = "include item equip locations when sorting.\n\nnote: only affects items that can be equipped"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMTYPE"] = "item type and subtype"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMTYPE_TEXT"] = "include item type and subtype when sorting."
	L["CONFIG_SORTMETHOD_INCLUDE_CATEGORY"] = "item category"
	L["CONFIG_SORTMETHOD_INCLUDE_CATEGORY_TEXT"] = "include item category in sorting your inventory"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMUSELEVEL"] = "item (use) level"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMUSELEVEL_TEXT"] = "include item (use) level when sorting."
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMSTATLEVEL"] = "item (stat) level"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMSTATLEVEL_TEXT"] = "include item (stat) level when sorting."
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMAGE"] = "item age"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMAGE_TEXT"] = "include item age when sorting."
	L["CONFIG_SORTMETHOD_INCLUDE_VENDORPRICE"] = "vendor price"
	L["CONFIG_SORTMETHOD_INCLUDE_VENDORPRICE_TEXT"] = "include vendor price (per current stack size) when sorting."
	L["CONFIG_SORTMETHOD_INCLUDE_ID"] = "internal id"
	L["CONFIG_SORTMETHOD_INCLUDE_ID_TEXT"] = "include internal id (class:id:soulbound) when sorting."
	
	L["CONFIG_SORTMETHOD_DIRECTION_TEXT"] = "select what direction you want your items sorted in"
	L["CONFIG_SORTMETHOD_ORDER"] = "Sort Order"
	L["CONFIG_SORTMETHOD_MOVE_UP_TEXT"] = "moves %1$s up in the sort order"
	L["CONFIG_SORTMETHOD_MOVE_DOWN_TEXT"] = "moves %1$s down in the sort order"
	L["CONFIG_SORTMETHOD_NOT_INCLUDED"] = "* not currently included in sort*"
	
	L["CONFIG_SORTMETHOD_ADD"] = "Add Sort Method"
	L["CONFIG_SORTMETHOD_ADD_TEXT"] = "add new sort method"
	L["CONFIG_SORTMETHOD_RENAME_TEXT"] = "rename this sort method"
	L["CONFIG_SORTMETHOD_DELETE_TEXT"] = "delete this sort method"
	
	
-- rules
	L["CONFIG_RULES"] = "Rules"
	L["CONFIG_RULES_SHOWDISABLED"] = "Show Disabled Rules"
	L["CONFIG_RULES_SHOWDISABLED_TEXT"] = "toggles the display of disabled rules"
	
	
--	configuration options > categories
	L["CONFIG_CATEGORY_CUSTOM"] = "Custom Categories"
	L["CONFIG_CATEGORY_DELETED"] = "**Deleted Category [%s]**"
	
	L["CONFIG_CATEGORY_ADD"] = "Add Category"
	L["CONFIG_CATEGORY_ADD_TEXT"] = "add new category"
	L["CONFIG_CATEGORY_RENAME_TEXT"] = "rename this category"
	L["CONFIG_CATEGORY_DELETE_TEXT"] = "delete this category"
	
	
--	configuration options > debug
	L["CONFIG_DEBUG"] = "Debug Mode"
	L["CONFIG_DEBUG_TEXT"] = "toggles whether debugging code is enabled or not"
	
	
--	configuration options > generic
	L["BORDER_SCALE_TEXT"] = "set the scale for the border texture"
	L["BORDER_TEXTURE_TEXT"] = "border texture options"
	L["BORDER_TEXTURE_FILE_TEXT"] = "the texture to use for the border"
	L["BORDER_TEXTURE_HEIGHT_TEXT"] = "the height (in pixels) of the texture"
	
	
--	rules frame
	L["RULE"] = "Rule"
	L["RULE_HIDDEN"] = "Hidden"
	L["RULE_FORMULA"] = "Formula"
	L["RULE_LIST_ENABLED"] = "Use"
	L["RULE_LIST_DAMAGED"] = "Dmg"
	L["RULE_LIST_ID"] = "Rule"
	
	L["RULE_DAMAGED"] = "Rule %s is now flagged as damaged and will no longer be used until repaired"
	L["RULE_FAILED"] = "Error validating rule %s"
	L["RULE_FAILED_KEY_NIL"] = "id is nil"
	L["RULE_FAILED_DATA_NIL"] = "data is nil"
	L["RULE_FAILED_DESCRIPTION_NIL"] = "description is missing"
	L["RULE_FAILED_FORMULA_NIL"] = "formula is missing"
	L["RULE_FAILED_FORMULA_BAD"] = "invalid formula"
	L["RULE_FAILED_ARGUMENT_IS_NIL"] = "%1$s( ... ), argument %2$i is nil"
	L["RULE_FAILED_ARGUMENT_IS_INVALID"] = "%1$s( ... ), argument %2$i is not %3$s"
	L["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"] = "%1$s( ... ), no arguments specified"
	
	
--	new item indicators
	L["NEW_ITEM_INCREASE"] = "+++"
	L["NEW_ITEM_DECREASE"] = "- - -"
	
	
--	slash commands
	L["SLASH_UI"] = "ui"
	L["SLASH_UI_TEXT"] = "ui options"
	L["SLASH_UI_RESET"] = "reset"
	L["SLASH_UI_RESET_TEXT"] = "centers the interface on the screen"
	L["SLASH_UI_RESET_COMPLETE_TEXT"] = "all ui windows reset to center of screen"
	L["SLASH_DB"] = "db"
	L["SLASH_DB_TEXT"] = "db options"
	L["SLASH_DB_RESET"] = "reset"
	L["SLASH_DB_RESET_TEXT"] = "resets all options back to the defaults"
	L["SLASH_DB_RESET_CONFIRM"] = "confirm"
	L["SLASH_DB_RESET_CONFIRM_TEXT"] = "confirms the database reset"
	L["SLASH_DB_RESET_COMPLETE_TEXT"] = "Profile has been reset.  All options are now back to defaults."
	L["SLASH_CACHE"] = "cache"
	L["SLASH_CACHE_TEXT"] = "cache options"
	L["SLASH_CACHE_ERASE"] = "erase"
	L["SLASH_CACHE_ERASE_TEXT"] = "erases all cached data"
	L["SLASH_CACHE_ERASE_CONFIRM"] = "confirm"
	L["SLASH_CACHE_ERASE_CONFIRM_TEXT"] = "confirms the cache erase"
	L["SLASH_CACHE_ERASE_COMPLETE_TEXT"] = "Erase All data for All Characters"
	L["SLASH_MISC"] = "misc"
	L["SLASH_MISC_TEXT"] = "misc options"
	L["SLASH_TRACK"] = "track"
	L["SLASH_TRACK_TEXT"] = "adds or removes an item from the tracking list"
	
	
--	misc chat stuff
	L["UPGRADE_PROFILE"] = "Upgrading profile data for [%1$s] to v%2$d" -- profile name, version
	L["UPGRADE_GLOBAL"] = "Upgrading global %1$s data to v%2$d" -- profile type, version
	L["UPGRADE_CHAR"] = "Upgrading character data for %1$s to v%2$d" -- character, version
	
	L["MISC_ALERT"] = "Alert!"
	L["MISC_ALERT_FRAMELEVEL_1"] = "Bug fix complete."
	L["MISC_ALERT_FRAMELEVEL_2"] = "The FrameLevel for the %1$s window is currently at %2$s and has been reset to %3$s to ensure that it remains functional.  Sorry for the lag spike caused by the fix."
	
	L["BATTLEPET_OPPONENT_IMMUNE"] = "Cannot be Captured"
	L["BATTLEPET_OPPONENT_KNOWN_MAX"] = "Limit Reached"
	L["BATTLEPET_OPPONENT_KNOWN"] = "Owned"
	L["BATTLEPET_OPPONENT_UNKNOWN"] = "Not Owned"
	L["BATTLEPET_OPPONENT_UPGRADE"] = "Upgrade?"
	
	
--	item count tooltip
	L["TOOLTIP_COUNT_ME"] = ">"
	L["TOOLTIP_VAULT_TABS"] = "Tab"
	L["TOOLTIP_GOLD_AMOUNT"] = "Amount"
	
	
--	generic text
	L["AUTOMATIC"] = "Automatic"
	L["BOTTOMLEFT"] = "Bottom Left"
	L["BOTTOMRIGHT"] = "Bottom Right"
	L["TOPLEFT"] = "Top Left"
	L["TOPRIGHT"] = "Top Right"
	L["TOP"] = "Top"
	L["BOTTOM"] = "Bottom"
	L["LEFT"] = "Left"
	L["RIGHT"] = "Right"
	L["HORIZONTAL"] = "Horizontal"
	L["VERTICAL"] = "Vertical"
	L["CLOSE_MENU"] = "Close Menu"
	L["ANCHOR"] = "Anchor Point"
	L["ANCHOR_TEXT1"] = "set the anchor point for the %1$s window" -- window name  (bags, bank, vault)
	L["ANCHOR_TEXT2"] = "set the anchor point for the %1$s" -- object name (bars, items)
	L["BORDER_TEXT"] = "border options"
	L["SHOW"] = "Show"
	L["FILE"] = "File"
	L["HEIGHT"] = "Height"
	L["SCALE"] = "Scale"
	L["TEXTURE"] = "Texture"
	L["FONT"] = "Font"
	L["BACKGROUND_COLOUR"] = "Background Colour"
	L["STYLE"] = "Style"
	L["ENABLED"] = "Enabled"
	L["ALERT"] = "Alert"
	L["PADDING"] = "Padding"
	L["INTERNAL"] = "Internal"
	L["EXTERNAL"] = "External"
	L["WIDTH"] = "Width"
	L["REALM"] = "Realm"
	L["VIEW"] = "View"
	L["EDIT"] = "Edit"
	L["DIRECTION"] = "Direction"
	L["ASCENDING"] = "Ascending"
	L["DECENDING"] = "Descending"
	L["LOCATION"] = "Location"
	L["CLEAR"] = "Clear"
	L["DHMS"] = "dhms"
	L["OPEN"] = "Open"
	L["RANDOM"] = "Random"
	L["RELOAD"] = "Reload"
	L["MOVE_UP"] = "Move Up"
	L["MOVE_DOWN"] = "Move Down"
	L["SORT_METHOD"] = "Sort Method"
	L["SORT_BY_NAME"] = "Sort by Name"
	L["SORT_BY_NUMBER"] = "Sort by Number"
	L["HIDE"] = "Hide"
	L["MOVE"] = "Move"
	L["INSERT"] = "Insert"
	L["CURRENT"] = "Current"
	L["OFFSET"] = "Offset"
	L["NUMBER"] = "number"
	L["STRING"] = "string"
	L["COOLDOWN"] = "Cooldown"
	L["FRAMES"] = "Frames"
	L["CLICK_TO_SELECT"] = "Click to select"
	L["CLICK_TO_DESELECT"] = "Click to deselect"
	L["CLICK_TO_IGNORE"] = "Click to ignore"
	L["ORDER"] = "Order"
	L["MOUSEOVER"] = "Mouse Over"
	
	
--	libdatabroker
	L["LDB"] = "LDB"
	L["LDB_BAGS_COLOUR_USE"] = "Use colour"
	L["LDB_BAGS_COLOUR_USE_TEXT"] = "Uses empty slot colours to colour the text"
	L["LDB_BAGS_STYLE"] = "Full display"
	L["LDB_BAGS_STYLE_TEXT"] = "Displays both used and total slot counts"
	L["LDB_BAGS_INCLUDE_TYPE"] = "Bag type"
	L["LDB_BAGS_INCLUDE_TYPE_TEXT"] = "Displays the type of bag in the text"
	L["LDB_TRACKING_CURRENCY"] = "Currencies / Tokens"
	L["LDB_PETS_SUMMON"] = "Summon Pet"
	L["LDB_MOUNTS_NOT_HERE"] = "None of your mounts are usable here"
	L["LDB_MOUNTS_TYPE_L"] = "Land"
	L["LDB_MOUNTS_TYPE_U"] = "Underwater"
	L["LDB_MOUNTS_TYPE_S"] = "Water Surface"
	L["LDB_MOUNTS_FLYING_DISMOUNT"] = "Dismount in flight"
	L["LDB_MOUNTS_FLYING_DISMOUNT_TEXT"] = "Enabled = allows you to dismount while flying.\n\nDisabled = you need to land before you can dismount"
	L["LDB_MOUNTS_FLYING_DISMOUNT_WARNING"] = "You are currently flying, please land to select another mount"
	L["LDB_MOUNTS_SUMMON"] = "Summon Mount"
	L["LDB_MOUNTS_NODATA"] = "Unknown / Changed"
	L["LDB_MOUNTS_TOOLTIP_MODE"] = "Mode"
	L["LDB_MOUNTS_TOOLTIP_SELECTION"] = "Selection"
	L["LDB_COMPANION_MISSING"] = "You seem to have misplaced your selected companion, resetting to random"
	L["LDB_COMPANION_NONE"] = "None available"
	L["LDB_COMPANION_RESTRICTED"] = "%s\n%s\n\nYou may or may not meet the requirements to summon this companion|r"
	L["LDB_COMPANION_RESTRICTED_ZONE"] = "Requires you to be in a specific zone"
	L["LDB_COMPANION_RESTRICTED_ITEM"] = "Requires certain reagents"
	L["LDB_COMPANION_RESTRICTED_EVENT"] = "Requires a specific event to be in progress"
	L["LDB_COMPANION_RESTRICTED_UNKNOWN"] = "Unknown restriction"
	L["LDB_COMPANION_NODATA"] = "No Data"
	L["LDB_COMPANION_NODATA_TEXT"] = "\nNo data for companion %s [%s] was found.\n\nPlease let the author know both of the above values so they can update the code."
	L["LDB_COMPANION_SELECT"] = "\nAdds the %s to the selected pool, limiting the companions that can be randomly summoned.\n\nIf all companions are selected then random mode will become enabled"
	L["LDB_COMPANION_DESELECT"] = "\nRemoves the %s from the selected pool.\n\nIf all companions are deslected then random mode will become enabled"
	L["LDB_COMPANION_IGNORE"] = "\nNever summon the %s in random mode"
