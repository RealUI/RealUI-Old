--[[

EasyMail

Mail frame mod that remembers last mail addressee for each character and allows the user to select addressee from 
a list of recently mailed players. Also allows the user to automatically take all attachments from an open mail or
get all attachments from all selected mails.

]]

---------------------------------------------------
-- Global vars
---------------------------------------------------
-- Set defaults
EASYMAIL_ADDONNAME = "EasyMail";
EASYMAIL_SLASHCMD = "easymail";

-- List length default and constraints
EASYMAIL_DEFAULTLISTLEN = 15;
EASYMAIL_MINLISTLEN = 8;
EASYMAIL_MAXLISTLEN = 40;

EASYMAIL_LISTLENMAX = 15;
EASYMAIL_BUTTONHEIGHT = 16;

-- Clear list dialog
StaticPopupDialogs["EASYMAIL_CLEARLIST"] = {
	text = EASYMAIL_CLEARQUESTION,
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		EasyMail_ClearList();
	end,
	timeout = 0,
	showAlert = 1,
	exclusive = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["EASYMAIL_DELETENAME"] = {
	text = "temp",
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		EasyMail_DeleteName();
	end,
	timeout = 0,
	showAlert = 1,
	exclusive = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["EASYMAIL_DELETEMAIL"] = {
	text = EASYMAIL_DELETEQUESTION,
	button1 = TEXT(YES),
	button2 = TEXT(NO),
	OnAccept = function()
		EasyMail_ClickDelete();
	end,
	timeout = 0,
	showAlert = 1,
	exclusive = 1,
	hideOnEscape = 1
};

-- Set up saved variables
EasyMail_SavedVars = {};

---------------------------------------------------
-- Local vars
---------------------------------------------------

local Old_PlayerNameAutocomplete;

-- Holds the current text from the addressee field as the user types it
local CurrentAddressee = "";

-- Holds the sorted recently-mailed list
local SortedList = {};

local DropdownTimer = 0;
local IsDropdownCounting = false;

-- Holds the complete dropdown list
local FullList = {};
local MenuResized = false;

local CurPlayer = "";
local CurRealm = "";
local CurFaction = "";

-- Name to delete from the addressee list
local NameToDel = "";

-- Take all attachments variables
local GettingAtt = false;
local AttIndex = 0;
local TimeSinceLastAtt = 0;
local AttInterval = .5;
local AttTimeout = 10;
local AttTimer = 0;
local CurAtt = nil;

-- Checkbox table
local CheckBoxes = {};
local CheckAll = true;

-- Get all mail attachment variables
local GettingAll = false;
local CurMail = nil;
local DeleteCount = 0;

-- Save settings of default inbox
local MailItemX, MailItemY, ExpireTimeX, ExpireTimeY, MailItemWidth, SubjectWidth;

-- Guild and friends variables
local TimeSinceLastGuildQuery = 0;
local GuildQueryInterval = 3;
local TimeSinceLastFriendQuery = 0;
local FriendQueryInterval = 3;
local GuildList = {};
local FriendList = {};
local TopButtonLoc = nil;

-- Mail to delete through right-click
local DeleteMail = 0;

local MoneySubject = false;
local TotalMoney = 0;

local MaxTooltipWidth = 40;

-- Money constants
local EasyMail_Copper = "";
local EasyMail_Silver = "";
local EasyMail_Gold = "";

local SendingMail = false;


---------------------------------------------------
-- EasyMail_OnLoad
-- Register events when the addon is loaded - Frame: EasyMail_MainFrame
---------------------------------------------------
function EasyMail_OnLoad(self)
	-- Register event that fires when the player logs in
	self:RegisterEvent("PLAYER_LOGIN");
end


---------------------------------------------------
-- EasyMail_OnEvent
-- Handle registered events - Frame: EasyMail_MainFrame
---------------------------------------------------
function EasyMail_OnEvent(self, event, ...)
	local arg1 = ...;
	
	-- PLAYER_LOGIN fires after all addons have loaded and just before the player enters the world
	if ( event == "PLAYER_LOGIN" ) then
		CurPlayer = UnitName("player");
		CurRealm = GetRealmName();
		CurFaction = UnitFactionGroup("player");
		
		-- Register event that fires when the mail frame is opened
		self:RegisterEvent("MAIL_SHOW");

		-- Register event that fires when a mail is sent successfully
		self:RegisterEvent("MAIL_SEND_SUCCESS");
		
		-- Register event that fires when the attachments are redrawn to check to see if attachment was taken
		self:RegisterEvent("MAIL_INBOX_UPDATE");

		-- Register events that fire after querying for guild and friends lists
		self:RegisterEvent("FRIENDLIST_SHOW");
		self:RegisterEvent("FRIENDLIST_UPDATE");
		self:RegisterEvent("GUILD_ROSTER_UPDATE");
		self:RegisterEvent("PLAYER_GUILD_UPDATE");
		
		EasyMail_SetupOptions();
		
		-- Setup saved variables
		if (not EasyMail_SavedVars[CurRealm]) then
			-- Separate saved variable sets for each realm
			EasyMail_SavedVars[CurRealm] = {};
		end
		if (not EasyMail_SavedVars[CurRealm][CurFaction]) then
			-- Separate saved variable sets for each faction
			EasyMail_SavedVars[CurRealm][CurFaction] = {};
		end
		if (not EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList) then
			-- List of all addresses mailed to recently
			EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList = {};
		end
		if (not EasyMail_SavedVars[CurRealm][CurFaction].LastAddressee) then
			-- List of last addressee each character mailed to
			EasyMail_SavedVars[CurRealm][CurFaction].LastAddressee = {};
		end
 		if (not EasyMail_SavedVars[CurRealm][CurFaction].LastAddressee[CurPlayer]) then
			-- Set the default last addressee for this player to empty string
			EasyMail_SavedVars[CurRealm][CurFaction].LastAddressee[CurPlayer] = "";
		end
		
		if (not EasyMail_SavedVars[CurRealm][CurFaction].MailListLen) then
			EasyMail_SetDefaults();
		end
		
		-- Create the sorted recently-mailed list
		EasyMail_SortList();
		
		-- Shorten the addressee field to accomodate dropdown button
		SendMailNameEditBox:SetWidth(SendMailNameEditBox:GetWidth() - 24);
		
		-- Hook to the send mail button to know what addressee was entered since Blizzard clears it on a successful 
		-- mailing
		--hooksecurefunc("SendMailMailButton_OnClick", EasyMail_GetAddressee);
		SendMailMailButton:HookScript("OnClick", EasyMail_GetAddressee);
		
		-- Hook to Blizzard's mail reset function to fill in the addressee field with the last mailed name
		hooksecurefunc("SendMailFrame_Reset", function() EasyMail_SetAddressee(nil, CurrentAddressee); end);
		
		-- Hook to the redraw function for the open mail to move the attachments down a bit to make room for the 
		-- Take All button
		hooksecurefunc("OpenMail_Update", EasyMail_AdjustAtt);
		
		-- Replace inbox onclick to cancel Take All if user changes open emails and to handle right-click
		for t = 1, INBOXITEMS_TO_DISPLAY do
			getglobal("MailItem"..t.."Button"):SetScript("OnClick", EasyMail_MailItemOnClickHandler);
		end
		
		-- Place the Take All button
		EasyMail_AttButton:SetParent(OpenMailFrame);
		
		-- Hook the inbox update function to draw the checkboxes
		hooksecurefunc("InboxFrame_Update", EasyMail_InboxUpdate);
		
		-- Save settings for default inbox
		_, _, _, MailItemX, MailItemY = MailItem1:GetPoint(1);
		MailItemWidth = MailItem1:GetWidth();
		SubjectWidth = MailItem1Subject:GetWidth();
		_, _, _, ExpireTimeX, ExpireTimeY = MailItem1ExpireTime:GetPoint(1);

		-- Adjust inbox to accomodate checkboxes
		EasyMail_ShowCheckBoxes();
		
		-- Hook the mail frame hide function to cancel the get all process
		MailFrame:HookScript("OnHide", EasyMail_StopGetAll);
		
		-- Hook the mail frame show function to reset the Mark All button
		MailFrame:SetScript("OnShow", EasyMail_ResetMarkAll);
		
		-- Hook the take attachment function to display money received
		OpenMailMoneyButton:HookScript("OnClick", EasyMail_PrintMoney);
		
		-- Set scroll frame so that it resets the dropdown hide counter
		EasyMailDropdownScrollFrameScrollBar:SetScript("OnEnter", EasyMail_ScrollOnEnter);
		EasyMailDropdownScrollFrameScrollBar:SetScript("OnLeave", EasyMail_ScrollOnLeave);
		EasyMailDropdownScrollFrameScrollBarScrollUpButton:SetScript("OnEnter", EasyMail_ScrollOnEnter);
		EasyMailDropdownScrollFrameScrollBarScrollUpButton:SetScript("OnLeave", EasyMail_ScrollOnLeave);
		EasyMailDropdownScrollFrameScrollBarScrollDownButton:SetScript("OnEnter", EasyMail_ScrollOnEnter);
		EasyMailDropdownScrollFrameScrollBarScrollDownButton:SetScript("OnLeave", EasyMail_ScrollOnLeave);
		
		-- Create invis buttons for scrollbar to hide dropdown
		CreateFrame("Button", "EasyMail_UpButton", EasyMailDropdownScrollFrameScrollBarScrollUpButton,
			"EasyMailInvisibleButtonTemplate");
		EasyMail_UpButton:SetAllPoints(EasyMailDropdownScrollFrameScrollBarScrollUpButton);
		CreateFrame("Button", "EasyMail_DownButton", EasyMailDropdownScrollFrameScrollBarScrollDownButton,
			"EasyMailInvisibleButtonTemplate");
		EasyMail_DownButton:SetAllPoints(EasyMailDropdownScrollFrameScrollBarScrollDownButton);
		
		-- Hook to money frame to set subject automatically
		SendMailMoneyGold:HookScript("OnTextChanged", EasyMail_MoneySubject);
		SendMailMoneySilver:HookScript("OnTextChanged", EasyMail_MoneySubject);
		SendMailMoneyCopper:HookScript("OnTextChanged", EasyMail_MoneySubject);
		
		-- Hook to inbox item tooltip to display text
		hooksecurefunc("InboxFrameItem_OnEnter", EasyMail_Tooltip);
		
		-- Hook to auto-complete with names from recently-mailed list
		--Old_PlayerNameAutocomplete = PlayerNameAutocomplete;
		--PlayerNameAutocomplete = EasyMail_SendeeAutocomplete;
		
		-- Hooks to addressee edit box for custom auto-complete
		SendMailNameEditBox:SetScript("OnTabPressed", EasyMail_OnTabPressed);
		SendMailNameEditBox:SetScript("OnEditFocusLost", EasyMail_OnEditFocusLost);
		SendMailNameEditBox:SetScript("OnCharComposition", EasyMail_OnCharComposition);
		SendMailNameEditBox:SetScript("OnChar", EasyMail_OnChar);
		SendMailNameEditBox:SetScript("OnEnterPressed", EasyMail_OnEnterPressed);
		SendMailNameEditBox:SetScript("OnEscapePressed", EasyMail_OnEscapePressed);
		SendMailNameEditBox:SetScript("OnTextChanged", EasyMail_OnTextChanged);
		
		-- Reposition too many mails warning at top of inbox
		InboxTooMuchMail:SetPoint("CENTER", InboxTooMuchMail:GetParent(), "CENTER", 7, 232);
		
		-- Add logged-in character to list if option is enabled
		if (EasyMail_SavedVars.AutoAdd == "Y") then
			EasyMail_SaveAddressee(CurPlayer, true);
		end
		
		EasyMail_Copper = EasyMail_Trim(gsub(COPPER_AMOUNT, "%%d", ""));
		EasyMail_Silver = EasyMail_Trim(gsub(SILVER_AMOUNT, "%%d", ""));
		EasyMail_Gold = EasyMail_Trim(gsub(GOLD_AMOUNT, "%%d", ""));
		
		InterfaceOptions_AddCategory(EasyMail_OptionsPanel);
	end

	-- MAIL_SHOW fires when the mailbox is opened and when the user opens a mail
	if ( event == "MAIL_SHOW") then
		-- Set the addressee field to the last mailed name when the user opens the mail frame
		EasyMail_SetAddressee(nil, EasyMail_SavedVars[CurRealm][CurFaction].LastAddressee[CurPlayer]);
	end
	
	-- MAIL_SEND_SUCCESS fires when a mail is successfully sent (check for nil arg1 since it also fires at other
	-- odd times)
	if ( event == "MAIL_SEND_SUCCESS" and SendingMail) then
		-- Save the addressee to the list and set the last mailed addressee for the current character
		EasyMail_SaveAddressee(CurrentAddressee);
	end
	
	-- MAIL_INBOX_UPDATE fires many times during mail work, but I only care about it if we are taking an attachment
	if ( event == "MAIL_INBOX_UPDATE" and GettingAtt and CurAtt ) then
		-- User is trying to take all attachments - make sure the window is still open
		if (OpenMailFrame:IsVisible() and InboxFrame.openMailID and InboxFrame.openMailID >= 1) then
			-- If the current attachment button is not visible, the take was successful
			if (not CurAtt:IsVisible()) then
				-- Reset the take timer, clear the current button, increase index to next button, and run the next
				-- take immediately
				CurAtt = nil;
				TimeSinceLastAtt = AttInterval;
			end
		else
			-- User or take all process closed the mail - stop trying to take all
			GettingAtt = false;
			
			if (OpenMailFrame:IsVisible()) then
				HideUIPanel(OpenMailFrame);
			end
			
			if (GettingAll) then
				-- Take all probably completed, uncheck the checkbox
				CheckBoxes[CurMail] = false;
				InboxFrame_Update();
			end
		end
	end
	
	-- Process guild list
	if (IsInGuild() and (event == "GUILD_ROSTER_UPDATE" or event == "PLAYER_GUILD_UPDATE") 
			and EasyMail_SavedVars.Guild == "Y") then
		EasyMail_GetGuildNames();
	end
	
	-- Process friend list
	if ((event == "FRIENDLIST_SHOW" or event == "FRIENDLIST_UPDATE") and EasyMail_SavedVars.Friends == "Y") then
		EasyMail_GetFriends();
	end
end


---------------------------------------------------
-- EasyMail_OnClick
-- Process the mail dropdown button click
---------------------------------------------------
function EasyMail_OnClick()
	-- Set cursor focus to the addressee field
	SendMailNameEditBox:SetFocus();

	-- Show the addressee dropdown list
	if (EasyMail_MailDropdown:IsShown()) then
		EasyMail_MailDropdown:Hide();
	else
		EasyMail_MailDropdown:Show();
		FauxScrollFrame_SetOffset(EasyMailDropdownScrollFrame, 0);
		EasyMailDropdownScrollFrame:SetVerticalScroll(0);
	end
	
	PlaySound("igMainMenuOptionCheckBoxOn");
end


---------------------------------------------------
-- EasyMail_DropdownOnShow
-- Build the full dropdown list
---------------------------------------------------
function EasyMail_DropdownOnShow(self)
	local t, r;
	FullList = {};
	
	-- Copy sorted list into final display array
	for t = 1, #SortedList do
		r = #FullList + 1;
		FullList[r] = {};
		FullList[r].text = SortedList[t];
	end
	
	-- Add friends
	if (EasyMail_SavedVars.Friends == "Y" and #FriendList > 0) then
		r = #FullList + 1;
		FullList[r] = {};
		FullList[r].text = NORMAL_FONT_COLOR_CODE..EASYMAIL_FRIENDSTEXT;
		FullList[r].noclick = true;
			
		for t = 1, #FriendList do
			r = #FullList + 1;
			FullList[r] = {};
			FullList[r].text = "    "..FriendList[t];
			FullList[r].value = FriendList[t];
		end
	end
	
	-- Add guild members
	if (IsInGuild() and EasyMail_SavedVars.Guild == "Y" and #GuildList > 0) then
		r = #FullList + 1;
		FullList[r] = {};
		FullList[r].text = NORMAL_FONT_COLOR_CODE..EASYMAIL_GUILDTEXT;
		FullList[r].noclick = true;
			
		for t = 1, #GuildList do
			r = #FullList + 1;
			FullList[r] = {};
			FullList[r].text = "    "..GuildList[t];
			FullList[r].value = GuildList[t];
		end
	end;
	
	-- Create Clear Field final entry
	r = #FullList + 1;
	FullList[r] = {};
	FullList[r].text = "|cff00ffff"..EASYMAIL_CLEAROPTION;
	FullList[r].value = "^"..EASYMAIL_CLEAROPTION;
	
	MenuResized = false;
	
	EasyMail_DropdownUpdate();
	
	-- Add scrolling capability to the dropdown list
	if (#FullList > EASYMAIL_LISTLENMAX) then
		EasyMailDropdownScrollFrame:SetParent(EasyMail_MailDropdown);
		EasyMailDropdownScrollFrame:SetPoint("TOPRIGHT", EasyMail_MailDropdown, "TOPRIGHT", -33, -12);
		EasyMailDropdownScrollFrame:Show();
	else
		EasyMailDropdownScrollFrame:Hide();
	end
	
	EasyMail_StartCounting();
end


---------------------------------------------------
-- EasyMail_DropdownUpdate
-- Scroll the dropdown list
---------------------------------------------------
function EasyMail_DropdownUpdate()
	local t, index;
	local numButtons = #FullList;
	local button, buttonText, invisButton;
	local maxwidth = 0;
	
	if (numButtons > EASYMAIL_LISTLENMAX) then
		numButtons = EASYMAIL_LISTLENMAX;
	end
	
	local offset = FauxScrollFrame_GetOffset(EasyMailDropdownScrollFrame);
	
	for t = 1, EASYMAIL_LISTLENMAX do
		index = t + offset;
		button = getglobal("EasyMail_MailDropdownButton"..t);
		
		if (index <= #FullList) then
			invisButton = getglobal("EasyMail_MailDropdownButton"..t.."InvisibleButton");
			buttonText = getglobal("EasyMail_MailDropdownButton"..t.."NormalText");
			button:SetText(FullList[index].text or FullList[index].value);
			
			if (FullList[index].noclick) then
				button:Disable();
				invisButton:Show();
			else
				button.value = (FullList[index].value or FullList[index].text);
				button:Enable();
				invisButton:Hide();
			end
			
			width = buttonText:GetWidth() + 10;
			
			if (width > maxwidth) then
				maxwidth = width;
			end
			
			button:Show();
		else
			button:Hide();
		end
	end
	
	-- Adjust menu width
	if (not MenuResized) then
		for t = 1,  EASYMAIL_LISTLENMAX do
			button = getglobal("EasyMail_MailDropdownButton"..t);
			button:SetWidth(maxwidth);
		end
		
		if (#FullList > EASYMAIL_LISTLENMAX) then
			maxwidth = maxwidth + 15;
		end
		
		EasyMail_MailDropdown:SetWidth(maxwidth + 25);
		
		MenuResized = true;
	
		-- Adjust menu height
		EasyMail_MailDropdown:SetHeight((numButtons * EASYMAIL_BUTTONHEIGHT) + 27);
	end
	
	if (#FullList > EASYMAIL_LISTLENMAX) then
		-- Show or hide scrollbar invis buttons
		if (offset == 0) then
			EasyMail_UpButton:Show();
		else
			EasyMail_UpButton:Hide();
		end

		if (offset == #FullList - EASYMAIL_LISTLENMAX) then
			EasyMail_DownButton:Show();
		else
			EasyMail_DownButton:Hide();
		end
	end

	-- ScrollFrame stuff
	FauxScrollFrame_Update(EasyMailDropdownScrollFrame, #FullList, EASYMAIL_LISTLENMAX, EASYMAIL_BUTTONHEIGHT);
end


---------------------------------------------------
-- EasyMail_DropdownButtonOnClick
-- Called when a dropdown entry is clicked (had to enhance blizzard's version to pass the mouse button param)
---------------------------------------------------
function EasyMail_DropdownButtonOnClick(self, button)
	local value = self.value;
	
	PlaySound("UChatScrollButton");
	
	if (button == "RightButton") then
		if (EasyMail_InMailList(value) > 0) then
			NameToDel = value;
			StaticPopupDialogs["EASYMAIL_DELETENAME"].text = format(EASYMAIL_DELNAMEQUESTION, value);
			StaticPopup_Show("EASYMAIL_DELETENAME");
		else
			return;
		end
	end
	
	if (button == "LeftButton") then
		-- Call the SetAddressee function
		EasyMail_SetAddressee(nil, value);
	end
	
	EasyMail_MailDropdown:Hide();
end


---------------------------------------------------
-- EasyMail_DeleteName
-- Remove the right-clicked name from the addressee list
---------------------------------------------------
function EasyMail_DeleteName()
	table.remove(EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList, EasyMail_InMailList(NameToDel));
	EasyMail_SortList();
	EasyMail_Print(format(EASYMAIL_DELNAMEMSG, NameToDel));
end


---------------------------------------------------
-- EasyMail_ScrollOnEnter
-- Stop the dropdown list hide counter
---------------------------------------------------
function EasyMail_ScrollOnEnter()
	EasyMail_StopCounting();
end


---------------------------------------------------
-- EasyMail_ScrollOnLeave
-- Restart the dropdown list hide counter
---------------------------------------------------
function EasyMail_ScrollOnLeave()
	EasyMail_StartCounting();
end


---------------------------------------------------
-- EasyMail_StartCounting
-- Start the dropdown hide countdown 
---------------------------------------------------
function EasyMail_StartCounting()
	DropdownTimer = UIDROPDOWNMENU_SHOW_TIME;
	IsDropdownCounting = true;
end


---------------------------------------------------
-- EasyMail_StopCounting
-- Stop the dropdown hide countdown 
---------------------------------------------------
function EasyMail_StopCounting()
	IsDropdownCounting = false;
end


---------------------------------------------------
-- EasyMail_GetAddressee
-- Get the addressee last mailed from the text field
---------------------------------------------------
function EasyMail_GetAddressee()
	SendingMail = true;
	
	local text = SendMailNameEditBox:GetText();
	
	CurrentAddressee = EasyMail_NameCase(text);
end


---------------------------------------------------
-- EasyMail_SetAddressee
-- Update the addressee field with the string passed to the function
---------------------------------------------------
function EasyMail_SetAddressee(self, namestr, arg2, checked, button)
	if (not namestr or namestr == "^"..EASYMAIL_CLEAROPTION) then
		-- User selected the CLear Field option on the dropdown
		SendMailNameEditBox:SetText("");
		return;
	end
	
	SendMailNameEditBox:SetText(namestr);
	
	-- Highlight the text in the field to make it easy for the user to change it by typing
	SendMailNameEditBox:HighlightText();
end


---------------------------------------------------
-- EasyMail_SaveAddressee
-- Save the last mailed addressee to the list and to the last addressee variable for the current character
---------------------------------------------------
function EasyMail_SaveAddressee(namestr, addlogged)
	local index, t;
	local listlen = #EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList;
	
	-- Make sure the first letter is uppercase and the rest are lower
	local namestr = EasyMail_NameCase(namestr);
	
	-- Locate the name in the list if it's there
	index = EasyMail_InMailList(namestr);
	
	-- If we are trying to add a logged-in char, don't do it if the list is at max length or if the name already exists
	if (addlogged and (index > 0 or listlen >= EasyMail_SavedVars[CurRealm][CurFaction].MailListLen)) then
		return;
	end
	
	-- Add names that don't already exist in the list, or if the name exists, move it to the top
	if (index == 0) then
		-- if the list is at max length, delete the first (oldest) entry
		if (listlen >= EasyMail_SavedVars[CurRealm][CurFaction].MailListLen) then
			table.remove(EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList, 1);
			listlen = listlen - 1;
		end
		
		-- Add the name to the end of the list
		EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList[listlen + 1] = namestr;
	else
		-- Only move the name if it's not already at the top
		if (index < listlen) then
			-- Move the name to the top of the list, maintaining list order
			table.remove(EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList, index);
			EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList[listlen] = namestr;
		end
	end
	
	-- Save the name as the last mailed addressee for the current character only if the function is not called with 
	-- parameter of true (used when adding logged-in char to list)
	if (not addlogged) then
		EasyMail_SavedVars[CurRealm][CurFaction].LastAddressee[CurPlayer] = namestr;
	end;
	
	EasyMail_SortList();
end


---------------------------------------------------
-- EasyMail_InMailList
-- Returns the table index if the specified name exists in the list, 0 otherwise
---------------------------------------------------
function EasyMail_InMailList(namestr)
	local t;
	
	for t = 1, #EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList do
		if (EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList[t] == namestr) then
			return t;
		end
	end
	
	return 0;
end


---------------------------------------------------
-- EasyMail_SortList
-- Sort the recently-mailed list
---------------------------------------------------
function EasyMail_SortList()
	local t = 1;
	local count = 1;
	
	-- Clean the list first in case problems remain from bugs
	while (t <= #EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList) do
		if (not EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList[t]) then
			-- Remove nil
			table.remove(EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList, t);
		else
			-- Remove duplicates
			local r;
			local removed = false
			
			for r = t + 1, #EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList do
				if (EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList[t] 
						== EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList[r]) then
					table.remove(EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList, t);
					removed = true;
					break
				end
			end
			
			if (not removed) then
				t = t + 1;
			end
		end
	end
	
	-- Copy list entries into table for sorting, ignoring the entry for the current player
	SortedList = {};
	
	for t = 1, #EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList do
		if (EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList[t] ~= CurPlayer) then
			SortedList[count] = EasyMail_SavedVars[CurRealm][CurFaction].EasyMailList[t];
			count = count + 1;
		end
	end
	
	-- Sort list by name
	table.sort(SortedList);
end


---------------------------------------------------
-- EasyMail_GetGuildNames
-- Build guild list to add to dropdown
---------------------------------------------------
function EasyMail_GetGuildNames()
	local t;
	local count = 1;
	GuildList = {};
	
	-- Copy list entries into temporary table for sorting, ignoring the entry for the current player
	for t = 1, GetNumGuildMembers(true) do
		local name = GetGuildRosterInfo(t);
		
		if (name ~= CurPlayer) then
			GuildList[count] = name;
			count = count + 1
		end
	end
	
	-- Sort list by name
	table.sort(GuildList);
	
	GuildQueryInterval = 0;
end


---------------------------------------------------
-- EasyMail_GetFriends
-- Build friend list to add to dropdown
---------------------------------------------------
function EasyMail_GetFriends()
	local t;
	FriendList = {};
	
	-- Copy list entries into temporary table for sorting
	for t = 1, GetNumFriends() do
		FriendList[t] = GetFriendInfo(t);
	end
	
	-- Sort list by name
	table.sort(FriendList);
	
	FriendQueryInterval = 0;
end


---------------------------------------------------
-- EasyMail_AdjustAtt
-- Move the attachments down to make room for the Take All button
---------------------------------------------------
function EasyMail_AdjustAtt()
	-- Resize the scroll frame (taken from MailFrame.lua)
	local scrollHeight = OpenMailScrollFrame:GetHeight() - 8
	
	OpenMailScrollFrame:SetHeight(scrollHeight);
	OpenMailScrollChildFrame:SetHeight(scrollHeight);
	OpenMailHorizontalBarLeft:SetPoint("TOPLEFT", "OpenMailFrame", "TOPLEFT", 15, 0 - OpenMailScrollFrame:GetHeight() - 94);
	OpenScrollBarBackgroundTop:SetHeight(min(scrollHeight, 256));
	OpenScrollBarBackgroundTop:SetTexCoord(0, 0.484375, 0, min(scrollHeight, 256) / 256);
	OpenStationeryBackgroundLeft:SetHeight(scrollHeight);
	OpenStationeryBackgroundLeft:SetTexCoord(0, 1.0, 0, min(scrollHeight, 256) / 256);
	OpenStationeryBackgroundRight:SetHeight(scrollHeight);
	OpenStationeryBackgroundRight:SetTexCoord(0, 1.0, 0, min(scrollHeight, 256) / 256);
	
	local point, relativeTo, relativePoint, xOfs, yOfs = OpenMailAttachmentText:GetPoint(1);
	OpenMailAttachmentText:SetPoint(point, relativeTo, relativePoint, xOfs, yOfs + 4);
	
	-- Position Take All button
	EasyMail_AttButton:SetPoint("TOPRIGHT", "OpenMailFrame", "TOPRIGHT", -44, 
		0 - OpenMailScrollFrame:GetHeight() - 104);
	
	-- Disable the button when mail is COD, there are no money or item attachments, or we are taking attachments
	if (GettingAtt or OpenMailFrame.cod or not (OpenMailFrame.money or EasyMail_HasAttachments())) then
		EasyMail_AttButton:Disable();
	else
		EasyMail_AttButton:Enable();
	end
end


---------------------------------------------------
-- EasyMail_HasAttachments
-- Check to see if the mail has attachments to take
---------------------------------------------------
function EasyMail_HasAttachments()
	if (InboxFrame.openMailID and InboxFrame.openMailID > 0) then
		-- Loop through list of attachment buttons
		for t = 1, ATTACHMENTS_MAX do
			if (GetInboxItem(InboxFrame.openMailID, t)) then
				-- There is an item attachment
				return true;
			end
		end
	end
	
	return false;
end


---------------------------------------------------
-- EasyMail_GetAll
-- Start process to take all attachments from all checked mails
---------------------------------------------------
function EasyMail_GetAll()
	PlaySound("igMainMenuOptionCheckBoxOn");
	
	if (GettingAll) then
		return;
	end
	
	HideUIPanel(OpenMailFrame);
		
	GettingAll = true;
	CheckAll = true;
	CurMail = GetInboxNumItems() + 1;
	TotalMoney = 0;
end


---------------------------------------------------
-- EasyMail_MailAtt
-- Start the process to take all attachments from the specified mail
---------------------------------------------------
function EasyMail_MailAtt(mailid)
	if (GettingAtt) then
		return;
	end
	
	-- Set the mail window to not redraw the attachment buttons - this is what the window does when the buttons are 
	-- manually clicked, so we will do it too
	OpenMailFrame.updateButtonPositions = false;
	
	-- Disable the Take All button
	EasyMail_AttButton:Disable();
	
	-- Start at button 1, execute onupdate code immediately, reset the take timeout (tracks how long we have been
	-- trying to take the current attachment), clear the button, and set the flag to indicate we are taking
	-- attachments
	AttIndex = 0;
	TimeSinceLastAtt = AttInterval;
	CurAtt = nil;
	GettingAtt = true;
end


---------------------------------------------------
-- EasyMail_OnUpdate
-- Process all attachments for single open mail or for checked mails, also process guild and friend list
---------------------------------------------------
function EasyMail_OnUpdate(self, elapsed)
	if (not EasyMail_MailDropdown:IsShown() and not MailFrame:IsShown()) then
		return;
	end

	TimeSinceLastAtt = TimeSinceLastAtt + elapsed
	
	-- Execute only at the specified interval
	if (TimeSinceLastAtt >= AttInterval) then
		-- Check if we are taking attachments
		if (GettingAtt) then
			-- Check if we are not currently trying to take an attachment
			if (not CurAtt) then
				-- Take next attachment
				AttIndex = AttIndex + 1;
				
				-- Use for loop to skip the buttons we don't want
				for t = AttIndex, ATTACHMENTS_MAX do
					-- Use list of buttons that MailFrame.lua builds
					CurAtt = OpenMailFrame.activeAttachmentButtons[AttIndex];
					
					-- skip the buttons that are hidden and the letter attachment button
					if (CurAtt and CurAtt:GetName() ~= "OpenMailLetterButton" and CurAtt:IsVisible()) then
						-- The index is pointing to a button we want to take
						break;
					end
					
					-- Try next button
					AttIndex = AttIndex + 1;
				end
				
				-- Reset timer - we only want to wait for the successful take for a specified period of time
				AttTimer = 0;
			end
			
			-- Try to take the current attachment (in CurAtt) if the index has not gone off the top of the list,
			-- the mail frame is still open, a valid mail is selected, and we have not timed out trying to
			-- take an attachment
			if (AttIndex <= ATTACHMENTS_MAX and AttTimer <= AttTimeout and OpenMailFrame:IsVisible()
					and InboxFrame.openMailID and InboxFrame.openMailID >= 1) then
					
				if (AttTimer == 0) then
					-- Attempt take
					if (CurAtt:GetName() == "OpenMailMoneyButton") then
						TakeInboxMoney(InboxFrame.openMailID);
						
						if (GettingAll and EasyMail_SavedVars.Total == "Y") then
							TotalMoney = TotalMoney + OpenMailFrame.money;
						end
						
						if (EasyMail_SavedVars.Money == "Y") then
							EasyMail_PrintMoney();
						end
					else
						TakeInboxItem(InboxFrame.openMailID, getglobal(CurAtt:GetName()):GetID());				
					end
				end
				
				-- update timer - we dont try to take the same attachment forever
				AttTimer = AttTimer + AttInterval;
			else
				-- The user has closed the mail, we finished taking all attachments, or we timed out getting one
				-- of the attachments
				if (AttTimer > AttTimeout) then
					-- Timed out
					EasyMail_PrintError(format(EASYMAIL_ERRTIMEOUT, AttTimeout));
					
					-- Stop the Get all process also - something bad is happening
					EasyMail_StopGetAll();
				else
					if (OpenMailFrame:IsVisible()) then
						HideUIPanel(OpenMailFrame);
					end
				end
				
				if (AttIndex > ATTACHMENTS_MAX and GettingAll) then
					-- Completed take all successully, uncheck the checkbox
					CheckBoxes[CurMail] = false;
					InboxFrame_Update();
				end
				
				GettingAtt = false;
			end
		end
		
		TimeSinceLastAtt = 0
	end
	
	if (GettingAll and not GettingAtt and DeleteCount == 0 and not OpenMailFrame:IsVisible()) then
		-- We are getting all attachments from all mails and the mail window is closed, so find the next mail for
		-- processing and open it.
		if (CurMail > 1) then
			CurMail = CurMail - 1;
			
			local packageIcon, stationeryIcon, sender, subject, money, CODAmount = GetInboxHeaderInfo(CurMail);
			local pending = (subject and EasyMail_MatchTemplate(AUCTION_INVOICE_MAIL_SUBJECT, subject));
			
			-- Skip unchecked, COD mails, and pending auction mails if the option is selected
			if (CheckBoxes[CurMail] and (not CODAmount or CODAmount == 0)
					and subject and (not pending or EasyMail_SavedVars.DelPending == "Y")) then
				-- Page the inbox to the correct page
				InboxFrame.pageNum = floor((CurMail - 1) / INBOXITEMS_TO_DISPLAY) + 1;
				InboxFrame_Update();
				
				-- Actually open the mail
				getglobal("MailItem"..(((CurMail - 1) % INBOXITEMS_TO_DISPLAY) + 1).."Button"):Click("LeftButton");
				
				if (pending) then
					OpenMail_Delete();
					DeleteCount = GetInboxNumItems();
				end
			else
				CheckBoxes[CurMail] = false;
				InboxFrame_Update();
			end
		else
			-- Done processing mails
			EasyMail_StopGetAll();
		end
	end
	
	if (GettingAll and not GettingAtt and DeleteCount == 0 and OpenMailFrame:IsVisible()) then
		-- Start the take process for the selected open mail
		EasyMail_MailAtt(CurMail);
	end
	
	if (DeleteCount > 0) then
		if (GetInboxNumItems() < DeleteCount) then
			DeleteCount = 0;
			
			-- Just in case...
			if (OpenMailFrame:IsVisible()) then
				HideUIPanel(OpenMailFrame);
			end
		end
	end
	
	if (GuildQueryInterval > 0 and IsInGuild() and EasyMail_SavedVars.Guild == "Y") then
		-- Execute Query for guild list
		TimeSinceLastGuildQuery = TimeSinceLastGuildQuery + elapsed
		
		if (TimeSinceLastGuildQuery >= GuildQueryInterval) then
			-- Query guild members
			GuildRoster();
			
			GuildQueryInterval = 3;
			TimeSinceLastGuildQuery = 0
		end
	end

	if (FriendQueryInterval > 0 and EasyMail_SavedVars.Friends == "Y") then
		-- Execute Query for friend list
		TimeSinceLastFriendQuery = TimeSinceLastFriendQuery + elapsed
		
		if (TimeSinceLastFriendQuery >= FriendQueryInterval) then
			-- Query friends
			ShowFriends();
			
			FriendQueryInterval = 3;
			TimeSinceLastFriendQuery = 0
		end
	end
	
	-- Hide dropdown if the send mail frame is not visible
	if (EasyMail_MailDropdown:IsShown() and not SendMailFrame:IsVisible()) then
		EasyMail_MailDropdown:Hide();
	end
	
	-- Hide dropdown after 2 seconds
	if (IsDropdownCounting) then
		DropdownTimer = DropdownTimer - elapsed;
		
		if (DropdownTimer < 0) then
			EasyMail_MailDropdown:Hide();
			IsDropdownCounting = false;
		end
	end
end


---------------------------------------------------
-- EasyMail_StopGetAll
-- Stop the attachment getting process
---------------------------------------------------
function EasyMail_StopGetAll()
	SendingMail = false;
	
	if (not GettingAll) then
		return;
	end
	
	if (TotalMoney > 0) then
		EasyMail_PrintTotal();
		TotalMoney = 0;
	end
	
	GettingAtt = false;
	GettingAll = false;
end


---------------------------------------------------
-- EasyMail_MailItemOnClickHandler
-- Stop the attachment getting process if the user clicks an inbox button
-- Also drives right-click inbox functionality
---------------------------------------------------
function EasyMail_MailItemOnClickHandler(self, button)
	local index = self.index;
	local modifiedClick = IsModifiedClick("MAILAUTOLOOTTOGGLE");

	if (GettingAtt) then
		EasyMail_StopGetAll();
	end
	
	if ( modifiedClick ) then
		InboxFrame_OnModifiedClick(self, index);
		return;
	end
	
	if (button ~= "RightButton") then
		-- Execute standard onclick
		InboxFrame_OnClick(self, index);
		return;
	end
	
	local packageIcon, stationeryIcon, sender, subject, money, CODAmount, daysLeft, hasItem, 
		wasRead = GetInboxHeaderInfo(index);
		
	local doGet = (money > 0 or hasItem);
	local doDel = not (money > 0 or hasItem);
	
	if ((doGet and EasyMail_SavedVars.ClickGet ~= "Y") or (doDel and EasyMail_SavedVars.ClickDel ~= "Y"
	      or CODAmount > 0)) then
		InboxFrame_OnClick(self, index);
		return;
	end
	
	self:SetChecked(not self:GetChecked());
	
	if (doDel) then
	   DeleteMail = index;
	   
	   if (wasRead and EasyMail_SavedVars.DelPrompt ~= "Y") then
		   EasyMail_ClickDelete();
		else
		   if (not wasRead) then
		      StaticPopupDialogs["EASYMAIL_DELETEMAIL"].text = format(EASYMAIL_DELETEUNREADQUESTION, sender);
		   else
		      StaticPopupDialogs["EASYMAIL_DELETEMAIL"].text = format(EASYMAIL_DELETEQUESTION, sender);
		   end
		   
		   StaticPopup_Show("EASYMAIL_DELETEMAIL");
		end
      
      return;
	end

	EasyMail_OpenMail(index);
	
	if (doGet) then
		EasyMail_MailAtt(index);
	end
end

---------------------------------------------------
-- EasyMail_OpenMail
-- Open a mail using its index (from MailFrame.lua InboxFrame_OnClick)
---------------------------------------------------
function EasyMail_OpenMail(index)
	local isShown = OpenMailFrame:IsShown();
	
	InboxFrame.openMailID = index;
	OpenMailFrame.updateButtonPositions = true;
	OpenMail_Update();
	--OpenMailFrame:Show();
	ShowUIPanel(OpenMailFrame);
	
	if (not isShown) then
		PlaySound("igSpellBookOpen");
	end
	
	InboxFrame_Update();
end


---------------------------------------------------
-- EasyMail_ClickDelete
-- Processes the right click deletion
---------------------------------------------------
function EasyMail_ClickDelete()
	EasyMail_OpenMail(DeleteMail);
	OpenMail_Delete();
end


---------------------------------------------------
-- EasyMail_ShowCheckBoxes
-- Show or hide the checkboxes when addon is enabled or disabled
---------------------------------------------------
function EasyMail_ShowCheckBoxes()
	-- Move the inbox frames over to the right to make room for the checkboxes
	MailItem1:SetPoint("TOPLEFT", "InboxFrame", "TOPLEFT", 48, -80);

	for t = 1, INBOXITEMS_TO_DISPLAY do
		-- Shorten the widths of the inbox frames, shorten the subject, and move the expire time text over
		getglobal("MailItem"..t):SetWidth(280);
		getglobal("MailItem"..t.."Subject"):SetWidth(228);
		getglobal("MailItem"..t.."ExpireTime"):SetPoint("TOPRIGHT", "MailItem"..t, "TOPRIGHT", 10, -4);
		
		-- Create checkboxes and locate them
		local frame;
		
		if (not getglobal("EasyMail_CheckButton"..t)) then
			frame = CreateFrame("CheckButton", "EasyMail_CheckButton"..t, getglobal("MailItem"..t), 
				"EasyMail_CheckButtonTemplate");
			frame:SetPoint("TOPLEFT", "MailItem"..t, "TOPLEFT", -25, -9);
			frame:Hide();
		end
	end
end


---------------------------------------------------
-- EasyMail_InboxUpdate
-- Draw the inbox checkboxes
---------------------------------------------------
function EasyMail_InboxUpdate()
	EasyMail_CheckAllButton:SetText((CheckAll and EASYMAIL_CHECKALLTEXT) or EASYMAIL_CLEARALLTEXT);
	
	local numItems, totalItems = GetInboxNumItems();
	
	if (numItems > 0) then
		EasyMail_CheckAllButton:Enable();
		EasyMail_GetAllButton:Enable();
	else
		EasyMail_CheckAllButton:Disable();
		EasyMail_GetAllButton:Disable();
	end
	
	-- Trim the checkbox table if necessary
	while numItems < #CheckBoxes do
		tremove(CheckBoxes, numItems + 1);
	end
	
	-- Add entries to the checkbox table if necessary defaulting them off
	for t = #CheckBoxes + 1, numItems do
		CheckBoxes[t] = false;
	end
	
	local index = ((InboxFrame.pageNum - 1) * INBOXITEMS_TO_DISPLAY) + 1;
	
	for i=1, INBOXITEMS_TO_DISPLAY do
		if ( index <= numItems ) then
			-- Show the box as checked if the corresponding table entry is true
			getglobal("EasyMail_CheckButton"..i):SetChecked(CheckBoxes[index]);
			getglobal("EasyMail_CheckButton"..i):Show();
		else
			getglobal("EasyMail_CheckButton"..i):Hide();
		end
		
		index = index + 1;
	end
	
	if ( totalItems > numItems) then
		InboxTitleText:Hide();
	else
		InboxTitleText:Show();
	end
end


---------------------------------------------------
-- EasyMail_CheckButtonOnMouseUp
-- Toggle the check box for the inbox item
---------------------------------------------------
function EasyMail_CheckButtonOnMouseUp(self)
	PlaySound("igMainMenuOptionCheckBoxOn");
	
	-- Get the inbox button for the selected mail
	local index = gsub(self:GetName(), "EasyMail_CheckButton(%d+)", "%1");
	local button = getglobal("MailItem"..index.."Button");
	
	-- Toggle the table entry indicated by the mail index field on the inbox button
	CheckBoxes[button.index] = not CheckBoxes[button.index];
end


---------------------------------------------------
-- EasyMail_CheckAll
-- Check or uncheck all checkboxes
---------------------------------------------------
function EasyMail_CheckAll()
	PlaySound("igMainMenuOptionCheckBoxOn");
	
	if (not GettingAll) then
		for t = 1, #CheckBoxes do
			CheckBoxes[t] = CheckAll;
		end
		
		CheckAll = not CheckAll;
		
		EasyMail_InboxUpdate();
	end
end


---------------------------------------------------
-- EasyMail_ResetMarkAll
-- Set the Mark All button back to Mark All rather than Clear All when the user opens the mail box
-- Also execute friend and quild queries to refresh the lists when the inbox is opened
---------------------------------------------------
function EasyMail_ResetMarkAll()
	CheckAll = true;
	EasyMail_CheckAllButton:Disable();
	EasyMail_GetAllButton:Disable();
	
	-- Query for the friends and guild lists
	if (IsInGuild() and EasyMail_SavedVars.Guild == "Y") then
		GuildQueryInterval = .5;
	end

	if (EasyMail_SavedVars.Friends == "Y") then
		FriendQueryInterval = .5;
	end
end


---------------------------------------------------
-- EasyMail_MatchTemplate
-- Determine if a string matches a Blizzard text template
---------------------------------------------------
function EasyMail_MatchTemplate(template, str)
	local loc = strfind(template, "%s", 1, true);
	local front = strsub(template, 1, loc - 1);
	local back = strsub(template, loc + 2);
	
	local matchfront = (strsub(str, 1, strlen(front)) == front);
	local matchback = (strsub(str, strlen(str) - strlen(back) + 1) == back);
	
	return (matchfront and matchback);
end


---------------------------------------------------
-- EasyMail_PrintMoney
-- Output money received from mail
---------------------------------------------------
function EasyMail_PrintMoney()
	local fromtext = "";
	local auctiontext = AUCTION_SOLD_MAIL_SUBJECT;
	local subject = OpenMailSubject:GetText();
	
	local loc = strfind(auctiontext, "%s", 1, true);
	local front = strsub(auctiontext, 1, loc - 1);
	local back = strsub(auctiontext, loc + 2);
	
	if (subject and EasyMail_MatchTemplate(auctiontext, subject)) then
		fromtext = format(EASYMAIL_FROMAUCTION, gsub(subject, front.."(.+)"..back, "%1"))
	else
		fromtext = format(EASYMAIL_FROM, OpenMailSender:GetText())
	end
	
	EasyMail_Print("|cffffff00"..format(EASYMAIL_RECEIVEMONEY, GetLongMoneyString(OpenMailFrame.money),
		fromtext));
end


---------------------------------------------------
-- EasyMail_PrintTotal
-- Output money received from mail
---------------------------------------------------
function EasyMail_PrintTotal()
	EasyMail_Print("|cffffff00"..format(EASYMAIL_TOTALMONEY, 
	   HIGHLIGHT_FONT_COLOR_CODE..GetLongMoneyString(TotalMoney)));
end


---------------------------------------------------
-- EasyMail_MoneySubject
-- Set the subject of a new mail to automatically indicate amount sent
---------------------------------------------------
function EasyMail_MoneySubject()
	if (MoneySubject or SendMailSubjectEditBox:GetText() == "") then
		local copper = MoneyInputFrame_GetCopper(SendMailMoney)
		
		if (copper > 0) then
			SendMailSubjectEditBox:SetText(format(EASYMAIL_MONEYSUBJECT, GetShortMoneyString(copper)));
			MoneySubject = true;
		else
			SendMailSubjectEditBox:SetText("");
			MoneySubject = false;
		end
	end
end


---------------------------------------------------
-- GetLongMoneyString
-- Return a long string version of an amount in copper
---------------------------------------------------
function GetLongMoneyString(money)
	local moneytext = "";
	
	local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
	local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
	local copper = mod(money, COPPER_PER_SILVER);

	if (copper > 0) then
		moneytext = copper.." "..EasyMail_Copper;
	end
	
	if (silver > 0) then
		if (copper > 0) then
			moneytext = ", "..moneytext;
		end
		
		moneytext = silver.." "..EasyMail_Silver..moneytext
	end

	if (gold > 0) then
		if (copper > 0 or silver > 0) then
			moneytext = ", "..moneytext;
		end
		
		moneytext = gold.." "..EasyMail_Gold..moneytext
	end
	
	return moneytext;
end


---------------------------------------------------
-- GetShortMoneyString
-- Return a short string version of an amount in copper
---------------------------------------------------
function GetShortMoneyString(money)
	local gold = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD));
	local silver = floor((money - (gold * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER);
	local copper = mod(money, COPPER_PER_SILVER);

	local copperString = "";
	if ( copper > 0 ) then
		copperString = copper..EasyMail_Lower(strsub(EasyMail_Copper, 1, 1));
	end
	
	local silverString = "";
	if ( silver > 0 ) then
		silverString = silver..EasyMail_Lower(strsub(EasyMail_Silver, 1, 1));
		if ( copper > 0 ) then
			silverString = silverString.." ";
		end
	end
	
	local goldString = "";
	if ( tonumber(gold) > 0 ) then
		goldString = gold..EasyMail_Lower(strsub(EasyMail_Gold, 1, 1));
		if ( copper > 0 or silver > 0 ) then
			goldString = goldString.." ";
		end
	end
	return goldString..silverString..copperString;
end


---------------------------------------------------
-- EasyMail_Tooltip
-- Show the mail text in the inbox item tooltip
---------------------------------------------------
function EasyMail_Tooltip(self)
   if (EasyMail_SavedVars.TextTooltip ~= "Y") then
      return;
   end

   if (not GameTooltip:IsOwned(self)) then
	   GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	end
	
	if (self.hasItem or self.money or self.cod) then
      GameTooltip:AddLine(" ");
   end
   
   bodyText = GetInboxText(self.index);
      
   if (bodyText) then
     GameTooltip:AddLine("Mail Text");
         
      local lines = {strsplit("\n", bodyText)};
      local t;
      
      for t = 1, #lines do
         local line;
         local remainder = lines[t];
         
         while (remainder) do
            if (strlen(remainder) > MaxTooltipWidth) then
               local lastchar, nextstart;
               local lastspace = EasyMail_ReverseFind(strsub(remainder, 1, MaxTooltipWidth + 1), " ");
               
               if (lastspace and lastspace ~= MaxTooltipWidth + 1) then
                  lastchar = lastspace - 1;
                  nextstart = lastspace + 1;
               else
                  lastchar = MaxTooltipWidth;
                  nextstart = lastchar + (((strsub(remainder, MaxTooltipWidth + 1, MaxTooltipWidth + 1) == " ") and 2) 
                     or 1);
               end
               
               line = strsub(remainder, 1, lastchar);
               remainder = strsub(remainder, nextstart);
            else
               line = remainder;
               remainder = nil;
            end

            GameTooltip:AddLine(line, .85, .85, .85);
         end
      end
   else
      GameTooltip:AddLine(EASYMAIL_NOTEXT, .85, .85, .85);
   end
   
   GameTooltip:Show();
end


---------------------------------------------------
-- EasyMail_ReverseFind
-- Locate the last occurrance of a char in a string
---------------------------------------------------
function EasyMail_ReverseFind(str, ch)
   local t;
   local location;
   
   for t = strlen(str), 1, -1 do
      if (strsub(str, t, t) == ch) then
         location = t;
         break;
      end
   end
   
   return location;
end


---------------------------------------------------
-- EasyMail_OnTabPressed
-- Standard Blizzard or custom auto-complete
---------------------------------------------------
function EasyMail_OnTabPressed(self)
	if (EasyMail_SavedVars.BlizzList ~= "Y" or not AutoCompleteEditBox_OnTabPressed(self)) then
		EditBox_HandleTabbing(self, SEND_MAIL_TAB_LIST);
	end
end


---------------------------------------------------
-- EasyMail_OnEditFocusLost
-- Standard Blizzard or custom auto-complete
---------------------------------------------------
function EasyMail_OnEditFocusLost(self)
	if (EasyMail_SavedVars.BlizzList == "Y") then
		AutoCompleteEditBox_OnEditFocusLost(self);
	end
	
	EditBox_ClearHighlight(self);
end


---------------------------------------------------
-- EasyMail_OnCharComposition
-- Standard Blizzard or custom auto-complete
---------------------------------------------------
function OnCharComposition(self, text)
	if (EasyMail_SavedVars.BlizzList ~= "Y") then
		EasyMail_AutoComplete(self, text);
	end
end


---------------------------------------------------
-- EasyMail_OnChar
-- Standard Blizzard or custom auto-complete
---------------------------------------------------
function EasyMail_OnChar(self, text)
	if (EasyMail_SavedVars.BlizzList ~= "Y" and not self:IsInIMECompositionMode()) then
		EasyMail_AutoComplete(self, text);
	end
end


---------------------------------------------------
-- EasyMail_OnEnterPressed
-- Standard Blizzard or custom auto-complete
---------------------------------------------------
function EasyMail_OnEnterPressed(self)
	if (EasyMail_SavedVars.BlizzList ~= "Y" or not AutoCompleteEditBox_OnEnterPressed(self)) then
		SendMailSubjectEditBox:SetFocus();
	end
end


---------------------------------------------------
-- EasyMail_OnEscapePressed
-- Standard Blizzard or custom auto-complete
---------------------------------------------------
function EasyMail_OnEscapePressed(self)
	if (EasyMail_SavedVars.BlizzList ~= "Y" or not AutoCompleteEditBox_OnEscapePressed(self)) then
		EditBox_ClearFocus(self);
	end
end


---------------------------------------------------
-- EasyMail_OnTextChanged
-- Standard Blizzard or custom auto-complete
---------------------------------------------------
function EasyMail_OnTextChanged(self, userInput)
	if (EasyMail_SavedVars.BlizzList == "Y") then
		AutoCompleteEditBox_OnTextChanged(self, userInput);
	end
	
	SendMailFrame_CanSend(self);
end


---------------------------------------------------
-- EasyMail_AutoComplete
-- Build name in addressee field while typing
---------------------------------------------------
function EasyMail_AutoComplete(self, char, skipFriends, skipGuild)
	local text = self:GetText();
	local textlen = strlen(text);
	local numFriends, name;
	
	-- Check addressee list
	for i=1, #SortedList do
		if (text and (strfind(EasyMail_Upper(SortedList[i]), EasyMail_Upper(text), 1, 1) == 1) ) then
			self:SetText(SortedList[i]);
			
			if ( self:IsInIMECompositionMode() ) then
				self:HighlightText(textlen - strlen(char), -1);
			else
				self:HighlightText(textlen, -1);
			end
			
			return;
		end
	end

	-- First check your friends list
	if ( not skipFriends ) then
		numFriends = GetNumFriends();
		if ( numFriends > 0 ) then
			for i=1, numFriends do
				name = GetFriendInfo(i);
				if ( name and text and (strfind(strupper(name), strupper(text), 1, 1) == 1) ) then
					self:SetText(name);
					if ( self:IsInIMECompositionMode() ) then
						self:HighlightText(textlen - strlen(char), -1);
					else
						self:HighlightText(textlen, -1);
					end
					return;
				end
			end
		end
	end

	-- No match, check your guild list
	if ( not skipGuild ) then
		numFriends = GetNumGuildMembers(true);	-- true to include offline members
		if ( numFriends > 0 ) then
			for i=1, numFriends do
				name = GetGuildRosterInfo(i);
				if ( name and text and (strfind(strupper(name), strupper(text), 1, 1) == 1) ) then
					self:SetText(name);
					if ( self:IsInIMECompositionMode() ) then
						self:HighlightText(textlen - strlen(char), -1);
					else
						self:HighlightText(textlen, -1);
					end
					return;
				end
			end
		end
	end
end


---------------------------------------------------
-- EasyMail_Trim
-- Trim spaces from front and back of string (why doesn't strtrim work!?!?)
---------------------------------------------------
function EasyMail_Forward()
	MailFrameTab_OnClick(nil, 2);
	SendMailNameEditBox:SetText("");
	local subject = OpenMailSubject:GetText();
	local prefix = EASYMAIL_FORWARD_PREFIX .." ";
	if ( strsub(subject, 1, strlen(prefix)) ~= prefix ) then
		subject = prefix..subject;
	end
	SendMailSubjectEditBox:SetText(subject);
	local bodytext;
	if (OpenMailBodyText:GetText())	then
		bodytext = "\n---\n"..OpenMailBodyText:GetText();
	else
		bodytext = "";
	end
	SendMailBodyEditBox:SetText(bodytext);
	SendMailNameEditBox:SetFocus();
	SendMailBodyEditBox:SetCursorPosition(0);
	
	-- Set the send mode so the work flow can change accordingly
	SendMailFrame.sendMode = "reply";
end


---------------------------------------------------
-- EasyMail_Trim
-- Trim spaces from front and back of string (why doesn't strtrim work!?!?)
---------------------------------------------------
function EasyMail_Trim(str)
	return gsub(str, "%s*(.*)%s*", "%1");
end


---------------------------------------------------
-- EasyMail_NameCase
-- Force first letter of player name to uppercase, lower case the rest
---------------------------------------------------
function EasyMail_NameCase(instr)
	if (not strfind("koKRzhCNzhTW", GetLocale())) then
		local ch = strbyte(strsub(instr, 1, 1));
		local pos = 1;
		
		if (ch >= 240) then
			pos = 4;
		elseif (ch >= 224) then
			pos = 3;
		elseif (ch >= 192) then
			pos = 2;
		end
		
		return strupper(strsub(instr, 1, pos))..strlower(strsub(instr, pos + 1));
	end
	
	return instr;
end


---------------------------------------------------
-- EasyMail_Upper
-- Upper case only if casing is used in locale
---------------------------------------------------
function EasyMail_Upper(str)
	return ((strfind("koKRzhCNzhTW", GetLocale()) and str) or strupper(str));
end


---------------------------------------------------
-- EasyMail_Lower
-- Lower case only if casing is used in locale
---------------------------------------------------
function EasyMail_Lower(str)
	return ((strfind("koKRzhCNzhTW", GetLocale()) and str) or strlower(str));
end


---------------------------------------------------
-- EasyMail_PrintError
-- Output a message to Blizzard's error frame
---------------------------------------------------
function EasyMail_PrintError(errMsg)
	PlaySound("igQuestFailed");
	DEFAULT_CHAT_FRAME:AddMessage(EASYMAIL_ADDONNAME..": "..errMsg, 1.0, 0.1, 0.1);
end


---------------------------------------------------
-- EasyMail_Print
-- Output a message to the chat frame
---------------------------------------------------
function EasyMail_Print(msg)
	if ( DEFAULT_CHAT_FRAME ) then
		DEFAULT_CHAT_FRAME:AddMessage(msg, 0, 1, 0);
	end
end
