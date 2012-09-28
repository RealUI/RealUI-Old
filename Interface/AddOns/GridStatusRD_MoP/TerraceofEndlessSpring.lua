local zone = "Terrace of Endless Spring"

--en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
--true, true is for stackable

--Trash

--Protector Kaolan
GridStatusRaidDebuff:BossName(zone, 10, "Protector Kaolan")
GridStatusRaidDebuff:Debuff(zone, 117519, 11, 6, 6) --Touch of Sha
GridStatusRaidDebuff:Debuff(zone, 111850, 12, 3, 3) --Lightning Prison: Targeted
GridStatusRaidDebuff:Debuff(zone, 117436, 13, 3, 3) --Lightning Prison: Stunned
GridStatusRaidDebuff:Debuff(zone, 118191, 14, 6, 6, true, true) --Corrupted Essence
GridStatusRaidDebuff:Debuff(zone, 117986, 15, 6, 6, true, true) --Defiled Ground: Stacks

--Tsulong
GridStatusRaidDebuff:BossName(zone, 20, "Tsulong")
GridStatusRaidDebuff:Debuff(zone, 122768, 21, 3, 3, true, true) --Dread Shadows
GridStatusRaidDebuff:Debuff(zone, 122777, 22, 5, 5) --Nightmares (dispellable)
GridStatusRaidDebuff:Debuff(zone, 122752, 23, 6, 6, true, true) --Shadow Breath
GridStatusRaidDebuff:Debuff(zone, 122789, 24, 3, 3) --Sunbeam
GridStatusRaidDebuff:Debuff(zone, 123012, 25, 5, 5) --Terrorize: 5% (dispellable)
GridStatusRaidDebuff:Debuff(zone, 123011, 26, 5, 5) --Terrorize: 10% (dispellable)
GridStatusRaidDebuff:Debuff(zone, 123036, 27, 5, 5) --Fright (dispellable)
GridStatusRaidDebuff:Debuff(zone, 122858, 28, 6, 6) --Bathed in Light

--Lei Shi
GridStatusRaidDebuff:BossName(zone, 30, "Lei Shi")
GridStatusRaidDebuff:Debuff(zone, 123121, 31, 4, 4) --Spray
GridStatusRaidDebuff:Debuff(zone, 123705, 32, 3, 3) --Scary Fog

--Sha of Fear
GridStatusRaidDebuff:BossName(zone, 40, "Sha of Fear")
GridStatusRaidDebuff:Debuff(zone, 119414, 41, 6, 6) --Breath of Fear
GridStatusRaidDebuff:Debuff(zone, 129147, 42, 3, 3) --Onimous Cackle
GridStatusRaidDebuff:Debuff(zone, 119983, 43, 4, 4, true, true) --Dread Spray
GridStatusRaidDebuff:Debuff(zone, 120669, 44, 3, 3) --Naked and Afraid
GridStatusRaidDebuff:Debuff(zone, 75683, 45, 6, 6) --Waterspout
GridStatusRaidDebuff:Debuff(zone, 120629, 46, 3, 3) --Huddle in Terror
GridStatusRaidDebuff:Debuff(zone, 120394, 47, 6, 6) --Eternal Darkness
GridStatusRaidDebuff:Debuff(zone, 129189, 48, 6, 6) --Sha Globe
GridStatusRaidDebuff:Debuff(zone, 119086, 49, 4, 4) --Penetrating Bolt
GridStatusRaidDebuff:Debuff(zone, 119775, 50, 6, 6) --Reaching Attack

