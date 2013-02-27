local nibMinimap = LibStub("AceAddon-3.0"):NewAddon("nibMinimap", "AceConsole-3.0", "AceEvent-3.0", "AceBucket-3.0", "AceTimer-3.0")
local LSM = LibStub("LibSharedMedia-3.0")
local Astrolabe = DongleStub("Astrolabe-1.0")
local db
_G["nibMinimap"] = nibMinimap

local strform = _G.string.format

BINDING_HEADER_NIBMINIMAP = "nibMinimap"
BINDING_NAME_NIBMINIMAPTOGGLE = "Toggle Minimap"
BINDING_NAME_NIBMINIMAPFARM = "Toggle Farm Mode"

local defaults = {
	profile = {
		hidden = {
			enabled = true,
			zones = {
				pvp = false,
				arena = true,
				party = false,
				raid = false,
			},
		},
		position = {
			scale = 1,
			anchorto = "TOPLEFT",
			x = 8,
			y = -8,
		},
		expand = {
			appearance = {
				scale = 1.4,
				opacity = 0.75,
			},
			position = {
				anchorto = "TOPLEFT",
				x = 8,
				y = -8,
			},
			extras = {
				gatherertoggle = false,
				clickthrough = false,
				hidepoi = true,
			},
		},
		border = {
			texture = "None",
			edgesize = 16,
			inset = -6,
			color = {r = 1, g = 1, b = 1, a = 1},
		},
		backdrop = {
			color = {r = 0, g = 0, b = 0, a = 1},
			inset = -1,
		},
		information = {
			position = {x = -1, y = 0},
			font = {
				name = "Pixel1",
				size = 8,
				outline = "MONOCHROMEOUTLINE",
				gap = 4,
			},
		},
		poi = {
			enabled = true,
			watchedOnly = true,
			fadeEdge = true,
			icons = {
				scale = 0.7,
				opacity = 1,
			},
		},
	},
}

local Textures = {
	SquareMask = [[Interface\AddOns\nibMinimap\Media\SquareMinimapMask]],
	Button = [[Interface\Addons\nibMinimap\Media\Button]],
	Minimize = [[Interface\Addons\nibMinimap\Media\Minimize]],
	Maximize = [[Interface\Addons\nibMinimap\Media\Maximize]],
	Config = [[Interface\Addons\nibMinimap\Media\Config]],
	Tracking = [[Interface\Addons\nibMinimap\Media\Tracking]],
	Farm = [[Interface\Addons\nibMinimap\Media\Farm]],
}

local MMFrames = nibMinimap.Frames
local MinimapNewBorder
local InfoShown = {
	coords = false,
	dungeondifficulty = false,
	mail = false,
}
local pois = {}
nibMinimap.pois = pois
local POI_OnEnter, POI_OnLeave, POI_OnMouseUp, Arrow_OnUpdate

local Class, ClassColor

local ExpandedState = 0
local UpdateProcessing = false

-- Seconds to Time
local function ConvertSecondstoTime(value)
	local minues, seconds
	minutes = floor(value / 60)
	seconds = floor(value - (minutes * 60))
	if ( minutes > 0 ) then
		if ( seconds < 10 ) then seconds = strform("0%d", seconds) end
		return strform("%s:%s", minutes, seconds)
	else
		return strform("%ss", seconds)
	end
end

-- Class Color
local function GetClassColor(class)
	if not RAID_CLASS_COLORS[class] then return {1, 1, 1} end
	local classColors = CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class] or RAID_CLASS_COLORS[class]
	local offset = (class == "PRIEST" and -0.2) or ((class == "ROGUE" or class == "MAGE" or class == "HUNTER") and -0.1) or 0
	return {classColors.r * (1 + offset), classColors.g * (1 + offset), classColors.b * (1 + offset)}
end

-- SharedMedia retrieval
local function RetrieveFont(font)
	font = LSM:Fetch("font", font) or GameFontNormalSmall:GetFont()
	return font
end

local function RetrieveBorder(border)
	border = LSM:Fetch("border", border, true)
	return border
end

-- Zoom Out
local function ZoomMinimapOut()
	Minimap:SetZoom(0)
	MinimapZoomIn:Enable()
	MinimapZoomOut:Disable()
end

-- Timer
local RefreshMap, RefreshMail, RefreshZoom
local RefreshTimer = CreateFrame("FRAME")
RefreshTimer.elapsed = 5
RefreshTimer:Hide()
RefreshTimer:SetScript("OnUpdate", function(s, e)
	RefreshTimer.elapsed = RefreshTimer.elapsed - e
	if (RefreshTimer.elapsed <= 0) then
		-- Map
		if RefreshMap then
			local x, y = GetPlayerMapPosition("Player")
			
			-- If Coords are at 0,0 then it's possible that they are stuck
			if x == 0 and y == 0 and not WorldMapFrame:IsVisible() then
				SetMapToCurrentZone()
			end
			
			RefreshMap = false
		end
		
		-- Mail
		if RefreshMail then
			nibMinimap:MailUpdate()
			
			RefreshMail = false
		end
		
		-- Zoom
		if RefreshZoom then
			ZoomMinimapOut()
			
			RefreshZoom = false
		end
		RefreshTimer.elapsed = 1
	end
end)

---------------------------
-- MINIMAP FRAME UPDATES --
---------------------------

-- Clickthrough
function nibMinimap:UpdateClickthrough()
	if ( (ExpandedState == 0) or (not db.expand.extras.clickthrough) ) then
		Minimap:EnableMouse(true)
	else
		Minimap:EnableMouse(false)
	end
end

-- Farm Mode - Hide POI option
function nibMinimap:UpdateFarmModePOI()
	if ExpandedState == 0 then
		self:POIUpdate()
	else
		if db.expand.extras.hidepoi then
			self:RemoveAllPOIs()
		else
			self:POIUpdate()
		end
	end
end

-- Get size and position data
local function GetPositionData()
	-- Get Normal or Expanded data
	local NewMinimapPoints
	
	if ExpandedState == 0 then
		NewMinimapPoints = {
			xofs = db.position.x,
			yofs = db.position.y,
			point = db.position.anchorto,
			rpoint = db.position.anchorto,
			scale = db.position.scale,
			opacity = 1,
		}
	else
		NewMinimapPoints = {
			xofs = db.expand.position.x,
			yofs = db.expand.position.y,
			point = db.expand.position.anchorto,
			rpoint = db.expand.position.anchorto,
			scale = db.expand.appearance.scale,
			opacity = db.expand.appearance.opacity,
		}
	end
	
	return NewMinimapPoints
end

-- Set Info text/button positions
function nibMinimap:UpdateInfoPosition()
	local NewMinimapPoints = GetPositionData()
	
	local mm_xofs = NewMinimapPoints.xofs
	local mm_yofs = NewMinimapPoints.yofs
	local mm_point = NewMinimapPoints.point
	local scale = NewMinimapPoints.scale
	local rpoint, point
	
	local mm_width = Minimap:GetWidth()
	local mm_height = Minimap:GetHeight()
	
	local xofs
	local yofs
	local yadj
	local ymulti
	local iHeight = (db.information.font.size + db.information.font.gap) / scale
	
	local font = RetrieveFont(db.information.font.name)
	
	if Minimap:IsVisible() and (ExpandedState == 0) then
		-- Set Offsets, Positions, Gaps
		xofs = db.information.position.x
		ymulti = 1
		if mm_point == "TOPLEFT" then
			ymulti = -1
			point = "TOPLEFT"
			rpoint = "BOTTOMLEFT"
		elseif mm_point == "BOTTOMLEFT" then
			ymulti = 1
			point = "BOTTOMLEFT"
			rpoint = "TOPLEFT"
		end
		yofs = (db.information.position.y + 11) * ymulti - (5 * scale * ymulti)
		yadj = iHeight * ymulti
		
		-- Location
		MMFrames.info.location:ClearAllPoints()
		MMFrames.info.location:SetPoint(point, "Minimap", rpoint, xofs, yofs)
		MMFrames.info.location.text:SetFont(font, db.information.font.size / scale, db.information.font.outline)
		MMFrames.info.location:Show()
		yofs = yofs + yadj
		
		-- Coordinates
		if InfoShown.coords then
			MMFrames.info.coords:ClearAllPoints()
			MMFrames.info.coords:SetPoint(point, "Minimap", rpoint, xofs, yofs)
			MMFrames.info.coords.text:SetFont(font, db.information.font.size / scale, db.information.font.outline)
			MMFrames.info.coords:Show()
			yofs = yofs + yadj
		else
			MMFrames.info.coords:Hide()
		end
		
		-- Dungeon Difficulty
		if InfoShown.dungeondifficulty and not(InfoShown.coords) then
			MMFrames.info.dungeondifficulty:ClearAllPoints()
			MMFrames.info.dungeondifficulty:SetPoint(point, "Minimap", rpoint, xofs, yofs)
			MMFrames.info.dungeondifficulty.text:SetFont(font, db.information.font.size / scale, db.information.font.outline)
			MMFrames.info.dungeondifficulty:Show()
			yofs = yofs + yadj
		else
			MMFrames.info.dungeondifficulty:Hide()
		end
		
		-- Mail
		if InfoShown.mail then
			MMFrames.info.mail:ClearAllPoints()
			MMFrames.info.mail:SetPoint(point, "Minimap", rpoint, xofs, yofs)
			MMFrames.info.mail.text:SetFont(font, db.information.font.size / scale, db.information.font.outline)
			MMFrames.info.mail:Show()
			yofs = yofs + yadj
		else
			MMFrames.info.mail:Hide()
		end
		
		-- 
		-- Dungeon Finder Queue
		if InfoShown.queue then
			MMFrames.info.queue:ClearAllPoints()
			MMFrames.info.queue:SetPoint(point, "Minimap", rpoint, xofs, yofs)
			MMFrames.info.queue.text:SetFont(font, db.information.font.size / scale, db.information.font.outline)
			MMFrames.info.queue:Show()
			yofs = yofs + yadj
		else
			MMFrames.info.queue:Hide()
		end
		
			-- Raid Finder Queue
		if InfoShown.RFqueue then
			MMFrames.info.RFqueue:ClearAllPoints()
			MMFrames.info.RFqueue:SetPoint(point, "Minimap", rpoint, xofs, yofs)
			MMFrames.info.RFqueue.text:SetFont(font, db.information.font.size / scale, db.information.font.outline)
			MMFrames.info.RFqueue:Show()
			yofs = yofs + yadj
		else
			MMFrames.info.RFqueue:Hide()
		end
		
			-- Scenarios Queue
		if InfoShown.Squeue then
			MMFrames.info.Squeue:ClearAllPoints()
			MMFrames.info.Squeue:SetPoint(point, "Minimap", rpoint, xofs, yofs)
			MMFrames.info.Squeue.text:SetFont(font, db.information.font.size / scale, db.information.font.outline)
			MMFrames.info.Squeue:Show()
			yofs = yofs + yadj
		else
			MMFrames.info.Squeue:Hide()
		end
	else
		MMFrames.info.location:Hide()
		MMFrames.info.coords:Hide()
		MMFrames.info.dungeondifficulty:Hide()
		MMFrames.info.mail:Hide()
		MMFrames.info.queue:Hide()
		MMFrames.info.RFqueue:Hide()
		MMFrames.info.Squeue:Hide()
	end
end

-- Set Button positions
function nibMinimap:UpdateButtonsPosition()
	local NewMinimapPoints = GetPositionData()
	
	local xofs = NewMinimapPoints.xofs
	local yofs = NewMinimapPoints.yofs
	local point = NewMinimapPoints.point
	local rpoint = NewMinimapPoints.rpoint
	local scale = NewMinimapPoints.scale
	
	-- Get offset multipliers based on whether the Minimap is located at the bottom or top
	local tbxofs, tbyofs
	if point == "BOTTOMLEFT" then
		tbxofs = -1
		tbyofs = -1
	elseif point == "TOPLEFT" then
		tbxofs = -1
		tbyofs = 1
	end
	
	-- Set button positions and visibility for Normal or Farm Mode
	local xPos, yPos
	xPos = floor((tbxofs + xofs) * scale + 0.5)
	yPos = floor((tbyofs + yofs) * scale + 0.5)
	
	MMFrames.toggle:ClearAllPoints()
	MMFrames.toggle:SetPoint(point, "UIParent", rpoint, xPos, yPos)
	MMFrames.toggle:SetScale(1)
	MMFrames.toggle:Show()
	xPos = xPos + 16
	
	if Minimap:IsVisible() then
		MMFrames.config:ClearAllPoints()
		MMFrames.config:SetPoint(point, "UIParent", rpoint, xPos, yPos)
		MMFrames.config:SetScale(1)
		MMFrames.config:Show()
		xPos = xPos + 16
	else 
		MMFrames.config:Hide()
		MMFrames.config.mouseover = false
	end
		
	if Minimap:IsVisible() and ExpandedState == 0 then
		MMFrames.tracking:ClearAllPoints()
		MMFrames.tracking:SetPoint(point, "UIParent", rpoint, xPos, yPos)
		MMFrames.tracking:SetScale(1)
		MMFrames.tracking:Show()
		xPos = xPos + 16
	else 
		MMFrames.tracking:Hide()
		MMFrames.tracking.mouseover = false
	end
		
	if ( Minimap:IsVisible() and (not IsInInstance()) ) then
		MMFrames.farm:ClearAllPoints()
		MMFrames.farm:SetPoint(point, "UIParent", rpoint, xPos, yPos)
		MMFrames.farm:SetScale(1)
		MMFrames.farm:Show()
		xPos = xPos + 16
	else 
		MMFrames.farm:Hide()
		MMFrames.farm.mouseover = false
	end
	
	self:FadeButtons()
end

-- Set Minimap position
function nibMinimap:UpdateMinimapPosition()
	local NewMinimapPoints = GetPositionData()
	
	local xofs = NewMinimapPoints.xofs
	local yofs = NewMinimapPoints.yofs
	local point = NewMinimapPoints.point
	local rpoint = NewMinimapPoints.rpoint
	local scale = NewMinimapPoints.scale
	local opacity = NewMinimapPoints.opacity
	
	-- Set new size and position
	Minimap:SetFrameStrata("LOW")
	Minimap:SetFrameLevel(1)	
	
	Minimap:SetScale(scale)
	Minimap:SetAlpha(opacity)
	
	Minimap:SetMovable(true)
	Minimap:ClearAllPoints()
	Minimap:SetPoint(point, "UIParent", rpoint, xofs, yofs)
	Minimap:SetUserPlaced(true)
	
	-- LFD Button Tooltip
	local lfdpoint, lfdrpoint
	if point == "BOTTOMLEFT" then
		lfdpoint = "BOTTOMLEFT"
		lfdrpoint = "BOTTOMRIGHT"
	else	-- Set anchor to default
		lfdpoint = "TOPLEFT"
		lfdrpoint = "TOPRIGHT"
	end
	QueueStatusFrame:ClearAllPoints()
	QueueStatusFrame:SetPoint(lfdpoint, "QueueStatusMinimapButton", lfdrpoint)
	QueueStatusFrame:SetClampedToScreen(true)
	
	-- Update the rest of the Minimap
	self:UpdateButtonsPosition()
	self:UpdateInfoPosition()
	self:UpdateClickthrough()
	self:UpdateBG()
end

-------------------------
-- INFORMATION UPDATES --
-------------------------

---- POI ----

-- POI Frame events
-- Show Tooltip
local POITooltip = CreateFrame("GameTooltip", "QuestPointerTooltip", UIParent, "GameTooltipTemplate")
local function POI_OnEnter(self)
	-- Set Tooltip's parent
	if UIParent:IsVisible() then
		POITooltip:SetParent(UIParent)
	else
		POITooltip:SetParent(self)
	end
	
	-- Set Tooltip position
	local NewMinimapPoints = GetPositionData()
	local mm_point = NewMinimapPoints.point
	if mm_point == "TOPLEFT" then
		POITooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 10, -10)
	elseif mm_point == "BOTTOMLEFT" then
		POITooltip:SetOwner(self, "ANCHOR_TOPMRIGHT", 5, 5)
	end
	
	-- Skin Tooltip if Skinner is loaded
	if IsAddOnLoaded("Skinner") then
		local backdrop = {
			bgFile = [[Interface\AddOns\nibMinimap\Media\Plain]],
			insets = {left = 2, right = 2, top = 2, bottom = 2},
			edgeFile = [[Interface\AddOns\nibMinimap\Media\Border-Thin]],
			edgeSize = 16
		}
		POITooltip:SetScale(1)
		POITooltip:SetBackdrop(backdrop)
		POITooltip:SetBackdropColor(0, 0, 0, 0.75)
		POITooltip:SetBackdropBorderColor(0.7, 0.7, 0.7, 1)
	end
	
	-- Add Hyperlink
	local link = GetQuestLink(self.questLogIndex)
	if link then
		POITooltip:SetHyperlink(link)
	end
end

-- Hide Tooltip
local function POI_OnLeave(self)
	POITooltip:Hide()
end

-- Open World Map at appropriate quest
local function POI_OnMouseUp(self)
	WorldMapFrame:Show()
	local frame = _G["WorldMapQuestFrame"..self.index]
	if not frame then
		return
	end
	WorldMapFrame_SelectQuestFrame(frame)
	nibMinimap:SelectSpecificPOI(self)
end

-- Find closest POI
function nibMinimap:ClosestPOI(all)
	local closest, closest_distance, poi_distance
	for k, poi in pairs(self.pois) do
		if poi.active then
			poi_distance = Astrolabe:GetDistanceToIcon(poi)
			
			if closest then
				if ( poi_distance and closest_distance and (poi_distance < closest_distance) ) then
					closest = poi
					closest_distance = poi_distance
				end
			else
				closest = poi
				closest_distance = poi_distance
			end
		end
	end
	return closest
end

function nibMinimap:SelectSpecificPOI(self)
	QuestPOI_SelectButton(self.poiButton)
	SetSuperTrackedQuestID(self.questId)
	nibMinimap:UpdatePOIGlow()
end

-- Select Closest POI
function nibMinimap:SelectClosestPOI()
	if not db.poi.enabled then return end
	
	local closest = self:ClosestPOI()
	if closest then
		self:SelectSpecificPOI(self)
	end
end

-- Update POI at edge of Minimap
function nibMinimap:UpdatePOIEdges()
	for id, poi in pairs(pois) do
		if poi.active then
			if Astrolabe:IsIconOnEdge(poi) then
				poi.poiButton:Show()
				poi.poiButton:SetAlpha(db.poi.icons.opacity * (db.poi.fadeEdge and 0.6 or 1))
			else
				-- Hide completed POIs when close enough to see the ?
				if poi.complete then
					poi.poiButton:Hide()
				else
					poi.poiButton:Show()
				end
				poi.poiButton:SetAlpha(db.poi.icons.opacity)
			end
		end
	end
end

-- Update POI highlight
function nibMinimap:UpdatePOIGlow()
	for i, poi in pairs(pois) do
		if GetSuperTrackedQuestID() == poi.questId then
			QuestPOI_SelectButton(poi.poiButton)
			poi:SetFrameLevel(Minimap:GetFrameLevel() + 3)
		else
			QuestPOI_DeselectButton(poi.poiButton)
			poi:SetFrameLevel(Minimap:GetFrameLevel() + 2)
		end
	end
end

function nibMinimap:RemoveAllPOIs()
	for i, poi in pairs(pois) do
		Astrolabe:RemoveIconFromMinimap(poi)
		if poi.poiButton then
			poi.poiButton:Hide()
			poi.poiButton:SetParent(Minimap)
			poi.poiButton = nil
		end
		poi.active = false
	end
end

-- Update all POIs
function nibMinimap:POIUpdate(...)
	if ( (not db.poi.enabled) or (ExpandedState == 1 and db.expand.extras.hidepoi) ) then return end
	
	self:RemoveAllPOIs()
	
	local c,z,x,y = Astrolabe:GetCurrentPlayerPosition()
	
	-- Update was probably triggered by World Map browsing. Don't update any POIs.
	if not (c and z and x and y) then return end
	
	QuestPOIUpdateIcons()
	
	local numNumericQuests = 0
	local numCompletedQuests = 0
	local numEntries = QuestMapUpdateAllQuests()
	-- Iterate through all available quests, retrieving POI info
	for i = 1, numEntries do
		local questId, questLogIndex = QuestPOIGetQuestIDByVisibleIndex(i)
		if questId then
			local _, posX, posY, objective = QuestPOIGetIconInfo(questId)
			if ( posX and posY and (IsQuestWatched(questLogIndex) or not db.poi.watchedOnly) ) then
				local title, level, questTag, suggestedGroup, isHeader, isCollapsed, isComplete, isDaily = GetQuestLogTitle(questLogIndex)
				local numObjectives = GetNumQuestLeaderBoards(questLogIndex)
				if isComplete and isComplete < 0 then
					isComplete = false
				elseif numObjectives == 0 then
					isComplete = true
				end
				
				-- Create POI arrow
				local poi = pois[i]
				if not poi then
					poi = CreateFrame("Frame", "QuestPointerPOI"..i, Minimap)
					poi:SetFrameLevel(Minimap:GetFrameLevel() + 2)
					poi:SetWidth(10)
					poi:SetHeight(10)
					poi:SetScript("OnEnter", POI_OnEnter)
					poi:SetScript("OnLeave", POI_OnLeave)
					poi:SetScript("OnMouseUp", POI_OnMouseUp)
					poi:EnableMouse()
				end
				
				-- Create POI button
				local poiButton
				if isComplete then
					-- Using QUEST_POI_COMPLETE_SWAP gets the ? without any circle
					-- Using QUEST_POI_COMPLETE_IN gets the ? in a brownish circle
					numCompletedQuests = numCompletedQuests + 1
					poiButton = QuestPOI_DisplayButton("Minimap", QUEST_POI_COMPLETE_IN, numCompletedQuests, questId)
				else
					numNumericQuests = numNumericQuests + 1
					poiButton = QuestPOI_DisplayButton("Minimap", QUEST_POI_NUMERIC, numNumericQuests, questId)
				end
				poiButton:SetPoint("CENTER", poi)
				poiButton:SetScale(db.poi.icons.scale)
				poiButton:SetParent(poi)
				poiButton:EnableMouse(false)
				poi.poiButton = poiButton
				
				poi.index = i
				poi.questId = questId
				poi.questLogIndex = questLogIndex
				poi.c = c
				poi.z = z
				poi.x = posX
				poi.y = posY
				poi.title = title
				poi.active = true
				poi.complete = isComplete
				
				Astrolabe:PlaceIconOnMinimap(poi, c, z, posX, posY)
				
				pois[i] = poi
			else
				-- Skipped
			end
		end
	end
	self:UpdatePOIEdges()
	self:UpdatePOIGlow()
end

function nibMinimap:InitializePOI()
	-- This would be needed for switching to a different look when icons are on the edge of the minimap.
	Astrolabe:Register_OnEdgeChanged_Callback(function(...)
		self:UpdatePOIEdges()
	end, "nibMinimap")
	
	-- Update POI timer
	local GlowTimer = CreateFrame("Frame")
	GlowTimer.elapsed = 0
	GlowTimer:SetScript("OnUpdate", function(self, elapsed)
		GlowTimer.elapsed = GlowTimer.elapsed + elapsed
		if ( (GlowTimer.elapsed > 2) and (not WorldMapFrame:IsShown()) and db.poi.enabled ) then
			GlowTimer.elapsed = 0
			nibMinimap:UpdatePOIGlow()
		end
	end)
end

function nibMinimap:UpdatePOIEnabled()
	if db.poi.enabled then
		self:POIUpdate()
		self:InitializePOI()
	else
		self:RemoveAllPOIs()
	end
end

function nibMinimap:GetLFGQueue()
	for i=1, NUM_LE_LFG_CATEGORYS do
		local mode, submode = GetLFGMode(i);
		if ( mode ) then
			self:QueueTimeUpdate(i);
--			entry:Show();
--			totalHeight = totalHeight + entry:GetHeight();
--			nextEntry = nextEntry + 1;

--			showMinimapButton = true;
--			if ( mode == "queued" ) then
--				animateEye = true;
--			end
		end
	end
end

---- Queue Time ----
function nibMinimap:QueueTimeUpdate(category)
	local mode, submode = GetLFGMode(category)
	if mode == "queued" then
		local queueStr = ""
		local hasData, _, _, _, _, _, _, _, _, _, _, _, _, _, _, myWait, queuedTime = GetLFGQueueStats(category);
--		local hasData, _, _, _, _, _, _, _, _, _, _, _, _, _, _, myWait, queuedTime = GetLFGQueueStats()
		
		if not hasData then
			queueStr = LESS_THAN_ONE_MINUTE
		else
			local elapsedTime = GetTime() - queuedTime
			local tiqStr = strform("%s", ConvertSecondstoTime(elapsedTime))
			local awtStr = strform("%s", myWait == -1 and TIME_UNKNOWN or SecondsToTime(myWait, false, false, 1))
			queueStr = strform("%s |cffc0c0c0(%s)|r", tiqStr, awtStr)
		end
		
		if category == 1 then -- Dungeon Finder
			MMFrames.info.queue.text:SetText("|cffffa000DF:|r "..queueStr)
			MMFrames.info.queue:SetWidth(MMFrames.info.queue.text:GetStringWidth() + 12)
			InfoShown.queue = true
		elseif category == 3 then -- Raid Finder
			MMFrames.info.RFqueue.text:SetText("|cffffa000RF:|r "..queueStr)
			MMFrames.info.RFqueue:SetWidth(MMFrames.info.RFqueue.text:GetStringWidth() + 12)
			InfoShown.RFqueue = true
		elseif category == 4 then -- Scenarios
			MMFrames.info.Squeue.text:SetText("|cffffa000S:|r "..queueStr)
			MMFrames.info.Squeue:SetWidth(MMFrames.info.Squeue.text:GetStringWidth() + 12)
			InfoShown.Squeue = true
		end
	else
		-- Set to hide Queue time
		InfoShown.queue = false
		InfoShown.RFqueue = false
		InfoShown.Squeue = false
	end
	if not UpdateProcessing then
		self:UpdateInfoPosition()
	end
end

function nibMinimap:QueueTimeFrequentCheck()
	if InfoShown.queue or InfoShown.RFqueue or InfoShown.Squeue then
		self:GetLFGQueue()
	end
end

---- Dungeon Difficulty ----
local selectedRaidDifficulty
local allowedRaidDifficulty
local IS_GUILD_GROUP
function nibMinimap:DungeonDifficultyUpdate()
	-- If in a Party/Raid then show Dungeon Difficulty text
	MMFrames.info.dungeondifficulty.text:SetText("")
	local _, instanceType, difficulty, _, maxPlayers, playerDifficulty, isDynamicInstance = GetInstanceInfo()
	if (IS_GUILD_GROUP or ((instanceType == "party" or instanceType == "raid") and not (difficulty == 1 and maxPlayers == 5))) then
		-- Get Dungeon Difficulty
		local isHeroic = false
		if (instanceType == "party" and difficulty == 2) then
			isHeroic = true
		elseif instanceType == "raid" then
			if isDynamicInstance then
				selectedRaidDifficulty = difficulty
				if selectedRaidDifficulty == 1 then
					allowedRaidDifficulty = 3
				elseif selectedRaidDifficulty == 2 then
					allowedRaidDifficulty = 4
				elseif selectedRaidDifficulty == 3 then
					allowedRaidDifficulty = 1
				elseif selectedRaidDifficulty == 4 then
					allowedRaidDifficulty = 2
				elseif (selectedRaidDifficulty == 5 ) then -- Temporary fix. 5 here means LFR and we don't want to allow any other raid difficulty in that case. It's also not heroic (it's a 25 normal). -Should fix in 5.1.0 cleanup.
					allowedRaidDifficulty = nil;
					isHeroic = false;
				end
				if (allowedRaidDifficulty) then 
					allowedRaidDifficulty = "RAID_DIFFICULTY"..(allowedRaidDifficulty);
				end
			end
			if difficulty > 2 then
				isHeroic = true
			end
		end
		
		-- Set Text
		local DifficultyText = ""
		if isHeroic then DifficultyText = "+" end
		DifficultyText = DifficultyText..tostring(maxPlayers)
		if IS_GUILD_GROUP then DifficultyText = DifficultyText.." ("..GUILD..")" end
		
		MMFrames.info.dungeondifficulty.text:SetText("D: "..DifficultyText)
		MMFrames.info.dungeondifficulty:SetWidth(MMFrames.info.dungeondifficulty.text:GetStringWidth() + 12)
		
		-- Update Frames
		MMFrames.info.dungeondifficulty:EnableMouse(true)
		
		if IS_GUILD_GROUP then
			MMFrames.info.dungeondifficulty:SetScript("OnEnter", function(self)
				local guildName = GetGuildInfo("player")
				local _, instanceType, _, _, maxPlayers = GetInstanceInfo()
				local _, numGuildPresent, numGuildRequired = InGuildParty()
				if instanceType == "arena" then
					maxPlayers = numGuildRequired
				end
				GameTooltip:SetOwner(MMFrames.info.dungeondifficulty, "ANCHOR_RIGHT", 18)
				GameTooltip:SetText(GUILD_GROUP, 1, 1, 1)
				GameTooltip:AddLine(strform(GUILD_ACHIEVEMENTS_ELIGIBLE, numGuildRequired, maxPlayers, guildName), nil, nil, nil, 1)
				GameTooltip:Show()
			end)
			MMFrames.info.dungeondifficulty:SetScript("OnLeave", function()
				if GameTooltip:IsShown() then GameTooltip:Hide() end
			end)
		else
			MMFrames.info.dungeondifficulty:SetScript("OnEnter", nil)
		end
		
		-- Set to show DungeonDifficulty
		InfoShown.dungeondifficulty = true
	else
		-- Update Frames
		MMFrames.info.dungeondifficulty:SetScript("OnEnter", nil)
		
		-- Set to hide DungeonDifficulty
		InfoShown.dungeondifficulty = false
	end
	if not UpdateProcessing then
		self:UpdateInfoPosition()
	end
end

function nibMinimap:UpdateGuildPartyState(event, ...)
	-- Update Guild info and then update Dungeon Difficulty
	if event == "GUILD_PARTY_STATE_UPDATED" then
		local isGuildGroup = ...
		if isGuildGroup ~= IS_GUILD_GROUP then
			IS_GUILD_GROUP = isGuildGroup
			self:DungeonDifficultyUpdate()
		end
	else
		if IsInGuild() then
			RequestGuildPartyState()
		else
			IS_GUILD_GROUP = nil
		end
	end
end

function nibMinimap:InstanceDifficultyOnEvent(event, ...)
	self:DungeonDifficultyUpdate()
end


---- Mail ----

function nibMinimap:MailUpdate()
	local oldmailshown = InfoShown.mail
	if HasNewMail() then
		InfoShown.mail = true
		MMFrames.info.mail:EnableMouse(true)
		MMFrames.info.mail:SetScript("OnEnter", function(self)
			MinimapMailFrameUpdate()
			
			local send1, send2, send3 = GetLatestThreeSenders()
			local toolText

			GameTooltip:SetOwner(MMFrames.info.mail, "ANCHOR_CURSOR")
			if (send1 or send2 or send3) then
				GameTooltip:AddLine(HAVE_MAIL_FROM)
			else
				GameTooltip:AddLine(HAVE_MAIL)
			end

			if send1 then GameTooltip:AddLine(strform("|cffffffff%s|r", send1)) end
			if send2 then GameTooltip:AddLine(strform("|cffffffff%s|r", send2)) end
			if send3 then GameTooltip:AddLine(strform("|cffffffff%s|r", send3)) end

			GameTooltip:Show()
		end)
		MMFrames.info.mail:SetScript("OnLeave", function()
			if GameTooltip:IsShown() then GameTooltip:Hide() end
		end)
		MMFrames.info.mail.text:SetText(NEW .. " " .. MAIL_LABEL)
		MMFrames.info.mail:SetWidth(MMFrames.info.mail.text:GetStringWidth() + 12)
	else
		InfoShown.mail = false
		MMFrames.info.mail:SetScript("OnEnter", nil)
		MMFrames.info.mail:SetScript("OnLeave", nil)
	end
	if not UpdateProcessing then self:UpdateInfoPosition() end
end


---- Coordinates ----
local coords_int = 0.5
function nibMinimap:CoordsUpdate()
	if (IsInInstance() or not Minimap:IsVisible()) then	-- Hide Coords 
		MMFrames.info.coords:SetScript("OnUpdate", nil)
		InfoShown.coords = false
	else	-- Show Coords
		MMFrames.info.coords:SetScript("OnUpdate", function(self, elapsed)
			coords_int = coords_int - elapsed
			if (coords_int <= 0) then
				local X, Y = GetPlayerMapPosition("Player")
				MMFrames.info.coords.text:SetText(strform("%.1f, %.1f", X*100, Y*100))
				MMFrames.info.coords:SetWidth(MMFrames.info.coords.text:GetStringWidth() + 12)
				coords_int = 0.5
			end
		end)
		InfoShown.coords = true
	end
	if not UpdateProcessing then self:UpdateInfoPosition() end
end

---------------------
-- MINIMAP UPDATES --
---------------------
function nibMinimap:Update()
	UpdateProcessing = true		-- Stops individual update functions from calling UpdateInfoPosition
	self:CoordsUpdate()
	self:DungeonDifficultyUpdate()
	self:UpdateButtonsPosition()
	UpdateProcessing = false
end

-- Set Minimap visibility
function nibMinimap:Toggle(shown)
	if shown then
		Minimap:Show()
		MMFrames.toggle.icon:SetTexture(Textures.Minimize)
	else
		Minimap:Hide()
		MMFrames.toggle.icon:SetTexture(Textures.Maximize)
		MMFrames.toggle:SetAlpha(1)
	end
	self:Update()
end

-- Determine what visibility state the Minimap should be in
function nibMinimap:UpdateShownState()
	local Inst, InstType = IsInInstance()
	local MinimapShown = true
	if Inst then
		if db.hidden.enabled then
			if (InstType == "pvp" and db.hidden.zones.pvp) then			-- Battlegrounds
				MinimapShown = false
			elseif (InstType == "arena" and db.hidden.zones.arena) then	-- Arena
				MinimapShown = false
			elseif (InstType == "party" and db.hidden.zones.party) then	-- 5 Man Dungeons
				MinimapShown = false
			elseif (InstType == "raid" and db.hidden.zones.raid) then	-- Raid Dungeons
				MinimapShown = false
			end
		end
		
		-- Disable Farm Mode while in dungeon
		if ExpandedState ~= 0 then
			ExpandedState = 0
			self:ToggleGatherer()
			self:UpdateMinimapPosition()
		end
	end
	self:Toggle(MinimapShown)
end


-------------
-- BUTTONS --
-------------
---- Fade
local function UpdateButtonFade()
	if Minimap:IsVisible() then
		if Minimap.mouseover or MMFrames.toggle.mouseover or MMFrames.config.mouseover or MMFrames.tracking.mouseover or MMFrames.farm.mouseover then
			if MMFrames.toggle:GetAlpha() < 1 then
				UIFrameFadeIn(MMFrames.toggle, 0.25, MMFrames.toggle:GetAlpha(), 1)
			end
			if MMFrames.config:GetAlpha() < 1 then
				UIFrameFadeIn(MMFrames.config, 0.25, MMFrames.config:GetAlpha(), 1)
			end
			if ExpandedState == 0 then
				if MMFrames.tracking:GetAlpha() < 1 then
					UIFrameFadeIn(MMFrames.tracking, 0.25, MMFrames.tracking:GetAlpha(), 1)
				end
			end
			if not IsInInstance() then
				if MMFrames.farm:GetAlpha() < 1 then
					UIFrameFadeIn(MMFrames.farm, 0.25, MMFrames.farm:GetAlpha(), 1)
				end
			end
		else
			if MMFrames.toggle:GetAlpha() > 0 then
				UIFrameFadeOut(MMFrames.toggle, 0.25, MMFrames.toggle:GetAlpha(), 0)
			end
			if MMFrames.config:GetAlpha() > 0 then
				UIFrameFadeOut(MMFrames.config, 0.25, MMFrames.config:GetAlpha(), 0)
			end
			if ExpandedState == 0 then
				if MMFrames.tracking:GetAlpha() > 0 then
					UIFrameFadeOut(MMFrames.tracking, 0.25, MMFrames.tracking:GetAlpha(), 0)
				end
			end
			if not IsInInstance() then
				if MMFrames.farm:GetAlpha() > 0 then
					UIFrameFadeOut(MMFrames.farm, 0.25, MMFrames.farm:GetAlpha(), 0)
				end
			end
		end
	else
		
	end
end

local FadeTimer = CreateFrame("Frame")
FadeTimer:Hide()
FadeTimer.elapsed = 0
FadeTimer:SetScript("OnUpdate", function(s, e)
	FadeTimer.elapsed = FadeTimer.elapsed + e
	if FadeTimer.elapsed >= 0.25 then
		UpdateButtonFade()
		FadeTimer.elapsed = 0
		FadeTimer:Hide()
	end
end)
function nibMinimap:FadeButtons()
	FadeTimer.elapsed = 0
	FadeTimer:Show()
end

---- Toggle Button ----
local function Toggle_OnMouseDown()
	local MinimapShown = Minimap:IsVisible()
	if MinimapShown then
		PlaySound("igMiniMapClose")
		nibMinimap:Toggle(false)
	else
		PlaySound("igMiniMapOpen")
		nibMinimap:Toggle(true)
	end
	if DropDownList1 then DropDownList1:Hide() end
	if DropDownList2 then DropDownList2:Hide() end
end

function nibMinimap:ToggleBind()
	Toggle_OnMouseDown()
end

local function Toggle_OnEnter()
	MMFrames.toggle.bg:SetVertexColor(unpack(ClassColor))
	MMFrames.toggle.icon:SetVertexColor(unpack(ClassColor))
	MMFrames.toggle:SetFrameLevel(6)
	MMFrames.toggle.mouseover = true
	nibMinimap:FadeButtons()
end

local function Toggle_OnLeave()
	MMFrames.toggle.bg:SetVertexColor(0, 0, 0)
	MMFrames.toggle.icon:SetVertexColor(1, 1, 1)
	MMFrames.toggle:SetFrameLevel(5)
	MMFrames.toggle.mouseover = false
	nibMinimap:FadeButtons()
end

---- Config Button ----
local function Config_OnMouseDown()
	nibMinimap:ChatCommand()
	
	if DropDownList1 then DropDownList1:Hide() end
	if DropDownList2 then DropDownList2:Hide() end
end

local function Config_OnEnter()
	MMFrames.config.bg:SetVertexColor(unpack(ClassColor))
	MMFrames.config.icon:SetVertexColor(unpack(ClassColor))
	MMFrames.config:SetFrameLevel(6)
	MMFrames.config.mouseover = true
	nibMinimap:FadeButtons()
end

local function Config_OnLeave()
	MMFrames.config.bg:SetVertexColor(0, 0, 0)
	MMFrames.config.icon:SetVertexColor(1, 1, 1)
	MMFrames.config:SetFrameLevel(5)
	MMFrames.config.mouseover = false
	nibMinimap:FadeButtons()
	
	if GameTooltip:IsShown() then GameTooltip:Hide() end
end

---- Tracking Button ----
local function Tracking_OnMouseDown()
	ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, "nibMinimap_Tracking", 0, 0)
end

local function Tracking_OnEnter()
	MMFrames.tracking.bg:SetVertexColor(unpack(ClassColor))
	MMFrames.tracking.icon:SetVertexColor(unpack(ClassColor))
	MMFrames.tracking:SetFrameLevel(6)
	MMFrames.tracking.mouseover = true
	nibMinimap:FadeButtons()
end

local function Tracking_OnLeave()
	MMFrames.tracking.bg:SetVertexColor(0, 0, 0)
	MMFrames.tracking.icon:SetVertexColor(1, 1, 1)
	MMFrames.tracking:SetFrameLevel(5)
	MMFrames.tracking.mouseover = false
	nibMinimap:FadeButtons()
	
	if GameTooltip:IsShown() then GameTooltip:Hide() end
end

---- Farm Button ----
function nibMinimap:ToggleGatherer()
	if ( (not db.expand.extras.gatherertoggle) or (not Gatherer) ) then return end
	
	if ExpandedState == 1 then
		Gatherer.Config.SetSetting("minimap.enable", true)
	else
		Gatherer.Config.SetSetting("minimap.enable", false)
	end
end

local function Farm_OnMouseDown()
	if ExpandedState == 0 then
		ExpandedState = 1
		PlaySound("igMiniMapOpen")
	else
		ExpandedState = 0
		PlaySound("igMiniMapClose")
	end
	if DropDownList1 then DropDownList1:Hide() end
	if DropDownList2 then DropDownList2:Hide() end
	
	nibMinimap:ToggleGatherer()
	nibMinimap:UpdateMinimapPosition()
	nibMinimap:UpdateFarmModePOI()
end

function nibMinimap:FarmBind()
	local Inst = IsInInstance()
	if Inst then return end
	Farm_OnMouseDown()
end

local function Farm_OnEnter()
	MMFrames.farm.bg:SetVertexColor(unpack(ClassColor))
	MMFrames.farm.icon:SetVertexColor(unpack(ClassColor))
	MMFrames.farm:SetFrameLevel(6)
	MMFrames.farm.mouseover = true
	nibMinimap:FadeButtons()
end

local function Farm_OnLeave()
	MMFrames.farm.bg:SetVertexColor(0, 0, 0)
	MMFrames.farm.icon:SetVertexColor(1, 1, 1)
	MMFrames.farm:SetFrameLevel(5)
	MMFrames.farm.mouseover = false
	nibMinimap:FadeButtons()
end

---- Minimap
local function Minimap_OnEnter()
	Minimap.mouseover = true
	nibMinimap:FadeButtons()
end

local function Minimap_OnLeave()
	Minimap.mouseover = false
	nibMinimap:FadeButtons()
end

------------
-- EVENTS --
------------

function nibMinimap:ZoneChange()
	local r, g, b = 1, 1, 1
	local pvpType = GetZonePVPInfo()
	if pvpType == "sanctuary" then
		r, g, b = 0.41, 0.8, 0.94
	elseif pvpType == "arena" then
		r, g, b = 1, 0.1, 0.1
	elseif pvpType == "friendly" then
		r, g, b = 0.2, 0.9, 0.2
	elseif pvpType == "hostile" then
		r, g, b = 1, 0.15, 0.15
	elseif pvpType == "contested" then
		r, g, b = 1, 0.7, 0
	elseif pvpType == "combat" then
		r, g, b = 1, 0, 0
	end
	
	local oldName = GetMinimapZoneText()
	local zName = (strlen(oldName) > 22) and gsub(oldName, "%s?(.[\128-\191]*)%S+%s", "%1.") or oldName
	if strlen(zName) > 22 then
		zName = strsub(zName, 1, 20)..".."
	end
	
	MMFrames.info.location.text:SetText(zName)
	MMFrames.info.location.text:SetTextColor(r, g, b)
	MMFrames.info.location:SetWidth(MMFrames.info.location.text:GetWidth() + 4)
	
	RefreshMap = true
end

function nibMinimap:ZONE_CHANGED_NEW_AREA()
	SetMapToCurrentZone()
	self:ZoneChange()
	
	-- Update POIs
	self:POIUpdate()
end

function nibMinimap:MINIMAP_UPDATE_ZOOM()
	ZoomMinimapOut()
	self:UnregisterEvent("MINIMAP_UPDATE_ZOOM")
end

function nibMinimap:PLAYER_ENTERING_WORLD()
	-- Hide persistent Minimap elements
	GameTimeFrame:Hide()
	GameTimeFrame.Show = function() end
	
	-- Update specific information
	self:MailUpdate()
	self:DungeonDifficultyUpdate()
	
	-- Update Minimap position and visible state
	self:UpdateMinimapPosition()
	self:UpdateShownState() -- Will also call nibMinimap:Update
	
	-- Update POIs
	self:UpdatePOIEnabled()
	
	-- Timer
	RefreshMap = true
	RefreshMail = true
	RefreshZoom = true
	RefreshTimer:Show()
end

-- Hide default Clock Button
function nibMinimap:ADDON_LOADED(event, ...)
	local addon = ...
	if addon == "Blizzard_TimeManager" then
		TimeManagerClockButton:HookScript("OnShow", function()
			TimeManagerClockButton:Hide()
		end)
		TimeManagerClockButton:Hide()
	end
end

local function ClassColorsUpdate()
	ClassColor = GetClassColors(Class)
end

function nibMinimap:PLAYER_LOGIN()
	Class = select(2, UnitClass("player"))
	ClassColor = GetClassColor(Class)
	
	---- ClassColors support
	if CUSTOM_CLASS_COLORS then
		CUSTOM_CLASS_COLORS:RegisterCallback(ClassColorsUpdate)
	end
end

-- Register events
function nibMinimap:RegEvents()
	-- Hook into Blizzard addons
	self:RegisterEvent("ADDON_LOADED")
	
	-- Basic settings
	self:RegisterEvent("PLAYER_LOGIN")
	
	-- Initialise settings on UI load
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	
	-- Set Minimap Zoom
	self:RegisterEvent("MINIMAP_UPDATE_ZOOM")

	-- Location
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	self:RegisterBucketEvent({
		"ZONE_CHANGED",
		"ZONE_CHANGED_INDOORS",
		"WORLD_MAP_UPDATE",
	}, 0.2, "ZoneChange")
	
	-- Dungeon Difficulty
	self:RegisterEvent("GUILD_PARTY_STATE_UPDATED", "UpdateGuildPartyState")
	self:RegisterEvent("PLAYER_GUILD_UPDATE", "UpdateGuildPartyState")
	self:RegisterBucketEvent({
		"PLAYER_DIFFICULTY_CHANGED",
		"UPDATE_INSTANCE_INFO",
		"PARTY_MEMBERS_CHANGED",
		"PARTY_MEMBER_ENABLE",
		"PARTY_MEMBER_DISABLE",
	}, 1, "InstanceDifficultyOnEvent")
	
	
	-- Queue
	self:RegisterEvent("LFG_UPDATE", "GetLFGQueue")
	self:RegisterEvent("LFG_PROPOSAL_SHOW", "GetLFGQueue")
	self:RegisterEvent("LFG_QUEUE_STATUS_UPDATE", "GetLFGQueue")
	self:ScheduleRepeatingTimer("QueueTimeFrequentCheck", 1)
	
	-- Mail
	self:RegisterEvent("UPDATE_PENDING_MAIL", "MailUpdate")
	self:RegisterEvent("MAIL_CLOSED", "MailUpdate")
	self:RegisterEvent("MAIL_SHOW", "MailUpdate")
	self:RegisterEvent("MAIL_INBOX_UPDATE", "MailUpdate")
	
	-- POI
	self:RegisterEvent("QUEST_POI_UPDATE", "POIUpdate")
	self:RegisterEvent("QUEST_LOG_UPDATE", "POIUpdate")
	
	local UpdatePOICall = function() self:POIUpdate() end
	hooksecurefunc("AddQuestWatch", UpdatePOICall)
	hooksecurefunc("RemoveQuestWatch", UpdatePOICall)
end


--------------------------
-- FRAME INITIALIZATION --
--------------------------

function nibMinimap:UpdateBG()
	local frameborder = ""
	if db.border.texture and strlen(db.border.texture) > 0 then 
		frameborder = RetrieveBorder(db.border.texture)
		if db.border.texture ~= "None" then
			if not frameborder then
				print("Border "..db.border.texture.." was not found in SharedMedia.")
			end
		end
	end
	
	-- BG
	local insetSize
	if ExpandedState == 0 then
		insetSize = db.backdrop.inset / db.position.scale
	else
		insetSize = db.backdrop.inset / db.expand.appearance.scale
	end
	Minimap:SetBackdrop({bgFile = [=[Interface\ChatFrame\ChatFrameBackground]=], edgeFile = "", edgeSize = 0, tile = false, tileSize = 0, insets = {left = insetSize, right = insetSize, top = insetSize, bottom = insetSize}})
	Minimap:SetBackdropColor(db.backdrop.color.r, db.backdrop.color.g, db.backdrop.color.b, db.backdrop.color.a)
		
	-- Border
	MinimapNewBorder:SetHeight(Minimap:GetHeight() - db.border.inset)
	MinimapNewBorder:SetWidth(Minimap:GetWidth() - db.border.inset)
	MinimapNewBorder:SetBackdrop({bgFile = "", edgeFile = frameborder, edgeSize = db.border.edgesize, tile = false, tileSize = 0, insets = {left = 0, right = 0, top = 0, bottom = 0}})
	MinimapNewBorder:SetBackdropBorderColor(db.border.color.r, db.border.color.g, db.border.color.b, db.border.color.a)
end

function nibMinimap:CreateBorder()
	MinimapNewBorder = CreateFrame("Frame", nil, UIParent)
	MinimapNewBorder:SetParent(Minimap)
	MinimapNewBorder:ClearAllPoints()
	MinimapNewBorder:SetPoint("CENTER", Minimap, "CENTER", 0, 0)
end

-- Update Frame fonts
function nibMinimap:UpdateFonts()
	-- Retrieve Font variables
	local font = RetrieveFont(db.information.font.name)
	
	-- Set Info font
	local fs	
	for k,v in pairs(MMFrames.info) do
		fs = MMFrames.info[k].text
		fs:SetPoint("LEFT", MMFrames.info[k], "LEFT", 0.5, 0.5)
		fs:SetFont(font, db.information.font.size, db.information.font.outline)
		fs:SetJustifyH("LEFT")
		MMFrames.info[k]:SetHeight(db.information.font.size)
	end
end

-- Frame Template
local function NewInfoFrame(Name, Parent)
	local Newframe
	
	Newframe = CreateFrame("Frame", Name, Parent)
	Newframe:SetHeight(12)
	Newframe:SetWidth(12)
	Newframe:SetFrameStrata("LOW")
	Newframe:SetFrameLevel(5)
	
	Newframe.text = Newframe:CreateFontString(nil, "ARTWORK")
	
	return Newframe
end

-- Create Information/Toggle frames
local function CreateButton(Name, Texture)
	local NewButton
	
	NewButton = CreateFrame("Frame", Name, UIParent)
	NewButton:SetHeight(16)
	NewButton:SetWidth(16)
	NewButton:SetFrameStrata("MEDIUM")
	NewButton:SetFrameLevel(5)
	NewButton:EnableMouse(true)
	NewButton:Show()
	
	NewButton.bg = NewButton:CreateTexture(nil, "BACKGROUND")
	NewButton.bg:SetTexture(Textures.Button)
	NewButton.bg:SetVertexColor(0, 0, 0)
	NewButton.bg:SetPoint("LEFT", NewButton, "LEFT", 0, 0)
	NewButton.bg:SetHeight(16)
	NewButton.bg:SetWidth(16)
	
	NewButton.icon = NewButton:CreateTexture(nil, "ARTWORK")
	NewButton.icon:SetTexture(Texture)
	NewButton.icon:SetVertexColor(1, 1, 1)
	NewButton.icon:SetPoint("LEFT", NewButton, "LEFT", 0, 0)
	NewButton.icon:SetHeight(16)
	NewButton.icon:SetWidth(16)
	
	return NewButton
end

local function CreateFrames()
	-- Set up Frame table
	nibMinimap.Frames = {
		toggle = nil,
		config = nil,
		tracking = nil,
		farm = nil,
		info = {},
	}
	MMFrames = nibMinimap.Frames

	-- Toggle Button
	MMFrames.toggle = CreateButton("nibMinimap_Toggle", Textures.Minimize)
	MMFrames.toggle:SetScript("OnEnter", Toggle_OnEnter)
	MMFrames.toggle:SetScript("OnLeave", Toggle_OnLeave)
	MMFrames.toggle:SetScript("OnMouseDown", Toggle_OnMouseDown)
	
	-- Config Button
	MMFrames.config = CreateButton("nibMinimap_Config", Textures.Config)
	MMFrames.config:SetScript("OnEnter", Config_OnEnter)
	MMFrames.config:SetScript("OnLeave", Config_OnLeave)
	MMFrames.config:SetScript("OnMouseDown", Config_OnMouseDown)
	
	-- Tracking Button
	MMFrames.tracking = CreateButton("nibMinimap_Tracking", Textures.Tracking)
	MMFrames.tracking:SetScript("OnEnter", Tracking_OnEnter)
	MMFrames.tracking:SetScript("OnLeave", Tracking_OnLeave)
	MMFrames.tracking:SetScript("OnMouseDown", Tracking_OnMouseDown)
	
	-- Farm Button
	MMFrames.farm = CreateButton("nibMinimap_Farm", Textures.Farm)
	MMFrames.farm:SetScript("OnEnter", Farm_OnEnter)
	MMFrames.farm:SetScript("OnLeave", Farm_OnLeave)
	MMFrames.farm:SetScript("OnMouseDown", Farm_OnMouseDown)
	
	-- Info
	MMFrames.info.location = NewInfoFrame("nibMinimap_Location", Minimap)
	MMFrames.info.location:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_CURSOR")
		GameTooltip:AddLine(oldName, nil, nil, nil, 1)
		GameTooltip:Show()
	end)
	MMFrames.info.location:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
	MMFrames.info.coords = NewInfoFrame("nibMinimap_Coords", Minimap)
	MMFrames.info.mail = NewInfoFrame("nibMinimap_Mail", Minimap)
	MMFrames.info.dungeondifficulty = NewInfoFrame("nibMinimap_DungeonDifficulty", Minimap)	
	MMFrames.info.queue = NewInfoFrame("nibMinimap_Queue", Minimap)	
	MMFrames.info.RFqueue = NewInfoFrame("nibMinimap_RFQueue", Minimap)	
	MMFrames.info.Squeue = NewInfoFrame("nibMinimap_SQueue", Minimap)	
	
	-- Update Fonts
	nibMinimap:UpdateFonts()
end


-------------------
-- MINIMAP FRAME --
-------------------

local function SetUpMinimapFrame()
	-- Establish Scroll Wheel zoom
	MinimapZoomIn:Hide()
	MinimapZoomOut:Hide()
	Minimap:EnableMouseWheel()
	Minimap:SetScript("OnMouseWheel", function(self, direction)
		if direction > 0 then
			MinimapZoomIn:Click()
		else
			MinimapZoomOut:Click()
		end
	end)
	Minimap:SetScript("OnEnter", Minimap_OnEnter)
	Minimap:SetScript("OnLeave", Minimap_OnLeave)
	
	-- Hide/Move Minimap elements
	MiniMapTracking:Hide()
	
	MiniMapMailFrame:Hide()
	MiniMapMailFrame.Show = function() end

	MinimapZoneText:Hide()
	MinimapZoneTextButton:Hide()
	
	QueueStatusMinimapButton:ClearAllPoints()
	QueueStatusMinimapButton:SetParent(Minimap)
	QueueStatusMinimapButton:SetPoint('BOTTOMRIGHT', 2, -2)
	QueueStatusMinimapButtonBorder:Hide()

	--MiniMapBattlefieldFrame:ClearAllPoints()
	--MiniMapBattlefieldFrame:SetParent(Minimap)
	--MiniMapBattlefieldFrame:SetPoint('TOPRIGHT', 2, -2)
	--MiniMapBattlefieldBorder:SetTexture(nil)
	
	--BattlegroundShine:Hide()

	MinimapNorthTag:SetAlpha(0)
	
	MiniMapInstanceDifficulty:Hide()
	MiniMapInstanceDifficulty.Show = function() end
	GuildInstanceDifficulty:Hide()
	GuildInstanceDifficulty.Show = function() end
	
	MiniMapWorldMapButton:Hide()
	
	GameTimeFrame:Hide()
	
	MinimapBorderTop:Hide()
	
	-- Make it square
	MinimapBorder:SetTexture(nil)
	Minimap:SetMaskTexture(Textures.SquareMask)
	
	-- Create New Border
	nibMinimap:CreateBorder()	
	nibMinimap:UpdateBG()

	-- Disable MinimapCluster area
	MinimapCluster:EnableMouse(false)
end


----------------
-- ADDON INIT --
----------------

function nibMinimap:ProfChange()
	db = self.db.profile
	self:ConfigRefresh()
	self:Refresh()
end

-- Refresh DB table and Minimap
function nibMinimap:Refresh()	
	self:UpdateFonts()
	self:UpdateBG()
	self:UpdateMinimapPosition()	
end

function nibMinimap:OnInitialize()
	-- Initialize settings, options, slash commands
	self.db = LibStub("AceDB-3.0"):New("nibMinimapDB", defaults, "Default")
	
	self.db.RegisterCallback(self, "OnProfileChanged", "ProfChange")
	self.db.RegisterCallback(self, "OnProfileCopied", "ProfChange")
	self.db.RegisterCallback(self, "OnProfileReset", "ProfChange")
	
	db = self.db.profile
	
	self:SetUpOptions()
	
	-- Create frames, register events, begin the Minimap
	SetUpMinimapFrame()
	CreateFrames()
	self:RegEvents()
end