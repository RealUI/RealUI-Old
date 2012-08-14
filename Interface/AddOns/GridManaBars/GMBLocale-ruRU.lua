
do
	if GetLocale() ~= "ruRU" then return end
	local L = GridManaBarsLocale

	L["Mana"] = "Мана"
	L["Mana Bar"] = "Полоса маны"
	L["Mana Bar options."] = "Настройки полосы маны."

	L["Size"] = "Размер"
	L["Percentage of frame for mana bar"] = "Размер полосы маны в процентах."
	L["Side"] = "Сторона"
	L["Side of frame manabar attaches to"] = "Сторона фрейма к которой прикрепить полосы маны."
	L["Left"] = "Слева"
	L["Top"] = "Сверху"
	L["Right"] = "Справа"
	L["Bottom"] = "Снизу"

	L["Colours"] = "Окраска"
	L["Colours for the various powers"] = "Окраска различной энергии."
	L["Mana color"] = "Цвет маны"
	L["Color for mana"] = "Окраска маны."
	L["Energy color"] = "Цвет энергии"
	L["Color for energy"] = "Окраска энергии."
	L["Rage color"] = "Цвет ярости"
	L["Color for rage"] = "Окраска ярости."
	L["Runic power color"] = "Цвет энергии рун"
	L["Color for runic power"] = "Оераска рунической энергии"

	L["Ignore Non-Mana"] = "Игнор без-маны"
	L["Don't track power for non-mana users"] = "Не отслеживать энергию играков, которых класс не использует ману."
	L["Ignore Pets"] = "Игнор питомцев"
	L["Don't track power for pets"] = "Не отслеживать энергию питомцев."
end

