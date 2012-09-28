local L = LibStub( "AceLocale-3.0" ):NewLocale( "ArkInventory", "zhTW" )
if not L then return end

-- post updated translations at http://groups.google.com/group/wow-arkinventory (modify this file and include as an attachment)
-- note: when creating a new locale do not leave any english translations in your file, comment them out by placing -- at the start of the line


-- Translated by: mcc 青楓殘月@水晶之刺
-- Updated 2007/07/15 by 青楓殘月@水晶之刺 using purple's Translation
-- Updated 2007/07/24 by 青楓殘月@水晶之刺
-- Updated 2008/10/27 by eroval
-- Updated 2010/11/23 by 楓之刃@米奈希爾







--	wow zone names - must match exactly what is in game
	L["WOW_ZONE_AHNQIRAJ"] = "安其拉"
	L["WOW_ZONE_VASHJIR"] = "瓦許伊爾"
	L["WOW_ZONE_KELPTHAR_FOREST"] = "凱波薩爾森林"
	L["WOW_ZONE_SHIMMERING_EXPANSE"] = "閃光瀚洋"
	L["WOW_ZONE_ABYSSAL_DEPTHS"] = "地獄深淵"
	
	
--	wow tooltip text - must match exactly what is in game
	L["WOW_ITEM_TOOLTIP_FOOD"] = "進食時必須保持坐姿"
	L["WOW_ITEM_TOOLTIP_DRINK"] = "喝水時必須保持坐姿"
	L["WOW_ITEM_TOOLTIP_POTION_HEAL"] = "恢復%d+至%d+點生命力"
	L["WOW_ITEM_TOOLTIP_POTION_MANA"] = "恢復%d+至%d+點法力"
	L["WOW_ITEM_TOOLTIP_ELIXIR_BATTLE"] = "戰鬥藥劑"
	L["WOW_ITEM_TOOLTIP_ELIXIR_GUARDIAN"] = "守護藥劑"
	
	
--	location names
	L["LOCATION_ALL"] = "全部"
	L["LOCATION_BANK"] = "銀行"
	L["LOCATION_WEARING"] = "裝備"
	
	
--	subframe names
	L["SUBFRAME_NAME_TITLE"] = "隱藏標題"
	L["SUBFRAME_NAME_BAGCHANGER"] = "隱藏背包置換區"
	
	
--	status bar/bag text
	L["STATUS_NO_DATA"] = "無資料"
	L["STATUS_FULL"] = "滿"
	L["STATUS_PURCHASE"] = "買"
	
	
--	restack
	L["RESTACK"] = "壓縮並重新堆疊"
	L["RESTACK_TEXT"] = "重新堆疊物品以減少物品佔用的欄位，特殊背包的欄位將會優先被使用"
	L["RESTACK_FAIL_WAIT"] = "正在重新堆疊，請等候完成"
	L["RESTACK_FAIL_ACCESS"] = "你沒有權限重新堆疊|cffffffff%1$s|r的第|cffffffff%2$s|r個分頁"
	
	
--	vault tooltip text
	L["VAULT_TAB_ACCESS_NONE"] = "無存取權限"
	L["VAULT_TAB_NAME"] = "標籤: |cffffffff%1$s - %2$s|r" -- tab number, tab name
	L["VAULT_TAB_ACCESS"] = "存取權限: |cffffffff%1$s|r"
	L["VAULT_TAB_REMAINING_WITHDRAWALS"] = "剩餘每日提領額度: |cffffffff%1$s|r"
	
	
--	category "header" descriptions  (does not have to match wow)
	L["CATEGORY_RULE"] = "規則"
	
	
--	system category descriptions
	L["CATEGORY_SYSTEM_CORE_MATS"] = "原始材料"
	L["CATEGORY_SYSTEM_EQUIPMENT"] = "裝備 (未綁定)"
	L["CATEGORY_SYSTEM_EQUIPMENT_SOULBOUND"] = "裝備 (已綁定)"
	
	
--	consumable category descriptions
	L["CATEGORY_CONSUMABLE_FOOD_PET"] = "食物 (寵物)"
	L["CATEGORY_CONSUMABLE_POTION_HEAL"] = "治療 (藥水/石)"
	L["CATEGORY_CONSUMABLE_POTION_MANA"] = "法力 (藥水/寶石)"
	L["CATEGORY_CONSUMABLE_ELIXIR_BATTLE"] = "戰鬥藥劑"
	L["CATEGORY_CONSUMABLE_ELIXIR_GUARDIAN"] = "守護藥劑"
	
	
--	bag names - used to name the empty slots in the status frame
	L["STATUS_NAME_BAG"] = "背包"
	L["STATUS_NAME_CRITTER"] = "小動物"
	L["STATUS_NAME_ENCHANTING"] = "附魔"
	L["STATUS_NAME_ENGINEERING"] = "工程"
	L["STATUS_NAME_GEAR"] = "裝備"
	L["STATUS_NAME_GEM"] = "珠寶"
	L["STATUS_NAME_HERB"] = "草藥"
	L["STATUS_NAME_INSCRIPTION"] = "銘文"
	L["STATUS_NAME_KEY"] = "鑰匙"
	L["STATUS_NAME_LEATHERWORKING"] = "製皮"
	L["STATUS_NAME_MAIL"] = "郵件"
	L["STATUS_NAME_MINING"] = "礦石"
	L["STATUS_NAME_MOUNT"] = "坐騎"
--	L["STATUS_NAME_TOKEN"] = ""
--	L["STATUS_NAME_TACKLE"] = ""


--	main menu
	L["MENU"] = "選單"
	
	L["MENU_CHARACTER_SWITCH"] = "切換角色"
	L["MENU_CHARACTER_SWITCH_TEXT"] = "切換顯示其他角色"
	L["MENU_CHARACTER_SWITCH_CHOOSE_NONE"] = "沒有其他角色資料"
	L["MENU_CHARACTER_SWITCH_CHOOSE_TEXT"] = "切換顯示資料為 %1$s"
	L["MENU_CHARACTER_SWITCH_ERASE"] = "清除快取資料"
	L["MENU_CHARACTER_SWITCH_ERASE_TEXT"] = "清除所有 %1$s 的快取資料"
	
	L["MENU_LOCATION_SWITCH"] = "切換位置"
	L["MENU_LOCATION_SWITCH_TEXT"] = "切換 %1$s 視窗顯示"
	
	
--	actions menu
	L["MENU_ACTION"] = "功能"
	L["MENU_ACTION_REFRESH"] = "更新"
	L["MENU_ACTION_REFRESH_TEXT"] = "更新及排序視窗內容"
	L["MENU_ACTION_RELOAD_TEXT"] = "重載視窗，當你使用換裝軟體時使用"
	L["MENU_ACTION_EDITMODE"] = "開啟編輯模式"
	L["MENU_ACTION_EDITMODE_TEXT"] = "切換編輯模式，讓你指定分組及調整樣式"
	L["MENU_ACTION_BAGCHANGER"] = "開啟背包置換"
	L["MENU_ACTION_BAGCHANGER_TEXT"] = "切換顯示背包置換區，以供你替換背包"
	
	
--	item menu
	L["MENU_ITEM_TITLE"] = "物品資訊"
	L["MENU_ITEM_ITEM"] = "物品"
	L["MENU_ITEM_DEFAULT_RESET"] = "重設為預設值"
	L["MENU_ITEM_DEFAULT_RESET_TEXT"] = "重設此物品為預設類別 (不會重設規則)"
	L["MENU_ITEM_ASSIGN_CHOICES"] = "可指定類別"
	L["MENU_ITEM_ASSIGN_THIS"] = "指定類別"
	L["MENU_ITEM_ASSIGN_THIS_TEXT"] = "指定此物品為特定的類別"
	L["MENU_ITEM_RULE_NEW"] = "新增一個規則"
	L["MENU_ITEM_RULE_ADD"] = "加入物品至規則"
	L["MENU_ITEM_CUSTOM_NEW"] = "新增一個自訂類別"
	L["MENU_ITEM_DEBUG"] = "除錯訊息"
	L["MENU_ITEM_DEBUG_BAG"] = "背包"
	L["MENU_ITEM_DEBUG_SLOT"] = "空格"
	L["MENU_ITEM_DEBUG_BAG_TYPE"] = "背包類型"
--	L["MENU_ITEM_DEBUG_PET_ID"] = ""
	L["MENU_ITEM_DEBUG_AI_ID_SHORT"] = "簡短ID"
	L["MENU_ITEM_DEBUG_AI_ID_CACHE"] = "快取ID"
--	L["MENU_ITEM_DEBUG_AI_ID_RULE"] = ""
	L["MENU_ITEM_DEBUG_AI_ID_CATEGORY"] = "AI類別ID"
	L["MENU_ITEM_DEBUG_LVL_ITEM"] = "物品等級 (Stat)"
	L["MENU_ITEM_DEBUG_LVL_USE"] = "使用等級"
	L["MENU_ITEM_DEBUG_TYPE"] = "類型"
	L["MENU_ITEM_DEBUG_SUBTYPE"] = "次要類型"
	L["MENU_ITEM_DEBUG_EQUIP"] = "位置"
	L["MENU_ITEM_DEBUG_ID"] = "暴風雪 ID"
	L["MENU_ITEM_DEBUG_FAMILY"] = "家族"
	L["MENU_ITEM_DEBUG_PT"] = "PT 類別"
	L["MENU_ITEM_DEBUG_PT_TEXT"] = "顯示此物品的 PT 類別"
	L["MENU_ITEM_DEBUG_PT_NONE"] = "此物品不在任何 PT 類別內"
	L["MENU_ITEM_DEBUG_PT_TITLE"] = "此物品的 PT 類別"
	
	
--	bar menu
	L["MENU_BAR_TITLE"] = "分組 %1$s 選項"
	L["MENU_BAR_CATEGORY"] = "類別"
	L["MENU_BAR_CATEGORY_TEXT"] = "指定 %1$s 到此分組"
	L["MENU_BAR_CATEGORY_CURRENT"] = "目前使用"
	L["MENU_BAR_CATEGORY_ASSIGN"] = "可使用類別"
	L["MENU_BAR_CATEGORY_REMOVE_TEXT"] = "自分組 %2$s 中移除 %1$s，並將它放回預設分組" -- 1 is the category name, 2 is the bar number
	L["MENU_BAR_CATEGORY_HIDDEN_TEXT"] = "設定此分組是否為隱藏模式\n\n在隱藏分組內的物品，一般情況下將不會顯示"
--	L["MENU_BAR_CATEGORY_MOVE_START_TEXT"] = ""
--	L["MENU_BAR_CATEGORY_MOVE_COMPLETE_TEXT"] = ""
	L["MENU_BAR_OPTIONS"] = "分組選項"
	L["MENU_BAR_CLEAR_TEXT"] = "移除所有除了預設分類以外指定到此的類別"
	L["MENU_BAR_INSERT_TEXT"] = "插入空白分組，將其他分組往後移"
	L["MENU_BAR_REMOVE_TEXT"] = "移除此分組，此分組內的類別將會被放回預設分組"
--	L["MENU_BAR_MOVE_START_TEXT"] = ""
--	L["MENU_BAR_MOVE_COMPLETE_TEXT"] = ""
--	L["MENU_BAR_SORTKEY_TEXT"] = ""
--	L["MENU_BAR_SORTKEY_DEFAULT_RESET_TEXT"] = ""
	
	
--	changer bag menu
	L["MENU_BAG_TITLE"] = "背包選項"
	L["MENU_BAG_SHOW"] = "顯示"
	L["MENU_BAG_SHOW_TEXT"] = "顯示背包的內容"
	L["MENU_BAG_ISOLATE"] = "獨立"
	L["MENU_BAG_ISOLATE_TEXT"] = "僅顯示此背包的內容"
	L["MENU_BAG_SHOWALL"] = "顯示全部"
	L["MENU_BAG_SHOWALL_TEXT"] = "顯示所有背包的內容"
--	L["MENU_BAG_EMPTY"] = ""
--	L["MENU_BAG_EMPTY_TEXT"] = ""
	
	
--	configuration options
	L["CONFIG"] = "組態"
	L["CONFIG_TEXT"] = "組態選單"
	
--	configuration options > system
	L["CONFIG_SYSTEM"] = "系統"
	L["CONFIG_SYSTEM_TEXT"] = "系統選項"
	
	L["CONFIG_SYSTEM_FONT_TEXT"] = "設定為 %s 的字型"
	
--	L["CONFIG_SYSTEM_FRAMESTRATA"] = ""
--	L["CONFIG_SYSTEM_FRAMESTRATA_TEXT"] = ""
--	L["CONFIG_SYSTEM_FRAMESTRATA_LEVEL_LOW"] = ""
--	L["CONFIG_SYSTEM_FRAMESTRATA_LEVEL_MEDIUM"] = ""
--	L["CONFIG_SYSTEM_FRAMESTRATA_LEVEL_HIGH"] = ""
	
	L["CONFIG_SYSTEM_TOOLTIP"] = "工具提示"
	L["CONFIG_SYSTEM_TOOLTIP_ENABLE_TEXT"] = "設定是否顯示工具提示"
	L["CONFIG_SYSTEM_TOOLTIP_EMPTY_ADD"] = "空行"
	L["CONFIG_SYSTEM_TOOLTIP_EMPTY_ADD_TEXT"] = "在提示框原有文字和自訂文字間顯示空行"
	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_ADD"] = "顯示物品數量"
	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_ADD_TEXT"] = "設定是否在工具提示上顯示物品數量"
	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_COLOUR_TEXT"] = "設定物品數量的文字顏色"
--	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_VAULT_TABS"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_VAULT_TABS_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_SCALE_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_CLASSCOLOUR_TEXT"] = ""
	L["CONFIG_SYSTEM_TOOLTIP_SELF_ONLY"] = "只有目前角色"
	L["CONFIG_SYSTEM_TOOLTIP_SELF_ONLY_TEXT"] = "只顯示目前角色的物品數量"
--	L["CONFIG_SYSTEM_TOOLTIP_FACTION_ONLY"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_FACTION_ONLY_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_VAULT_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_BATTLEPET_SOURCE_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_BATTLEPET_DESCRIPTION_TEXT"] = ""
	
	L["CONFIG_SYSTEM_BUGFIX"] = "除錯/規避錯誤"
	L["CONFIG_SYSTEM_BUGFIX_TEXT"] = "切換除錯或規避錯誤的程式碼"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL"] = "框架層級"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_TEXT"] = "暴風雪的CreateFrame API有個bug會導致框架背景蓋住前景，使物品提示無法顯示，也不能點擊視窗裡的任何東西。"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_TEXT"] = "設定框架層級除錯警告的顯示方式"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE0"] = "不顯示"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE0_TEXT"] = "不顯示除錯警告"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE1"] = "簡短"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE1_TEXT"] = "顯示簡短的除錯警告"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE2"] = "完整"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE2_TEXT"] = "顯示完整的除錯警告"
--	L["CONFIG_SYSTEM_BUGFIX_ZEROSIZEBAG"] = ""
--	L["CONFIG_SYSTEM_BUGFIX_ZEROSIZEBAG_TEXT"] = ""
--	L["CONFIG_SYSTEM_BUGFIX_ZEROSIZEBAG_ALERT_TEXT"] = ""
--	L["BUGFIX_TAINTED_ALERT_MOUSEOVER_TEXT"] = ""
--	L["BUGFIX_TAINTED_ALERT_OPEN_TEXT"] = ""
	
--	L["CONFIG_SYSTEM_MESSAGES"] = ""
--	L["CONFIG_SYSTEM_MESSAGES_TRANSLATION"] = ""
--	L["CONFIG_SYSTEM_MESSAGES_TRANSLATION_INTERIM"] = ""
--	L["CONFIG_SYSTEM_MESSAGES_TRANSLATION_INTERIM_TEXT"] = ""
--	L["CONFIG_SYSTEM_MESSAGES_TRANSLATION_FINAL"] = ""
--	L["CONFIG_SYSTEM_MESSAGES_TRANSLATION_FINAL_TEXT"] = ""
	
	
--	configuration options > auto
	L["CONFIG_AUTO"] = "自動開關"
	
	L["CONFIG_AUTO_OPEN"] = "開啟%1$s %2$s，當你 %3$s"
	L["CONFIG_AUTO_OPEN_BANK"] = "開啟銀行"
	L["CONFIG_AUTO_OPEN_VAULT"] = "開啟公會銀行"
	L["CONFIG_AUTO_OPEN_MAIL"] = "開啟郵箱"
	L["CONFIG_AUTO_OPEN_MERCHANT"] = "開啟商店視窗"
	L["CONFIG_AUTO_OPEN_TRADE"] = "開啟交易視窗"
	L["CONFIG_AUTO_OPEN_AUCTION"] = "開啟拍賣視窗"
	
	L["CONFIG_AUTO_CLOSE"] = "關閉%1$s %2$s，當你 %3$s"
	L["CONFIG_AUTO_CLOSE_BANK"] = "關閉銀行"
	L["CONFIG_AUTO_CLOSE_VAULT"] = "關閉公會銀行"
	L["CONFIG_AUTO_CLOSE_MAIL"] = "關閉郵箱"
	L["CONFIG_AUTO_CLOSE_MERCHANT"] = "關閉商店視窗"
	L["CONFIG_AUTO_CLOSE_TRADE"] = "關閉交易視窗"
	L["CONFIG_AUTO_CLOSE_AUCTION"] = "關閉拍賣視窗"
	L["CONFIG_AUTO_CLOSE_COMBAT"] = "進入戰鬥"
	
	
--	configuration options > control
	L["CONFIG_CONTROL"] = "狀態"
	
	L["CONFIG_CONTROL_MONITOR"] = "監視"
	L["CONFIG_CONTROL_MONITOR_TEXT"] = "切換是否監視角色 (%2$s) 的 %1$s 資料"
	L["CONFIG_CONTROL_SAVE_TEXT"] = "切換是否儲存角色 (%2$s) 的 %1$s 資料，如此一來你可以在使用其他角色時瀏覽 (或是離線)。"
--	L["CONFIG_CONTROL_NOTIFY_ERASE"] = ""
--	L["CONFIG_CONTROL_NOTIFY_ERASE_TEXT"] = ""
	L["CONFIG_CONTROL_OVERRIDE"] = "取代系統框架"
	L["CONFIG_CONTROL_OVERRIDE_TEXT"] = "切換是否隱藏原本的暴風雪 %2$s 框架，如此一來可用 %1$s 取代。\n\n取消此選項將會使用標準暴風雪 %2$s 功能。\n\n當此選項取消，你仍舊可以設定熱鍵開啟 %1$s %2$s。"
	L["CONFIG_CONTROL_ANCHOR_LOCK_TEXT"] = "鎖定 %1$s 框架以避免移動"
--	L["CONFIG_CONTROL_REPOSITION_NOW"] = ""
--	L["CONFIG_CONTROL_REPOSITION_NOW_TEXT"] = ""
--	L["CONFIG_CONTROL_REPOSITION_ONLOAD"] = ""
--	L["CONFIG_CONTROL_REPOSITION_ONLOAD_TEXT"] = ""
	L["CONFIG_CONTROL_SETTINGS_TEXT"] = "選擇當產生%1$s視窗時使用的設定"
	
	
--	configuration options > settings
	L["CONFIG_SETTINGS"] = "設定"
	
	L["CONFIG_SETTINGS_FRAME"] = "視窗"
	
--	L["CONFIG_SETTINGS_FRAME_HIDE_TEXT"] = ""
	
	L["CONFIG_SETTINGS_FRAME_SCALE_TEXT"] = "設定縮放視窗的大小比例"
	L["CONFIG_SETTINGS_FRAME_PADDING_TEXT"] = "設定視窗邊緣至分組的間隔距離"
	L["CONFIG_SETTINGS_FRAME_WIDTH_TEXT"] = "設定一行所能包含的物品欄位數目"
	L["CONFIG_SETTINGS_FRAME_BACKGROUND_COLOUR_TEXT"] = "設定主要視窗的背景顏色"
	L["CONFIG_SETTINGS_FRAME_BORDER_SHOW_TEXT"] = "設定是否顯示主要視窗的邊框"
	L["CONFIG_SETTINGS_FRAME_BORDER_STYLE_TEXT"] = "設定主要視窗的邊框樣式"
	L["CONFIG_SETTINGS_FRAME_BORDER_COLOUR_TEXT"] = "設定主要視窗的邊框顏色"
	
	L["CONFIG_SETTINGS_FRAME_CHANGER_HIGHLIGHT"] = "背包標示顏色"
--	L["CONFIG_SETTINGS_FRAME_CHANGER_HIGHLIGHT_TEXT"] = ""
	L["CONFIG_SETTINGS_FRAME_CHANGER_HIGHLIGHT_COLOUR_TEXT"] = "設定標示滑鼠目前指向的背包的對應欄位顏色"
	L["CONFIG_SETTINGS_FRAME_CHANGER_FREE"] = "顯示數量"
	L["CONFIG_SETTINGS_FRAME_CHANGER_FREE_TEXT"] = "切換是否在背包上顯示空格數量"
	L["CONFIG_SETTINGS_FRAME_CHANGER_FREE_COLOUR_TEXT"] = "設定空格數量文字顏色"
	
--	L["CONFIG_SETTINGS_FRAME_STATUS_EMPTY"] = ""
--	L["CONFIG_SETTINGS_FRAME_STATUS_EMPTY_TEXT"] = ""
	
--	L["CONFIG_SETTINGS_FRAME_TITLE_SIZE_NORMAL"] = ""
--	L["CONFIG_SETTINGS_FRAME_TITLE_SIZE_THIN"] = ""
	
	L["CONFIG_SETTINGS_BARS"] = "分組"
	L["CONFIG_SETTINGS_BARS_PER_ROW"] = "橫向分組數目"
	L["CONFIG_SETTINGS_BARS_PER_ROW_TEXT"] = "設定橫向所能包含的分組數目"
	L["CONFIG_SETTINGS_BARS_BACKGROUND_TEXT"] = "設定分組的背景顏色"
	L["CONFIG_SETTINGS_BARS_COMPACT"] = "簡潔模式"
	L["CONFIG_SETTINGS_BARS_COMPACT_TEXT"] = "以現有順序顯示所有非空白欄位"
	L["CONFIG_SETTINGS_BARS_SHOW_EMPTY"] = "顯示空格"
	L["CONFIG_SETTINGS_BARS_SHOW_EMPTY_TEXT"] = "設定是否顯示空白分組"
	L["CONFIG_SETTINGS_BARS_PADDING_INTERNAL_TEXT"] = "分組內距"
	L["CONFIG_SETTINGS_BARS_PADDING_EXTERNAL_TEXT"] = "分組外距"
	L["CONFIG_SETTINGS_BARS_BORDER_TEXT"] = "設定是否顯示分組邊框"
	L["CONFIG_SETTINGS_BARS_BORDER_STYLE_TEXT"] = "設定邊框樣式"
	L["CONFIG_SETTINGS_BARS_BORDER_COLOUR_TEXT"] = "設定分組的邊框顏色"
	L["CONFIG_SETTINGS_BARS_NAME_TEXT"] = "為此分組設定名稱"
	L["CONFIG_SETTINGS_BARS_NAME_SHOW_TEXT"] = "切換顯示分組名稱"
	L["CONFIG_SETTINGS_BARS_NAME_COLOUR_TEXT"] = "設定分組名稱的邊框顏色"
--	L["CONFIG_SETTINGS_BARS_NAME_HEIGHT_TEXT"] = ""
--	L["CONFIG_SETTINGS_BARS_NAME_ANCHOR_TEXT"] = ""
	
	L["CONFIG_SETTINGS_ITEMS"] = "物品"
	L["CONFIG_SETTINGS_ITEMS_PADDING_TEXT"] = "設定物品欄位的間隔距離"
	L["CONFIG_SETTINGS_ITEMS_HIDDEN"] = "顯示隱藏物品"
	L["CONFIG_SETTINGS_ITEMS_HIDDEN_TEXT"] = "設定是否顯示在隱藏分組內的物品"
	L["CONFIG_SETTINGS_ITEMS_FADE"] = "淡化離線物品"
	L["CONFIG_SETTINGS_ITEMS_FADE_TEXT"] = "設定是否淡化顯示離線物品"
	L["CONFIG_SETTINGS_ITEMS_TINT_USABLE"] = "標示可使用物品"
	L["CONFIG_SETTINGS_ITEMS_TINT_USABLE_TEXT"] = "將可使用物品標示為紅色"
	L["CONFIG_SETTINGS_ITEMS_BORDER_SHOW_TEXT"] = "設定是否顯示物品邊框"
	L["CONFIG_SETTINGS_ITEMS_BORDER_STYLE_TEXT"] = "設定物品的邊框樣式"
	L["CONFIG_SETTINGS_ITEMS_BORDER_RARITY"] = "依品質著色邊框"
	L["CONFIG_SETTINGS_ITEMS_BORDER_RARITY_TEXT"] = "設定是否依品質標示物品邊框顏色 (普通、精良、稀有...)"
--	L["CONFIG_SETTINGS_ITEMS_BORDER_RARITY_CUTOFF"] = ""
--	L["CONFIG_SETTINGS_ITEMS_BORDER_RARITY_CUTOFF_TEXT"] = ""
	L["CONFIG_SETTINGS_ITEMS_BORDER_TEXTURE_OFFSET_TEXT"] = "圖片外緣到邊框內緣的像素數(用來重新對齊邊框和物品材質)"
	L["CONFIG_SETTINGS_ITEMS_AGE"] = "新物品"
	L["CONFIG_SETTINGS_ITEMS_AGE_SHOW_TEXT"] = "顯示新物品文字"
	L["CONFIG_SETTINGS_ITEMS_AGE_COLOUR_TEXT"] = "設定新物品文字顏色"
--	L["CONFIG_SETTINGS_ITEMS_AGE_CUTOFF"] = ""
--	L["CONFIG_SETTINGS_ITEMS_AGE_CUTOFF_TEXT"] = ""
	L["CONFIG_SETTINGS_ITEMS_AGE_RESET_TEXT"] = "清除此角色之所有新物品記錄"
--	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_SHOW_TEXT"] = ""
--	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_GLOBAL"] = ""
--	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_GLOBAL_TEXT"] = ""
--	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_COMBAT"] = ""
--	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_COMBAT_TEXT"] = ""
	
	L["CONFIG_SETTINGS_SORTING_OPEN"] = "視窗開啟時"
	L["CONFIG_SETTINGS_SORTING_OPEN_TEXT"] = "設定是否在視窗開啟時重新排序"
	L["CONFIG_SETTINGS_SORTING_INSTANT"] = "即時"
	L["CONFIG_SETTINGS_SORTING_INSTANT_TEXT"] = "設定是否立即排序\n\n啟用: 有改變則立即排序\n\n停用: 只有在視窗開啟或手動更新時才排序\n\n注意: 如果背包置換區是開啟的, 則會永遠使用立即模式"
	
	L["CONFIG_SETTINGS_EMPTY"] = "空格"
	L["CONFIG_SETTINGS_EMPTY_ICON"] = "使用圖示"
	L["CONFIG_SETTINGS_EMPTY_ICON_TEXT"] = "切換是否使用圖示來表示空白欄位"
	L["CONFIG_SETTINGS_EMPTY_BORDER"] = "邊框著色"
	L["CONFIG_SETTINGS_EMPTY_BORDER_TEXT"] = "切換是否依空白欄位的背包類別來著色邊框"
	L["CONFIG_SETTINGS_EMPTY_COLOUR"] = "空格著色"
	L["CONFIG_SETTINGS_EMPTY_COLOUR_TEXT"] = "設定%1$s的空白欄位邊框和背景顏色"
	L["CONFIG_SETTINGS_EMPTY_CLUMP"] = "整合空格"
	L["CONFIG_SETTINGS_EMPTY_CLUMP_TEXT"] = "設定是否將同背包的空格跟非空格湊在一起，或將不同背包的空格視為一個特殊類別"
--	L["CONFIG_SETTINGS_EMPTY_STATUS"] = ""
	
	
-- sorting
--	L["CONFIG_SORTMETHOD"] = ""
	
	L["CONFIG_SORTMETHOD_SORT"] = "排序"
	
--	L["CONFIG_SORTMETHOD_STYLE_TEXT"] = ""
	L["CONFIG_SORTMETHOD_STYLE_BAGSLOT"] = "依背包/欄位"
	L["CONFIG_SORTMETHOD_STYLE_BAGSLOT_TEXT"] = "依背包/欄位編號排序物品"
	L["CONFIG_SORTMETHOD_STYLE_USER"] = "使用者定義"
	L["CONFIG_SORTMETHOD_STYLE_USER_TEXT"] = "設定排序規則為使用者定義"
	
	L["CONFIG_SORTMETHOD_INCLUDE_NAME"] = "物品名稱"
	L["CONFIG_SORTMETHOD_INCLUDE_NAME_TEXT"] = "設定排序時是否考慮物品名稱"
	L["CONFIG_SORTMETHOD_INCLUDE_NAME_REVERSE"] = "包含反轉名稱"
	L["CONFIG_SORTMETHOD_INCLUDE_NAME_REVERSE_TEXT"] = "設定排序時是否考慮反轉名稱。\n\n例如: 極效法力藥水變成法力藥水極效"
	L["CONFIG_SORTMETHOD_INCLUDE_QUALITY"] = "物品品質"
	L["CONFIG_SORTMETHOD_INCLUDE_QUALITY_TEXT"] = "設定排序時是否考慮物品品質"
	L["CONFIG_SORTMETHOD_INCLUDE_LOCATION"] = "裝備部位"
	L["CONFIG_SORTMETHOD_INCLUDE_LOCATION_TEXT"] = "設定排序時是否考慮物品裝備的部位 (如: 頭、手等)\n\n注意: 只影響可裝備的物品"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMTYPE"] = "物品類型"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMTYPE_TEXT"] = "設定排序時是否考慮物品類型及次類型"
	L["CONFIG_SORTMETHOD_INCLUDE_CATEGORY"] = "物品類別"
	L["CONFIG_SORTMETHOD_INCLUDE_CATEGORY_TEXT"] = "設定排序時是否考慮物品的類別"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMUSELEVEL"] = "物品使用等級"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMUSELEVEL_TEXT"] = "設定排序時是否考慮物品之使用等級"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMSTATLEVEL"] = "物品等級 (stat)"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMSTATLEVEL_TEXT"] = "設定排序時是否考慮物品等級 (stat)"
--	L["CONFIG_SORTMETHOD_INCLUDE_ITEMAGE"] = ""
--	L["CONFIG_SORTMETHOD_INCLUDE_ITEMAGE_TEXT"] = ""
	L["CONFIG_SORTMETHOD_INCLUDE_VENDORPRICE"] = "商店價格"
	L["CONFIG_SORTMETHOD_INCLUDE_VENDORPRICE_TEXT"] = "設定排序時是否考慮物品的商店價格"
	
	L["CONFIG_SORTMETHOD_DIRECTION_TEXT"] = "切換設定排序使用遞增或是遞減排序"
	L["CONFIG_SORTMETHOD_ORDER"] = "排序依據"
	L["CONFIG_SORTMETHOD_MOVE_UP_TEXT"] = "將 %1$s 的優先性在排序規則中向上移動"
	L["CONFIG_SORTMETHOD_MOVE_DOWN_TEXT"] = "將 %1$s 的優先性在排序規則中向下一動"
	L["CONFIG_SORTMETHOD_NOT_INCLUDED"] = "*未使用於目前排序依據*"

--	L["CONFIG_SORTMETHOD_ADD"] = ""
--	L["CONFIG_SORTMETHOD_ADD_TEXT"] = ""
--	L["CONFIG_SORTMETHOD_RENAME_TEXT"] = ""
--	L["CONFIG_SORTMETHOD_DELETE_TEXT"] = ""
	
	
--	rules
	L["CONFIG_RULES"] = "規則"
	L["CONFIG_RULES_SHOWDISABLED"] = "顯示停用規則"
	L["CONFIG_RULES_SHOWDISABLED_TEXT"] = "顯示已經停用的規則"
	
	
--	configuration options > categories
	L["CONFIG_CATEGORY"] = "類別"
	
	L["CONFIG_CATEGORY_CUSTOM"] = "自訂類別"
--	L["CONFIG_CATEGORY_DELETED"] = ""
	
--	L["CONFIG_CATEGORY_ADD"] = ""
--	L["CONFIG_CATEGORY_ADD_TEXT"] = ""
--	L["CONFIG_CATEGORY_RENAME_TEXT"] = ""
--	L["CONFIG_CATEGORY_DELETE_TEXT"] = ""
	
	
--	configuration options > debug
	L["CONFIG_DEBUG"] = "除錯模式"
	L["CONFIG_DEBUG_TEXT"] = "顯示除錯訊息"
	
	
--	configuration options > generic
--	L["BORDER_SCALE_TEXT"] = ""
	L["BORDER_TEXTURE_TEXT"] = "邊框材質選項"
	L["BORDER_TEXTURE_FILE_TEXT"] = "設定邊框材質 (改變此設定將會把縮放比例重置為 100%)"
	L["BORDER_TEXTURE_HEIGHT_TEXT"] = "材質的高度 (以像素為單位)"
	
	
--	rules frame
	L["RULE"] = "規則"
	L["RULE_HIDDEN"] = "隱藏"
	L["RULE_FORMULA"] = "公式"
	L["RULE_LIST_ENABLED"] = "使用"
	L["RULE_LIST_DAMAGED"] = "損壞"
	L["RULE_LIST_ID"] = "規則"
	
	L["RULE_DAMAGED"] = "規則「%s」已標示為損壞，維修前不會再被使用"
	L["RULE_FAILED"] = "錯誤的驗證規則 %s"
	L["RULE_FAILED_KEY_NIL"] = "缺少鍵值"
	L["RULE_FAILED_DATA_NIL"] = "缺少資料"
	L["RULE_FAILED_DESCRIPTION_NIL"] = "缺少描述"
	L["RULE_FAILED_FORMULA_NIL"] = "缺少公式"
	L["RULE_FAILED_FORMULA_BAD"] = "無效的公式"
	L["RULE_FAILED_ARGUMENT_IS_NIL"] = "%1$s( ... ), 參數 %2$i 為零"
	L["RULE_FAILED_ARGUMENT_IS_INVALID"] = "%1$s( ... ), 參數 %2$i 不是 %3$s"
--	L["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"] = ""
	
	
--	new item indicators
--	L["NEW_ITEM_INCREASE"] = ""
--	L["NEW_ITEM_DECREASE"] = ""
	
	
--	slash commands
	L["SLASH_UI"] = "介面"
	L["SLASH_UI_TEXT"] = "介面選項"
	L["SLASH_UI_RESET"] = "重設"
	L["SLASH_UI_RESET_TEXT"] = "將視窗移至螢幕中央"
	L["SLASH_UI_RESET_COMPLETE_TEXT"] = "所有 UI 視窗重置到螢幕中央"
	L["SLASH_DB"] = "資料庫"
	L["SLASH_DB_TEXT"] = "資料庫選項"
	L["SLASH_DB_RESET"] = "重設"
	L["SLASH_DB_RESET_TEXT"] = "重設所有選項為預設值"
	L["SLASH_DB_RESET_CONFIRM"] = "確認"
	L["SLASH_DB_RESET_CONFIRM_TEXT"] = "確認重設資料庫"
	L["SLASH_DB_RESET_COMPLETE_TEXT"] = "設定檔已被重設 所有設定已重設為預設值"
	L["SLASH_CACHE"] = "暫存"
	L["SLASH_CACHE_TEXT"] = "暫存選項"
	L["SLASH_CACHE_ERASE"] = "清除"
	L["SLASH_CACHE_ERASE_TEXT"] = "清除所有暫存資料"
	L["SLASH_CACHE_ERASE_CONFIRM"] = "確認"
	L["SLASH_CACHE_ERASE_CONFIRM_TEXT"] = "確認清除暫存資料"
	L["SLASH_CACHE_ERASE_COMPLETE_TEXT"] = "所有暫存資料已被刪除"
	L["SLASH_MISC"] = "其他"
	L["SLASH_MISC_TEXT"] = "其他選項"
--	L["SLASH_TRACK"] = ""
--	L["SLASH_TRACK_TEXT"] = ""
	
	
--	misc chat stuff
	L["UPGRADE_PROFILE"] = "升級設定檔「%1$s」到%2$df"
	L["UPGRADE_GLOBAL"] = "升級全域資料%1$s至v%2$df"
	L["UPGRADE_CHAR"] = "升級角色資料%1$s至v%2$d"
	
	L["MISC_ALERT"] = "警告！"
	L["MISC_ALERT_FRAMELEVEL_1"] = "除錯完成"
	L["MISC_ALERT_FRAMELEVEL_2"] = "%1$s視窗的框架層級是%2$s，已經被設為%3$s以確保它能正常運作。除錯儀式會吸引雷格大神，抱歉。"
	
	
--	item count tooltip
	L["TOOLTIP_COUNT_ME"] = " > "
--	L["TOOLTIP_VAULT_TABS"] = ""
	
	
--	generic menu text
	L["AUTOMATIC"] = "自動"
	L["BOTTOMLEFT"] = "左下角"
	L["BOTTOMRIGHT"] = "右下角"
	L["TOPLEFT"] = "左上角"
	L["TOPRIGHT"] = "右上角"
	L["TOP"] = "上"
	L["BOTTOM"] = "下"
	L["LEFT"] = "左"
	L["RIGHT"] = "右"
	L["HORIZONTAL"] = "水平"
	L["VERTICAL"] = "垂直"
	L["CLOSE_MENU"] = "關閉選單"
	L["ANCHOR"] = "錨點"
	L["ANCHOR_TEXT1"] = "設定錨點"
	L["ANCHOR_TEXT2"] = "固定 %1$s 在 %2$s"
	L["BORDER_TEXT"] = "邊框選項"
	L["SHOW"] = "顯示"
	L["FILE"] = "檔案"
	L["HEIGHT"] = "高度"
	L["SCALE"] = "縮放"
	L["TEXTURE"] = "材質"
	L["FONT"] = "字型"
	L["BACKGROUND_COLOUR"] = "背景顏色"
	L["STYLE"] = "樣式"
	L["ENABLED"] = "已啟用"
	L["ALERT"] = "警告"
	L["PADDING"] = "間隔"
	L["INTERNAL"] = "內部"
	L["EXTERNAL"] = "外部"
	L["WIDTH"] = "欄位數目"
	L["REALM"] = "伺服器"
	L["VIEW"] = "查看"
	L["EDIT"] = "編輯"
	L["DIRECTION"] = "排列方向"
	L["ASCENDING"] = "遞增"
	L["DECENDING"] = "遞減"
	L["LOCATION"] = "地區"
	L["CLEAR"] = "重置"
	L["DHMS"] = "天時分秒"
	L["OPEN"] = "開啟"
	L["RANDOM"] = "隨機"
	L["RELOAD"] = "重載"
	L["MOVE_UP"] = "向上"
	L["MOVE_DOWN"] = "向下"
	L["SORT_METHOD"] = "排序方式"
	L["SORT_BY_NAME"] = "名稱排序"
	L["SORT_BY_NUMBER"] = "編號排序"
	L["HIDE"] = "隱藏"
	L["MOVE"] = "移動"
	L["INSERT"] = "插入空白分組"
	L["CURRENT"] = "目前指定"
	L["OFFSET"] = "偏移"
	L["NUMBER"] = "編號"
--	L["STRING"] = ""
	L["COOLDOWN"] = "冷卻"
	L["FRAMES"] = "框架"
	L["CLICK_TO_SELECT"] = "單擊選擇"
	L["CLICK_TO_DESELECT"] = "單擊取消選擇"
--	L["CLICK_TO_IGNORE"] = ""
	L["ORDER"] = "順序"
	
	
-- libdatabroker
--	L["LDB"] = ""
	L["LDB_BAGS_COLOUR_USE"] = "使用顏色"
--	L["LDB_BAGS_COLOUR_USE_TEXT"] = ""
	L["LDB_BAGS_STYLE"] = "全部顯示"
--	L["LDB_BAGS_STYLE_TEXT"] = ""
	L["LDB_BAGS_INCLUDE_TYPE"] = "背包類型"
--	L["LDB_BAGS_INCLUDE_TYPE_TEXT"] = ""
	L["LDB_TRACKING_CURRENCY"] = "兌換通貨 / 徽章"
	L["LDB_PETS_SUMMON"] = "召喚寵物"
	L["LDB_MOUNTS_NOT_HERE"] = "不管你的坐騎在這裡是否可用"
--	L["LDB_MOUNTS_GROUND"] = ""
	L["LDB_MOUNTS_FLYING_DISMOUNT"] = "在飛行中卸載"
	L["LDB_MOUNTS_FLYING_DISMOUNT_TEXT"] = "啟用 = 允許你在飛行中下坐騎。\n\n停用 = 你需要在地面上，才可以下坐騎"
	L["LDB_MOUNTS_FLYING_DISMOUNT_WARNING"] = "您目前正在飛行，請選擇一個降落地點"
	L["LDB_MOUNTS_SUMMON"] = "召喚坐騎"
--	L["LDB_MOUNTS_NODATA"] = ""
--	L["LDB_MOUNTS_TOOLTIP_MODE"] = ""
--	L["LDB_MOUNTS_TOOLTIP_SELECTION"] = ""
--	L["LDB_COMPANION_MISSING"] = ""
	L["LDB_COMPANION_NONE"] = "無可用的"
--	L["LDB_COMPANION_RESTRICTED"] = ""
--	L["LDB_COMPANION_RESTRICTED_ZONE"] = ""
--	L["LDB_COMPANION_RESTRICTED_ITEM"] = ""
--	L["LDB_COMPANION_RESTRICTED_EVENT"] = ""
--	L["LDB_COMPANION_RESTRICTED_UNKNOWN"] = ""
	L["LDB_COMPANION_NODATA"] = "無數據"
--	L["LDB_COMPANION_NODATA_TEXT"] = ""
--	L["LDB_COMPANION_SELECT"] = ""
--	L["LDB_COMPANION_DESELECT"] = ""
--	L["LDB_COMPANION_IGNORE"] = ""
