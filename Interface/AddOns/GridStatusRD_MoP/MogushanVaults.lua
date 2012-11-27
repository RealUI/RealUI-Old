local zone = "Mogu'shan Vaults"

--en_zone, debuffID, order, icon_priority, color_priority, timer, stackable, color, default_disable, noicon
--true, true is for stackable

--Trash

-- Dais of Conquerors
-- Stone Guard trash
-- Enormous Stone Quilen
GridStatusRaidDebuff:Debuff(zone, 125092, 1, 6, 6, true, true) --Petrification
-- Stone Quilen
GridStatusRaidDebuff:Debuff(zone, 116970, 1, 1, 1, true, true) --Sundering Bite

-- The Repository
-- Feng trash 
-- Cursed Mogu Sculpture
GridStatusRaidDebuff:Debuff(zone, 121087, 2, 1, 1) --Ground Slam
GridStatusRaidDebuff:Debuff(zone, 121245, 2, 1, 1) --Curse of Vitality (Curse)
GridStatusRaidDebuff:Debuff(zone, 121247, 2, 1, 1) --Impale

-- Gara'jal trash
-- Zandalari Infiltrator
GridStatusRaidDebuff:Debuff(zone, 116596, 3, 1, 1) --Smoke Bomb
-- Zandalari Fire-Dancer
GridStatusRaidDebuff:Debuff(zone, 120670, 3, 1, 1) --Pyroblast
-- Zandalari Skullcharger
GridStatusRaidDebuff:Debuff(zone, 116606, 3, 3, 3) --Troll Rush

-- Forge of the Endless
-- Elegon trash
-- Mogu'shan Secret-Keeper
GridStatusRaidDebuff:Debuff(zone, 118552, 4, 6, 6, true, true) --Flesh to Stone (dispellable)
GridStatusRaidDebuff:Debuff(zone, 118562, 4, 6, 6) --Petrified

--The Stone Guard
GridStatusRaidDebuff:BossName(zone, 10, "The Stone Guard")
GridStatusRaidDebuff:Debuff(zone, 130395, 11, 6, 6, true, true) --Jasper Chains: Stacks
GridStatusRaidDebuff:Debuff(zone, 130774, 13, 5, 5) --Amethyst Pool
GridStatusRaidDebuff:Debuff(zone, 116281, 14, 4, 4) --Cobalt Mine Blast (dispellable)
GridStatusRaidDebuff:Debuff(zone, 125206, 15, 3, 3) --Rend Flesh: Tank only
GridStatusRaidDebuff:Debuff(zone, 116038, 16, 1, 1, true, true) --Jasper Petrification: stacks [Note: Do we care? Not sure yet. Didn't get to test heroic]
GridStatusRaidDebuff:Debuff(zone, 115861, 17, 1, 1, true, true) --Cobalt Petrification: stacks [Note: Do we care? Not sure yet. Didn't get to test heroic]
GridStatusRaidDebuff:Debuff(zone, 116060, 18, 1, 1, true, true) --Amethyst Petrification: stacks [Note: Do we care? Not sure yet. Didn't get to test heroic]
GridStatusRaidDebuff:Debuff(zone, 116008, 19, 1, 1, true, true) --Jade Petrification: stacks [Note: Do we care? Not sure yet. Didn't get to test heroic]

--Feng The Accursed
GridStatusRaidDebuff:BossName(zone, 20, "Feng The Accursed")
GridStatusRaidDebuff:Debuff(zone, 131788, 21, 4, 4, true, true) --Lightning Lash: Tank Only: Stacks (Spirit of the Fist)
GridStatusRaidDebuff:Debuff(zone, 116942, 22, 4, 4, true, true) --Flaming Spear: Tank Only
GridStatusRaidDebuff:Debuff(zone, 131790, 23, 4, 4, true, true) --Arcane Shock: Stack : Tank Only
GridStatusRaidDebuff:Debuff(zone, 131792, 24, 4, 4, true, true) --Shadowburn: Tank only: Stacks: HEROIC ONLY
GridStatusRaidDebuff:Debuff(zone, 116784, 25, 6, 6) --Wildfire Spark: Super Super Important! Like Holy jesus important!
GridStatusRaidDebuff:Debuff(zone, 116417, 26, 6, 6, true, true) --Arcane Resonance: [Note: Do we care it stacks? Yes I think you lose a stack each time you explode but I was too busy healing to notice]
GridStatusRaidDebuff:Debuff(zone, 116374, 27, 5, 5) --Lightning Charge: Stun effect
GridStatusRaidDebuff:Debuff(zone, 116364, 28, 1, 1) --Arcane Velocity
GridStatusRaidDebuff:Debuff(zone, 116040, 29, 1, 1) --Epicenter
GridStatusRaidDebuff:Debuff(zone, 102464, 30, 3, 3) --Arcane Shock: AOE [Note: Not sure this is needed. It appeared on wowhead but I have yet to see it in game]

--Gara'jal the Spiritbinder : [NOTE: Combat events from the second realm do not show in combat logs for those not phased]
GridStatusRaidDebuff:BossName(zone, 40, "Gara'jal the Spiritbinder")
GridStatusRaidDebuff:Debuff(zone, 122151, 41, 6, 6) --Voodoo doll: Super Super Important! Like Holy jesus important!
GridStatusRaidDebuff:Debuff(zone, 117723, 42, 3, 3) --Frail Soul: HEROIC ONLY
GridStatusRaidDebuff:Debuff(zone, 116260, 43, 5, 5) --Crossed Over [NOTE: Putting this incase events fire between both realms]
-- Severer of Souls (Heroic) (adds that kill the tank if not killed)
GridStatusRaidDebuff:Debuff(zone, 116278, 44, 6, 6, true, true) -- Soul Sever

--The Spirit Kings
GridStatusRaidDebuff:BossName(zone, 50, "The Spirit Kings")
-- Meng the Demented
GridStatusRaidDebuff:Debuff(zone, 117708, 51, 6, 6) --Maddening Shout (unhealable)
-- Subetai the Swift
GridStatusRaidDebuff:Debuff(zone, 118048, 52, 3, 3) --Pillaged
GridStatusRaidDebuff:Debuff(zone, 118047, 53, 3, 3) --Pillage: Target
GridStatusRaidDebuff:Debuff(zone, 118135, 54, 3, 3) --Pinned Down
GridStatusRaidDebuff:Debuff(zone, 118163, 55, 1, 1) --Robbed Blind
-- Zian of the Endless Shadow
GridStatusRaidDebuff:Debuff(zone, 118303, 56, 5, 5) --Undying Shadow: Fixate

--Elegon
GridStatusRaidDebuff:BossName(zone, 60, "Elegon")
GridStatusRaidDebuff:Debuff(zone, 117878, 61, 1, 1, true, true) --Overcharged (debuff from standing in circle)
GridStatusRaidDebuff:Debuff(zone, 117949, 62, 6, 6) --Closed circuit (dispellable debuff)
GridStatusRaidDebuff:Debuff(zone, 117945, 63, 3, 3) --Arcing Energy
-- Celestial Protector (Heroic)
GridStatusRaidDebuff:Debuff(zone, 132222, 64, 8, 8) --Destabilizing Energies

--Will of the Emperor
GridStatusRaidDebuff:BossName(zone, 70, "Will of the Emperor")
-- Jan-xi and Qin-xi
GridStatusRaidDebuff:Debuff(zone, 116835, 71, 4, 4, true, true) -- Devastating Arc
GridStatusRaidDebuff:Debuff(zone, 132425, 72, 4, 4) -- Stomp
-- Rage
GridStatusRaidDebuff:Debuff(zone, 116525, 73, 6, 6) --Focused Assault (Rage fixate)
-- Courage
GridStatusRaidDebuff:Debuff(zone, 116778, 74, 6, 6) --Focused Defense (fixate)
GridStatusRaidDebuff:Debuff(zone, 117485, 75, 1, 1) --Impeding Thrust (slow debuff)
-- Strength
GridStatusRaidDebuff:Debuff(zone, 116550, 76, 4, 4) --Energizing Smash (knock down)
-- Titan Spark (Heroic)
GridStatusRaidDebuff:Debuff(zone, 116829, 77, 3, 3) --Focused Energy (fixate)

