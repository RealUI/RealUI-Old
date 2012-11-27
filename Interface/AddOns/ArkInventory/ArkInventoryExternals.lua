-- forcibly load required libraries if not already loaded - required when running disembedded (some curse users)

if not IsAddOnLoaded( "Ace3" ) then
	LoadAddOn( "Ace3" )
end

if not IsAddOnLoaded( "AceGUI-3.0-SharedMediaWidgets" ) then
	LoadAddOn( "AceGUI-3.0-SharedMediaWidgets" )
end

if not IsAddOnLoaded( "LibPeriodicTable-3.1" ) then
	LoadAddOn( "LibPeriodicTable-3.1" )
end

if not IsAddOnLoaded( "LibSharedMedia-3.0" ) then
	LoadAddOn( "LibSharedMedia-3.0" )
end

if not IsAddOnLoaded( "LibPetJournal-2.0" ) then
	LoadAddOn( "LibPetJournal-2.0" )
end
