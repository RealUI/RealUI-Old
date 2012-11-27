local zone = "Heart of Fear"

--en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--Trash

-- Imperial Vizier Zor'lok trash
-- Sra'thik Shield Master
GridStatusRaidDebuff:Debuff(zone, 123417, 1, 1, 1, true, true) --Dismantled Armor (armor)

-- Blade Lord Ta'yak trash
-- Instructor Kli'thak
GridStatusRaidDebuff:Debuff(zone, 123180, 2, 1, 1) --Wind Step (dot)
-- Sra'thik Shield Master
GridStatusRaidDebuff:Debuff(zone, 123420, 2, 2, 2) --Stunning Strike (stun)

-- Amber-Shaper trash
-- Amber-Ridden Mushan
GridStatusRaidDebuff:Debuff(zone, 125081, 5, 1, 1) --Slam (stun)
-- Amber Searsting
GridStatusRaidDebuff:Debuff(zone, 125490, 5, 1, 1) --Burning Sting (dot)
-- Kor'thik Fleshrender
GridStatusRaidDebuff:Debuff(zone, 126901, 5, 2, 2, true, true) --Mortal Rend (tank, stackable healing debuff)
GridStatusRaidDebuff:Debuff(zone, 126912, 5, 6, 6) --Grievous Whirl (dot removed when target healed to 90%)

-- Grand Empress Trash
-- Kor'thik Warsinger
GridStatusRaidDebuff:Debuff(zone, 125907, 6, 1, 1) --Cry Havoc

--Imperial Vizier Zor'lok
GridStatusRaidDebuff:BossName(zone, 10, "Imperial Vizier Zor'lok")
--GridStatusRaidDebuff:Debuff(zone, 122760, 11, 3, 3) --Exhale
GridStatusRaidDebuff:Debuff(zone, 123812, 12, 1, 1) --Pheromones of Zeal
GridStatusRaidDebuff:Debuff(zone, 122740, 13, 6, 6) --Convert (MC)
GridStatusRaidDebuff:Debuff(zone, 122706, 14, 3, 3) --Noise Cancelling (AMZ)

--Blade Lord Ta'yak
GridStatusRaidDebuff:BossName(zone, 20, "Blade Lord Ta'yak")
GridStatusRaidDebuff:Debuff(zone, 123474, 21, 1, 1, true, true) --Overwhelming Assault (tank stacks)
GridStatusRaidDebuff:Debuff(zone, 122949, 22, 6, 6) --Unseen Strike (group up on target)
GridStatusRaidDebuff:Debuff(zone, 124783, 23, 5, 5) --Storm Unleashed
--GridStatusRaidDebuff:Debuff(zone, 123600, 24, 5, 5) --Storm Unleashed?

--Garalon
GridStatusRaidDebuff:BossName(zone, 30, "Garalon")
GridStatusRaidDebuff:Debuff(zone, 122835, 31, 5, 5) --Pheromones (fixate/dot/passable)
GridStatusRaidDebuff:Debuff(zone, 123081, 32, 6, 6, true, true) --Pungency (Pheromones stacks)
GridStatusRaidDebuff:Debuff(zone, 122774, 33, 2, 2) --Crush (knocked down)
GridStatusRaidDebuff:Debuff(zone, 123423, 34, 1, 1) --Weak Points (damage increase)
--GridStatusRaidDebuff:Debuff(zone, 123120, 33, 4, 4) --Pheromone Trail

--Wind Lord Mel'jarak
GridStatusRaidDebuff:BossName(zone, 40, "Wind Lord Mel'jarak")
GridStatusRaidDebuff:Debuff(zone, 121881, 41, 6, 6) --Amber Prison
GridStatusRaidDebuff:Debuff(zone, 122055, 42, 1, 1) --Residue
GridStatusRaidDebuff:Debuff(zone, 122064, 43, 3, 3, true, true) --Corrosive Resin

--Amber-Shaper Un'sok
GridStatusRaidDebuff:BossName(zone, 50, "Amber-Shaper Un'sok")
GridStatusRaidDebuff:Debuff(zone, 121949, 51, 6, 6) --Parasitic Growth
GridStatusRaidDebuff:Debuff(zone, 122784, 52, 3, 3) --Reshape Life
--GridStatusRaidDebuff:Debuff(zone, 122504, 54, 5, 5) --Burning Amber (not a debuff)

--Grand Empress Shek'zeer
GridStatusRaidDebuff:BossName(zone, 60, "Grand Empress Shek'zeer")
GridStatusRaidDebuff:Debuff(zone, 123707, 61, 5, 5, true, true) --Eyes of the Empress (tank stacks)
GridStatusRaidDebuff:Debuff(zone, 125390, 62, 3, 3) --Fixate
GridStatusRaidDebuff:Debuff(zone, 123788, 63, 5, 5) --Cry of Terror (debuff that causes AoE)
GridStatusRaidDebuff:Debuff(zone, 124097, 64, 4, 4) --Sticky Resin
GridStatusRaidDebuff:Debuff(zone, 123184, 65, 7, 7) --Dissonance Field (unhealable)
--GridStatusRaidDebuff:Debuff(zone, 125824, 65, 3, 3) --Trapped!
GridStatusRaidDebuff:Debuff(zone, 124777, 66, 4, 4) --Poison Bomb
GridStatusRaidDebuff:Debuff(zone, 124821, 67, 3, 3) --Poison-Drenched Armor
GridStatusRaidDebuff:Debuff(zone, 124827, 68, 1, 1) --Poison Fumes
GridStatusRaidDebuff:Debuff(zone, 124849, 69, 6, 6) --Consuming Terror (fear, dispellable)
GridStatusRaidDebuff:Debuff(zone, 124863, 70, 6, 6) --Visions of Demise (fear/AoE, dispellable)
GridStatusRaidDebuff:Debuff(zone, 124862, 71, 5, 5) --Visions of Demise: Target
GridStatusRaidDebuff:Debuff(zone, 123845, 72, 5, 5) --Heart of Fear: Chosen
GridStatusRaidDebuff:Debuff(zone, 123846, 73, 5, 5) --Heart of Fear: Lure
GridStatusRaidDebuff:Debuff(zone, 125283, 74, 1, 1) --Sha Corruption

