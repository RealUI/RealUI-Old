local zone = "Kun-Lai Summit"

--en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon

--Sha of Anger
GridStatusRaidDebuff:BossName(zone, 10, "Sha of Anger")
GridStatusRaidDebuff:Debuff(zone, 119626, 11, 3, 3) --Aggressive Behavior [NOTE: this is the MC]
GridStatusRaidDebuff:Debuff(zone, 119488, 12, 3, 3) --Unleashed Wrath [NOTE: Must heal these people. Lots of shadow dmg]
GridStatusRaidDebuff:Debuff(zone, 119610, 13, 3, 3) --Bitter Thoughts (Silence) [NOTE: There are 2 spell IDs in the logs for Bitter Thoughts. which one will Blizzard go with?]
GridStatusRaidDebuff:Debuff(zone, 119601, 14, 3, 3) --Bitter Thoughts (Silence) [NOTE: There are 2 spell IDs in the logs for Bitter Thoughts. which one will Blizzard go with?]
