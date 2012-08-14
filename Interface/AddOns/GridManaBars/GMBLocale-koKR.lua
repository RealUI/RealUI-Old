
do
	if GetLocale() ~= "koKR" then return end
	local L = GridManaBarsLocale

	L["Mana"] = "마나"
	L["Mana Bar"] = "마나 바"
	L["Mana Bar options."] = "마나 바 옵션을 설정합니다."

	L["Size"] = "크기"
	L["Percentage of frame for mana bar"] = "마나 바의 크기를 설정합니다."
	L["Side"] = "위치"
	L["Side of frame manabar attaches to"] = "마나 바의 위치를 설정합니다."
	L["Left"] = "좌측"
	L["Top"] = "상단"
	L["Right"] = "우측"
	L["Bottom"] = "하단"

	L["Colours"] = "색상"
	L["Colours for the various powers"] = "다양한 파워 바의 색상을 설정합니다."
	L["Mana color"] = "마나 색상"
	L["Color for mana"] = "마나의 색상을 설정합니다."
	L["Energy color"] = "기력 색상"
	L["Color for energy"] = "기력의 색상을 설정합니다."
	L["Rage color"] = "분노 색상"
	L["Color for rage"] = "분노의 색상을 설정합니다."
	L["Runic power color"] = "룬 마력 색상"
	L["Color for runic power"] = "룬 마력의 색상을 설정합니다."

	L["Ignore Non-Mana"] = "비-마나 무시"
	L["Don't track power for non-mana users"] = "비-마나 사용자를 위해 파워 바를 표시하지 않습니다."
	L["Ignore Pets"] = "소환수 무시"
	L["Don't track power for pets"] = "소환수의 파워를 표시하지 않습니다."
end

