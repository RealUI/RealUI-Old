--[[
	The contents of this file are auto-generated using the WoWAce localization application
	Please go to http://www.wowace.com/projects/deus-vox-encounters/localization/ to update translations.
	Anyone with a wowace/curseforge account can edit them.
]]

local AL = LibStub("AceLocale-3.0")

local silent = true

local L = AL:GetLocale("DXE")
if not L then
    local L = AL:NewLocale("DXE", "enUS", true, silent)
end

if L then

-- Chat triggers
local chat_dragonsoul = AL:NewLocale("DXE Chat Dragon Soul", "enUS", true, silent)
AL:GetLocale("DXE").chat_dragonsoul = AL:GetLocale("DXE Chat Dragon Soul")
-- NPC names
local npc_dragonsoul = AL:NewLocale("DXE NPC Dragon Soul", "enUS", true, silent)
AL:GetLocale("DXE").npc_dragonsoul = AL:GetLocale("DXE NPC Dragon Soul")
if GetLocale() == "enUS" or GetLocale() == "enGB" then return end
end

local L = AL:NewLocale("DXE", "deDE")
if L then

-- Chat triggers
local chat_dragonsoul = AL:NewLocale("DXE Chat Dragon Soul", "deDE")
-- chat_dragonsoul["^All ahead full"] = ""
chat_dragonsoul["He's about to roll"] = "Er wird gleich nach" -- Needs review
-- chat_dragonsoul["levels out"] = ""
chat_dragonsoul["^You have done NOTHING"] = "^Ihr habt NICHTS erreicht" -- Needs review

AL:GetLocale("DXE").chat_dragonsoul = AL:GetLocale("DXE Chat Dragon Soul")
-- NPC names
local npc_dragonsoul = AL:NewLocale("DXE NPC Dragon Soul", "deDE")
npc_dragonsoul["Dragonriders"] = "Drachenreiter" -- Needs review
npc_dragonsoul["Hagara the Stormbinder"] = "Hagara die Sturmbinderin" -- Needs review
-- npc_dragonsoul["Kohcrom"] = ""
npc_dragonsoul["Madness of Deathwing"] = "Todesschwinges Wahnsinn" -- Needs review
-- npc_dragonsoul["Morchok"] = ""
npc_dragonsoul["Spine of Deathwing"] = "Todesschwinges Rückgrat" -- Needs review
-- npc_dragonsoul["Ultraxion"] = ""
npc_dragonsoul["Warlord Zon'ozz"] = "Kriegsherr Zon'ozz" -- Needs review
npc_dragonsoul["Warmaster Blackhorn"] = "Kriegsmeister Schwarzhorn" -- Needs review
npc_dragonsoul["Yor'sahj the Unsleeping"] = "Yor'sahj der Unermüdliche" -- Needs review

AL:GetLocale("DXE").npc_dragonsoul = AL:GetLocale("DXE NPC Dragon Soul")
return
end

local L = AL:NewLocale("DXE", "esES")
if L then

-- Chat triggers
local chat_dragonsoul = AL:NewLocale("DXE Chat Dragon Soul", "esES")
chat_dragonsoul["^All ahead full"] = "^A toda vela" -- Needs review
chat_dragonsoul["He's about to roll"] = "¡Está a punto de girar" -- Needs review
chat_dragonsoul["levels out"] = "se estabiliza." -- Needs review
chat_dragonsoul["^You have done NOTHING"] = "^No habéis hecho nada" -- Needs review

AL:GetLocale("DXE").chat_dragonsoul = AL:GetLocale("DXE Chat Dragon Soul")
-- NPC names
local npc_dragonsoul = AL:NewLocale("DXE NPC Dragon Soul", "esES")
npc_dragonsoul["Dragonriders"] = "Jinetes de dragones" -- Needs review
npc_dragonsoul["Hagara the Stormbinder"] = "Hagara la Vinculadora"
npc_dragonsoul["Kohcrom"] = "Kohcrom"
npc_dragonsoul["Madness of Deathwing"] = "Locura de Alamuerte"
npc_dragonsoul["Morchok"] = "Morchok"
npc_dragonsoul["Spine of Deathwing"] = "Espinazo de Alamuerte"
npc_dragonsoul["Ultraxion"] = "Ultraxion"
npc_dragonsoul["Warlord Zon'ozz"] = "Señor de la guerra Zon'ozz"
npc_dragonsoul["Warmaster Blackhorn"] = "Maestro de guerra Cuerno Negro"
npc_dragonsoul["Yor'sahj the Unsleeping"] = "Yor'sahj el Velador"

AL:GetLocale("DXE").npc_dragonsoul = AL:GetLocale("DXE NPC Dragon Soul")
return
end

local L = AL:NewLocale("DXE", "esMX")
if L then

-- Chat triggers
local chat_dragonsoul = AL:NewLocale("DXE Chat Dragon Soul", "esMX")
-- chat_dragonsoul["^All ahead full"] = ""
-- chat_dragonsoul["He's about to roll"] = ""
-- chat_dragonsoul["levels out"] = ""
-- chat_dragonsoul["^You have done NOTHING"] = ""

AL:GetLocale("DXE").chat_dragonsoul = AL:GetLocale("DXE Chat Dragon Soul")
-- NPC names
local npc_dragonsoul = AL:NewLocale("DXE NPC Dragon Soul", "esMX")
-- npc_dragonsoul["Dragonriders"] = ""
-- npc_dragonsoul["Hagara the Stormbinder"] = ""
-- npc_dragonsoul["Kohcrom"] = ""
-- npc_dragonsoul["Madness of Deathwing"] = ""
-- npc_dragonsoul["Morchok"] = ""
-- npc_dragonsoul["Spine of Deathwing"] = ""
-- npc_dragonsoul["Ultraxion"] = ""
-- npc_dragonsoul["Warlord Zon'ozz"] = ""
-- npc_dragonsoul["Warmaster Blackhorn"] = ""
-- npc_dragonsoul["Yor'sahj the Unsleeping"] = ""

AL:GetLocale("DXE").npc_dragonsoul = AL:GetLocale("DXE NPC Dragon Soul")
return
end

local L = AL:NewLocale("DXE", "frFR")
if L then

-- Chat triggers
local chat_dragonsoul = AL:NewLocale("DXE Chat Dragon Soul", "frFR")
chat_dragonsoul["^All ahead full"] = "^En avant toute" -- Needs review
chat_dragonsoul["He's about to roll"] = "Il va faire un tonneau" -- Needs review
chat_dragonsoul["levels out"] = "se redresse" -- Needs review
chat_dragonsoul["^You have done NOTHING"] = "^Vous n'avez RIEN fait" -- Needs review

AL:GetLocale("DXE").chat_dragonsoul = AL:GetLocale("DXE Chat Dragon Soul")
-- NPC names
local npc_dragonsoul = AL:NewLocale("DXE NPC Dragon Soul", "frFR")
npc_dragonsoul["Dragonriders"] = "Monteurs de dragons" -- Needs review
npc_dragonsoul["Hagara the Stormbinder"] = "Hagara la Lieuse des tempêtes" -- Needs review
npc_dragonsoul["Kohcrom"] = "Kohcrom" -- Needs review
npc_dragonsoul["Madness of Deathwing"] = "Folie d'Aile de mort"
npc_dragonsoul["Morchok"] = "Morchok" -- Needs review
npc_dragonsoul["Spine of Deathwing"] = "Échine d'Aile de mort" -- Needs review
npc_dragonsoul["Ultraxion"] = "Ultraxion" -- Needs review
npc_dragonsoul["Warlord Zon'ozz"] = "Seigneur de guerre Zon'ozz"
npc_dragonsoul["Warmaster Blackhorn"] = "Maître de guerre Corne-Noire" -- Needs review
npc_dragonsoul["Yor'sahj the Unsleeping"] = "Yor'sahj l'Insomniaque" -- Needs review

AL:GetLocale("DXE").npc_dragonsoul = AL:GetLocale("DXE NPC Dragon Soul")
return
end

local L = AL:NewLocale("DXE", "koKR")
if L then

-- Chat triggers
local chat_dragonsoul = AL:NewLocale("DXE Chat Dragon Soul", "koKR")
-- chat_dragonsoul["^All ahead full"] = ""
-- chat_dragonsoul["He's about to roll"] = ""
chat_dragonsoul["levels out"] = "수평으로 균형을 잡습니다" -- Needs review
chat_dragonsoul["^You have done NOTHING"] = "^넌 아무것도 못 했다." -- Needs review

AL:GetLocale("DXE").chat_dragonsoul = AL:GetLocale("DXE Chat Dragon Soul")
-- NPC names
local npc_dragonsoul = AL:NewLocale("DXE NPC Dragon Soul", "koKR")
-- npc_dragonsoul["Dragonriders"] = ""
npc_dragonsoul["Hagara the Stormbinder"] = "폭풍술사 하가라" -- Needs review
npc_dragonsoul["Kohcrom"] = "크초르모" -- Needs review
npc_dragonsoul["Madness of Deathwing"] = "데스윙의 광기" -- Needs review
npc_dragonsoul["Morchok"] = "모르초크" -- Needs review
npc_dragonsoul["Spine of Deathwing"] = "데스윙의 등" -- Needs review
npc_dragonsoul["Ultraxion"] = "울트락시온" -- Needs review
npc_dragonsoul["Warlord Zon'ozz"] = "장군 존오즈" -- Needs review
npc_dragonsoul["Warmaster Blackhorn"] = "전투대장 블랙혼" -- Needs review
npc_dragonsoul["Yor'sahj the Unsleeping"] = "잠들지 않는 요르사지" -- Needs review

AL:GetLocale("DXE").npc_dragonsoul = AL:GetLocale("DXE NPC Dragon Soul")
return
end

local L = AL:NewLocale("DXE", "ruRU")
if L then

-- Chat triggers
local chat_dragonsoul = AL:NewLocale("DXE Chat Dragon Soul", "ruRU")
-- chat_dragonsoul["^All ahead full"] = ""
chat_dragonsoul["He's about to roll"] = "Он собирается накрениться" -- Needs review
chat_dragonsoul["levels out"] = "Смертокрыл наклоняется" -- Needs review
chat_dragonsoul["^You have done NOTHING"] = "^У вас НИЧЕГО не вышло"

AL:GetLocale("DXE").chat_dragonsoul = AL:GetLocale("DXE Chat Dragon Soul")
-- NPC names
local npc_dragonsoul = AL:NewLocale("DXE NPC Dragon Soul", "ruRU")
-- npc_dragonsoul["Dragonriders"] = ""
npc_dragonsoul["Hagara the Stormbinder"] = "Хагара Владычица Штормов"
npc_dragonsoul["Kohcrom"] = "Корхом"
npc_dragonsoul["Madness of Deathwing"] = "Безумие Смертокрыла"
npc_dragonsoul["Morchok"] = "Морхок"
npc_dragonsoul["Spine of Deathwing"] = "Хребет Смертокрыла"
npc_dragonsoul["Ultraxion"] = "Ультраксион"
npc_dragonsoul["Warlord Zon'ozz"] = "Полководец Зон'озз"
npc_dragonsoul["Warmaster Blackhorn"] = "Воевода Черный Рог"
npc_dragonsoul["Yor'sahj the Unsleeping"] = "Йор'садж Неспящий"

AL:GetLocale("DXE").npc_dragonsoul = AL:GetLocale("DXE NPC Dragon Soul")
return
end

local L = AL:NewLocale("DXE", "zhCN")
if L then

-- Chat triggers
local chat_dragonsoul = AL:NewLocale("DXE Chat Dragon Soul", "zhCN")
chat_dragonsoul["^All ahead full"] = "^全速前进" -- Needs review
chat_dragonsoul["He's about to roll"] = "他开始向" -- Needs review
chat_dragonsoul["levels out"] = "保持平衡" -- Needs review
chat_dragonsoul["^You have done NOTHING"] = "^你们什么都没做到" -- Needs review

AL:GetLocale("DXE").chat_dragonsoul = AL:GetLocale("DXE Chat Dragon Soul")
-- NPC names
local npc_dragonsoul = AL:NewLocale("DXE NPC Dragon Soul", "zhCN")
npc_dragonsoul["Dragonriders"] = "龙骑士" -- Needs review
npc_dragonsoul["Hagara the Stormbinder"] = "缚风者哈格拉"
npc_dragonsoul["Kohcrom"] = "克卓莫"
npc_dragonsoul["Madness of Deathwing"] = "疯狂的死亡之翼"
npc_dragonsoul["Morchok"] = "莫卓克"
npc_dragonsoul["Spine of Deathwing"] = "死亡之翼的背脊"
npc_dragonsoul["Ultraxion"] = "奥卓克希昂"
npc_dragonsoul["Warlord Zon'ozz"] = "督军佐诺兹"
npc_dragonsoul["Warmaster Blackhorn"] = "战争大师黑角"
npc_dragonsoul["Yor'sahj the Unsleeping"] = "不眠的约萨希"

AL:GetLocale("DXE").npc_dragonsoul = AL:GetLocale("DXE NPC Dragon Soul")
return
end

local L = AL:NewLocale("DXE", "zhTW")
if L then

-- Chat triggers
local chat_dragonsoul = AL:NewLocale("DXE Chat Dragon Soul", "zhTW")
-- chat_dragonsoul["^All ahead full"] = ""
-- chat_dragonsoul["He's about to roll"] = ""
-- chat_dragonsoul["levels out"] = ""
-- chat_dragonsoul["^You have done NOTHING"] = ""

AL:GetLocale("DXE").chat_dragonsoul = AL:GetLocale("DXE Chat Dragon Soul")
-- NPC names
local npc_dragonsoul = AL:NewLocale("DXE NPC Dragon Soul", "zhTW")
-- npc_dragonsoul["Dragonriders"] = ""
npc_dragonsoul["Hagara the Stormbinder"] = "『暴風守縛者』哈甲拉"
npc_dragonsoul["Kohcrom"] = "科考姆"
npc_dragonsoul["Madness of Deathwing"] = "死亡之翼的狂亂"
npc_dragonsoul["Morchok"] = "魔寇"
npc_dragonsoul["Spine of Deathwing"] = "死亡之翼的脊椎"
npc_dragonsoul["Ultraxion"] = "奧特拉賽恩"
npc_dragonsoul["Warlord Zon'ozz"] = "督軍松奧茲"
npc_dragonsoul["Warmaster Blackhorn"] = "將領黑角"
npc_dragonsoul["Yor'sahj the Unsleeping"] = "未眠者尤沙伊"

AL:GetLocale("DXE").npc_dragonsoul = AL:GetLocale("DXE NPC Dragon Soul")
return
end

local L = AL:NewLocale("DXE", "ptBR")
if L then

-- Chat triggers
local chat_dragonsoul = AL:NewLocale("DXE Chat Dragon Soul", "ptBR")
-- chat_dragonsoul["^All ahead full"] = ""
-- chat_dragonsoul["He's about to roll"] = ""
-- chat_dragonsoul["levels out"] = ""
-- chat_dragonsoul["^You have done NOTHING"] = ""

AL:GetLocale("DXE").chat_dragonsoul = AL:GetLocale("DXE Chat Dragon Soul")
-- NPC names
local npc_dragonsoul = AL:NewLocale("DXE NPC Dragon Soul", "ptBR")
-- npc_dragonsoul["Dragonriders"] = ""
npc_dragonsoul["Hagara the Stormbinder"] = "Hagara, a Tempestigadora" -- Needs review
npc_dragonsoul["Kohcrom"] = "Kohcrom" -- Needs review
npc_dragonsoul["Madness of Deathwing"] = "Loucura do Asa da Morte" -- Needs review
npc_dragonsoul["Morchok"] = "Morchok" -- Needs review
npc_dragonsoul["Spine of Deathwing"] = "Espinhaço do Asa da Morte" -- Needs review
npc_dragonsoul["Ultraxion"] = "Ultraxion" -- Needs review
npc_dragonsoul["Warlord Zon'ozz"] = "Senhor da Guerra Zon'ozz" -- Needs review
npc_dragonsoul["Warmaster Blackhorn"] = "Mestre Guerreiro Chifre Negro" -- Needs review
npc_dragonsoul["Yor'sahj the Unsleeping"] = "Yor'sahj, o Vígil" -- Needs review

AL:GetLocale("DXE").npc_dragonsoul = AL:GetLocale("DXE NPC Dragon Soul")
return
end
