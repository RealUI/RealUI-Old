local zone = "Blackwing Descent"

--en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

-- It looks like Grid works by name, not by spell Id
-- So don't need to add all the different spell ids for the different difficulties

-- Trash
--Drakonid Slayer
GridStatusRaidDebuff:Debuff(zone, 80390, 1, 6, 5) --Mortal Strike
-- Don't care about Blast Wave, it's just a slow
--Maimgor/Ivoroc
GridStatusRaidDebuff:Debuff(zone, 80270, 1, 6, 5) --Shadowflame
GridStatusRaidDebuff:Debuff(zone, 80145, 1, 6, 5) --Piercing Grip
--Spirit of Ironstar (spreads to other spirits when you kill Ironstar)
GridStatusRaidDebuff:Debuff(zone, 80727, 1, 6, 5, true) --Execution Sentence
--Drakeadon Mongrel
GridStatusRaidDebuff:Debuff(zone, 80345, 1, 6, 5) --Corrosive Acid
GridStatusRaidDebuff:Debuff(zone, 80329, 1, 6, 5) --Time Lapse
-- Frost Burn is magic and alredy shows up
--Drakonid Drudge
GridStatusRaidDebuff:Debuff(zone, 79630, 1, 6, 5) --Drakonid Rush
--Drakonid Chainwielder
GridStatusRaidDebuff:Debuff(zone, 79589, 1, 6, 5) --Constricting Chains
GridStatusRaidDebuff:Debuff(zone, 79580, 1, 6, 5) --Overhead Smash
GridStatusRaidDebuff:Debuff(zone, 91910, 1, 7, 6) --Grievous Wound
--Golem Sentry
GridStatusRaidDebuff:Debuff(zone, 81060, 1, 6, 5) --Flash Bomb
--Pyrecraw
GridStatusRaidDebuff:Debuff(zone, 80127, 1, 4, 4, true, true) --Flame Buffet
--Nefarian
GridStatusRaidDebuff:Debuff(zone, 79353, 1, 4, 4, true, true) --Shadow of Cowardice

--Curse of Mending shows up as a Curse (dispellable)
--Stormbolt shows up as Magic (dispellable)
--Burden of the Crown is a buff debuff
GridStatusRaidDebuff:Debuff(zone, 80718, 1, 1, 1, false, false, 0, true) --Burden of the Crown
-- Don't show this either
GridStatusRaidDebuff:Debuff(zone, 89798, 1, 1, 1, false, false, 0, true) --Master Adventurer Award

--Magmaw
GridStatusRaidDebuff:BossName(zone, 10, "Magmaw")
GridStatusRaidDebuff:Debuff(zone, 89773, 11, 5, 5) --Mangle
GridStatusRaidDebuff:Debuff(zone, 78941, 12, 5, 5) --Parasitic Infection
GridStatusRaidDebuff:Debuff(zone, 88287, 13, 5, 5) --Massive Crash
GridStatusRaidDebuff:Debuff(zone, 78199, 14, 4, 4) --Sweltering Armor

--Omnitron Defense System
GridStatusRaidDebuff:BossName(zone, 20, "Omnitron Defense System")
GridStatusRaidDebuff:Debuff(zone, 79888, 21, 5, 5) --Lightning Conductor
GridStatusRaidDebuff:Debuff(zone, 80161, 22, 5, 5) --Chemical Cloud
GridStatusRaidDebuff:Debuff(zone, 80011, 23, 5, 5) --Soaked in Poison
GridStatusRaidDebuff:Debuff(zone, 79505, 24, 5, 5) --Flamethrower
GridStatusRaidDebuff:Debuff(zone, 80094, 25, 5, 5) --Fixate
GridStatusRaidDebuff:Debuff(zone, 79501, 26, 5, 5) --Acquiring Target
-- Heroic
GridStatusRaidDebuff:Debuff(zone, 92053, 27, 5, 5) --Shadow Conductor
GridStatusRaidDebuff:Debuff(zone, 92048, 28, 5, 5) --Shadow Infusion
GridStatusRaidDebuff:Debuff(zone, 92023, 29, 6, 6) --Encasing Shadows
-- Power Generator is good, don't need to watch it
GridStatusRaidDebuff:Debuff(zone, 79629, 29, 1, 1, false, false, 0, true) --Power Generator
-- Overcharged Power Generator is good, don't need to watch it
GridStatusRaidDebuff:Debuff(zone, 91858, 29, 1, 1, false, false, 0, true) --Overcharged Power Generator

--Chimaeron
GridStatusRaidDebuff:BossName(zone, 30, "Chimaeron")
GridStatusRaidDebuff:Debuff(zone, 89084, 31, 8, 8) --Low Health
GridStatusRaidDebuff:Debuff(zone, 82890, 32, 5, 5) --Mortality
GridStatusRaidDebuff:Debuff(zone, 82935, 33, 6, 6) --Caustic Slime
-- Heroic
GridStatusRaidDebuff:Debuff(zone, 82881, 34, 7, 7, true, true) --Break
GridStatusRaidDebuff:Debuff(zone, 91307, 35, 4, 4) --Mocking Shadows
-- Don't care about Finkle's Mixture
GridStatusRaidDebuff:Debuff(zone, 82705, 36, 1, 1, false, false, 0, true) --Finkle's Mixture

--Atramedes
GridStatusRaidDebuff:BossName(zone, 40, "Atramedes")
GridStatusRaidDebuff:Debuff(zone, 78092, 41, 7, 7) --Tracking
GridStatusRaidDebuff:Debuff(zone, 77982, 42, 4, 4, true, true) --Searing Flame
GridStatusRaidDebuff:Debuff(zone, 78023, 43, 6, 6) --Roaring Flame
GridStatusRaidDebuff:Debuff(zone, 78897, 44, 6, 6) --Noisy!
-- Heroic
GridStatusRaidDebuff:Debuff(zone, 92685, 45, 6, 6) --Pestered!

--Maloriak
GridStatusRaidDebuff:BossName(zone, 50, "Maloriak")
GridStatusRaidDebuff:Debuff(zone, 78034, 51, 5, 5, true, true) --Rend 10-normal
GridStatusRaidDebuff:Debuff(zone, 78225, 52, 6, 6) --Acid Nova 10-normal
GridStatusRaidDebuff:Debuff(zone, 77615, 53, 5, 5) --Debilitating Slime 10-normal/25-normal
GridStatusRaidDebuff:Debuff(zone, 77786, 54, 6, 6) --Consuming Flames 10-normal
GridStatusRaidDebuff:Debuff(zone, 78617, 55, 6, 6) --Fixate
GridStatusRaidDebuff:Debuff(zone, 77760, 56, 6, 6) --Biting Chill
GridStatusRaidDebuff:Debuff(zone, 77699, 57, 6, 6) --Flash Freeze 10-normal
-- Heroic
GridStatusRaidDebuff:Debuff(zone, 92987, 58, 5, 5) --Dark Sludge 
GridStatusRaidDebuff:Debuff(zone, 92982, 59, 7, 7) --Engulfing Darkness

--Nefarian
GridStatusRaidDebuff:BossName(zone, 80, "Nefarian")
GridStatusRaidDebuff:Debuff(zone, 81118, 81, 5, 5, true, true) --Magma 10-normal
GridStatusRaidDebuff:Debuff(zone, 77827, 82, 5, 5) --Tail Lash 10-normal
-- Heroic
GridStatusRaidDebuff:Debuff(zone, 79339, 83, 6, 6) --Explosive Cinders
GridStatusRaidDebuff:Debuff(zone, 79318, 84, 6, 6) --Dominion

