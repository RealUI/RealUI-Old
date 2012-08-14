local ReforgingInfo = LibStub("LibReforgingInfo-1.0")
local reforgedStr = REFORGED

local function ExtendTooltip(tip, itemLink)
	if ReforgingInfo:IsItemReforged(itemLink) then
		local regions = {tip:GetRegions()}
		for i = 1, #regions do
			local region = regions[i]
			if region and region:GetObjectType() == "FontString" then
				local text = region:GetText()
				if text and text == reforgedStr then
					local rid = ReforgingInfo:GetReforgeID(itemLink)
					local minus, plus = ReforgingInfo:GetReforgedStatShortNames(rid)
					if minus and plus then
						local newText = text .. " (" .. minus .. " -> " .. plus .. ")"
						region:SetText(newText)
						tip:Show()
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
		HookTooltips()
	end
end

f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("ADDON_LOADED")

