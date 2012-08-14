
do
	if GetLocale() ~= "deDE" then return end
	local L = GridManaBarsLocale

	L["Mana"] = "Mana"
	L["Mana Bar"] = "Manaleiste"
	L["Mana Bar options."] = "Optionen für Manaleiste."

	L["Size"] = "Größe"
	L["Percentage of frame for mana bar"] = "Prozentualer Anteil der Rahmengröße für die Manaleiste"
	L["Side"] = "Seite"
	L["Side of frame manabar attaches to"] = "Rahmenseite, an der die Manaleiste angebracht werden soll"
	L["Left"] = "Links"
	L["Top"] = "Oben"
	L["Right"] = "Rechts"
	L["Bottom"] = "Unten"

	L["Colours"] = "Leistenfarben"
	L["Colours for the various powers"] = "Farbe der verschiedenen Leisten"
	L["Mana color"] = "Mana"
	L["Color for mana"] = "Farbe für Mana"
	L["Energy color"] = "Energie"
	L["Color for energy"] = "Farbe für Energie"
	L["Rage color"] = "Wut"
	L["Color for rage"] = "Farbe für Wut"
	L["Runic power color"] = "Runenmacht"
	L["Color for runic power"] = "Farbe für Runenmacht"

	L["Ignore Non-Mana"] = "Verstecken bei Nicht-Manaklassen"
	L["Don't track power for non-mana users"] = "Versteckt Leiste für Nicht-Manaklassen"
	L["Ignore Pets"] = "Begleiter ignorieren"
	L["Don't track power for pets"] = "Versteckt die jeweiligen Leisten der Begleiter"
end

