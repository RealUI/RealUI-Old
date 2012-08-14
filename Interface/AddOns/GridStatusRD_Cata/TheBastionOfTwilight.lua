local zone = "The Bastion of Twilight"

--en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

-- Trash
--Magma (falling off)
--GridStatusRaidDebuff:Debuff(zone, 81114, 1, 6, 5) --Magma
GridStatusRaidDebuff:Debuff(zone, 81118, 1, 6, 5, true, true) --Magma
--Tremors
GridStatusRaidDebuff:Debuff(zone, 87931, 1, 6, 5) --Tremors
--Phased Burn
GridStatusRaidDebuff:Debuff(zone, 85799, 1, 6, 5) --Phased Burn
--Crimson Flames
GridStatusRaidDebuff:Debuff(zone, 88232, 1, 6, 5) --Crimson Flames
--Twilight Soulblade
GridStatusRaidDebuff:Debuff(zone, 84850, 1, 6, 5) --Soul Blade
GridStatusRaidDebuff:Debuff(zone, 84853, 1, 6, 5) --Dark Pool
--Crimsonborne Firestarter
GridStatusRaidDebuff:Debuff(zone, 88219, 1, 6, 5) --Burning Twilight
--Twilight Elementalist
GridStatusRaidDebuff:Debuff(zone, 88079, 1, 6, 5) --Frostfire Bolt
--Twilight Shadow Knight
GridStatusRaidDebuff:Debuff(zone, 76622, 1, 4, 4, true, true) --Sunder Armor
GridStatusRaidDebuff:Debuff(zone, 84832, 1, 5, 5) --Dismantle
--Twilight Dark Mender
GridStatusRaidDebuff:Debuff(zone, 84856, 1, 6, 5) --Hungering Shadows
--Twilight Shadow Mender
GridStatusRaidDebuff:Debuff(zone, 85643, 1, 6, 5) --Mind Sear
--Twilight-shifter
GridStatusRaidDebuff:Debuff(zone, 85564, 1, 5, 5, true, true) --Shifted Reality
--Bound Zephyr
GridStatusRaidDebuff:Debuff(zone, 93277, 1, 6, 5, true, true) --Rending Gale
-- More important to show Rending Gale stack imo, but user can adjust priority
-- if they feel differently
GridStatusRaidDebuff:Debuff(zone, 93306, 1, 4, 4) --Vaporize
--Bound Rumbler
GridStatusRaidDebuff:Debuff(zone, 93327, 1, 6, 5, true, true) --Entomb
-- More important to show Entomb stack imo, but user can adjust priority
-- if they feel differently
GridStatusRaidDebuff:Debuff(zone, 93325, 1, 4, 4) --Shockwave
--Faceless Guardian
GridStatusRaidDebuff:Debuff(zone, 85482, 1, 6, 5, true, true) --Shadow Volley
--Shadow Lord
GridStatusRaidDebuff:Debuff(zone, 87629, 1, 6, 5) --Gripping Shadows

--Bound Deluge
--Everyone should get Cold-Touched
--Frost Whirl is magic

--Azureborne Destroyer
-- Statis Strike is magic
--GridStatusRaidDebuff:Debuff(zone, 88178, 1, 6, 5) --Stasis Strike

--Earth Ravager
-- Petrify Skin is magic
-- GridStatusRaidDebuff:Debuff(zone, 87917, 1, 6, 5) --Petrify Skin

--Twist Phase-Twister
-- Twist Phase is magic
-- GridStatusRaidDebuff:Debuff(zone, 84838, 1, 6, 5) --Twist Phase

--Twilight Crossfire
-- Wyvern Sting is a poison and shows up as one

--Shadow Lord
-- Gripping Shadows is magic
--GridStatusRaidDebuff:Debuff(zone, 87629, 1, 6, 5) --Gripping Shadows

--Chosen Seer
-- Flame Shock is Magic

--Halfus Wyrmbreaker
GridStatusRaidDebuff:BossName(zone, 10, "Halfus Wyrmbreaker")
GridStatusRaidDebuff:Debuff(zone, 83710, 11, 5, 5) --Furious Roar
GridStatusRaidDebuff:Debuff(zone, 83908, 12, 5, 5, true, true) --Malevolent Strikes
GridStatusRaidDebuff:Debuff(zone, 83603, 13, 5, 5) --Stone Touch

-- Valiona and Theralion
GridStatusRaidDebuff:BossName(zone, 20, "Valiona and Theralion")
GridStatusRaidDebuff:Debuff(zone, 86788, 21, 5, 5) --Blackout 10-normal
GridStatusRaidDebuff:Debuff(zone, 86622, 22, 5, 5) --Engulfing Magic 10-normal
GridStatusRaidDebuff:Debuff(zone, 86202, 23, 5, 5, true, true) --Twilight Shift 10-normal
GridStatusRaidDebuff:Debuff(zone, 86014, 24, 5, 5) --Twilight Meteorite
GridStatusRaidDebuff:Debuff(zone, 92886, 25, 6, 6, true, true) --Twilight Zone

-- Twilight Ascendant Council
GridStatusRaidDebuff:BossName(zone, 30, "Ascendant Council")
GridStatusRaidDebuff:Debuff(zone, 82762, 31, 5, 5) --Waterlogged
GridStatusRaidDebuff:Debuff(zone, 83099, 32, 7, 7) --Lightning Rod
GridStatusRaidDebuff:Debuff(zone, 82285, 33, 6, 6) --Elemental Stasis
GridStatusRaidDebuff:Debuff(zone, 82660, 34, 6, 6) --Burning Blood
GridStatusRaidDebuff:Debuff(zone, 82665, 35, 6, 6) --Heart of Ice
GridStatusRaidDebuff:Debuff(zone, 82772, 36, 7, 7) --Frozen
GridStatusRaidDebuff:Debuff(zone, 84948, 37, 6, 6) --Gravity Crush
GridStatusRaidDebuff:Debuff(zone, 83500, 38, 4, 4) --Swirling Winds
GridStatusRaidDebuff:Debuff(zone, 83581, 38, 4, 4) --Grounded
GridStatusRaidDebuff:Debuff(zone, 82285, 38, 4, 4) --Elemental Stasis
-- Debuffs we don't care about seeing:
-- GridStatusRaidDebuff:Debuff(zone, 83587, 39, 4, 4) --Magnetic Pull
-- Heroic
GridStatusRaidDebuff:Debuff(zone, 92307, 39, 7, 7) --Frost Beacon
GridStatusRaidDebuff:Debuff(zone, 92467, 39, 7, 7) --Static Overload
GridStatusRaidDebuff:Debuff(zone, 92538, 39, 7, 7) --Gravity Core

-- Cho'gall
GridStatusRaidDebuff:BossName(zone, 40, "Cho'gall")
GridStatusRaidDebuff:Debuff(zone, 81701, 41, 4, 4, true, true) --Corrupted Blood
-- Corruption: Accelerated is lower priority than the stacks so it won't overwrite
GridStatusRaidDebuff:Debuff(zone, 81836, 42, 3, 3) --Corruption: Accelerated
GridStatusRaidDebuff:Debuff(zone, 82125, 43, 3, 3) --Corruption: Malformation
GridStatusRaidDebuff:Debuff(zone, 82170, 44, 5, 5) --Corruption: Absolute
GridStatusRaidDebuff:Debuff(zone, 82523, 45, 6, 6) --Gall's Blast
GridStatusRaidDebuff:Debuff(zone, 82518, 46, 6, 6) --Cho's Blast
GridStatusRaidDebuff:Debuff(zone, 82411, 47, 7, 7) --Debilitating Beam

-- Sinestra
GridStatusRaidDebuff:BossName(zone, 50, "Sinestra")
GridStatusRaidDebuff:Debuff(zone, 89299, 51, 4, 4, true, true) --Twilight Spit
-- Wrack is dispellable
-- GridStatusSinestra handles this better
-- GridStatusRaidDebuff:Debuff(zone, 92955, 51, 4, 4) --Wrack

