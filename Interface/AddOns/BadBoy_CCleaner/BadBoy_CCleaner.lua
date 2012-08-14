
local knownIcons = { --list of all known raid icon chat shortcuts
	"{rt%d}",
	"{RT%d}",
	"{x}",
	"{X}",
	"{"..(RAID_TARGET_1):lower().."}",
	"{"..(RAID_TARGET_2):lower().."}",
	"{"..(RAID_TARGET_3):lower().."}",
	"{"..(RAID_TARGET_4):lower().."}",
	"{"..(RAID_TARGET_5):lower().."}",
	"{"..(RAID_TARGET_6):lower().."}",
	"{"..(RAID_TARGET_7):lower().."}",
	"{"..(RAID_TARGET_8):lower().."}",
	"{"..(RAID_TARGET_1):upper().."}",
	"{"..(RAID_TARGET_2):upper().."}",
	"{"..(RAID_TARGET_3):upper().."}",
	"{"..(RAID_TARGET_4):upper().."}",
	"{"..(RAID_TARGET_5):upper().."}",
	"{"..(RAID_TARGET_6):upper().."}",
	"{"..(RAID_TARGET_7):upper().."}",
	"{"..(RAID_TARGET_8):upper().."}",
}
local replace = string.gsub
BadBoyConfig:RegisterEvent("ADDON_LOADED")
BadBoyConfig:SetScript("OnEvent", function(frame, evt, addon)
	if addon ~= "BadBoy_CCleaner" then return end
	if type(BADBOY_CCLEANER) ~= "table" then
		BADBOY_CCLEANER = {
			"anal",
			"dirge",
			"murloc",
			"rape",
		}
	end
	table.sort(BADBOY_CCLEANER)
	local text
	for i=1, #BADBOY_CCLEANER do
		if not text then
			text = BADBOY_CCLEANER[i]
		else
			text = text.."\n"..BADBOY_CCLEANER[i]
		end
	end
	BadBoyCCleanerEditBox:SetText(text or "")
	BadBoyCCleanerNoIconButton:SetChecked(BADBOY_NOICONS)

	--main filtering function
	local filter = function(_,event,msg,player,...)
		local chanid, found, modify = select(5, ...), 0, nil
		if event == "CHAT_MSG_CHANNEL" and chanid == 0 then return end --Only scan official custom channels (gen/trade)
		if not CanComplainChat(player) or UnitIsInMyGuild(player) then return end --Don't filter ourself/friends/guild
		local lowMsg = (msg):lower() --lower all text
		for i=1, #BADBOY_CCLEANER do --scan DB for matches
			if lowMsg:find(BADBOY_CCLEANER[i]) then
				if BadBoyLogger then BadBoyLogger("CCleaner", event, player, msg) end
				return true --found a trigger, filter
			end
		end
		if BADBOY_NOICONS then
			for i = 1, #knownIcons do
				msg, found = replace(msg, knownIcons[i], "")
				if found > 0 then modify = true end --Set to true if we remove a raid icon from this message
			end
			if modify then --only modify message if we removed an icon
				return false, msg, player, ...
			end
		end
	end
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", filter)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", filter)

	frame:SetScript("OnEvent", nil)
	frame:UnregisterEvent("ADDON_LOADED")
end)

