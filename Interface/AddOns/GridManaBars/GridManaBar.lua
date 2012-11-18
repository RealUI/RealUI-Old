local L = GridManaBarsLocale
--local AceOO = AceLibrary("AceOO-2.0")

local SML = LibStub("LibSharedMedia-3.0", true)

local GridFrame = Grid:GetModule("GridFrame")

GridMBFrame = GridFrame:NewModule("GridMBFrame")

GridMBFrame.defaultDB = {
    size = 0.3,
    side = "Right",
}

local indicators = GridFrame.prototype.indicators
table.insert(indicators, { type = "manabar",    order = 15,  name = L["Mana Bar"] })

local statusmap = GridFrame.db.profile.statusmap
if ( not statusmap["manabar"] ) then
	statusmap["manabar"] = { unit_mana = true }
end

local mb_options = {
    type = "group",
    name = L["Mana Bar"],
    desc = L["Mana Bar options."],
    args = {
        ["Manabar size"] = {
            type = "range",
            name = L["Size"],
            desc = L["Percentage of frame for mana bar"],
            max = 90,
            min = 10,
            step = 5,
            get = function ()
                return GridMBFrame.db.profile.size * 100
                end,
            set = function(_, v)
                GridMBFrame.db.profile.size = v / 100
                GridFrame:ResizeAllFrames()
                --GridFrame:ScheduleEvent("GridFrame_UpdateLayoutSize", "Grid_ReloadLayout", 0.5)
            end
        },
        ["Manabar side"] = {
            type = "select",
            name = L["Side"],
            desc = L["Side of frame manabar attaches to"],
            get = function ()
                return GridMBFrame.db.profile.side
                end,
            set = function(_, v)
                GridMBFrame.db.profile.side = v
                GridFrame:WithAllFrames(function (f) GridMBFrame.ReAnchor(f, v) end)
            end,
            values={["Left"] = L["Left"], ["Top"] = L["Top"], ["Right"] = L["Right"], ["Bottom"] = L["Bottom"] },
        },
    }
}

Grid.options.args["manabar"] = mb_options
--GridFrame.options.args["manabar"] = mb_options


function GridMBFrame.Reset(frame)
	GridMBFrame.ReAnchor(frame, GridMBFrame.db.profile.side)
    --GridFrame:WithAllFrames(function (f) f:ReAnchor(GridMBFrame.db.profile.side) end)
end


function GridMBFrame.SetManaBarColor(frame, col)	
	if GridFrame.db.profile.invertBarColor then
--DEFAULT_CHAT_FRAME:AddMessage("using inverted colours")
		frame.ManaBar:SetStatusBarColor(col.r,col.g,col.b,col.a)
		frame.BarMBG:SetVertexColor(0,0,0,0.8)
	else
--DEFAULT_CHAT_FRAME:AddMessage("using noninverted colours")
		frame.ManaBar:SetStatusBarColor(0,0,0,0.8)
		frame.BarMBG:SetVertexColor(col.r,col.g,col.b,col.a)
	end
end

function GridMBFrame.InvertBarColor(frame)
--DEFAULT_CHAT_FRAME:AddMessage("FC:InvertBarColor("..self.unitName..")")
	if frame.ManaBar then
        local col = {}
        if GridFrame.db.profile.invertBarColor then
            col.r, col.g, col.b, col.a = frame.BarMBG:GetVertexColor()
        else
            col.r, col.g, col.b, col.a = frame.ManaBar:GetStatusBarColor()
        end
		GridMBFrame.SetManaBarColor(frame, col)
	end
end

function GridMBFrame:SetFrameTexture(frame, texture)

	if not frame.ManaBar then return end

	frame.ManaBar:SetStatusBarTexture(texture)
    frame.BarMBG:SetTexture(texture)
end

function GridMBFrame.SetIndicator(frame, indicator, color, text, value, maxValue, texture, start, duration, stack)
	
    if not frame.ManaBar then return end
	if indicator == "manabar" then
		--DEFAULT_CHAT_FRAME:AddMessage("SI(2 "..type(color)..")")
        if frame.hideMB then
            --DEFAULT_CHAT_FRAME:AddMessage("SI(3)")
            GridMBFrame.HideManaBar(frame, false)
        end
        if value and maxValue then
            --DEFAULT_CHAT_FRAME:AddMessage("SI(4)")
            if maxValue <= 0 or value < 0 or value > maxValue then
                maxValue = 100
                value = 0
            end
            frame.ManaBar:SetValue(value/maxValue*100)
		end
        if type(color) == "table" then
            --DEFAULT_CHAT_FRAME:AddMessage("SI(5)")
			GridMBFrame.SetManaBarColor(frame, color)
        end
	end
end

function GridMBFrame.ClearIndicator(frame, indicator)
    
    if not frame.ManaBar then return end
    
    if (not frame.hideMB) and indicator == "manabar" then
        GridMBFrame.HideManaBar(frame, true)
    end
end

function GridMBFrame.SetBorderSize(frame, borderSize)
    GridMBFrame.ReAnchor(frame, GridMBFrame.db.profile.side)
end

function GridMBFrame.SetManaBarWidth(frame, width)
	if not frame.ManaBar then return end

	if frame.hideMB==true then return end
--    DEFAULT_CHAT_FRAME:AddMessage("FC:SetWidth("..width..")")

	local f=frame;
	local side = GridMBFrame.db.profile.side

	if side == "Left" or side == "Right" then
		local MBSize = GridMBFrame.db.profile.size
        local newWidth = width * (1 - MBSize)
        f.BarBG:SetWidth(newWidth)
        f.Bar:SetWidth(newWidth)
        f.HealingBar:SetWidth(newWidth)
	end
end


function GridMBFrame.SetWidth(frame, width)
	GridMBFrame.SetManaBarWidth(frame, width - (GridFrame.db.profile.borderSize+1)*2)
end

function GridMBFrame.SetManaBarHeight(frame, height)
	if not frame.ManaBar then return end
    
	if frame.hideMB==true then return end
--    DEFAULT_CHAT_FRAME:AddMessage("FC:SetHeight("..height..")")

	local f=frame;
	local side = GridMBFrame.db.profile.side

	if side == "Bottom" or side == "Top" then
        local MBSize = GridMBFrame.db.profile.size
        local newHeight = height * (1 - MBSize)
        f.BarBG:SetHeight(newHeight)
        f.Bar:SetHeight(newHeight)
        f.HealingBar:SetHeight(newHeight)
	end
end

function GridMBFrame.SetHeight(frame, height)
	GridMBFrame.SetManaBarHeight(frame, height - (GridFrame.db.profile.borderSize+1)*2)
end

function GridMBFrame.CreateFrames(gridFrameObj, frame)
	--ManaBarGridFrameClass.super.prototype.CreateFrames(self)
    --print("creating")
	
    local f = frame
    local texture = SML and SML:Fetch("statusbar", GridFrame.db.profile.texture) or "Interface\\Addons\\Grid\\gradient32x32"
    f.BarMBG = f:CreateTexture()
    f.BarMBG:SetTexture(texture)

    f.ManaBar = CreateFrame("StatusBar", nil, f)
    f.ManaBar:SetStatusBarTexture(texture)
    f.ManaBar:SetMinMaxValues(0,100)
    f.ManaBar:SetValue(100)
    f.ManaBar:SetPoint("TOPLEFT", f.BarMBG, "TOPLEFT")
    f.ManaBar:SetPoint("BOTTOMRIGHT", f.BarMBG, "BOTTOMRIGHT")

    GridMBFrame.ReAnchor(frame, GridMBFrame.db.profile.side)
    GridMBFrame.HideManaBar(frame, true)
end

function GridMBFrame.HideManaBar(frame, v)
    local f = frame
    
    if not f.ManaBar then return end    

--    DEFAULT_CHAT_FRAME:AddMessage("FC:HideManaBar("..tostring(v)..")")
    f.hideMB = v

    if v then
        local side = GridMBFrame.db.profile.side
        if side == "Left" or side == "Right" then
            local width = frame:GetWidth() 
            f.BarBG:SetWidth(width - (GridFrame.db.profile.borderSize+1)*2) --resize health bar to whole frame size
        else
            local height = frame:GetHeight() 
            f.BarBG:SetHeight(height - (GridFrame.db.profile.borderSize+1)*2) --resize health bar to whole frame size
        end
        f.ManaBar:Hide()
        f.BarMBG:Hide()
    else
        f.ManaBar:Show()
        f.BarMBG:Show()
        GridMBFrame.SetManaBarHeight(frame, frame:GetHeight()  - (GridFrame.db.profile.borderSize+1)*2)
        GridMBFrame.SetManaBarWidth(frame, frame:GetWidth()  - (GridFrame.db.profile.borderSize+1)*2)
    end
end

function GridMBFrame.ReAnchor(frame, side)

	local f = frame
	if not f.ManaBar then return end
 --   DEFAULT_CHAT_FRAME:AddMessage("FC:ReAnchor("..side..")")

	f.BarBG:ClearAllPoints()
	f.BarMBG:ClearAllPoints()
    
    local b = GridFrame.db.profile.borderSize+1

	if side == "Right" then
		f.BarBG:SetPoint("TOPLEFT", f, "TOPLEFT",b,-b)
		f.BarMBG:SetPoint("TOPRIGHT", f, "TOPRIGHT",-b,-b)
        f.BarMBG:SetPoint("BOTTOMLEFT", f.BarBG, "BOTTOMRIGHT")
		f.ManaBar:SetOrientation("VERTICAL")
	elseif side == "Left" then
		f.BarMBG:SetPoint("TOPLEFT", f, "TOPLEFT",b,-b)
		f.BarBG:SetPoint("TOPRIGHT", f, "TOPRIGHT",-b,-b)
        f.BarMBG:SetPoint("BOTTOMRIGHT", f.BarBG, "BOTTOMLEFT")
		f.ManaBar:SetOrientation("VERTICAL")
	elseif side == "Bottom" then
		f.BarBG:SetPoint("TOPLEFT", f, "TOPLEFT",b,-b)
		f.BarMBG:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT",b,b)
        f.BarMBG:SetPoint("TOPRIGHT", f.BarBG, "BOTTOMRIGHT")
		f.ManaBar:SetOrientation("HORIZONTAL")
	else
		f.BarMBG:SetPoint("TOPLEFT", f, "TOPLEFT",b,-b)
		f.BarBG:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT",b,b)
        f.BarMBG:SetPoint("BOTTOMRIGHT", f.BarBG, "TOPRIGHT")
		f.ManaBar:SetOrientation("HORIZONTAL")
	end

	frame:SetFrameWidth(frame:GetWidth() )     --tell the frame to update its childs width
	frame:SetFrameHeight(frame:GetHeight() )   --and height
end


function GridMBFrame:OnInitialize()
   if not self.db then
		self.db = Grid.db:RegisterNamespace(self.moduleName, { profile = self.defaultDB or { } })
	end
    
    --hook the hell out of GridFrame :-)
    hooksecurefunc(GridFrame, "InitializeFrame", GridMBFrame.CreateFrames)
    hooksecurefunc(GridFrame.prototype, "SetIndicator", GridMBFrame.SetIndicator)
    hooksecurefunc(GridFrame.prototype, "ClearIndicator", GridMBFrame.ClearIndicator)
    hooksecurefunc(GridFrame.prototype, "SetFrameWidth", GridMBFrame.SetWidth)
    hooksecurefunc(GridFrame.prototype, "SetFrameHeight", GridMBFrame.SetHeight)
    hooksecurefunc(GridFrame.prototype, "SetBorderSize", GridMBFrame.SetBorderSize)
    hooksecurefunc(GridFrame.prototype, "SetFrameTexture", GridMBFrame.SetFrameTexture)
end

function GridMBFrame:OnEnable()
end

function GridMBFrame:OnDisable()
end

function GridMBFrame:Reset()
end


