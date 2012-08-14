local zone = "Dragon Soul"

--en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--Trash

--Stormbinder Adept
GridStatusRaidDebuff:Debuff(zone, 109442, 1, 4, 4) --Tornado
--Lieutenant Shara
GridStatusRaidDebuff:Debuff(zone, 109331, 1, 4, 4, true, true) --Shatter
GridStatusRaidDebuff:Debuff(zone, 109333, 1, 5, 5) --Frost Corruption (magic)
--Ancient Water Lord
GridStatusRaidDebuff:Debuff(zone, 107801, 1, 4, 4) --Drenched
GridStatusRaidDebuff:Debuff(zone, 107797, 1, 4, 4) --Flood
GridStatusRaidDebuff:Debuff(zone, 107770, 1, 1, 1, false, false, 0, true) --Pure Water
--Earthen Destroyer
GridStatusRaidDebuff:Debuff(zone, 107677, 1, 4, 4, true, true) --Dust Storm
GridStatusRaidDebuff:Debuff(zone, 107629, 1, 5, 5) --Boulder Smash (magic)
--Stormborn Myrmidon
GridStatusRaidDebuff:Debuff(zone, 109368, 1, 4, 4, true, true) --Spark
--Twilight Frost Evoker
GridStatusRaidDebuff:Debuff(zone, 109423, 1, 5, 5) --Shackles of Ice (magic)
--Twilight Siege Captain
GridStatusRaidDebuff:Debuff(zone, 108183, 1, 5, 5) --Twilight Submission (magic)

--Morchok
GridStatusRaidDebuff:BossName(zone, 10, "Morchok")
GridStatusRaidDebuff:Debuff(zone, 103687, 11, 4, 4, true, true) --Crush Armor
GridStatusRaidDebuff:Debuff(zone, 103821, 12, 3, 3) --Earthen Vortex
GridStatusRaidDebuff:Debuff(zone, 103785, 13, 6, 6) --Black Blood of the Earth
GridStatusRaidDebuff:Debuff(zone, 103534, 14, 5, 5) --Danger (Red)
GridStatusRaidDebuff:Debuff(zone, 103536, 15, 5, 5) --Warning (Yellow)
-- Don't need to show Safe people
GridStatusRaidDebuff:Debuff(zone, 103541, 16, 5, 5, false, false, 0, true) --Safe (Blue)
-- Heroic
GridStatusRaidDebuff:Debuff(zone, 109033, 17, 3, 3) --Stomp

--Warlord Zon'ozz
GridStatusRaidDebuff:BossName(zone, 20, "Warlord Zon'ozz")
GridStatusRaidDebuff:Debuff(zone, 104378, 21, 3, 3) --Black Blood of Go'rath
GridStatusRaidDebuff:Debuff(zone, 103434, 22, 5, 5) --Disrupting Shadows (dispellable)
GridStatusRaidDebuff:Debuff(zone, 108799, 23, 2, 2) --Black Blood Erruption

--Yor'sahj the Unsleeping
GridStatusRaidDebuff:BossName(zone, 30, "Yor'sahj the Unsleeping")
GridStatusRaidDebuff:Debuff(zone, 104849, 31, 3, 3, true, true) --Void Bolt
GridStatusRaidDebuff:Debuff(zone, 105171, 32, 4, 4, true, true) --Deep Corruption

--Hagara the Stormbinder
GridStatusRaidDebuff:BossName(zone, 40, "Hagara the Stormbinder")
GridStatusRaidDebuff:Debuff(zone, 105316, 41, 6, 6, true, true) --Ice Lance
GridStatusRaidDebuff:Debuff(zone, 105465, 42, 6, 6) --Lightning Storm
GridStatusRaidDebuff:Debuff(zone, 105369, 43, 5, 5) --Lightning Conduit
GridStatusRaidDebuff:Debuff(zone, 105289, 44, 7, 7) --Shattered Ice (dispellable)
GridStatusRaidDebuff:Debuff(zone, 105285, 45, 4, 4) --Target (next Ice Lance)
GridStatusRaidDebuff:Debuff(zone, 104451, 46, 5, 5) --Ice Tomb
GridStatusRaidDebuff:Debuff(zone, 110317, 47, 3, 3) --Watery Entrenchment
GridStatusRaidDebuff:Debuff(zone, 105314, 48, 3, 3) --Ice Wave
-- Heroic
GridStatusRaidDebuff:Debuff(zone, 109325, 49, 7, 7) --Frostflake (dispellable)

--Ultraxion
GridStatusRaidDebuff:BossName(zone, 50, "Ultraxion")
GridStatusRaidDebuff:Debuff(zone, 105925, 51, 6, 6) --Fading Light
GridStatusRaidDebuff:Debuff(zone, 106108, 52, 5, 5) --Heroic Will
GridStatusRaidDebuff:Debuff(zone, 105984, 53, 2, 2) --Timeloop
GridStatusRaidDebuff:Debuff(zone, 105927, 54, 4, 4) --Faded Into Twilight
GridStatusRaidDebuff:Debuff(zone, 106415, 55, 4, 4, true, true) --Twilight Burst
-- Heroic
GridStatusRaidDebuff:Debuff(zone, 106498, 56, 3, 3) --Looming Darkness

--Warmaster Blackhorn
GridStatusRaidDebuff:BossName(zone, 60, "Warmaster Blackhorn")
GridStatusRaidDebuff:Debuff(zone, 108043, 61, 4, 4, true, true) --Sunder Armor
GridStatusRaidDebuff:Debuff(zone, 107558, 62, 3, 3, true, true) --Degeneration
GridStatusRaidDebuff:Debuff(zone, 107567, 64, 3, 3, true, true) --Brutal Strike
GridStatusRaidDebuff:Debuff(zone, 108046, 65, 5, 5) --Shockwave
-- Heroic
GridStatusRaidDebuff:Debuff(zone, 109204, 66, 5, 5) -- Twilight Barrage
GridStatusRaidDebuff:Debuff(zone, 110214, 67, 6, 6) -- Consuming Shroud

--Spine of Deathwing
GridStatusRaidDebuff:BossName(zone, 70, "Spine of Deathwing")
GridStatusRaidDebuff:Debuff(zone, 105563, 71, 3, 3) --Grasping Tendrils
GridStatusRaidDebuff:Debuff(zone, 105479, 72, 6, 6) --Searing Plasma
GridStatusRaidDebuff:Debuff(zone, 105490, 73, 4, 4) --Fiery Grip
-- Heroic
GridStatusRaidDebuff:Debuff(zone, 106005, 74, 1, 1, false, false, 0, true) --Degradation (disabled)
GridStatusRaidDebuff:Debuff(zone, 106200, 75, 5, 5) --Blood Corruption: Earth
GridStatusRaidDebuff:Debuff(zone, 106199, 76, 7, 7) --Blood Corruption: Death

--Madness of Deathwing
GridStatusRaidDebuff:BossName(zone, 80, "Madness of Deathwing")
GridStatusRaidDebuff:Debuff(zone, 105445, 81, 3, 3, true, true) --Blistering Heat
GridStatusRaidDebuff:Debuff(zone, 105841, 82, 4, 4, true, true) --Degenerative Bite
GridStatusRaidDebuff:Debuff(zone, 106385, 83, 5, 5, true, true) --Crush
GridStatusRaidDebuff:Debuff(zone, 106730, 84, 5, 5, true, true) --Tetanus
GridStatusRaidDebuff:Debuff(zone, 106444, 85, 5, 5, true, true) --Impale
GridStatusRaidDebuff:Debuff(zone, 106794, 86, 6, 6) --Shrapnel (target)
-- Heroic
GridStatusRaidDebuff:Debuff(zone, 108649, 87, 6, 6) --Corrupting Parasite

