local zone = "Mogu'shan Vaults"

--en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
--true, true is for stackable

--Trash
GridStatusRaidDebuff:Debuff(zone, 118562, 1, 6, 6) --Petrified
GridStatusRaidDebuff:Debuff(zone, 116596, 2, 6, 6) --Smoke Bomb

--The Stone Guard
GridStatusRaidDebuff:BossName(zone, 10, "The Stone Guard")
GridStatusRaidDebuff:Debuff(zone, 130395, 11, 6, 6, true, true) --Jasper Chains: Stacks
GridStatusRaidDebuff:Debuff(zone, 130404, 12, 3, 3) --Jasper Chains [NOTE: This is what was causing dmg in the logs]
GridStatusRaidDebuff:Debuff(zone, 130774, 13, 6, 6) --Amethyst Pool
GridStatusRaidDebuff:Debuff(zone, 116038, 14, 6, 6, true, true) --Jasper Petrification: stacks [Note: Do we care? Not sure yet. Didn't get to test heroic]
GridStatusRaidDebuff:Debuff(zone, 115861, 15, 6, 6, true, true) --Cobalt Petrification: stacks [Note: Do we care? Not sure yet. Didn't get to test heroic]
GridStatusRaidDebuff:Debuff(zone, 116060, 16, 6, 6, true, true) --Amethyst Petrification: stacks [Note: Do we care? Not sure yet. Didn't get to test heroic]
GridStatusRaidDebuff:Debuff(zone, 116281, 17, 3, 3) --Cobalt Mine Blast (dispellable)
GridStatusRaidDebuff:Debuff(zone, 125206, 18, 6, 6) --Rend Flesh: Tank only
GridStatusRaidDebuff:Debuff(zone, 116008, 19, 6, 6, true, true) --Jade Petrification: stacks [Note: Do we care? Not sure yet. Didn't get to test heroic]

--Feng The Accursed
GridStatusRaidDebuff:BossName(zone, 20, "Feng The Accursed")
GridStatusRaidDebuff:Debuff(zone, 131788, 21, 6, 6, true, true) --Lightning Lash: Tank Only: Stacks
GridStatusRaidDebuff:Debuff(zone, 116040, 22, 3, 3) --Epicenter
GridStatusRaidDebuff:Debuff(zone, 116942, 23, 6, 6, true, true) --Flaming Spear: Tank Only
GridStatusRaidDebuff:Debuff(zone, 116784, 24, 3, 3) --Wildfire Spark: Super Super Important! Like Holy jesus important!
GridStatusRaidDebuff:Debuff(zone, 131790, 25, 6, 6, true, true) --Arcane Shock: Stack : Tank Only
GridStatusRaidDebuff:Debuff(zone, 102464, 26, 3, 3) --Arcane Shock: AOE [Note: Not sure this is needed. It appeared on wowhead but I have yet to see it in game]
GridStatusRaidDebuff:Debuff(zone, 116417, 27, 3, 3, true, true) --Arcane Resonance: [Note: Do we care it stacks? Yes I think you lose a stack each time you explode but I was too busy healing to notice]
GridStatusRaidDebuff:Debuff(zone, 116364, 28, 6, 6) --Arcane Velocity
GridStatusRaidDebuff:Debuff(zone, 116374, 29, 3, 3) --Lightning Charge: Stun effect
GridStatusRaidDebuff:Debuff(zone, 131792, 30, 6, 6, true, true) --Shadowburn: Tank only: Stacks: HEROIC ONLY

--Gara'jal the Spiritbinder : [NOTE: Combat events from the second realm do not show in combat logs for those not phased]
GridStatusRaidDebuff:BossName(zone, 40, "Gara'jal the Spiritbinder")
GridStatusRaidDebuff:Debuff(zone, 122151, 41, 3, 3) --Voodoo doll: Super Super Important! Like Holy jesus important!
GridStatusRaidDebuff:Debuff(zone, 117723, 42, 3, 3) --Frail Soul: HEROIC ONLY
GridStatusRaidDebuff:Debuff(zone, 116260, 43, 6, 6) --Crossed Over [NOTE: Putting this incase events fire between both realms]

--The Spirit Kings
GridStatusRaidDebuff:BossName(zone, 50, "The Spirit Kings")
GridStatusRaidDebuff:Debuff(zone, 118303, 51, 3, 3) --Undying Shadow: Fixate
GridStatusRaidDebuff:Debuff(zone, 118048, 52, 3, 3) --Pillaged
GridStatusRaidDebuff:Debuff(zone, 118135, 53, 3, 3) --Pinned Down
GridStatusRaidDebuff:Debuff(zone, 118047, 54, 3, 3) --Pillage: Target
GridStatusRaidDebuff:Debuff(zone, 118163, 55, 3, 3) --Robbed Blind

--Elegon
GridStatusRaidDebuff:BossName(zone, 60, "Elegon")
GridStatusRaidDebuff:Debuff(zone, 117878, 61, 6, 6, true, true) --Overcharged
GridStatusRaidDebuff:Debuff(zone, 117949, 62, 3, 3) --Closed circuit (dispellable)
GridStatusRaidDebuff:Debuff(zone, 117945, 63, 3, 3) --Arcing Energy

--Will of the Emperor
GridStatusRaidDebuff:BossName(zone, 70, "Will of the Emperor")
GridStatusRaidDebuff:Debuff(zone, 116525, 71, 3, 3) --Focused Assault
GridStatusRaidDebuff:Debuff(zone, 116778, 72, 3, 3) --Focused Defense
GridStatusRaidDebuff:Debuff(zone, 117485, 73, 6, 6) --Impeding Thrust
GridStatusRaidDebuff:Debuff(zone, 116550, 74, 4, 4) --Energizing Smash
GridStatusRaidDebuff:Debuff(zone, 116829, 75, 3, 3) --Focused Energy

