-- -------------------------------------------------------------------------- --
-- GridIndicatorCornerPlus DEFAULT (english) Localization                     --
-- Please make sure to save this file as UTF-8. ¶                             --
-- -------------------------------------------------------------------------- --

GridIndicatorCornerPlus_Locales =

{
	["Corner Plus"] = true,
	["Options for Corner Plus."] = true,
	["Corner Plus Space"] = true,
	["Adjust the space between the Corner Plus indicators."] = true,
	["Same size as Grid standard"] = true,
	["If enabled, the size of the Corner Plus indicator is adjustable with the standard Grid corner option. If deactivated, you can set an individual size for the Corner Plus indicators."] = true,
	["Corner Plus Size"] = true,
	["Adjust the size of the Corner Plus indicators."] = true,

	["Top Left Corner Plus"] = true,
	["Options for Top Left Corner Plus indicators."] = true,
	["Top Left Corner (top right)"] = true,
	["Top Left Corner (bottom left)"] = true,
	["Top Left Corner (bottom right)"] = true,

	["Top Right Corner Plus"] = true,
	["Options for Top Right Corner Plus indicators."] = true,
	["Top Right Corner (top left)"] = true,
	["Top Right Corner (bottom left)"] = true,
	["Top Right Corner (bottom right)"] = true,

	["Bottom Left Corner Plus"] = true,
	["Options for Bottom Left Corner Plus indicators."] = true,
	["Bottom Left Corner (top left)"] = true,
	["Bottom Left Corner (top right)"] = true,
	["Bottom Left Corner (bottom right)"] = true,

	["Bottom Right Corner Plus"] = true,
	["Options for Bottom Right Corner Plus indicators."] = true,
	["Bottom Right Corner (top left)"] = true,
	["Bottom Right Corner (top right)"] = true,
	["Bottom Right Corner (bottom left)"] = true,

	["Configuration Mode"] = true,
	["Shows all Corner Plus indicators."] = true,
}

function GridIndicatorCornerPlus_Locales:CreateLocaleTable(t)
	for k,v in pairs(t) do
		self[k] = (v == true and k) or v
	end
end

GridIndicatorCornerPlus_Locales:CreateLocaleTable(GridIndicatorCornerPlus_Locales)