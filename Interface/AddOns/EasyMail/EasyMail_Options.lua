
---------------------------------------------------
-- Global vars
---------------------------------------------------
EasyMail_ClearAll = false;

---------------------------------------------------
-- Local vars
---------------------------------------------------
local CurRealm = "";
local CurFaction = "";

local Old_InterfaceOptionsFrameOkay_OnClick = nil;

-- Durability status warning dialog
StaticPopupDialogs["EASYMAIL_LENGTHWARNING"] = {
	text = "",
	button1 = OKAY,
	timeout = 0,
	showAlert = 1,
	whileDead = 1,
	exclusive = 1,
	hideOnEscape = 1
};

---------------------------------------------------
-- EasyMail_SetupOptions
-- Set up slash commands and register in Khaos
---------------------------------------------------
function EasyMail_SetupOptions()
	CurRealm = GetRealmName();
	CurFaction = UnitFactionGroup("player");

	Old_InterfaceOptionsFrameOkay_OnClick = InterfaceOptionsFrameOkay_OnClick;
	InterfaceOptionsFrameOkay_OnClick = EasyMail_InterfaceOptionsFrameOkayOnClick;
end


---------------------------------------------------
-- EasyMail_SetDefaults
---------------------------------------------------
function EasyMail_SetDefaults()
	EasyMail_SavedVars[CurRealm][CurFaction].LastAddressee = {};
	EasyMail_SavedVars[CurRealm][CurFaction].MailListLen = EASYMAIL_DEFAULTLISTLEN;
	EasyMail_SavedVars.AutoAdd = "N";
	EasyMail_SavedVars.Guild = "N";
	EasyMail_SavedVars.Friends = "N";
	EasyMail_SavedVars.BlizzList = "N";
	EasyMail_SavedVars.ClickGet = "N";
	EasyMail_SavedVars.ClickDel = "N";
	EasyMail_SavedVars.DelPending = "N";
	EasyMail_SavedVars.Money = "Y";
	EasyMail_SavedVars.Total = "Y";
	EasyMail_SavedVars.TextTooltip = "N";
	EasyMail_SavedVars.DelPrompt = "Y";
end


---------------------------------------------------
-- EasyMail_OptionsDefault
---------------------------------------------------
function EasyMail_OptionsDefault()
	EasyMail_SetDefaults();
	EasyMail_ClearAll = true;
	EasyMail_UpdateInterface();
end


---------------------------------------------------
-- EasyMail_OptionsRefresh
---------------------------------------------------
function EasyMail_OptionsRefresh(self)
	EasyMail_OptionsPanelAutoAdd:SetChecked(EasyMail_SavedVars.AutoAdd == "Y");
	EasyMail_OptionsPanelListLen:SetNumber(EasyMail_SavedVars[CurRealm][CurFaction].MailListLen);
	EasyMail_OptionsPanelListLen:SetCursorPosition(0);
	EasyMail_OptionsPanelFriends:SetChecked(EasyMail_SavedVars.Friends == "Y");
	EasyMail_OptionsPanelGuild:SetChecked(EasyMail_SavedVars.Guild == "Y");
	EasyMail_OptionsPanelBlizzList:SetChecked(EasyMail_SavedVars.BlizzList == "Y");
	EasyMail_OptionsPanelClickGet:SetChecked(EasyMail_SavedVars.ClickGet == "Y");
	EasyMail_OptionsPanelClickDel:SetChecked(EasyMail_SavedVars.ClickDel == "Y");
	EasyMail_OptionsPanelDelPending:SetChecked(EasyMail_SavedVars.DelPending == "Y");
	EasyMail_OptionsPanelMoney:SetChecked(EasyMail_SavedVars.Money == "Y");
	EasyMail_OptionsPanelTotal:SetChecked(EasyMail_SavedVars.Total == "Y");
	EasyMail_OptionsPanelTextTooltip:SetChecked(EasyMail_SavedVars.TextTooltip == "Y");
	EasyMail_OptionsPanelDelPrompt:SetChecked(EasyMail_SavedVars.DelPrompt == "Y");
end


---------------------------------------------------
-- EasyMail_InterfaceOptionsFrameOkayOnClick
---------------------------------------------------
function EasyMail_InterfaceOptionsFrameOkayOnClick(isApply)
	-- Check for valid entries
	local listlen = EasyMail_OptionsPanelListLen:GetNumber();

	if (listlen < EASYMAIL_MINLISTLEN or listlen > EASYMAIL_MAXLISTLEN) then
		StaticPopupDialogs["EASYMAIL_LENGTHWARNING"].text 
			= format(EASYMAIL_ERROUTOFRANGE, EASYMAIL_MINLISTLEN, EASYMAIL_MAXLISTLEN);
		StaticPopup_Show("EASYMAIL_LENGTHWARNING");
		EasyMail_OptionsPanelListLen:SetFocus();
		return;
	end
	
	Old_InterfaceOptionsFrameOkay_OnClick(isApply);
end


---------------------------------------------------
-- EasyMail_OptionsOkay
---------------------------------------------------
function EasyMail_OptionsOkay()
	EasyMail_SavedVars.AutoAdd = ((EasyMail_OptionsPanelAutoAdd:GetChecked() and "Y") or "N");
	EasyMail_SavedVars[CurRealm][CurFaction].MailListLen = EasyMail_OptionsPanelListLen:GetNumber();
	EasyMail_SavedVars.Guild = ((EasyMail_OptionsPanelGuild:GetChecked() and "Y") or "N");
	EasyMail_SavedVars.Friends = ((EasyMail_OptionsPanelFriends:GetChecked() and "Y") or "N");
	EasyMail_SavedVars.BlizzList = ((EasyMail_OptionsPanelBlizzList:GetChecked() and "Y") or "N");
	EasyMail_SavedVars.ClickGet = ((EasyMail_OptionsPanelClickGet:GetChecked() and "Y") or "N");
	EasyMail_SavedVars.ClickDel = ((EasyMail_OptionsPanelClickDel:GetChecked() and "Y") or "N");
	EasyMail_SavedVars.DelPending = ((EasyMail_OptionsPanelDelPending:GetChecked() and "Y") or "N");
	EasyMail_SavedVars.Money = ((EasyMail_OptionsPanelMoney:GetChecked() and "Y") or "N");
	EasyMail_SavedVars.Total = ((EasyMail_OptionsPanelTotal:GetChecked() and "Y") or "N");
	EasyMail_SavedVars.TextTooltip = ((EasyMail_OptionsPanelTextTooltip:GetChecked() and "Y") or "N");
	EasyMail_SavedVars.DelPrompt = ((EasyMail_OptionsPanelDelPrompt:GetChecked() and "Y") or "N");
	
	EasyMail_UpdateInterface();
end


---------------------------------------------------
-- EasyMail_UpdateInterface
---------------------------------------------------
function EasyMail_UpdateInterface()
	if (EasyMail_ClearAll) then
		EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList = {};
		EasyMail_ClearAll = false;
	else
		local newLen = EasyMail_SavedVars[CurRealm][CurFaction].MailListLen;
		
		if (newLen < #EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList) then
			-- Remove oldest entries on list when the list is longer than the new length
			for i = 1, #EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList - newLen do
				tremove(EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList, 1)
			end
		end
	end
	
	if (EasyMail_SavedVars.AutoAdd == "Y") then
		EasyMail_SaveAddressee(UnitName("player"), true);
	end;
	
	if (IsInGuild() and EasyMail_SavedVars.Guild == "Y") then
		TimeSinceLastGuildQuery = 3;
		GuildQueryInterval = .5;
	end

	if (EasyMail_SavedVars.Friend == "Y") then
		TimeSinceLastFriendQuery = 3;
		FriendQueryInterval = .5;
	end
	
	EasyMail_SortList();
end
