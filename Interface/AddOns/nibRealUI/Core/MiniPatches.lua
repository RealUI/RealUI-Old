local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")

function nibRealUI:MiniPatch(ver)
	-- if ver == "73r1" then
		-- if IsAddOnLoaded("addon") and addonDB then
			-- if addonDB["profiles"]["RealUI"] then
				-- addonDB["profiles"]["RealUI"]["x"] = 0
			-- end
			-- if addonDB["profiles"]["RealUI-HR"] then
				-- addonDB["profiles"]["RealUI-HR"]["x"] = 0
			-- end
		-- end
	-- elseif
	
	-- if
	
	
	-- end
	
	if ver == "74r4" then
		AuroraConfig = nil


	elseif ver == "74r5" then
		-- High-Res optimization
		local db, dbg, dbp, dp = self.db.profile, self.db.global, self.db.profile.positions, self.defaultpositions
		local resWidth, resHeight = self:GetResolutionVals()
		if (resWidth >= 1600) and (resHeight >= 1050) and not(dbg.tags.ldOptimized) then
			if (dbp[2]["HuDWidth"] == dp[2]["HuDWidth"]) and (dbp[2]["UFHorizontal"] == dp[2]["UFHorizontal"]) then
				self:SetLDOptimizations()
			end
			dbg.tags.ldOptimized = true
			self:GetModule("HuDConfig"):RegisterForUpdate("AB")
		end
	end
end