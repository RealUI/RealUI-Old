
---------------------------------------------------------
--	Library
---------------------------------------------------------
local bzone = LibStub("LibBabble-Zone-3.0"):GetUnstrictLookupTable()
local bboss = LibStub("LibBabble-Boss-3.0"):GetUnstrictLookupTable()
local bzoneRev = LibStub("LibBabble-Zone-3.0"):GetReverseLookupTable()

---------------------------------------------------------
--	Localization
---------------------------------------------------------

local L = {}
do
	local loc = GetLocale()
	if loc == "koKR" then
		L["Raid Debuff"] = "레이드 디버프"
		L["Option for %s"] = "%s의 설정"
		L["Enable"] = "활성화"
		L["Enable %s"] = "%s 활성화"
		L["Icon Priority"] = "아이콘 우선순위"
		L["Color Priority"] = "색상 우선순위"
		L["Custom Color"] = "임의의 색상"
		L["Color"] = "색상"
		L.colorDesc = "색상 변경"
		L["Ignore dispellable debuff"] = "해제 가능한 디버프 무시"
		L["Ignore undispellable debuff"] = "해제 불가능한 디버프 무시"
		L["Remained time"] = "남은 시간"
		L["Stackable debuff"] = "중첩 디버프"
		L["Only color"] = "색상만 표시"
		L.detector = "새로운 디버프 기록"
		L["Remove"] = "제거"
		L["Load"] = "불러오기"
		L["Detected debuff"] = "추적된 디버프"
		L["Remove detected debuff"] = "추적된 디버프 제거"
		L.msgAct = "지금부터 새로운 디버프를 추적합니다."
		L.msgDeact = "새로운 디버프를 추적하지 않습니다."
		L["Aura Refresh Frequency"] = "디버프 재확인 주기"
		L["Border"] = "테두리"
		L["Center Icon"] = "중앙 아이콘"
		L["Import Debuff"] = "디버프 추가"
    		L["Import Debuff Desc"] = "현재 지역에 새 레이드 디버프 추가"
	elseif loc == "ruRU" then
		L["Raid Debuff"] = "Дебаффы рейда"
		L["Option for %s"] = "Опции %s"
		L["Enable"] = "Включить"
		L["Enable %s"] = "Включить %s"
		L["Icon Priority"] = "Приоритет иконки"
		L["Color Priority"] = "Приоритет цвета"
		L["Custom Color"] = "Свой цвет"
		L["Color"] = "Цвет"
		L.colorDesc = "Изменение цвета"
		L["Ignore dispellable debuff"] = "Игнорировать дебаффы которые можно снять"
		L["Ignore undispellable debuff"] = "Игнорировать дебаффы которые не можно снять"
		L["Remained time"] = "Остаток времени"
		L["Stackable debuff"] = "Наращиваемые дебаффы"
		L["Only color"] = "Показывать только цвет, игнорируя иконку"
		L.detector = "Детектор дебаффов"
		L["Remove"] = "Удалить"
		L["Load"] = "Загрузить"
		L["Detected debuff"] = "Определённый дебафф"
		L["Remove detected debuff"] = "Удалить определённый дебафф"
		L.msgAct = "Детектор дебаффов активирован для текущей сессии."
		L.msgDeact = "Детектор дебаффов деактивирован."
		L["Aura Refresh Frequency"] = "Частота обновления ауры"
		L["Border"] = "Граница"
		L["Center Icon"] = "Иконка в центре"
		L["Import Debuff"] = "Import Debuff"
   		 L["Import Debuff Desc"] = "Import a new raid debuff for this zone"
	elseif loc == "zhCN" then
		L["Raid Debuff"] = "团队减益状态"
		L["Option for %s"] = "%s 设置"
		L["Enable"] = "开启"
		L["Enable %s"] = "开启 %s"
		L["Icon Priority"] = "图标属性"
		L["Color Priority"] = "颜色属性"
		L["Custom Color"] = "自订颜色"
		L["Color"] = "颜色"
		L.colorDesc = "修改颜色"
		L["Ignore dispellable debuff"] = "忽略可驱散的减益状态"
		L["Ignore undispellable debuff"] = "忽略不可驱散的减益状态"
		L["Remained time"] = "剩余时间"
		L["Stackable debuff"] = "可堆叠的减益状态"
		L["Only color"] = "忽略图示而只显示颜色"
		L.detector = "侦测新的减益状态"
		L["Remove"] = "移除"
		L["Load"] = "载入"
		L["Detected debuff"] = "已侦测的减益状态"
		L["Remove detected debuff"] = "移除已侦测的减益状态"
		L.msgAct = "减益状态侦测器已开启在目前的战斗期间。"
		L.msgDeact = "减益状态侦测器已关闭。"
		L["Aura Refresh Frequency"] = "光环刷新频率"
		L["Border"] = "外框"
		L["Center Icon"] = "中心图标"
		L["Import Debuff"] = "导入数据"
    		L["Import Debuff Desc"] = "导入这个地区新的数据"
	elseif loc == "zhTW" then
		L["Raid Debuff"] = "團隊減益狀態"
		L["Option for %s"] = "%s 選項"
		L["Enable"] = "啟用"
		L["Enable %s"] = "啟用%s"
		L["Icon Priority"] = "圖示屬性"
		L["Color Priority"] = "顏色屬性"
		L["Custom Color"] = "自訂顏色"
		L["Color"] = "顏色"
		L.colorDesc = "修改顏色"
		L["Ignore dispellable debuff"] = "忽略可驅散的減益狀態"
		L["Ignore undispellable debuff"] = "忽略不可驅散的減益狀態"
		L["Remained time"] = "剩餘時間"
		L["Stackable debuff"] = "可堆疊的減益狀態"
		L["Only color"] = "忽略圖示而只顯示顏色"
		L.detector = "偵測新的減益狀態"
		L["Remove"] = "移除"
		L["Load"] = "載入"
		L["Detected debuff"] = "已偵測的減益狀態"
		L["Remove detected debuff"] = "移除已偵測的減益狀態"
		L.msgAct = "減益狀態偵測器已啟動在目前的戰鬥期間。"
		L.msgDeact = "減益狀態偵測器已停用。"
		L["Aura Refresh Frequency"] = "光環更新頻率"
		L["Border"] = "邊框"
		L["Center Icon"] = "中央圖示"
		L["Import Debuff"] = "導入數據"
    		L["Import Debuff Desc"] = "導入這個地區的新數據"
	else
		L["Raid Debuff"] = "Raid Debuff"
		L["Option for %s"] = "Option for %s"
		L["Enable"] = "Enable"
		L["Enable %s"] = "Enable %s"
		L["Icon Priority"] = "Icon Priority"
		L["Color Priority"] = "Color Priority"
		L["Custom Color"] = "Custom Color"
		L["Color"] = "Color"
		L.colorDesc = "Modify Color"
		L["Ignore dispellable debuff"] = "Ignore dispellable debuff"
		L["Ignore undispellable debuff"] = "Ignore undispellable debuff"
		L["Remained time"] = "Remained time"
		L["Stackable debuff"] = "Stackable debuff"
		L["Only color"] = "Only show color, Ignore icon"
		L.detector = "Detect new debuff"
		L["Remove"] = "Remove"
		L["Load"] = "Load"
		L["Detected debuff"] = "Detected debuff"
		L["Remove detected debuff"] = "Remove detected debuff"
		L.msgAct = "Debuff detector is activated."
		L.msgDeact = "Debuff detector is deactivated."
		L["Aura Refresh Frequency"] = "Aura Refresh Frequency"
		L["Border"] = "Border"
		L["Center Icon"] = "Center Icon"
		L["Import Debuff"] = "Import Debuff"
  		L["Import Debuff Desc"] = "Import a new raid debuff for this zone"
	end
end

---------------------------------------------------------
--	local
---------------------------------------------------------
local realzone, detectStatus, enzone, zonetype
local db, myClass, myDispellable
local debuff_list = {}
local refreshEventScheduled = false
local refreshTimer

local colorMap = {
	["Curse"] = { r = .6, g =  0, b = 1},
	["Magic"] = { r = .2, g = .6, b = 1},
	["Poison"] = {r =  0, g = .6, b =  0},
	["Disease"] = { r = .6, g = .4, b =  0},
}

local dispelMap = {
	["PRIEST"] = {["Magic"] = true, ["Disease"] = true},
	["PALADIN"] = {["Disease"] = true, ["Poison"] = true, ["Magic"] = (select(5,GetTalentInfo(1,14)) == 1)},
	["MAGE"] = {["Curse"] = true},
	["DRUID"] = {["Curse"] = true, ["Poison"] = true, ["Magic"] = (select(5,GetTalentInfo(3,17)) == 1)},
	["SHAMAN"] = {["Curse"] = true, ["Magic"] = (select(5,GetTalentInfo(3,12)) == 1)},
}

local clientVersion
do
	local version = GetBuildInfo() -- e.g. "4.0.6"
	local a, b, c = strsplit(".", version) -- e.g. "4", "0", "6"
	clientVersion = 10000*a + 100*b + c -- e.g. 40006
end

---------------------------------------------------------
--	Core
---------------------------------------------------------

GridStatusRaidDebuff = Grid:GetModule("GridStatus"):NewModule("GridStatusRaidDebuff", "AceTimer-3.0")
GridStatusRaidDebuff.menuName = L["Raid Debuff"]

local GridFrame = Grid:GetModule("GridFrame")
local GridRoster = Grid:GetModule("GridRoster")
local GridStatusRaidDebuff = GridStatusRaidDebuff

local GetSpellInfo = GetSpellInfo
local fmt = string.format
local ssub = string.sub

GridStatusRaidDebuff.defaultDB = {
	debug = false,
	isFirst = true,

	["alert_RaidDebuff"] = {
		text = L["Raid Debuff"],
		desc = L["Raid Debuff"],
		enable = true,
		color = { r = .0, g = .0, b = .0, a=1.0 },
		priority = 98,
		range = false,
	},

	ignDis = false,
	ignUndis = false,
	detect = false,
	frequency = 0.1,

	["debuff_options"] = {},
	["detected_debuff"] = {},
}

function GridStatusRaidDebuff:OnInitialize()
	self.super.OnInitialize(self)
	self:RegisterStatuses()
	db = self.db.profile.debuff_options
end

function GridStatusRaidDebuff:OnEnable()
	self.debugging = self.db.profile.debug

	myClass = select(2, UnitClass("player"))
	myDispellable = dispelMap[myClass]

	-- For classes that don't have a dispelMap
	-- Create an empty array
	if (myDispellable == nil) then
		myDispellable = {}
	end

	if self.db.profile.isFirst then
		GridFrame.db.profile.statusmap["icon"].alert_RaidDebuff  =  true,
		GridFrame:UpdateAllFrames()
		self.db.profile.isFirst = false
	end

	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "ZoneCheck")
	self:RegisterCustomDebuff()
end

function GridStatusRaidDebuff:Reset()
	self.super.Reset(self)
	self:UnregisterStatuses()
	self:RegisterStatuses()
end

function GridStatusRaidDebuff:PLAYER_ENTERING_WORLD()
	self:ZoneCheck()
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end

function GridStatusRaidDebuff:CheckDetectZone()
	detectStatus = self.db.profile.detect and not (zonetype == "none" or zonetype == "pvp") --check db Enable
	self:Debug("CheckDetectZone", realzone, enzone, detectStatus and "Detector On")

	if detectStatus then
		self:CreateZoneMenu(realzone)
		if not debuff_list[realzone] then debuff_list[realzone] = {} end
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", "ScanNewDebuff")
	else
		self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	end
end

function GridStatusRaidDebuff:ZoneCheck()
	realzone, zonetype = GetInstanceInfo()
	enzone = bzoneRev[realzone]

	-- Fall back on GetRealZoneText if GetInstanceInfo does not return a valid zone
	if (not enzone) then
		realzone = GetRealZoneText()
		enzone = bzoneRev[realzone]
	end

	if (not enzone) then
		self:Debug("ZoneCheck", realzone, enzone, "No enzone translation")
		-- enzone = nil
		-- return
	end

	self:UpdateAllUnit()
	self:CheckDetectZone()

	if myClass == "PALADIN" or myClass == "DRUID" or myClass == "SHAMAN" then
		self:RegisterEvent("PLAYER_TALENT_UPDATE")
	end

	if debuff_list[realzone] then
		if not refreshEventScheduled then
			refreshTimer = self:ScheduleRepeatingTimer("UpdateAllUnit", self.db.profile.frequency)
			self:RegisterMessage("Grid_UnitJoined")
			refreshEventScheduled = true
		end
	else
		if refreshEventScheduled then
			self:CancelTimer(refreshTimer)
			self:UnregisterMessage("Grid_UnitJoined")
			refreshEventScheduled = false
		end
	end
end

function GridStatusRaidDebuff:UpdateRefresh()
	self:CancelTimer(refreshTimer)
	refreshTimer = self:ScheduleRepeatingTimer("UpdateAllUnit", self.db.profile.frequency)
end

function GridStatusRaidDebuff:RegisterStatuses()
	self:RegisterStatus("alert_RaidDebuff", L["Raid Debuff"])
	self:CreateMainMenu()
end

function GridStatusRaidDebuff:UnregisterStatuses()
	self:UnregisterStatus("alert_RaidDebuff")
end

function GridStatusRaidDebuff:Grid_UnitJoined(event, guid, unitid)
	self:ScanUnit(unitid, guid)
end

function GridStatusRaidDebuff:PLAYER_TALENT_UPDATE()
	if myClass == "PALADIN" then
		myDispellable["Magic"] = (select(5,GetTalentInfo(1,14)) == 1)
	elseif myClass == "DRUID" then
		myDispellable["Magic"] = (select(5,GetTalentInfo(3,17)) == 1)
	elseif myClass == "SHAMAN" then
		myDispellable["Magic"] = (select(5,GetTalentInfo(3,12)) == 1)
	end
end

function GridStatusRaidDebuff:UpdateAllUnit()
	for guid, unitid in GridRoster:IterateRoster() do
		self:ScanUnit(unitid, guid)
	end
end

function GridStatusRaidDebuff:ScanNewDebuff(e, ts, event, hideCaster, srcguid, srcname, srcflg, srcraidflg, dstguid, dstname, dstflg, dstraidflg, spellId, name)
	local settings = self.db.profile["alert_RaidDebuff"]
	if (settings.enable and debuff_list[realzone]) then
		if event == "SPELL_AURA_APPLIED" and srcguid and not GridRoster:IsGUIDInRaid(srcguid) and GridRoster:IsGUIDInRaid(dstguid)
			and not debuff_list[realzone][name] then
			if spellId == 1604 then return end --Ignore Dazed
			self:Debug("New Debuff", srcname, dstname, name)

			self:DebuffLocale(realzone, name, spellId, 5, 5, true, true)
			if not self.db.profile.detected_debuff[realzone] then self.db.profile.detected_debuff[realzone] = {} end
			if not self.db.profile.detected_debuff[realzone][name] then self.db.profile.detected_debuff[realzone][name] = spellId end

			self:LoadZoneDebuff(realzone, name)
		end
	end
end

function GridStatusRaidDebuff:ScanUnit(unitid, unitGuid)
	local guid = unitGuid or UnitGUID(unitid)
	--if not GridRoster:IsGUIDInRaid(guid) then	return end

	local name, rank, icon, count, debuffType, duration, expirationTime, caster, isStealable
	local settings = self.db.profile["alert_RaidDebuff"]

	if (settings.enable and debuff_list[realzone]) then
		local d_name, di_prior, dc_prior, dt_prior, d_icon,d_color,d_startTime,d_durTime,d_count
		local data

		di_prior = 0
		dc_prior = 0
		dt_prior = 0

		local index = 0
		while true do
			index = index + 1
			name, _, icon, count, debuffType, duration, expirationTime, caster, isStealable = UnitAura(unitid, index, "HARMFUL")

			if not name then
				break
			end

			if debuff_list[realzone][name] then
				data = debuff_list[realzone][name]

				if not data.disable and
				   not (self.db.profile.ignDis and myDispellable[debuffType]) and
				   not (self.db.profile.ignUndis and debuffType and not myDispellable[debuffType]) then

					if di_prior < data.i_prior then
						di_prior = data.i_prior
						d_name = name
						d_icon = 	not data.noicon and icon
						if data.timer and dt_prior < data.i_prior then
							d_startTime = expirationTime - duration
							d_durTime = duration
						end
					end
					--Stack
					if data.stackable then
						d_count = count
					end
					--Color Priority
					if dc_prior < data.c_prior then
						dc_prior = data.c_prior
						d_color = (data.custom_color and data.color) or colorMap[debuffType] or settings.color
					end
				end
			end
		end

		if d_color and not d_color.a then
			d_color.a = settings.color.a
		end

		if d_color and d_color.a == 0 then
			d_color.a = 1
		end

		if d_name then
			self.core:SendStatusGained(
			guid, "alert_RaidDebuff", settings.priority, (settings.range and 40),
			d_color, nil, nil, nil, d_icon, d_startTime, d_durTime, d_count)
		else
			self.core:SendStatusLost(guid, "alert_RaidDebuff")
		end
	else
		self.core:SendStatusLost(guid, "alert_RaidDebuff")
	end
end

---------------------------------------------------------
--	For External
---------------------------------------------------------
local function getDb(zone, name, arg, ret)
	if db[zone] and db[zone][name] and db[zone][name][arg] ~= nil then
		return db[zone][name][arg]
	end
	return ret
end

local function insertDb(zone, name, arg, value)
	if not db[zone] then db[zone] = {} end
	if not db[zone][name] then db[zone][name] = {} end

	if arg then
		db[zone][name][arg] = value
	end
end

function GridStatusRaidDebuff:DebuffLocale(zone, first, second, icon_priority, color_priority, timer, stackable, color, default_disable, noicon)
	local name, icon, id
	local args, data, order
	local detected

	self:CreateZoneMenu(zone)

	if type(first) == "number" then
		name, _, icon = GetSpellInfo(first)
		id = first
		order = second
	else
		name, _, icon = GetSpellInfo(second)
		id = second
		order = 9999
		detected = true
	end

	if name and not debuff_list[zone][name] then
		debuff_list[zone][name] = {}
		data = debuff_list[zone][name]

		data.debuffId = id
		data.icon = icon
		data.order = order
		data.disable = getDb(zone,name,"disable",default_disable)
		data.i_prior = getDb(zone,name,"i_prior",icon_priority)
		data.c_prior = getDb(zone,name,"c_prior",color_priority)
		data.custom_color = getDb(zone,name,"custom_color",color ~= nil)
		data.color = getDb(zone,name,"color",color)
		data.stackable = getDb(zone,name,"stackable",stackable)
		data.timer = getDb(zone,name,"timer",timer)
		data.noicon = getDb(zone,name,"noicon",noicon)
		data.detected = detected
	end
end

function GridStatusRaidDebuff:Debuff(en_zone, first, second, icon_priority, color_priority, timer, stackable, color, default_disable, noicon)
	local zone = bzone[en_zone]

	if (zone) then
		-- Call with localized zone
		self:DebuffLocale(zone, first, second, icon_priority, color_priority, timer, stackable, color, default_disable, noicon)
	else
		-- The structure is stored by localized zone
		-- If we only have the English zone and not the localized one
		-- we can't store it
		-- self:Debug("Debuff", realzone, enzone, "en_zone translation not found")
		warn(("LibBabble translation for zone %q not found"):format(en_zone))
	end
end

function GridStatusRaidDebuff:BossNameLocale(zone, order, en_boss)
	local boss = en_boss or order
	if (en_boss and bboss[en_boss]) then
		boss = en_boss and bboss[en_boss]
	end

	-- If both en_boss and order are defined, otherwise
	-- default to 9998 for order
	local ord = en_boss and order or 9998

	self:CreateZoneMenu(zone)

	local args = self.options.args

	args[zone].args[boss] = {
			type = "group",
			name = fmt("%s%s%s","   [ ", boss," ]"),
                        desc = L["Option for %s"]:format(boss),
			order = ord,
			guiHidden = true,
			args = {}
	}
end

function GridStatusRaidDebuff:BossName(en_zone, order, en_boss)
	local zone = bzone[en_zone]

	if (zone) then
		self:BossNameLocale(zone, order, en_boss)
	else
		-- The structure is stored by localized zone
		-- If we only have the English zone and not the localized one
		-- we can't store it
		-- self:Debug("BossName", realzone, enzone, "zone translation not found")
		warn(("LibBabble translation for zone %q not found"):format(en_zone))
	end
end

-- Create a custom tooltip for debuff description
local tip = CreateFrame("GameTooltip", "GridStatusRaidDebuffTooltip", nil, "GameTooltipTemplate")
tip:SetOwner(UIParent, "ANCHOR_NONE")
for i = 1, 10 do
	tip[i] = _G["GridStatusRaidDebuffTooltipTextLeft"..i]
	if not tip[i] then
		tip[i] = tip:CreateFontString()
		tip:AddFontStrings(tip[i], tip:CreateFontString())
	end
end


function GridStatusRaidDebuff:LoadZoneMenu(zone)
	local args = self.options.args[zone].args
	local settings = self.db.profile["alert_RaidDebuff"]

	for i,k in pairs(args) do
		if k.guiHidden then
			k.guiHidden = false
		end
	end

	for name,_ in pairs(debuff_list[zone]) do
		self:LoadZoneDebuff(zone, name)
	end
end

function GridStatusRaidDebuff:LoadZoneDebuff(zone, name)
	local description, menuName, icon, data, k
	local args = self.options.args[zone].args

	k = debuff_list[zone][name]

	if not args[name] then
		description = L["Enable %s"]:format(name)

		tip:SetHyperlink("spell:"..k.debuffId)
		if tip:NumLines() > 1 then
			description = tip[tip:NumLines()]:GetText()
		end

		menuName = fmt("|T%s:0|t%s", k.icon, name)

		args[name] = {
			type = "group",
			name = menuName,
			desc = description,
			order = k.order,
			args = {
				["enable"] = {
					type = "toggle",
					name = L["Enable"],
					desc = L["Enable %s"]:format(name),
					order = 1,
					get = function()
									return not k.disable
								end,
					set = function(_, v)
									insertDb(zone,name,"disable",not v)
									k.disable = not v
									self:UpdateAllUnit()
								end,
				},
				["icon priority"] = {
					type = "range",
					name = L["Icon Priority"],
					desc = L["Option for %s"]:format(L["Icon Priority"]),
					order = 2,
					min = 1,
					max = 10,
					step = 1,
					get = function()
									return k.i_prior
								end,
					set = function(_, v)
									insertDb(zone,name,"i_prior",v)
									k.i_prior = v
									self:UpdateAllUnit()
								end,
				},
				["color priority"] = {
					type = "range",
					name = L["Color Priority"],
					desc = L["Option for %s"]:format(L["Color Priority"]),
					order = 3,
					min = 1,
					max = 10,
					step = 1,
					get = function()
									return k.c_prior
								end,
					set = function(_, v)
									insertDb(zone,name,"c_prior",v)
									k.c_prior = v
									self:UpdateAllUnit()
								end,
				},
				["Remained time"] = {
					type = "toggle",
					name = L["Remained time"],
					desc = L["Enable %s"]:format(L["Remained time"]),
					order = 4,
					get = function()
									return k.timer
								end,
					set = function(_, v)
									insertDb(zone,name,"timer",v)
									k.timer = v
									self:UpdateAllUnit()
								end,
				},
				["Stackable debuff"] = {
					type = "toggle",
					name = L["Stackable debuff"],
					desc = L["Enable %s"]:format(L["Stackable debuff"]),
					order = 5,
					get = function()
									return k.stackable
								end,
					set = function(_, v)
									insertDb(zone,name,"stackable",v)
									k.stackable = v
									self:UpdateAllUnit()
								end,
				},
				["only color"] = {
					type = "toggle",
					name = L["Only color"],
					desc = L["Only color"],
					order = 7,
					get = function()
									return k.noicon
								end,
					set = function(_, v)
									insertDb(zone,name,"noicon",v)
									k.noicon = v
									self:UpdateAllUnit()
								end,
				},
				["custom color"] = {
					type = "toggle",
					name = L["Custom Color"],
					desc = L["Enable %s"]:format(L["Custom Color"]),
					order = 7,
					get = function()
									return k.custom_color
								end,
					set = function(_, v)
									insertDb(zone,name,"custom_color",v)
									k.custom_color = v
									if v then
										insertDb(zone,name,"color", {r = 0, g = 0, b = 0})
										k.color = {r = 0, g = 0, b = 0}
									end
									self:UpdateAllUnit()
								end,
				},
				["color"] = {
					type = "color",
					name = L["Color"],
					desc = L["Option for %s"]:format(L["Color"]),
					order = 8,
					disabled = function()
											return not k.custom_color
										end,
					hasAlpha = false,
					get = function ()
									t = getDb(zone,name,"color", color or {r = 1, g = 0, b = 0})
									return t.r, t.g, t.b
							  end,
					set = function (_, ir, ig, ib)
									local t = {r = ir, g = ig, b = ib}
									insertDb(zone,name,"color",t)
								  k.color = t
								  self:UpdateAllUnit()
							  end,
				},
				["remove"] = {
					type = "execute",
					name = L["Remove"],
					desc = L["Remove"],
					order = 9,
					disabled = not k.detected,
					func = function()
									self.db.profile.detected_debuff[zone][name] = nil
									debuff_list[zone][name] = nil
									args[name] = nil
									self:UpdateAllUnit()
								end,
				},
				["link"] = {
				  type = "execute",
					name = "Link",
					desc = "Link",
					order = 10,
					func = function()
									local chatWindow = ChatEdit_GetActiveWindow()
            			if chatWindow then
            				chatWindow:Insert(GetSpellLink(k.debuffId))
            			end
								end,
				},
			},
		}
	end
end


function GridStatusRaidDebuff:CreateZoneMenu(zone)
	local args
	if not debuff_list[zone] then
		debuff_list[zone] = {}

		args = self.options.args

		args[zone] = {
			type = "group",
			name = zone,
			desc = L["Option for %s"]:format(zone),
			args = {
				["load zone"] = {
					type = "execute",
					name = L["Load"],
					desc = L["Load"],
					func = function()
						self:LoadZoneMenu(zone)
						if not args[zone].args["load zone"].disabled then args[zone].args["load zone"].disabled = true end
					end,
				},
				["remove all"] = {
					type = "execute",
					name = L["Remove detected debuff"],
					desc = L["Remove detected debuff"],
					func = function()
									if self.db.profile.detected_debuff[zone] then
										for name,k in pairs(self.db.profile.detected_debuff[zone]) do
											self.db.profile.detected_debuff[zone][name] = nil
											debuff_list[zone][name] = nil
											args[zone].args[name] = nil
											self:UpdateAllUnit()
										end
									end
					end,
				},
				["import debuff"] = {
					type = "input",
					name = L["Import Debuff"],
					desc = L["Import Debuff Desc"],
					get = false,
					usage = "SpellID",
					set = function(_, v)
						local name = GetSpellInfo(v)
						if name then						  
        						self:DebuffLocale(zone, name, v, 5, 5, true, true)
							if not self.db.profile.detected_debuff[zone][name] then 
								self.db.profile.detected_debuff[zone][name] = v
								self:LoadZoneDebuff(zone, name)
								self:UpdateAllUnit() 
							end
						end
					end,
				},
			},
		}
	end
end

function GridStatusRaidDebuff:CreateMainMenu()
	local args = self.options.args

	for i,k in pairs(args["alert_RaidDebuff"].args) do
		args[i] = k
	end

	args["alert_RaidDebuff"].hidden = true

	args["Border"] = {
			type = "toggle",
			name = L["Border"],
			desc = L["Enable %s"]:format(L["Border"]),
			order = 98,
			disabled = InCombatLockdown,
			get = function() return GridFrame.db.profile.statusmap["border"].alert_RaidDebuff end,
			set = function(_, v)
							GridFrame.db.profile.statusmap["border"].alert_RaidDebuff  =  v
							GridFrame:UpdateAllFrames()
						end,
	}
	args["Icon"] = {
			type = "toggle",
			name = L["Center Icon"],
			desc = L["Enable %s"]:format(L["Center Icon"]),
			order = 99,
			disabled = InCombatLockdown,
			get = function() return GridFrame.db.profile.statusmap["icon"].alert_RaidDebuff end,
			set = function(_, v)
							GridFrame.db.profile.statusmap["icon"].alert_RaidDebuff  =  v
							GridFrame:UpdateAllFrames()
						end,
	}
	args["Ignore dispellable"] = {
		type = "toggle",
		name = L["Ignore dispellable debuff"],
		desc = L["Ignore dispellable debuff"],
		order = 100,
		get = function() return self.db.profile.ignDis end,
		set = function(_, v)
						self.db.profile.ignDis = v
						self:UpdateAllUnit()
					end,

	}
	args["Ignore undispellable"] = {
		type = "toggle",
		name = L["Ignore undispellable debuff"],
		desc = L["Ignore undispellable debuff"],
		order = 101,
		get = function() return self.db.profile.ignUndis end,
		set = function(_, v)
						self.db.profile.ignUndis = v
						self:UpdateAllUnit()
					end,
	}
	args["Frequency"] = {
		type = "range",
		name = L["Aura Refresh Frequency"],
		desc = L["Aura Refresh Frequency"],
		min = 0.01,
		max = 0.5,
		order = 102,
		step = 0.01,
		get = function()
						return self.db.profile.frequency
					end,
		set = function(_, v)
						self.db.profile.frequency = v
					end,
	}
	args["Detect"] = {
		type = "toggle",
		name = L["detector"],
		desc = L["Enable %s"]:format(L["detector"]),
		order = 103,
		get = function() return self.db.profile.detect end,
		set = function()		        
						self.db.profile.detect = not self.db.profile.detect
		        local detectEnable = self.db.profile.detect
						if detectEnable then
							ChatFrame1:AddMessage(L.msgAct)
						else
							ChatFrame1:AddMessage(L.msgDeact)
						end
						self:ZoneCheck()
					end,
	}
end

function GridStatusRaidDebuff:RegisterCustomDebuff()
	-- local en_zone
	for zone,j in pairs(self.db.profile.detected_debuff) do
		self:BossNameLocale(zone, L["Detected debuff"])

		-- en_zone = bzoneRev[zone]

		for name,k in pairs(j) do
			self:DebuffLocale(zone, name, k, 5, 5, true, true)
		end
	end
end

