local mass

if IsAddOnLoaded("Massive") then
	mass = LibStub:GetLibrary("Massive")
end

IceUnitBar = IceCore_CreateClass(IceBarElement)

IceUnitBar.prototype.unit = nil
IceUnitBar.prototype.alive = nil
IceUnitBar.prototype.tapped = nil

IceUnitBar.prototype.unitClass = nil
IceUnitBar.prototype.hasPet = nil

IceUnitBar.prototype.noFlash = nil

-- Constructor --
function IceUnitBar.prototype:init(name, unit)
	IceUnitBar.super.prototype.init(self, name)
	assert(unit, "IceUnitBar 'unit' is nil")

	self:SetUnit(unit)
	self.noFlash = false

	self:SetDefaultColor("Dead", 0.5, 0.5, 0.5)
	self:SetDefaultColor("Tapped", 0.8, 0.8, 0.8)

	self.scaleHPColorInst = { r = 0, g = 255, b = 0 }
	self.scaleMPColorInst = { r = 0, g = 0, b = 255 }
end

function IceUnitBar.prototype:SetUnit(unit)
	self.unit = unit
	self.unitClass = select(2, UnitClass(self.unit))
end

-- OVERRIDE
function IceUnitBar.prototype:GetDefaultSettings()
	local settings = IceUnitBar.super.prototype.GetDefaultSettings(self)

	return settings
end


-- OVERRIDE
function IceUnitBar.prototype:GetOptions()
	local opts = IceUnitBar.super.prototype.GetOptions(self)

	return opts
end


-- 'Public' methods -----------------------------------------------------------

function IceUnitBar.prototype:Enable()
	IceUnitBar.super.prototype.Enable(self)

	self:RegisterEvent("PLAYER_UNGHOST", "Alive")
	self:RegisterEvent("PLAYER_ALIVE", "Alive")
	self:RegisterEvent("PLAYER_DEAD", "Dead")
	self:RegisterEvent("PLAYER_TALENT_UPDATE", "checkRole")

	self.alive = not UnitIsDeadOrGhost(self.unit)
	self.combat = UnitAffectingCombat(self.unit)
end


-- OVERRIDE
function IceUnitBar.prototype:Redraw()
	IceUnitBar.super.prototype.Redraw(self)

	if (self.moduleSettings.enabled) then
		self:Update(self.unit)
	end
end





-- 'Protected' methods --------------------------------------------------------

-- OVERRIDE
function IceUnitBar.prototype:CreateFrame()
	IceUnitBar.super.prototype.CreateFrame(self)
end


-- OVERRIDE
function IceUnitBar.prototype:Update()
	IceUnitBar.super.prototype.Update(self)
end


function IceUnitBar.prototype:Alive()
	-- instead of maintaining a state for 3 different things
	-- (dead, dead/ghost, alive) just afford the extra function call here
	self.alive = not UnitIsDeadOrGhost(self.unit)
	self:Update(self.unit)
end


function IceUnitBar.prototype:Dead()
	self.alive = false
	self:Update(self.unit)
end


-- OVERRIDE
function IceUnitBar.prototype:UpdateBar(scale, color, alpha)
	IceUnitBar.super.prototype.UpdateBar(self, scale, color, alpha)
end


function IceUnitBar.prototype:MyOnUpdate()
	IceUnitBar.super.prototype.MyOnUpdate(self)
end

function IceUnitBar.prototype:checkRole()
	-- IceUnitBar.super.prototype.checkRole(self)
	
	local spec = GetSpecialization()
	--print("spec: "..tostring(spec))
	local role
	if UnitLevel("player") >= 10 then
		if spec then
			role = GetSpecializationRole(spec)
		else
			role = DAMAGER
			print(ERR_SPEC_WIPE_ERROR)
		end
	else
		role = DAMAGER
	end
	--print("role: "..tostring(role))
	return role
end
