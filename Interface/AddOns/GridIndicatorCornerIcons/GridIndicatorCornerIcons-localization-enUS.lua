-- -------------------------------------------------------------------------- --
-- GridIndicatorCornerIcons DEFAULT (english) Localization                    --
-- Please make sure to save this file as UTF-8. ¶                             --
-- -------------------------------------------------------------------------- --

GridIndicatorCornerIcons_Locales =

{
	["Icon (Corners)"] = true,
	["Options for Icon (Corners) indicators."] = true,

	["Top Left Corner Icon (Left)"] = true,
	["Top Left Corner Icon (Right)"] = true,
	["Icon Size Top Left Corner"] = true,
	["Adjust the size of the 2 Top Left Corner Icons."] = true,

	["Top Right Corner Icon (Left)"] = true,
	["Top Right Corner Icon (Right)"] = true,
	["Icon Size Top Right Corner"] = true,
	["Adjust the size of the 2 Top Right Corner Icons."] = true,

	["Bottom Left Corner Icon (Left)"] = true,
	["Bottom Left Corner Icon (Right)"] = true,
	["Icon Size Bottom Left Corner"] = true,
	["Adjust the size of the 2 Bottom Left Corner Icons."] = true,

	["Bottom Right Corner Icon (Left)"] = true,
	["Bottom Right Corner Icon (Right)"] = true,
	["Icon Size Bottom Right Corner"] = true,
	["Adjust the size of the 2 Bottom Right Corner Icons."] = true,
	
	["Offset X-axis"] = true,
	["Adjust the offset of the X-axis."] = true,

	["Offset Y-axis"] = true,
	["Adjust the offset of the Y-axis."] = true,

	["Icon Border Size"] = true,
	["Adjust the size of the icon's border."] = true,
	["Enable Icon Stack Text"] = true,
	["Toggle icon's stack count text."] = true,
	["Enable Icon Cooldown Frame"] = true,
	["Toggle icon's cooldown frame."] = true,

	["Icon Stack Text: Font Size"] = true,
	["Adjust the font size for Icon Stack Text."] = true,
	["Icon Stack Text: Offset XY-axis"] = true,
	["Adjust the offset for Icon Stack Text of the XY-axis."] = true,

	["Same settings as Grid"] = true,
	["If enabled, the settings for the Icon (Corners) indicators are adjustable with the standard Grid options. If deactivated, you can set individual settings for the Icon (Corners) indicators."] = true,

	["Configuration Mode"] = true,
	["Shows all Icon (Corners) indicators."] = true,
}

function GridIndicatorCornerIcons_Locales:CreateLocaleTable(t)
	for k,v in pairs(t) do
		self[k] = (v == true and k) or v
	end
end

GridIndicatorCornerIcons_Locales:CreateLocaleTable(GridIndicatorCornerIcons_Locales)