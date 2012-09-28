local L = LibStub( "AceLocale-3.0" ):NewLocale( "ArkInventory", "koKR" )
if not L then return end

-- post updated translations at http://groups.google.com/group/wow-arkinventory (modify this file and include as an attachment)
-- note: when creating a new locale do not leave any english translations in your file, comment them out by placing -- at the start of the line


-- Translated by: Fenlis (jungseop.park@gmail.com)
-- Translated by: Liebe (sumomo90@gmail.com)










--	wow zone names - must match exactly what is in game
	L["WOW_ZONE_AHNQIRAJ"] = "안퀴라즈"
	L["WOW_ZONE_VASHJIR"] = "바쉬르"
	L["WOW_ZONE_KELPTHAR_FOREST"] = "켈프타르 숲"
	L["WOW_ZONE_SHIMMERING_EXPANSE"] = "흐린빛 벌판"
	L["WOW_ZONE_ABYSSAL_DEPTHS"] = "심연의 나락"
	
	
--	wow tooltip text - must match exactly what is in game
	L["WOW_ITEM_TOOLTIP_FOOD"] = "음식을 먹으려면 앉아 있어야 합니다."
	L["WOW_ITEM_TOOLTIP_DRINK"] = "음료를 마시려면 앉아 있어야 합니다."
	L["WOW_ITEM_TOOLTIP_POTION_HEAL"] = "%d+~%d+의 생명력이 회복됩니다."
	L["WOW_ITEM_TOOLTIP_POTION_MANA"] = "%d+~%d+의 마나가 회복됩니다."
--	L["WOW_ITEM_TOOLTIP_ELIXIR_BATTLE"] = ""
--	L["WOW_ITEM_TOOLTIP_ELIXIR_GUARDIAN"] = ""
	
	
--	location names
--	L["LOCATION_ALL"] = ""
	L["LOCATION_BANK"] = "은행"
--	L["LOCATION_WEARING"] = ""
	
	
--	subframe names
	L["SUBFRAME_NAME_TITLE"] = "제목 숨김"
	L["SUBFRAME_NAME_BAGCHANGER"] = "가방 변경 숨김"
	
	
--	status bar/bag text
	L["STATUS_NO_DATA"] = "자료 없음"
	L["STATUS_FULL"] = "가득참"
--	L["STATUS_PURCHASE"] = ""
	
	
--	restack
	L["RESTACK"] = "압축과 쌓기"
	L["RESTACK_TEXT"] = "나뉘어진 더미를 하나로 압축하고 빈 칸 없이 채웁니다."
--	L["RESTACK_FAIL_WAIT"] = ""
--	L["RESTACK_FAIL_ACCESS"] = ""
	
	
--	vault tab tooltips
--	L["VAULT_TAB_ACCESS_NONE"] = ""
--	L["VAULT_TAB_NAME"] = ""
--	L["VAULT_TAB_ACCESS"] = ""
--	L["VAULT_TAB_REMAINING_WITHDRAWALS"] = ""
	
	
--	category "header" descriptions  (does not have to match wow)
	L["CATEGORY_RULE"] = "규칙"
	
	
--	system category descriptions
	L["CATEGORY_SYSTEM_CORE_MATS"] = "중요 재료"
	L["CATEGORY_SYSTEM_EQUIPMENT"] = "착용장비 (착용 시 귀속)"
	L["CATEGORY_SYSTEM_EQUIPMENT_SOULBOUND"] = "착용장비(귀속 아이템)"
	
	
--	consumable category descriptions
	L["CATEGORY_CONSUMABLE_FOOD_PET"] = "음식 (소환수용)"
	L["CATEGORY_CONSUMABLE_POTION_MANA"] = "마나 (물약/석)"
	L["CATEGORY_CONSUMABLE_POTION_HEAL"] = "치유 (물약/석)"
--	L["CATEGORY_CONSUMABLE_ELIXIR_BATTLE"] = ""
--	L["CATEGORY_CONSUMABLE_ELIXIR_GUARDIAN"] = ""
	
	
--	bag names - used to name the empty slots in the status frame
	L["STATUS_NAME_BAG"] = "가방"
--	L["STATUS_NAME_CRITTER"] = ""
	L["STATUS_NAME_ENCHANTING"] = "마부"
	L["STATUS_NAME_ENGINEERING"] = "기공"
--	L["STATUS_NAME_GEAR"] = ""
	L["STATUS_NAME_GEM"] = "보석"
	L["STATUS_NAME_HERB"] = "약초"
	L["STATUS_NAME_INSCRIPTION"] = "주각"
	L["STATUS_NAME_KEY"] = "열쇠"
	L["STATUS_NAME_LEATHERWORKING"] = "가세"
--	L["STATUS_NAME_MAIL"] = ""
	L["STATUS_NAME_MINING"] = "광물"
	L["STATUS_NAME_MOUNT"] = "탈것"
	L["STATUS_NAME_TOKEN"] = "토큰"
--	L["STATUS_NAME_TACKLE"] = ""
	
	
--	main menu
	L["MENU"] = "메뉴"
	
	L["MENU_CHARACTER_SWITCH"] = "캐릭터 전환"
	L["MENU_CHARACTER_SWITCH_TEXT"] = "다른 캐릭터로 디스플레이를 전환합니다."
	L["MENU_CHARACTER_SWITCH_CHOOSE_NONE"] = "선택할 다른 캐릭터의 데이터가 없습니다."
	L["MENU_CHARACTER_SWITCH_CHOOSE_TEXT"] = "현재 디스플레이를 %1$s|1으로;로; 전환합니다."
	L["MENU_CHARACTER_SWITCH_ERASE"] = "저장된 데이터 삭제"
	L["MENU_CHARACTER_SWITCH_ERASE_TEXT"] = "%1$s에 대해 저장된 모든 데이터를 삭제합니다."
	
--	L["MENU_LOCATION_SWITCH"] = ""
--	L["MENU_LOCATION_SWITCH_TEXT"] = ""
	
	
--	actions menu
--	L["MENU_ACTION"] = ""
	L["MENU_ACTION_REFRESH"] = "새로 고침"
	L["MENU_ACTION_REFRESH_TEXT"] = "창을 갱신합니다."
	L["MENU_ACTION_RELOAD_TEXT"] = "창을 재시작 합니다.  장비 세트에 아이템 변경시 사용하세요."
	L["MENU_ACTION_EDITMODE"] = "편집 모드 전환"
	L["MENU_ACTION_EDITMODE_TEXT"] = "아이템 레이아웃을 설정 할 수 있도록 편집 모드를 전환합니다."
	L["MENU_ACTION_BAGCHANGER"] = "가방 표시 전환"
	L["MENU_ACTION_BAGCHANGER_TEXT"] = "가방을 추가하거나 교체할 수 있도록 가방칸의 표시를 전환합니다."
	
	
--	item menu
	L["MENU_ITEM_TITLE"] = "아이템 설정"
	L["MENU_ITEM_ITEM"] = "아이템"
--	L["MENU_ITEM_DEFAULT_RESET"] = ""
--	L["MENU_ITEM_DEFAULT_RESET_TEXT"] = ""
--	L["MENU_ITEM_ASSIGN_CHOICES"] = ""
--	L["MENU_ITEM_ASSIGN_THIS"] = ""
--	L["MENU_ITEM_ASSIGN_THIS_TEXT"] = ""
	L["MENU_ITEM_RULE_NEW"] = "새 규칙 생성"
	L["MENU_ITEM_RULE_ADD"] = "규칙에 추가"
--	L["MENU_ITEM_CUSTOM_NEW"] = ""
	L["MENU_ITEM_DEBUG"] = "디버그 정보"
--	L["MENU_ITEM_DEBUG_BAG"] = ""
--	L["MENU_ITEM_DEBUG_SLOT"] = ""
--	L["MENU_ITEM_DEBUG_BAG_TYPE"] = ""
--	L["MENU_ITEM_DEBUG_PET_ID"] = ""
--	L["MENU_ITEM_DEBUG_AI_ID_SHORT"] = ""
--	L["MENU_ITEM_DEBUG_AI_ID_CACHE"] = ""
--	L["MENU_ITEM_DEBUG_AI_ID_RULE"] = ""
--	L["MENU_ITEM_DEBUG_AI_ID_CATEGORY"] = ""
--	L["MENU_ITEM_DEBUG_LVL_ITEM"] = ""
--	L["MENU_ITEM_DEBUG_LVL_USE"] = ""
--	L["MENU_ITEM_DEBUG_TYPE"] = ""
--	L["MENU_ITEM_DEBUG_SUBTYPE"] = ""
--	L["MENU_ITEM_DEBUG_EQUIP"] = ""
--	L["MENU_ITEM_DEBUG_ID"] = ""
--	L["MENU_ITEM_DEBUG_FAMILY"] = ""
	L["MENU_ITEM_DEBUG_PT"] = "PT 세트"
	L["MENU_ITEM_DEBUG_PT_TEXT"] = "해당 아이템이 속한 PT 세트 목록"
	L["MENU_ITEM_DEBUG_PT_NONE"] = "해당 아이템은 PT 세트에 없습니다."
	L["MENU_ITEM_DEBUG_PT_TITLE"] = "해당 아이템의 PT 세트 위치"
	
	
--	bar menu
	L["MENU_BAR_TITLE"] = "%1$s번 바 설정"
	L["MENU_BAR_CATEGORY"] = "분류"
	L["MENU_BAR_CATEGORY_TEXT"] = "해당 바에 %1$s 분류를 지정합니다."
	L["MENU_BAR_CATEGORY_CURRENT"] = "현재 지정"
	L["MENU_BAR_CATEGORY_ASSIGN"] = "지정 가능한 분류"
	L["MENU_BAR_CATEGORY_REMOVE_TEXT"] = "%2$s번 바에서 %1$s 분류를 제거하고 기본 바로 되돌리려면 클릭하세요." -- 1 is the category name, 2 is the bar number
	L["MENU_BAR_CATEGORY_HIDDEN_TEXT"] = "해당 분류의 숨겨진 상태를 전환하려면 클릭하세요.\n\n숨겨진 분류의 아이템은 정상 모드에서 표시되지 않습니다."
--	L["MENU_BAR_CATEGORY_MOVE_START_TEXT"] = ""
--	L["MENU_BAR_CATEGORY_MOVE_COMPLETE_TEXT"] = ""
--	L["MENU_BAR_OPTIONS"] = ""
	L["MENU_BAR_CLEAR_TEXT"] = "해당 바의 기본 분류를 제외하고 현재 지정된 모든 분류를 제거합니다."
	L["MENU_BAR_INSERT_TEXT"] = "모든 분류을 위로 이동시키고 빈 바를 삽입합니다."
	L["MENU_BAR_REMOVE_TEXT"] = "해당 바를 제거합니다, 현재 모든 지정된 분류를 이전의 기본 바로 되돌리고 다른 것들은 아래 바로 이동합니다."
--	L["MENU_BAR_MOVE_START_TEXT"] = ""
--	L["MENU_BAR_MOVE_COMPLETE_TEXT"] = ""
--	L["MENU_BAR_SORTKEY_TEXT"] = ""
--	L["MENU_BAR_SORTKEY_DEFAULT_RESET_TEXT"] = ""
	
	
--	changer bag menu
--	L["MENU_BAG_TITLE"] = ""
--	L["MENU_BAG_SHOW"] = ""
--	L["MENU_BAG_SHOW_TEXT"] = ""
--	L["MENU_BAG_ISOLATE"] = ""
--	L["MENU_BAG_ISOLATE_TEXT"] = ""
--	L["MENU_BAG_SHOWALL"] = ""
--	L["MENU_BAG_SHOWALL_TEXT"] = ""
--	L["MENU_BAG_EMPTY"] = ""
--	L["MENU_BAG_EMPTY_TEXT"] = ""
	
	
--	configuration options
--	L["CONFIG"] = ""
--	L["CONFIG_TEXT"] = ""
	
--	configuration options > system
--	L["CONFIG_SYSTEM"] = ""
--	L["CONFIG_SYSTEM_TEXT"] = ""
	
--	L["CONFIG_SYSTEM_FONT_TEXT"] = ""
	
--	L["CONFIG_SYSTEM_FRAMESTRATA"] = ""
--	L["CONFIG_SYSTEM_FRAMESTRATA_TEXT"] = ""
--	L["CONFIG_SYSTEM_FRAMESTRATA_LEVEL_LOW"] = ""
--	L["CONFIG_SYSTEM_FRAMESTRATA_LEVEL_MEDIUM"] = ""
--	L["CONFIG_SYSTEM_FRAMESTRATA_LEVEL_HIGH"] = ""
	
--	L["CONFIG_SYSTEM_TOOLTIP"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_ENABLE_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_EMPTY_ADD"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_EMPTY_ADD_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_ADD"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_ADD_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_COLOUR_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_VAULT_TABS"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_VAULT_TABS_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_SCALE_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_CLASSCOLOUR_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_SELF_ONLY"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_SELF_ONLY_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_FACTION_ONLY"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_FACTION_ONLY_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_VAULT_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_BATTLEPET_SOURCE_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_BATTLEPET_DESCRIPTION_TEXT"] = ""
	
--	L["CONFIG_SYSTEM_BUGFIX"] = ""
--	L["CONFIG_SYSTEM_BUGFIX_TEXT"] = ""
--	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL"] = ""
--	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_TEXT"] = ""
--	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_TEXT"] = ""
--	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE0"] = ""
--	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE0_TEXT"] = ""
--	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE1"] = ""
--	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE1_TEXT"] = ""
--	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE2"] = ""
--	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE2_TEXT"] = ""
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
	L["CONFIG_AUTO"] = "자동 열기/닫기"
	
--	L["CONFIG_AUTO_OPEN"] = ""
--	L["CONFIG_AUTO_OPEN_BANK"] = ""
--	L["CONFIG_AUTO_OPEN_VAULT"] = ""
--	L["CONFIG_AUTO_OPEN_MAIL"] = ""
--	L["CONFIG_AUTO_OPEN_MERCHANT"] = ""
--	L["CONFIG_AUTO_OPEN_TRADE"] = ""
--	L["CONFIG_AUTO_OPEN_AUCTION"] = ""
	
--	L["CONFIG_AUTO_CLOSE"] = ""
--	L["CONFIG_AUTO_CLOSE_BANK"] = ""
--	L["CONFIG_AUTO_CLOSE_VAULT"] = ""
--	L["CONFIG_AUTO_CLOSE_MAIL"] = ""
--	L["CONFIG_AUTO_CLOSE_MERCHANT"] = ""
--	L["CONFIG_AUTO_CLOSE_TRADE"] = ""
--	L["CONFIG_AUTO_CLOSE_AUCTION"] = ""
--	L["CONFIG_AUTO_CLOSE_COMBAT"] = ""
	
	
--	configuration options > control
--	L["CONFIG_CONTROL"] = ""
	
--	L["CONFIG_CONTROL_MONITOR"] = ""
--	L["CONFIG_CONTROL_MONITOR_TEXT"] = ""
--	L["CONFIG_CONTROL_SAVE_TEXT"] = ""
--	L["CONFIG_CONTROL_NOTIFY_ERASE"] = ""
--	L["CONFIG_CONTROL_NOTIFY_ERASE_TEXT"] = ""
	L["CONFIG_CONTROL_OVERRIDE"] = "블리자드 프레임 숨김"
--	L["CONFIG_CONTROL_OVERRIDE_TEXT"] = ""
--	L["CONFIG_CONTROL_ANCHOR_LOCK_TEXT"] = ""
--	L["CONFIG_CONTROL_REPOSITION_NOW"] = ""
--	L["CONFIG_CONTROL_REPOSITION_NOW_TEXT"] = ""
--	L["CONFIG_CONTROL_REPOSITION_ONLOAD"] = ""
--	L["CONFIG_CONTROL_REPOSITION_ONLOAD_TEXT"] = ""
--	L["CONFIG_CONTROL_SETTINGS_TEXT"] = ""
	
	
--	configuration options > settings
--	L["CONFIG_SETTINGS"] = ""
	
	L["CONFIG_SETTINGS_FRAME"] = "창"
	
--	L["CONFIG_SETTINGS_FRAME_HIDE_TEXT"] = ""
	
	L["CONFIG_SETTINGS_FRAME_SCALE_TEXT"] = "창을 크게 혹은 작게 하기 위한 크기 비율을 설정합니다."
	L["CONFIG_SETTINGS_FRAME_PADDING_TEXT"] = "창의 경계와 바 사이의 간격을 설정합니다."
	L["CONFIG_SETTINGS_FRAME_WIDTH_TEXT"] = "디스플레이할 열의 수를 설정합니다."
	L["CONFIG_SETTINGS_FRAME_BACKGROUND_COLOUR_TEXT"] = "메인 창의 배경 색상을 설정합니다."
	L["CONFIG_SETTINGS_FRAME_BORDER_SHOW_TEXT"] = "메인 창 주변의 테두리 표시를 전환합니다."
--	L["CONFIG_SETTINGS_FRAME_BORDER_STYLE_TEXT"] = ""
	L["CONFIG_SETTINGS_FRAME_BORDER_COLOUR_TEXT"] = "메인 창의 테두리 색상을 설정합니다."
	
	L["CONFIG_SETTINGS_FRAME_CHANGER_HIGHLIGHT"] = "가방 강조 색상"
--	L["CONFIG_SETTINGS_FRAME_CHANGER_HIGHLIGHT_TEXT"] = ""
	L["CONFIG_SETTINGS_FRAME_CHANGER_HIGHLIGHT_COLOUR_TEXT"] = "가방에 마우스를 올렸을 때 칸을 강조하는데 사용할 색상을 설정합니다."
--	L["CONFIG_SETTINGS_FRAME_CHANGER_FREE"] = ""
--	L["CONFIG_SETTINGS_FRAME_CHANGER_FREE_TEXT"] = ""
--	L["CONFIG_SETTINGS_FRAME_CHANGER_FREE_COLOUR_TEXT"] = ""
	
--	L["CONFIG_SETTINGS_FRAME_STATUS_EMPTY"] = ""
--	L["CONFIG_SETTINGS_FRAME_STATUS_EMPTY_TEXT"] = ""
	
--	L["CONFIG_SETTINGS_FRAME_TITLE_SIZE_NORMAL"] = ""
--	L["CONFIG_SETTINGS_FRAME_TITLE_SIZE_THIN"] = ""
	
	L["CONFIG_SETTINGS_BARS"] = "바"
	L["CONFIG_SETTINGS_BARS_PER_ROW"] = "열 단위"
	L["CONFIG_SETTINGS_BARS_PER_ROW_TEXT"] = "각 열에 표시할 바의 수를 설정합니다."
	L["CONFIG_SETTINGS_BARS_BACKGROUND_TEXT"] = "바의 배경 색상을 설정합니다."
	L["CONFIG_SETTINGS_BARS_COMPACT"] = "간략형"
	L["CONFIG_SETTINGS_BARS_COMPACT_TEXT"] = "순서대로 모든 비어있지 않은 바를 표시합니다."
	L["CONFIG_SETTINGS_BARS_SHOW_EMPTY"] = "빈 바 표시"
	L["CONFIG_SETTINGS_BARS_SHOW_EMPTY_TEXT"] = "빈 바의 표시를 전환합니다."
--	L["CONFIG_SETTINGS_BARS_PADDING_INTERNAL_TEXT"] = ""
--	L["CONFIG_SETTINGS_BARS_PADDING_EXTERNAL_TEXT"] = ""
	L["CONFIG_SETTINGS_BARS_BORDER_TEXT"] = "각 바 주변의 테두리 표시를 전환합니다."
--	L["CONFIG_SETTINGS_BARS_BORDER_STYLE_TEXT"] = ""
	L["CONFIG_SETTINGS_BARS_BORDER_COLOUR_TEXT"] = "바 주변의 테두리 색상을 설정합니다."
--	L["CONFIG_SETTINGS_BARS_NAME_TEXT"] = ""
--	L["CONFIG_SETTINGS_BARS_NAME_SHOW_TEXT"] = ""
--	L["CONFIG_SETTINGS_BARS_NAME_COLOUR_TEXT"] = ""
--	L["CONFIG_SETTINGS_BARS_NAME_HEIGHT_TEXT"] = ""
--	L["CONFIG_SETTINGS_BARS_NAME_ANCHOR_TEXT"] = ""
	
	L["CONFIG_SETTINGS_ITEMS"] = "아이템"
	L["CONFIG_SETTINGS_ITEMS_PADDING_TEXT"] = "아이템 칸 사이에 추가할 간격을 설정합니다."
	L["CONFIG_SETTINGS_ITEMS_HIDDEN"] = "숨겨진 아이템 표시"
	L["CONFIG_SETTINGS_ITEMS_HIDDEN_TEXT"] = "숨겨진 분류 내의 아이템을 표시할 지를 결정합니다."
	L["CONFIG_SETTINGS_ITEMS_FADE"] = "아이템 숨김"
	L["CONFIG_SETTINGS_ITEMS_FADE_TEXT"] = "오프라인 아이템을 숨길지를 결정합니다."
--	L["CONFIG_SETTINGS_ITEMS_TINT_USABLE"] = ""
--	L["CONFIG_SETTINGS_ITEMS_TINT_USABLE_TEXT"] = ""
--	L["CONFIG_SETTINGS_ITEMS_BORDER_SHOW_TEXT"] = ""
--	L["CONFIG_SETTINGS_ITEMS_BORDER_STYLE_TEXT"] = ""
	L["CONFIG_SETTINGS_ITEMS_BORDER_RARITY"] = "등급에 따른 테두리 색상화"
	L["CONFIG_SETTINGS_ITEMS_BORDER_RARITY_TEXT"] = "각 아이템의 칸 주변의 테두리를 아이템의 등급에 따른 색상을 사용할 지를 결정합니다. (일반, 희귀, 영웅, 등)"
--	L["CONFIG_SETTINGS_ITEMS_BORDER_RARITY_CUTOFF"] = ""
--	L["CONFIG_SETTINGS_ITEMS_BORDER_RARITY_CUTOFF_TEXT"] = ""
--	L["CONFIG_SETTINGS_ITEMS_BORDER_TEXTURE_OFFSET_TEXT"] = ""
	L["CONFIG_SETTINGS_ITEMS_AGE"] = "새 아이템"
	L["CONFIG_SETTINGS_ITEMS_AGE_SHOW_TEXT"] = "새 아이템 글자의 표시를 전환합니다."
	L["CONFIG_SETTINGS_ITEMS_AGE_COLOUR_TEXT"] = "새 아이템 글자의 색상을 설정합니다."
--	L["CONFIG_SETTINGS_ITEMS_AGE_CUTOFF"] = ""
--	L["CONFIG_SETTINGS_ITEMS_AGE_CUTOFF_TEXT"] = ""
	L["CONFIG_SETTINGS_ITEMS_AGE_RESET_TEXT"] = "해당 캐릭터의 모든 아이템에 대한 새 아이템 상태를 클리어합니다."
--	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_SHOW_TEXT"] = ""
--	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_GLOBAL"] = ""
--	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_GLOBAL_TEXT"] = ""
--	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_COMBAT"] = ""
--	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_COMBAT_TEXT"] = ""
	
--	L["CONFIG_SETTINGS_SORTING_OPEN"] = ""
--	L["CONFIG_SETTINGS_SORTING_OPEN_TEXT"] = ""
	L["CONFIG_SETTINGS_SORTING_INSTANT"] = "즉시"
	L["CONFIG_SETTINGS_SORTING_INSTANT_TEXT"] = "즉시 정렬 모드를 전환합니다.\n\nenabled: sorting is done when something changes\n\ndisabled: sorting is done only when the window is opened, or you refresh.\n\nnote: if the bag changer window is open then your choice is ignored and instant sort is always enabled"
	
	L["CONFIG_SETTINGS_EMPTY"] = "빈 칸"
	L["CONFIG_SETTINGS_EMPTY_ICON"] = "아이콘 사용"
	L["CONFIG_SETTINGS_EMPTY_ICON_TEXT"] = "빈 칸 배경에 고정 색상 혹은 아이콘 사용을 전환합니다."
--	L["CONFIG_SETTINGS_EMPTY_CLUMP"] = ""
--	L["CONFIG_SETTINGS_EMPTY_CLUMP_TEXT"] = ""
	L["CONFIG_SETTINGS_EMPTY_BORDER"] = "테두리 색상화"
	L["CONFIG_SETTINGS_EMPTY_BORDER_TEXT"] = "가방 종류에 따른 빈 칸 테두리 색상 사용을 전환합니다."
	L["CONFIG_SETTINGS_EMPTY_COLOUR"] = "칸 색상"
--	L["CONFIG_SETTINGS_EMPTY_COLOUR_TEXT"] = ""
--	L["CONFIG_SETTINGS_EMPTY_STATUS"] = ""
	
	
-- sorting
--	L["CONFIG_SORTMETHOD"] = ""
	
	L["CONFIG_SORTMETHOD_SORT"] = "정렬"
	
--	L["CONFIG_SORTMETHOD_STYLE_TEXT"] = ""
	L["CONFIG_SORTMETHOD_STYLE_BAGSLOT"] = "가방 / 칸 순"
	L["CONFIG_SORTMETHOD_STYLE_BAGSLOT_TEXT"] = "인텐토리를 가방과 칸 번호순으로 정렬합니다."
	L["CONFIG_SORTMETHOD_STYLE_USER"] = "이름순"
	L["CONFIG_SORTMETHOD_STYLE_USER_TEXT"] = "인벤토리를 아이템의 이름순으로 정렬합니다."
	
	L["CONFIG_SORTMETHOD_INCLUDE_NAME"] = "아이템 이름"
	L["CONFIG_SORTMETHOD_INCLUDE_NAME_TEXT"] = "인벤토리 정렬에 아이템 이름의 포함을 전환합니다.."
	L["CONFIG_SORTMETHOD_INCLUDE_NAME_REVERSE"] = "반전한 이름 포함"
	L["CONFIG_SORTMETHOD_INCLUDE_NAME_REVERSE_TEXT"] = "인벤토리 정렬에 반전한 이름의 포함을 전환합니다.\n\n예 최상급 마나 물약은 물약 마나 최고급이 됩니다."
	L["CONFIG_SORTMETHOD_INCLUDE_QUALITY"] = "아이템 등급"
	L["CONFIG_SORTMETHOD_INCLUDE_QUALITY_TEXT"] = "인벤토리 정렬에 아이템 등급의 포함을 전환합니다."
	L["CONFIG_SORTMETHOD_INCLUDE_LOCATION"] = "아이템 착용 부위"
	L["CONFIG_SORTMETHOD_INCLUDE_LOCATION_TEXT"] = "인벤토리 정렬에 아이템 착용 부위의 포함을 전환합니다.\n\n노트: 단 착용가능한 아이템만 적용됩니다."
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMTYPE"] = "아이템 종류와 세부 종류"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMTYPE_TEXT"] = "인벤토리 정렬에 아이템의 종류와 세부 종류의 포함을 전환합니다."
	L["CONFIG_SORTMETHOD_INCLUDE_CATEGORY"] = "아이템 분류"
	L["CONFIG_SORTMETHOD_INCLUDE_CATEGORY_TEXT"] = "인벤토리 정렬에 아이템 분류의 포함을 전환합니다."
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMUSELEVEL"] = "아이템 (사용) 레벨"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMUSELEVEL_TEXT"] = "인벤토리 정렬에 아이템의 (사용) 레벨의 포함을 전환합니다."
--	L["CONFIG_SORTMETHOD_INCLUDE_ITEMSTATLEVEL"] = ""
--	L["CONFIG_SORTMETHOD_INCLUDE_ITEMSTATLEVEL_TEXT"] = ""
--	L["CONFIG_SORTMETHOD_INCLUDE_ITEMAGE"] = ""
--	L["CONFIG_SORTMETHOD_INCLUDE_ITEMAGE_TEXT"] = ""
--	L["CONFIG_SORTMETHOD_INCLUDE_VENDORPRICE"] = ""
--	L["CONFIG_SORTMETHOD_INCLUDE_VENDORPRICE_TEXT"] = ""
	
--	L["CONFIG_SORTMETHOD_DIRECTION_TEXT"] = ""
	L["CONFIG_SORTMETHOD_ORDER"] = "정렬 순서"
--	L["CONFIG_SORTMETHOD_MOVE_UP_TEXT"] = ""
--	L["CONFIG_SORTMETHOD_MOVE_DOWN_TEXT"] = ""
--	L["CONFIG_SORTMETHOD_NOT_INCLUDED"] = ""
	
--	L["CONFIG_SORTMETHOD_ADD"] = ""
--	L["CONFIG_SORTMETHOD_ADD_TEXT"] = ""
--	L["CONFIG_SORTMETHOD_RENAME_TEXT"] = ""
--	L["CONFIG_SORTMETHOD_DELETE_TEXT"] = ""
	
	
--	rules
	L["CONFIG_RULES"] = "규칙"
	L["CONFIG_RULES_SHOWDISABLED"] = "비활성화된 규칙 표시"
	L["CONFIG_RULES_SHOWDISABLED_TEXT"] = "비활성화된 규칙의 표시를 전환합니다."
	
	
--	configuration options > categories
--	L["CONFIG_CATEGORY"] = ""
	
--	L["CONFIG_CATEGORY_CUSTOM"] = ""
--	L["CONFIG_CATEGORY_DELETED"] = ""
	
--	L["CONFIG_CATEGORY_ADD"] = ""
--	L["CONFIG_CATEGORY_ADD_TEXT"] = ""
--	L["CONFIG_CATEGORY_RENAME_TEXT"] = ""
--	L["CONFIG_CATEGORY_DELETE_TEXT"] = ""
	
	
--	configuration options > debug
--	L["CONFIG_DEBUG"] = ""
--	L["CONFIG_DEBUG_TEXT"] = ""
	
	
--	configuration options > generic
--	L["BORDER_SCALE_TEXT"] = ""
--	L["BORDER_TEXTURE_TEXT"] = ""
--	L["BORDER_TEXTURE_FILE_TEXT"] = ""
--	L["BORDER_TEXTURE_HEIGHT_TEXT"] = ""
	
	
--	rules frame
	L["RULE"] = "규칙"
	L["RULE_HIDDEN"] = "숨겨짐"
	L["RULE_FORMULA"] = "형식"
--	L["RULE_LIST_ENABLED"] = ""
--	L["RULE_LIST_DAMAGED"] = ""
--	L["RULE_LIST_ID"] = ""
	
--	L["RULE_DAMAGED"] = ""
--	L["RULE_FAILED"] = ""
--	L["RULE_FAILED_KEY_NIL"] = ""
--	L["RULE_FAILED_DATA_NIL"] = ""
--	L["RULE_FAILED_DESCRIPTION_NIL"] = ""
--	L["RULE_FAILED_FORMULA_NIL"] = ""
--	L["RULE_FAILED_FORMULA_BAD"] = ""
--	L["RULE_FAILED_ARGUMENT_IS_NIL"] = ""
--	L["RULE_FAILED_ARGUMENT_IS_INVALID"] = ""
--	L["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"] = ""
	
	
--	new item indicators
--	L["NEW_ITEM_INCREASE"] = ""
--	L["NEW_ITEM_DECREASE"] = ""
	
	
--	slash commands
--	L["SLASH_UI"] = ""
--	L["SLASH_UI_TEXT"] = ""
--	L["SLASH_UI_RESET"] = ""
--	L["SLASH_UI_RESET_TEXT"] = ""
--	L["SLASH_UI_RESET_COMPLETE_TEXT"] = ""
--	L["SLASH_DB"] = ""
--	L["SLASH_DB_TEXT"] = ""
--	L["SLASH_DB_RESET"] = ""
--	L["SLASH_DB_RESET_TEXT"] = ""
--	L["SLASH_DB_RESET_CONFIRM"] = ""
--	L["SLASH_DB_RESET_CONFIRM_TEXT"] = ""
--	L["SLASH_DB_RESET_COMPLETE_TEXT"] = ""
--	L["SLASH_CACHE"] = ""
--	L["SLASH_CACHE_TEXT"] = ""
--	L["SLASH_CACHE_ERASE"] = ""
--	L["SLASH_CACHE_ERASE_TEXT"] = ""
--	L["SLASH_CACHE_ERASE_CONFIRM"] = ""
--	L["SLASH_CACHE_ERASE_CONFIRM_TEXT"] = ""
--	L["SLASH_CACHE_ERASE_COMPLETE_TEXT"] = ""
--	L["SLASH_MISC"] = ""
--	L["SLASH_MISC_TEXT"] = ""
--	L["SLASH_TRACK"] = ""
--	L["SLASH_TRACK_TEXT"] = ""
	
	
--	misc chat stuff
--	L["UPGRADE_PROFILE"] = ""
--	L["UPGRADE_GLOBAL"] = ""
--	L["UPGRADE_CHAR"] = ""
	
--	L["MISC_ALERT"] = ""
--	L["MISC_ALERT_FRAMELEVEL_1"] = ""
--	L["MISC_ALERT_FRAMELEVEL_2"] = ""
	
	
--	item count tooltip
--	L["TOOLTIP_COUNT_ME"] = ""
	L["TOOLTIP_VAULT_TABS"] = ""
	
	
--	generic text
--	L["AUTOMATIC"] = ""
	L["BOTTOMLEFT"] = "좌측 하단"
	L["BOTTOMRIGHT"] = "우측 하단"
	L["TOPLEFT"] = "좌측 상단"
	L["TOPRIGHT"] = "우측 상단"
--	L["TOP"] = ""
--	L["BOTTOM"] = ""
--	L["LEFT"] = ""
--	L["RIGHT"] = ""
	L["HORIZONTAL"] = "수평"
	L["VERTICAL"] = "수직"
	L["CLOSE_MENU"] = "메뉴 닫기"
--	L["ANCHOR"] = ""
--	L["ANCHOR_TEXT1"] = ""
--	L["ANCHOR_TEXT2"] = ""
--	L["BORDER_TEXT"] = ""
--	L["SHOW"] = ""
--	L["FILE"] = ""
--	L["HEIGHT"] = ""
--	L["SCALE"] = ""
--	L["TEXTURE"] = ""
--	L["FONT"] = ""
	L["BACKGROUND_COLOUR"] = "배경 색상"
--	L["STYLE"] = ""
--	L["ENABLED"] = ""
--	L["ALERT"] = ""
	L["PADDING"] = "간격"
--	L["INTERNAL"] = ""
--	L["EXTERNAL"] = ""
	L["WIDTH"] = "너비"
--	L["REALM"] = ""
	L["VIEW"] = "보기"
	L["EDIT"] = "편집"
	L["DIRECTION"] = "방향"
--	L["ASCENDING"] = ""
--	L["DECENDING"] = ""
--	L["LOCATION"] = ""
	L["CLEAR"] = "클리어"
--	L["DHMS"] = ""
--	L["OPEN"] = ""
--	L["RANDOM"] = ""
	L["RELOAD"] = "재시작"
	L["MOVE_UP"] = "위로 이동"
	L["MOVE_DOWN"] = "아래로 이동"
--	L["SORT_METHOD"] = ""
--	L["SORT_BY_NAME"] = ""
--	L["SORT_BY_NUMBER"] = ""
	L["HIDE"] = "숨김"
--	L["MOVE"] = ""
	L["INSERT"] = "빈 바 삽입"
	L["CURRENT"] = "현재 지정"
--	L["OFFSET"] = ""
--	L["NUMBER"] = ""
--	L["STRING"] = ""
--	L["COOLDOWN"] = ""
--	L["FRAMES"] = ""
--	L["CLICK_TO_SELECT"] = ""
--	L["CLICK_TO_DESELECT"] = ""
--	L["CLICK_TO_IGNORE"] = ""	
	L["ORDER"] = "순서"
	
	
-- libdatabroker
--	L["LDB"] = ""
--	L["LDB_BAGS_COLOUR_USE"] = ""
--	L["LDB_BAGS_COLOUR_USE_TEXT"] = ""
--	L["LDB_BAGS_STYLE"] = ""
--	L["LDB_BAGS_STYLE_TEXT"] = ""
--	L["LDB_BAGS_INCLUDE_TYPE"] = ""
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
