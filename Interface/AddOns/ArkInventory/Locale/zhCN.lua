local L = LibStub( "AceLocale-3.0" ):NewLocale( "ArkInventory", "zhCN" )
if not L then return end

-- post updated translations at http://groups.google.com/group/wow-arkinventory (modify this file and include as an attachment)
-- note: when creating a new locale do not leave any english translations in your file, comment them out by placing -- at the start of the line


-- Translated by: xuxianhe@gmail.com
-- Email: xuxianhe@gmail.com
-- WebSite: http://blog.cwowaddon.com/xuxianhe

-- Translated by: 注册阴阳师@暴风祭坛
-- Email: iiibbbmmm@21cn.com






--	wow zone names - must match exactly what is in game
	L["WOW_ZONE_AHNQIRAJ"] = "安其拉"
	L["WOW_ZONE_VASHJIR"] = "瓦丝琪尔"
	L["WOW_ZONE_KELPTHAR_FOREST"] = "柯尔普萨之森"
	L["WOW_ZONE_SHIMMERING_EXPANSE"] = "烁光海床"
	L["WOW_ZONE_ABYSSAL_DEPTHS"] = "无底海渊"
	
	
--	wow tooltip text - must match exactly what is in game
	L["WOW_ITEM_TOOLTIP_FOOD"] = "进食时必须保持坐姿"
	L["WOW_ITEM_TOOLTIP_DRINK"] = "喝水时必须保持坐姿"
	L["WOW_ITEM_TOOLTIP_POTION_HEAL"] = "恢复%d+到%d+点生命值"
	L["WOW_ITEM_TOOLTIP_POTION_MANA"] = "恢复%d+到%d+点法力值"
	L["WOW_ITEM_TOOLTIP_ELIXIR_BATTLE"] = "战斗药剂"
	L["WOW_ITEM_TOOLTIP_ELIXIR_GUARDIAN"] = "守护药剂"
	
	
--	location names
	L["LOCATION_ALL"] = "全部"
	L["LOCATION_BANK"] = "银行"
	L["LOCATION_WEARING"] = "装备"
	
	
--	subframe names
	L["SUBFRAME_NAME_TITLE"] = "隐藏标题"
	L["SUBFRAME_NAME_BAGCHANGER"] = "隐藏背包置换框架"
	
	
--	status bar/bag text
	L["STATUS_NO_DATA"] = "无资料"
	L["STATUS_FULL"] = "满"
	L["STATUS_PURCHASE"] = "买"
	
	
--	restack
	L["RESTACK"] = "压缩并重新堆栈"
	L["RESTACK_TEXT"] = "重新堆栈物品以减少物品占用的字段，特殊背包的字段将会优先被使用"
	L["RESTACK_FAIL_WAIT"] = "堆叠行动已经在进行, 请等待完成"
	L["RESTACK_FAIL_ACCESS"] = "你没有权限堆叠 %1$s 里的 %2$s 标签 %1$s"
	
	
--	vault tab tooltips
	L["VAULT_TAB_ACCESS_NONE"] = "没有权限"
	L["VAULT_TAB_NAME"] = "标签: |cffffffff%1$s - %2$s|r"
	L["VAULT_TAB_ACCESS"] = "有权限: |cffffffff%1$s|r"
	L["VAULT_TAB_REMAINING_WITHDRAWALS"] = "当天剩余提取次数: |cffffffff%1$s|r"
	
	
--	category "header" descriptions  (does not have to match wow)
	L["CATEGORY_RULE"] = "规则"
	
	
--	system category descriptions
	L["CATEGORY_SYSTEM_CORE_MATS"] = "原始材料"
	L["CATEGORY_SYSTEM_EQUIPMENT"] = "装备 (未绑定)"
	L["CATEGORY_SYSTEM_EQUIPMENT_SOULBOUND"] = "装备"
	
	
--	consumable category descriptions
	L["CATEGORY_CONSUMABLE_FOOD_PET"] = "食物 (宠物)"
	L["CATEGORY_CONSUMABLE_POTION_HEAL"] = "治疗 (药水/石)"
	L["CATEGORY_CONSUMABLE_POTION_MANA"] = "法力 (药水/宝石)"
	L["CATEGORY_CONSUMABLE_ELIXIR_BATTLE"] = "战斗药剂"
	L["CATEGORY_CONSUMABLE_ELIXIR_GUARDIAN"] = "守护药剂"
	
	
--	bag names - used to name the empty slots in the status frame
	L["STATUS_NAME_BAG"] = "背包"
	L["STATUS_NAME_CRITTER"] = "宠物"
	L["STATUS_NAME_ENCHANTING"] = "附魔"
	L["STATUS_NAME_ENGINEERING"] = "工程"
	L["STATUS_NAME_GEAR"] = "装备"
	L["STATUS_NAME_GEM"] = "珠宝"
	L["STATUS_NAME_HERB"] = "草药"
	L["STATUS_NAME_INSCRIPTION"] = "铭文"
	L["STATUS_NAME_KEY"] = "钥匙"
	L["STATUS_NAME_LEATHERWORKING"] = "制皮"
	L["STATUS_NAME_MAIL"] = "邮件"
	L["STATUS_NAME_MINING"] = "矿石"
	L["STATUS_NAME_MOUNT"] = "坐骑"
	L["STATUS_NAME_TOKEN"] = "牌子"
--	L["STATUS_NAME_TACKLE"] = ""
	
	
--	main menu
	L["MENU"] = "选单"
	
	L["MENU_CHARACTER_SWITCH"] = "切换角色"
	L["MENU_CHARACTER_SWITCH_TEXT"] = "切换显示其他角色"
	L["MENU_CHARACTER_SWITCH_CHOOSE_NONE"] = "没有其他角色数据"
	L["MENU_CHARACTER_SWITCH_CHOOSE_TEXT"] = "切换显示数据为 %1$s"
	L["MENU_CHARACTER_SWITCH_ERASE"] = "清除快照资料"
	L["MENU_CHARACTER_SWITCH_ERASE_TEXT"] = "清除所有 %1$s 的快照数据"
	
	L["MENU_LOCATION_SWITCH"] = "功能切换菜单"
	L["MENU_LOCATION_SWITCH_TEXT"] = "切换到 %1$s 窗口"
	
	
--	actions menu
	L["MENU_ACTION"] = "动作设置"
	L["MENU_ACTION_REFRESH"] = "更新"
	L["MENU_ACTION_REFRESH_TEXT"] = "更新及排序窗口内容"
	L["MENU_ACTION_RELOAD_TEXT"] = "重载窗口，当你使用换装软件时使用"
	L["MENU_ACTION_EDITMODE"] = "开启编辑模式"
	L["MENU_ACTION_EDITMODE_TEXT"] = "切换编辑模式，让你指定分组及调整样式"
	L["MENU_ACTION_BAGCHANGER"] = "开启背包置换"
	L["MENU_ACTION_BAGCHANGER_TEXT"] = "切换显示背包置换区，以供你替换背包"
	
	
--	item menu
	L["MENU_ITEM_TITLE"] = "物品信息"
	L["MENU_ITEM_ITEM"] = "物品"
	L["MENU_ITEM_DEFAULT_RESET"] = "重置为默认"
	L["MENU_ITEM_DEFAULT_RESET_TEXT"] = "点击来重置此物品, 让它回到默认的分类(不重置规则)"
	L["MENU_ITEM_ASSIGN_CHOICES"] = "可归入的种类"
	L["MENU_ITEM_ASSIGN_THIS"] = "归入种类"
	L["MENU_ITEM_ASSIGN_THIS_TEXT"] = "将此物品归入指定分类"
	L["MENU_ITEM_RULE_NEW"] = "创建新规则"
	L["MENU_ITEM_RULE_ADD"] = "增加物品至规则"
	L["MENU_ITEM_CUSTOM_NEW"] = "建立一个新的分类"
	L["MENU_ITEM_DEBUG"] = "Debug 信息"
	L["MENU_ITEM_DEBUG_BAG"] = "背包"
	L["MENU_ITEM_DEBUG_SLOT"] = "包格"
	L["MENU_ITEM_DEBUG_BAG_TYPE"] = "背包类别"
--	L["MENU_ITEM_DEBUG_PET_ID"] = ""
	L["MENU_ITEM_DEBUG_AI_ID_SHORT"] = "短ID"
	L["MENU_ITEM_DEBUG_AI_ID_CACHE"] = "缓存ID"
	L["MENU_ITEM_DEBUG_AI_ID_RULE"] = "规则ID"
	L["MENU_ITEM_DEBUG_AI_ID_CATEGORY"] = "AI 类别"
	L["MENU_ITEM_DEBUG_LVL_ITEM"] = "物品等级 (属性等级)"
	L["MENU_ITEM_DEBUG_LVL_USE"] = "物品等级 (使用等级)"
	L["MENU_ITEM_DEBUG_TYPE"] = "类别"
	L["MENU_ITEM_DEBUG_SUBTYPE"] = "子类别"
	L["MENU_ITEM_DEBUG_EQUIP"] = "位置"
	L["MENU_ITEM_DEBUG_ID"] = "ID"
	L["MENU_ITEM_DEBUG_FAMILY"] = "族（Family）"
	L["MENU_ITEM_DEBUG_PT"] = "PT 设置"
	L["MENU_ITEM_DEBUG_PT_TEXT"] = "列出此物品所设置的 PT 类别"
	L["MENU_ITEM_DEBUG_PT_NONE"] = "此物品当前没有设置任何 PT 类别"
	L["MENU_ITEM_DEBUG_PT_TITLE"] = "设置此物品的 PT 类别"
	
	
--	bar menu
	L["MENU_BAR_TITLE"] = "分组 %1$s 选项"
	L["MENU_BAR_CATEGORY"] = "类别"
	L["MENU_BAR_CATEGORY_TEXT"] = "指定 %1$s 到此分组"
	L["MENU_BAR_CATEGORY_CURRENT"] = "目前使用"
	L["MENU_BAR_CATEGORY_ASSIGN"] = "可使用类别"
	L["MENU_BAR_CATEGORY_REMOVE_TEXT"] = "自分组 %2$s 中移除 %1$s，并将它放回预设分组" -- 1 is the category name, 2 is the bar number
	L["MENU_BAR_CATEGORY_HIDDEN_TEXT"] = "设定此分组是否为隐藏模式\n\n在隐藏分组内的物品，一般情况下将不会显示"
--	L["MENU_BAR_CATEGORY_MOVE_START_TEXT"] = ""
--	L["MENU_BAR_CATEGORY_MOVE_COMPLETE_TEXT"] = ""
	L["MENU_BAR_OPTIONS"] = "分组选项"
	L["MENU_BAR_CLEAR_TEXT"] = "移除所有除了预设分类以外指定到此的类别"
	L["MENU_BAR_INSERT_TEXT"] = "插入空白分组，将其他分组往后移"
	L["MENU_BAR_REMOVE_TEXT"] = "移除此分组，此分组内的类别将会被放回预设分组"
--	L["MENU_BAR_MOVE_START_TEXT"] = ""
--	L["MENU_BAR_MOVE_COMPLETE_TEXT"] = ""
--	L["MENU_BAR_SORTKEY_TEXT"] = ""
--	L["MENU_BAR_SORTKEY_DEFAULT_RESET_TEXT"] = ""
	
	
--	changer bag menu
	L["MENU_BAG_TITLE"] = "背包设置"
	L["MENU_BAG_SHOW"] = "显示"
	L["MENU_BAG_SHOW_TEXT"] = "显示此背包容那物"
	L["MENU_BAG_ISOLATE"] = "隔离"
	L["MENU_BAG_ISOLATE_TEXT"] = "只显示此背包容纳物"
	L["MENU_BAG_SHOWALL"] = "显示所有"
	L["MENU_BAG_SHOWALL_TEXT"] = "显示此位置所有背包容纳物"
--	L["MENU_BAG_EMPTY"] = ""
--	L["MENU_BAG_EMPTY_TEXT"] = ""
	
	
--	configuration options
	L["CONFIG"] = "设置"
	L["CONFIG_TEXT"] = "设置菜单"
	
--	configuration options > system
	L["CONFIG_SYSTEM"] = "系统"
	L["CONFIG_SYSTEM_TEXT"] = "系统选项"
	
	L["CONFIG_SYSTEM_FONT_TEXT"] = "设置 %s 的字体"
	
--	L["CONFIG_SYSTEM_FRAMESTRATA"] = ""
--	L["CONFIG_SYSTEM_FRAMESTRATA_TEXT"] = ""
--	L["CONFIG_SYSTEM_FRAMESTRATA_LEVEL_LOW"] = ""
--	L["CONFIG_SYSTEM_FRAMESTRATA_LEVEL_MEDIUM"] = ""
--	L["CONFIG_SYSTEM_FRAMESTRATA_LEVEL_HIGH"] = ""
	
	L["CONFIG_SYSTEM_TOOLTIP"] = "提示"
	L["CONFIG_SYSTEM_TOOLTIP_ENABLE_TEXT"] = "是否使用提示"
	L["CONFIG_SYSTEM_TOOLTIP_EMPTY_ADD"] = "空行"
	L["CONFIG_SYSTEM_TOOLTIP_EMPTY_ADD_TEXT"] = "是否在基础提示文字和自定义文字之间显示一个空行"
	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_ADD"] = "显示物品数量"
	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_ADD_TEXT"] = "设定提示中是否显示物品数量"
	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_COLOUR_TEXT"] = "设定物品数量文字颜色"
--	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_VAULT_TABS"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_VAULT_TABS_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_SCALE_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_CLASSCOLOUR_TEXT"] = ""
	L["CONFIG_SYSTEM_TOOLTIP_SELF_ONLY"] = "当前角色"
	L["CONFIG_SYSTEM_TOOLTIP_SELF_ONLY_TEXT"] = "只显示当前角色的物品计数"
--	L["CONFIG_SYSTEM_TOOLTIP_FACTION_ONLY"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_FACTION_ONLY_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_VAULT_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_BATTLEPET_SOURCE_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_BATTLEPET_DESCRIPTION_TEXT"] = ""
	
	L["CONFIG_SYSTEM_BUGFIX"] = "错误修正/绕开"
	L["CONFIG_SYSTEM_BUGFIX_TEXT"] = "切换代码修正或者绕开这个问题"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL"] = "框架级别"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_TEXT"] = "一个出自暴雪CreateFrame API的错误, 有可能引致框架背景在前景上出现的情况, 物品提示不会出现, 而且也不可能点击那个窗口里的任何东西."
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_TEXT"] = "改变错误修正警告的显示方式"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE0"] = "禁用"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE0_TEXT"] = "禁用错误修正警告"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE1"] = "短"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE1_TEXT"] = "以简短模式显示错误修正警告"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE2"] = "长"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE2_TEXT"] = "以详细模式显示错误修正警告"
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
	L["CONFIG_AUTO"] = "自动开关"
	
	L["CONFIG_AUTO_OPEN"] = " %1$s %2$s 将被开启, 当你..."
	L["CONFIG_AUTO_OPEN_BANK"] = "开启银行"
	L["CONFIG_AUTO_OPEN_VAULT"] = "开启公会银行"
	L["CONFIG_AUTO_OPEN_MAIL"] = "开启邮箱"
	L["CONFIG_AUTO_OPEN_MERCHANT"] = "开启一个商人/商店"
	L["CONFIG_AUTO_OPEN_TRADE"] = "开启一个交易"
	L["CONFIG_AUTO_OPEN_AUCTION"] = "开启拍卖行"
	
	L["CONFIG_AUTO_CLOSE"] = "%1$s %2$s 将被关闭, 当你..."
	L["CONFIG_AUTO_CLOSE_BANK"] = "关闭银行"
	L["CONFIG_AUTO_CLOSE_VAULT"] = "关闭公会银行"
	L["CONFIG_AUTO_CLOSE_MAIL"] = "关闭邮箱"
	L["CONFIG_AUTO_CLOSE_MERCHANT"] = "关闭商人/商店"
	L["CONFIG_AUTO_CLOSE_TRADE"] = "关闭交易"
	L["CONFIG_AUTO_CLOSE_AUCTION"] = "关闭拍卖行"
	L["CONFIG_AUTO_CLOSE_COMBAT"] = "进入战斗"
	
	
--	configuration options > control
	L["CONFIG_CONTROL"] = "控制"
	
	L["CONFIG_CONTROL_MONITOR"] = "监控"
	L["CONFIG_CONTROL_MONITOR_TEXT"] = "为此角色(%2$s)对 %1$s 数据建立监控."
	L["CONFIG_CONTROL_SAVE_TEXT"] = "记录 %1$s 的数据为 (%2$s) 角色， 使你可以在使用其他角色 (或离线！？)的时候进行查看."
--	L["CONFIG_CONTROL_NOTIFY_ERASE"] = ""
--	L["CONFIG_CONTROL_NOTIFY_ERASE_TEXT"] = ""
	L["CONFIG_CONTROL_OVERRIDE"] = "取代系统框架"
	L["CONFIG_CONTROL_OVERRIDE_TEXT"] = "设定是否取代系统内建背包及银行\n\n停用此项功能的话，你只能在按键设定中设定，才能开启 %1$s"
	L["CONFIG_CONTROL_ANCHOR_LOCK_TEXT"] = "锁定 %1$s 窗口到当前移动的位置"
--	L["CONFIG_CONTROL_REPOSITION_NOW"] = ""
--	L["CONFIG_CONTROL_REPOSITION_NOW_TEXT"] = ""
--	L["CONFIG_CONTROL_REPOSITION_ONLOAD"] = ""
--	L["CONFIG_CONTROL_REPOSITION_ONLOAD_TEXT"] = ""
	L["CONFIG_CONTROL_SETTINGS_TEXT"] = "在此窗口应用 %1$s 的设置"
	
	
--	configuration options > settings
	L["CONFIG_SETTINGS"] = "设置"
	
	L["CONFIG_SETTINGS_FRAME"] = "窗口"
	
--	L["CONFIG_SETTINGS_FRAME_HIDE_TEXT"] = ""
	
	L["CONFIG_SETTINGS_FRAME_SCALE_TEXT"] = "设定缩放窗口的大小比例"
	L["CONFIG_SETTINGS_FRAME_PADDING_TEXT"] = "设定窗口边缘至分组的间隔距离"
	L["CONFIG_SETTINGS_FRAME_WIDTH_TEXT"] = "设定一行所能包含的物品格子数目"
	L["CONFIG_SETTINGS_FRAME_BACKGROUND_COLOUR_TEXT"] = "设定主要窗口的背景颜色"
	L["CONFIG_SETTINGS_FRAME_BORDER_SHOW_TEXT"] = "设定主窗口边框是否显示"
	L["CONFIG_SETTINGS_FRAME_BORDER_STYLE_TEXT"] = "设定主窗口边框的风格"
	L["CONFIG_SETTINGS_FRAME_BORDER_COLOUR_TEXT"] = "设定主要窗口的边框颜色"
	
	L["CONFIG_SETTINGS_FRAME_CHANGER_HIGHLIGHT"] = "背包标示颜色"
--	L["CONFIG_SETTINGS_FRAME_CHANGER_HIGHLIGHT_TEXT"] = ""
	L["CONFIG_SETTINGS_FRAME_CHANGER_HIGHLIGHT_COLOUR_TEXT"] = "设定标示鼠标目前指向的背包的对应格子颜色"
	L["CONFIG_SETTINGS_FRAME_CHANGER_FREE"] = "显示数量"
	L["CONFIG_SETTINGS_FRAME_CHANGER_FREE_TEXT"] = "是否显示空格数量"
	L["CONFIG_SETTINGS_FRAME_CHANGER_FREE_COLOUR_TEXT"] = "设置空格数量文本颜色"
	
--	L["CONFIG_SETTINGS_FRAME_STATUS_EMPTY"] = ""
--	L["CONFIG_SETTINGS_FRAME_STATUS_EMPTY_TEXT"] = ""
	
--	L["CONFIG_SETTINGS_FRAME_TITLE_SIZE_NORMAL"] = ""
--	L["CONFIG_SETTINGS_FRAME_TITLE_SIZE_THIN"] = ""
	
	L["CONFIG_SETTINGS_BARS"] = "分组"
	L["CONFIG_SETTINGS_BARS_PER_ROW"] = "横向分组数目"
	L["CONFIG_SETTINGS_BARS_PER_ROW_TEXT"] = "设定横向所能包含的分组数目"
	L["CONFIG_SETTINGS_BARS_BACKGROUND_TEXT"] = "设定分组的背景颜色"
	L["CONFIG_SETTINGS_BARS_COMPACT"] = "简洁模式"
	L["CONFIG_SETTINGS_BARS_COMPACT_TEXT"] = "以现有顺序显示所有非空格子"
	L["CONFIG_SETTINGS_BARS_SHOW_EMPTY"] = "显示空格"
	L["CONFIG_SETTINGS_BARS_SHOW_EMPTY_TEXT"] = "设定是否显示空白分组"
	L["CONFIG_SETTINGS_BARS_PADDING_INTERNAL_TEXT"] = "分组和物品之间的距离"
	L["CONFIG_SETTINGS_BARS_PADDING_EXTERNAL_TEXT"] = "分组之间的距离"
	L["CONFIG_SETTINGS_BARS_BORDER_TEXT"] = "设定是否显示分组边框"
	L["CONFIG_SETTINGS_BARS_BORDER_STYLE_TEXT"] = "设定分组边框的风格"
	L["CONFIG_SETTINGS_BARS_BORDER_COLOUR_TEXT"] = "设定分组的边框颜色"
	L["CONFIG_SETTINGS_BARS_NAME_TEXT"] = "分组名称设置"
	L["CONFIG_SETTINGS_BARS_NAME_SHOW_TEXT"] = "是否显示分组名称"
	L["CONFIG_SETTINGS_BARS_NAME_COLOUR_TEXT"] = "分组外框颜色设置"
--	L["CONFIG_SETTINGS_BARS_NAME_HEIGHT_TEXT"] = ""
--	L["CONFIG_SETTINGS_BARS_NAME_ANCHOR_TEXT"] = ""
	
	L["CONFIG_SETTINGS_ITEMS"] = "物品"
	L["CONFIG_SETTINGS_ITEMS_PADDING_TEXT"] = "设定物品格子的间隔距离"
	L["CONFIG_SETTINGS_ITEMS_HIDDEN"] = "显示隐藏物品"
	L["CONFIG_SETTINGS_ITEMS_HIDDEN_TEXT"] = "设定是否显示在隐藏分组内的物品"
	L["CONFIG_SETTINGS_ITEMS_FADE"] = "淡化脱机物品"
	L["CONFIG_SETTINGS_ITEMS_FADE_TEXT"] = "设定是否淡化显示脱机物品"
	L["CONFIG_SETTINGS_ITEMS_TINT_USABLE"] = "着色无效物品"
	L["CONFIG_SETTINGS_ITEMS_TINT_USABLE_TEXT"] = "给不能使用的物品蒙上红色"
	L["CONFIG_SETTINGS_ITEMS_BORDER_SHOW_TEXT"] = "设置物品边框是否显示"
	L["CONFIG_SETTINGS_ITEMS_BORDER_STYLE_TEXT"] = "设置物品边框的风格"
	L["CONFIG_SETTINGS_ITEMS_BORDER_RARITY"] = "稀有物品边框着色"
	L["CONFIG_SETTINGS_ITEMS_BORDER_RARITY_TEXT"] = "物品边框是否按照稀有度进行着色"
--	L["CONFIG_SETTINGS_ITEMS_BORDER_RARITY_CUTOFF"] = ""
--	L["CONFIG_SETTINGS_ITEMS_BORDER_RARITY_CUTOFF_TEXT"] = ""
	L["CONFIG_SETTINGS_ITEMS_BORDER_TEXTURE_OFFSET_TEXT"] = "设置物品边框平滑度采用的像素数量 (用于与物品材质融合)"
	L["CONFIG_SETTINGS_ITEMS_AGE"] = "新物品"
	L["CONFIG_SETTINGS_ITEMS_AGE_SHOW_TEXT"] = "显示新物品文字"
	L["CONFIG_SETTINGS_ITEMS_AGE_COLOUR_TEXT"] = "设定新物品文字颜色"
--	L["CONFIG_SETTINGS_ITEMS_AGE_CUTOFF"] = ""
--	L["CONFIG_SETTINGS_ITEMS_AGE_CUTOFF_TEXT"] = ""
	L["CONFIG_SETTINGS_ITEMS_AGE_RESET_TEXT"] = "清除此角色之所有新物品记录"
--	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_SHOW_TEXT"] = ""
--	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_GLOBAL"] = ""
--	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_GLOBAL_TEXT"] = ""
--	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_COMBAT"] = ""
--	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_COMBAT_TEXT"] = ""
	
	L["CONFIG_SETTINGS_SORTING_OPEN"] = "当窗口打开时"
	L["CONFIG_SETTINGS_SORTING_OPEN_TEXT"] = "当窗口打开时是否采用"
	L["CONFIG_SETTINGS_SORTING_INSTANT"] = "实时"
	L["CONFIG_SETTINGS_SORTING_INSTANT_TEXT"] = "设定是否立即排序\n\n启用: 有改变则立即排序\n\n停用: 只有在窗口开启或手动更新时才排序\n\n注意: 如果背包置换区是开启的, 则会永远使用立即模式"
	
	L["CONFIG_SETTINGS_EMPTY"] = "空格"
	L["CONFIG_SETTINGS_EMPTY_ICON"] = "使用图示"
	L["CONFIG_SETTINGS_EMPTY_ICON_TEXT"] = "切换是否使用图示来表示空格子"
	L["CONFIG_SETTINGS_EMPTY_CLUMP"] = "整合空格"
	L["CONFIG_SETTINGS_EMPTY_CLUMP_TEXT"] = "设定是否将同背包的空格跟非空格凑在一起，或将不同背包的空格视为一个特殊类别"
	L["CONFIG_SETTINGS_EMPTY_BORDER"] = "边框着色"
	L["CONFIG_SETTINGS_EMPTY_BORDER_TEXT"] = "切换是否依空格子的背包类别来着色边框"
	L["CONFIG_SETTINGS_EMPTY_COLOUR"] = "空格着色"
	L["CONFIG_SETTINGS_EMPTY_COLOUR_TEXT"] = "设定空 %1$s 格子的边框和背景颜色"
--	L["CONFIG_SETTINGS_EMPTY_STATUS"] = "display format"
	
	
-- sorting
--	L["CONFIG_SORTMETHOD"] = ""
	
	L["CONFIG_SORTMETHOD_SORT"] = "排序"
	
--	L["CONFIG_SORTMETHOD_STYLE_TEXT"] = ""
	L["CONFIG_SORTMETHOD_STYLE_BAGSLOT"] = "依背包/格子"
	L["CONFIG_SORTMETHOD_STYLE_BAGSLOT_TEXT"] = "依背包/格子编号排序物品"
	L["CONFIG_SORTMETHOD_STYLE_USER"] = "自定义"
	L["CONFIG_SORTMETHOD_STYLE_USER_TEXT"] = "排列物品时是否包含自定义排列"
	
	L["CONFIG_SORTMETHOD_INCLUDE_NAME"] = "物品名称"
	L["CONFIG_SORTMETHOD_INCLUDE_NAME_TEXT"] = "排列物品时是否包含物品名称"
	L["CONFIG_SORTMETHOD_INCLUDE_NAME_REVERSE"] = "包括反转(!?)的名称"
	L["CONFIG_SORTMETHOD_INCLUDE_NAME_REVERSE_TEXT"] = "是否包括反转名称开关.\n\n例如超级法力合剂 -> 法力超级合剂"
	L["CONFIG_SORTMETHOD_INCLUDE_QUALITY"] = "包括物品稀有度"
	L["CONFIG_SORTMETHOD_INCLUDE_QUALITY_TEXT"] = "排列物品时是否包含物品稀有度"
	L["CONFIG_SORTMETHOD_INCLUDE_LOCATION"] = "包括物品装备位置"
	L["CONFIG_SORTMETHOD_INCLUDE_LOCATION_TEXT"] = "排列物品时是否包含物品装备位置.\n\n注：只影响可以装备的物品"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMTYPE"] = "物品类型和子类型"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMTYPE_TEXT"] = "排列物品时是否包含物品类型和子类型."
	L["CONFIG_SORTMETHOD_INCLUDE_CATEGORY"] = "包括物品分类"
	L["CONFIG_SORTMETHOD_INCLUDE_CATEGORY_TEXT"] = "排列物品时是否包含物品分类"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMUSELEVEL"] = "物品（需要）等级"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMUSELEVEL_TEXT"] = "排列物品时是否包含物品（需要）等级."
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMSTATLEVEL"] = "物品 (本身) 等级"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMSTATLEVEL_TEXT"] = "排列物品时是否包含物品 (本身) 等级."
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMAGE"] = "物品时间"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMAGE_TEXT"] = "排列物品时是否包含物品时间."
	L["CONFIG_SORTMETHOD_INCLUDE_VENDORPRICE"] = "商店价格"
	L["CONFIG_SORTMETHOD_INCLUDE_VENDORPRICE_TEXT"] = "排列物品时是否参考商店价格（当前堆叠数量价格）."
	
	L["CONFIG_SORTMETHOD_DIRECTION_TEXT"] = "设置物品升序、降序排列"
	L["CONFIG_SORTMETHOD_ORDER"] = "分类排序"
	L["CONFIG_SORTMETHOD_MOVE_UP_TEXT"] = "将 %1$s 在分类排序中上移"
	L["CONFIG_SORTMETHOD_MOVE_DOWN_TEXT"] = "将 %1$s 在分类排序中下移"
	L["CONFIG_SORTMETHOD_NOT_INCLUDED"] = "* 没有包含到当前排序 *"
	
--	L["CONFIG_SORTMETHOD_ADD"] = ""
--	L["CONFIG_SORTMETHOD_ADD_TEXT"] = ""
--	L["CONFIG_SORTMETHOD_RENAME_TEXT"] = ""
--	L["CONFIG_SORTMETHOD_DELETE_TEXT"] = ""
	
	
--	rules
	L["CONFIG_RULES"] = "规则"
	L["CONFIG_RULES_SHOWDISABLED"] = "显示禁用的规则"
	L["CONFIG_RULES_SHOWDISABLED_TEXT"] = "禁用规则显示开关"
	
	
--	configuration options > categories
	L["CONFIG_CATEGORY"] = "分类"
	
	L["CONFIG_CATEGORY_CUSTOM"] = "自定义分类"
--	L["CONFIG_CATEGORY_DELETED"] = ""
	
--	L["CONFIG_CATEGORY_ADD"] = ""
--	L["CONFIG_CATEGORY_ADD_TEXT"] = ""
--	L["CONFIG_CATEGORY_RENAME_TEXT"] = ""
--	L["CONFIG_CATEGORY_DELETE_TEXT"] = ""
	
	
--	configuration options > debug
	L["CONFIG_DEBUG"] = "Debug 模式"
	L["CONFIG_DEBUG_TEXT"] = "Debug 模式开关"
	
	
--	configuration options > generic
--	L["BORDER_SCALE_TEXT"] = ""
	L["BORDER_TEXTURE_TEXT"] = "物品材质选项"
	L["BORDER_TEXTURE_FILE_TEXT"] = "用于边框的材质 (改变此设置重置缩放比例为 100%)"
	L["BORDER_TEXTURE_HEIGHT_TEXT"] = "材质高度 (像素) "
	
	
--	rules frame
	L["RULE"] = "规则"
	L["RULE_HIDDEN"] = "隐藏"
	L["RULE_FORMULA"] = "公式"
	L["RULE_LIST_ENABLED"] = "使用"
	L["RULE_LIST_DAMAGED"] = "损坏"
	L["RULE_LIST_ID"] = "规则"
	
	L["RULE_DAMAGED"] = "当期规则设置 %s 为损坏的，除非修理不能使用"
--	L["RULE_FAILED"] = ""
	L["RULE_FAILED_KEY_NIL"] = "旧的关键字为空"
	L["RULE_FAILED_DATA_NIL"] = "旧数据为空"
	L["RULE_FAILED_DESCRIPTION_NIL"] = "无法找到描述信息"
	L["RULE_FAILED_FORMULA_NIL"] = "无法找到格式"
--	L["RULE_FAILED_FORMULA_BAD"] = ""
--	L["RULE_FAILED_ARGUMENT_IS_NIL"] = ""
--	L["RULE_FAILED_ARGUMENT_IS_INVALID"] = ""
--	L["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"] = ""
	
	
--	new item indicators
	L["NEW_ITEM_INCREASE"] = "增"
	L["NEW_ITEM_DECREASE"] = "减"
	
	
--	slash commands
	L["SLASH_UI"] = "UI"
	L["SLASH_UI_TEXT"] = "UI 设置"
	L["SLASH_UI_RESET"] = "重置"
	L["SLASH_UI_RESET_TEXT"] = "将界面重置到屏幕中心"
	L["SLASH_UI_RESET_COMPLETE_TEXT"] = "所有 UI 窗口将重置到屏幕中心"
	L["SLASH_DB"] = "数据"
	L["SLASH_DB_TEXT"] = "数据设置"
	L["SLASH_DB_RESET"] = "重置"
	L["SLASH_DB_RESET_TEXT"] = "重置所有设置为默认设置 - defaults "
	L["SLASH_DB_RESET_CONFIRM"] = "确认"
	L["SLASH_DB_RESET_CONFIRM_TEXT"] = "确认数据重置"
	L["SLASH_DB_RESET_COMPLETE_TEXT"] = "配置已重置，所有设置已设为默认 - defaults "
	L["SLASH_CACHE"] = "缓存"
	L["SLASH_CACHE_TEXT"] = "缓存设置"
	L["SLASH_CACHE_ERASE"] = "清除"
	L["SLASH_CACHE_ERASE_TEXT"] = "清除所有缓存数据"
	L["SLASH_CACHE_ERASE_CONFIRM"] = "确认"
	L["SLASH_CACHE_ERASE_CONFIRM_TEXT"] = "确认清除缓存数据"
	L["SLASH_CACHE_ERASE_COMPLETE_TEXT"] = "所有缓存数据清除！"
	L["SLASH_MISC"] = "杂类"
	L["SLASH_MISC_TEXT"] = "杂类选项"
--	L["SLASH_TRACK"] = ""
--	L["SLASH_TRACK_TEXT"] = ""
	
	
--	misc chat stuff
	L["UPGRADE_PROFILE"] = "更新配置文件 %1$s 到 %2$d"
	L["UPGRADE_GLOBAL"] = "更新全局配置文件 %1$s 到 v%2$d"
--	L["UPGRADE_CHAR"] = ""
	
	L["MISC_ALERT"] = "警告!"
	L["MISC_ALERT_FRAMELEVEL_1"] = "Bug 修正完毕."
	L["MISC_ALERT_FRAMELEVEL_2"] = "当前 %1$s 窗口界面级别在 %2$s 并且被重置到 %3$s 以确保回收模式.  由于此 bug 修正带来的 lag 现象向您道歉."
	
	
--	item count tooltip
	L["TOOLTIP_COUNT_ME"] = ">"
--	L["TOOLTIP_VAULT_TABS"] = ""
	
	
--	generic text
--	L["AUTOMATIC"] = ""
	L["BOTTOMLEFT"] = "左下角"
	L["BOTTOMRIGHT"] = "右下角"
	L["TOPLEFT"] = "左上角"
	L["TOPRIGHT"] = "右上角"
--	L["TOP"] = ""
--	L["BOTTOM"] = ""
--	L["LEFT"] = ""
--	L["RIGHT"] = ""
	L["HORIZONTAL"] = "水平"
	L["VERTICAL"] = "垂直"
	L["CLOSE_MENU"] = "关闭选单"
	L["ANCHOR"] = "锚点"
	L["ANCHOR_TEXT1"] = "设置锚点"
	L["ANCHOR_TEXT2"] = "将 %1$s 的锚点设置在 %2$s"
	L["BORDER_TEXT"] = "边框设置"
	L["SHOW"] = "显示"
	L["FILE"] = "文件"
	L["HEIGHT"] = "高"
	L["SCALE"] = "缩放"
	L["TEXTURE"] = "材质"
	L["FONT"] = "字体"
	L["BACKGROUND_COLOUR"] = "背景颜色"
	L["STYLE"] = "风格"
	L["ENABLED"] = "启用"
	L["ALERT"] = "警报"
	L["PADDING"] = "间隔"
	L["INTERNAL"] = "内部"
	L["EXTERNAL"] = "外部"
	L["WIDTH"] = "格子数目"
	L["REALM"] = "范围"
	L["VIEW"] = "查看"
	L["EDIT"] = "编辑"
	L["DIRECTION"] = "排列方向"
	L["ASCENDING"] = "升序"
	L["DECENDING"] = "降序"
	L["LOCATION"] = "位置"
	L["CLEAR"] = "清除"
--	L["DHMS"] = "DHMS"
	L["OPEN"] = "打开"
	L["RANDOM"] = "随机"
	L["RELOAD"] = "重载"
	L["MOVE_UP"] = "上移"
	L["MOVE_DOWN"] = "下移"
--	L["SORT_METHOD"] = ""
--	L["SORT_BY_NAME"] = ""
--	L["SORT_BY_NUMBER"] = ""
	L["HIDE"] = "隐藏"
--	L["MOVE"] = ""
	L["INSERT"] = "插入空白分组"
	L["CURRENT"] = "目前指定"
	L["OFFSET"] = "附加设置"
--	L["NUMBER"] = ""
--	L["STRING"] = ""
--	L["COOLDOWN"] = ""
--	L["FRAMES"] = ""
--	L["CLICK_TO_SELECT"] = ""
--	L["CLICK_TO_DESELECT"] = ""
--	L["CLICK_TO_IGNORE"] = ""	
	L["ORDER"] = "顺序"
	
	
--	libdatabroker
--	L["LDB"] = ""
	L["LDB_BAGS_COLOUR_USE"] = "使用颜色"
--	L["LDB_BAGS_COLOUR_USE_TEXT"] = ""
	L["LDB_BAGS_STYLE"] = "全部显示"
--	L["LDB_BAGS_STYLE_TEXT"] = ""
	L["LDB_BAGS_INCLUDE_TYPE"] = "包括背包类型"
--	L["LDB_BAGS_INCLUDE_TYPE_TEXT"] = ""
--	L["LDB_TRACKING_CURRENCY"] = ""
--	L["LDB_PETS_SUMMON"] = ""
--	L["LDB_MOUNTS_NOT_HERE"] = ""
--	L["LDB_MOUNTS_GROUND"] = ""
--	L["LDB_MOUNTS_FLYING_DISMOUNT"] = ""
--	L["LDB_MOUNTS_FLYING_DISMOUNT_TEXT"] = ""
--	L["LDB_MOUNTS_FLYING_DISMOUNT_WARNING"] = ""
--	L["LDB_MOUNTS_SUMMON"] = ""
--	L["LDB_MOUNTS_NODATA"] = ""
--	L["LDB_MOUNTS_TOOLTIP_MODE"] = ""
--	L["LDB_MOUNTS_TOOLTIP_SELECTION"] = ""
--	L["LDB_COMPANION_MISSING"] = ""
--	L["LDB_COMPANION_NONE"] = ""
--	L["LDB_COMPANION_RESTRICTED"] = ""
--	L["LDB_COMPANION_RESTRICTED_ZONE"] = ""
--	L["LDB_COMPANION_RESTRICTED_ITEM"] = ""
--	L["LDB_COMPANION_RESTRICTED_EVENT"] = ""
--	L["LDB_COMPANION_RESTRICTED_UNKNOWN"] = ""
--	L["LDB_COMPANION_NODATA"] = ""
--	L["LDB_COMPANION_NODATA_TEXT"] = ""
--	L["LDB_COMPANION_SELECT"] = ""
--	L["LDB_COMPANION_DESELECT"] = ""
--	L["LDB_COMPANION_IGNORE"] = ""
