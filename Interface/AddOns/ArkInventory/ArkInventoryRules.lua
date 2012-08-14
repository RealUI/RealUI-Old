function ArkInventory.Frame_Rules_Hide( )
	if ARKINV_Rules then
		ARKINV_Rules:Hide( )
	end
end
	
function ArkInventory.Frame_Rules_Show( )
	if ARKINV_Rules then
		ARKINV_Rules:Show( )
	end
end

function ArkInventory.Frame_Rules_Toggle( )
	
	if not IsAddOnLoaded( "ArkInventoryRules" ) then
		
		ArkInventory.OutputWarning( "Rules module has not been loaded" )
		
	else
		
		if ARKINV_Rules:IsVisible( ) then
			ArkInventory.Frame_Rules_Hide( )
		else
			ArkInventory.Frame_Rules_Show( )
		end
	
	end
	
end
