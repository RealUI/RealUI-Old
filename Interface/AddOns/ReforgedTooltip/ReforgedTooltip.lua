local ReforgingInfo = LibStub("LibReforgingInfo-1.0")

local strmatch = strmatch -- string.match
local gsub = gsub -- string.gsub

local reforgedStr = REFORGED

-- These are localized constants provied by WoW
-- They contain patterns like "%s" and "%c". %s will be replaced with a number,
-- %c will be replaced with + (not sure if this is the same for all locales).
local LINE_PATTERNS = {
	ITEM_MOD_SPIRIT,          -- e.g. "%c%s Spirit"
	ITEM_MOD_DODGE_RATING,    -- e.g. "Increases your dodge by %s."
	ITEM_MOD_PARRY_RATING,
	ITEM_MOD_HIT_RATING,
	ITEM_MOD_CRIT_RATING,
	ITEM_MOD_HASTE_RATING,
	ITEM_MOD_EXPERTISE_RATING,
	ITEM_MOD_MASTERY_RATING
}

-- Turns the string.format patterns into string.match patterns
local patternsReady = false
local function PreparePatterns()
	if patternsReady then return end
	patternsReady = true

	local i, s
	for i, s in ipairs(LINE_PATTERNS) do
		-- 4.x
		s = gsub(s, "%%d", "(%%d+)")
		s = gsub(s, "%%1$c", "%%+")
		s = gsub(s, "%%2$d", "(%%d+)")
		-- 5.x
		s = gsub(s, "%%s", "(%%d+)")
		s = gsub(s, "%%c", "%%+") -- not sure if correct for every locale

		LINE_PATTERNS[i] = s
	end
end

local function ExtendTooltip(tip, itemLink)
	if ReforgingInfo:IsItemReforged(itemLink) then
		-- get the pattern to extract the value of the reforged stat from the toolip
		local rid = ReforgingInfo:GetReforgeID(itemLink)
		local _, incStatId = ReforgingInfo:GetReforgedStatIDs(rid)
		local incStatPattern = LINE_PATTERNS[incStatId]
		local reforgedValue -- will be the value of the reforged stat (if found)

		-- loop through all lines in the tooltip, in reverse order
		-- the line we will replace will be above the stat lines, so we can extract
		-- the stat value first
		local regions = {tip:GetRegions()}
		for i = #regions, 1, -1 do
			local region = regions[i]
			if region and region:GetObjectType() == "FontString" then
				local text = region:GetText()
				if text then

					if text == reforgedStr then
						-- the "Reforged" line at the top we will replace
						local minus, plus = ReforgingInfo:GetReforgedStatShortNames(rid)
						if minus and plus then
							local newText = text .. " ("
							if reforgedValue then
								newText = newText .. reforgedValue .. " " .. minus .. " -> " ..
									reforgedValue .. " " .. plus .. ")"
							else
								newText = newText .. minus .. " -> " .. plus .. ")"
							end
							region:SetText(newText)
							tip:Show()
						end
					elseif incStatPattern then
						-- check if it contains the value of the reforged stat
						local value = strmatch(text, incStatPattern)
						if value then
							-- it does!
							reforgedValue = value
						end
					end
				end

			end
		end
	end
end

local function hookTip(tooltip, method, action)
	if not tooltip then return end
	hooksecurefunc(tooltip, method, function(tip, ...)
		local link, count = action(...)
		if link then
			ExtendTooltip(tip, link)
		end
	end)
end

local function hookCompareTip(tooltip)
	if not tooltip then return end
	hooksecurefunc(tooltip, 'SetHyperlinkCompareItem', function(tip, mainLink)
		local _, link = tip:GetItem()
		if link then
			ExtendTooltip(tip, link)
		end
	end)
end

local function hookTipScript(tooltip)
	if tooltip and tooltip.HookScript then
		tooltip:HookScript('OnTooltipSetItem', function(tip, ...)
			local _, link = tip:GetItem()
			if link and GetItemInfo(link) then
				ExtendTooltip(tip, link)
			end
		end)
	end
end

local hooked = false
local function HookTooltips()
	if hooked then return end
	hooked = true

	hookTipScript(GameTooltip)
	hookTipScript(ItemRefTooltip)

	hookCompareTip(ShoppingTooltip1)
	hookCompareTip(ShoppingTooltip2)
	hookCompareTip(ShoppingTooltip3)
	hookCompareTip(ItemRefShoppingTooltip1)
	hookCompareTip(ItemRefShoppingTooltip2)
	hookCompareTip(ItemRefShoppingTooltip3)

	if LinkWrangler and LinkWrangler.RegisterCallback then
		LinkWrangler.RegisterCallback("ReforgedTooltip", function(frame,link)
			ExtendTooltip(frame,link)
		end, "item")
	end
end

-- The following stuff is unfortunately necessary, because some addons *override*
-- the tooltip handlers instead of hooking them :(

local f = CreateFrame("Frame")
local entered = false
local elapsed = 0
local timerStarted = false
f:SetScript("OnEvent", function(f, e, ...) f[e](f, ...) end)

function f:PLAYER_ENTERING_WORLD()
	entered = true
	f:ScheduleHook()
end

function f:ADDON_LOADED()
	if entered then
		f:ScheduleHook()
	end
end

function f:ScheduleHook()
	if timerStarted then
		elapsed = 0
	else
		f:SetScript("OnUpdate", f.OnTimer)
	end
end

function f:OnTimer(eps)
	elapsed = elapsed + eps
	if elapsed >= 3 then
		f:SetScript("OnUpdate", nil)
		PreparePatterns()
		HookTooltips()
	end
end

f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("ADDON_LOADED")

