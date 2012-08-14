ArkInventory.Const.CompanionData = {
--[[
	[spellid] = { 		
		speed = {
			ground = numeric
			flying = numeric
			water = numeric
		},
		usable = {
			ground = true | false
			flying = true | false
			water = true | false
		},
	}
]]--
 }

ArkInventory.Const.ItemSpellCrossReference = {
--[[
	["item:xxxx"] = { "spell:yyyy" = true }
	["spell:yyyy"] = { "item:xxxx" = true }
]]--
}

ArkInventory.Const.CompanionTranslationData = { -- temporary table for item to spell translations.
-- see ArkInventoryCompanion.xls (sourced from wowhead and user feedback)

-- [itemid] = { }
-- if itemid not a number then it's not learnt from an item, eg achievement reward, trainer, etc
-- id = spell id for companion (must exist, item only "companions" are not used)
-- r = { restrictions }
-- only zone and item based restrictions can be checked
-- sg (ground) | sf (flying) | sw (water) = speed %, 0 = max known

[79744] = { id = 112994 }, -- Eye of the Legion

[79771] = { id = 113120, sf = true }, -- Feldrake

[73762] = { id = 103076 }, -- Darkmoon Balloon
[75040] = { id = 103076 }, -- Flimsy Darkmoon Balloon / Darkmoon Balloon
[74981] = { id = 105122 }, -- Darkmoon Cub
[73764] = { id = 101733 }, -- Darkmoon Monkey
[73903] = { id = 103544 }, -- Darkmoon Tonk
[73765] = { id = 103074 }, -- Darkmoon Turtle
[73905] = { id = 103549 }, -- Darkmoon Zeppelin
[74611] = { id = 104049 }, -- Festival Lantern
[76062] = { id = 105633 }, -- Fetish Shaman's Spear / Fetish Shaman
[72134] = { id = 102317 }, -- Grell Moss / Gregarious Grell
[73797] = { id = 103125 }, -- Lump of Coal / Lumpy
[74610] = { id = 104047 }, -- Lunar Lantern
[71624] = { id = 101493 }, -- Purple Puffer
[72153] = { id = 102353 }, -- Sand Scarab
[73953] = { id = 103588 }, -- Sea Pony
[78916] = { id = 110029 }, -- Soul of the Aspects

[77067] = { id = 107842, sf = true }, -- Reins of the Blazing Drake / Blazing Drake
[72582] = { id = 102514, sf = true }, -- Corrupted Hippogryph
[73766] = { id = 103081, sg = true }, -- Darkmoon Dancing Bear
[78919] = { id = 110039, sf = true }, -- Experiment 12-B
[78924] = { id = 110051, sf = true }, -- Heart of the Aspects
[77069] = { id = 107845, sf = true }, -- Life-Binder's Handmaiden
[73838] = { id = 103195, sg = true }, -- Mountain Horse
[71954] = { id = 101821, sf = true }, -- Ruthless Gladiator's Twilight Drake
[76889] = { id = 107516, sf = true }, -- Spectral Gryphon
[76902] = { id = 107517, sf = true }, -- Spectral Wind Rider
[72140] = { id = 102346, sg = true }, -- Swift Forest Strider
[72146] = { id = 102350, sg = true }, -- Swift Lovebird
[73839] = { id = 103196, sg = true }, -- Swift Mountain Horse
[71718] = { id = 101573, sg = true }, -- Swift Shorestrider
[72145] = { id = 102349, sg = true }, -- Swift Springstrider
[77068] = { id = 107844, sf = true }, -- Reins of the Twilight Harbinger / Twilight Harbinger
[76755] = { id = 107203, sf = true }, -- Tyrael's Charger
[72575] = { id = 102488, sg = true }, -- White Riding Camel

[71387] = { id = 101424 }, -- Brilliant Kaliri
[71076] = { id = 100684 }, -- The Creepy Crate
[70160] = { id = 99668 }, -- Crimson Lasher
[70908] = { id = 100330 }, -- Feline Familiar
[70140] = { id = 99663 }, -- Hyjal Bear Cub
[71033] = { id = 100576 }, -- Lil' Tarecgosa
[71726] = { id = 101606 }, -- Murkablo
[71140] = { id = 100970 }, -- Nuts' Acorn / Nuts
[72042] = { id = 101986 }, -- Alliance Balloon
[72045] = { id = 101989 }, -- Horde Balloon

[69230] = { id = 97560, sf = true }, -- Corrupted Egg of Millagazor / Corrupted Fire Hawk
[71665] = { id = 101542, sf = true }, -- Flametalon of Alysrazor
[71339] = { id = 101282, sf = true }, -- Vicious Gladiator's Twilight Drake
[70909] = { id = 100332, sg = true }, -- Vicious War Steed
[70910] = { id = 100333, sg = true }, -- Vicious War Wolf

[70099] = { id = 99578 }, -- Cenarion Hatchling
[69847] = { id = 98736 }, -- Guardian Cub
[72068] = { id = 98736 }, -- Guardian Cub
[68840] = { id = 96817 }, -- Landro's Lichling
['XS-93461'] = { id = 93461 }, -- Landro's Lil' XT
[69251] = { id = 97779 }, -- Lashtail Hatchling
[69648] = { id = 98079 }, -- Legs
[68841] = { id = 96819 }, -- Nightsaber Cub
[68833] = { id = 96571 }, -- Panther Cub
[69821] = { id = 98571 }, -- Pterrordax Hatchling
[69824] = { id = 98587 }, -- Voodoo Figurine
[69239] = { id = 97638 }, -- Winterspring Cub

[69747] = { id = 98204, sg = true }, -- Amani Battle Bear
[68825] = { id = 96503, sf = true }, -- Amani Dragonhawk
[68823] = { id = 96491, sg = true }, -- Armored Razzashi Raptor
[69213] = { id = 97359, sf = true }, -- Flameward Hippogryph
[69226] = { id = 97501, sf = true }, -- Green Fire Hawk Mount / Green Fire Hawk
[69224] = { id = 97493, sf = true }, -- Smoldering Egg of Millagazor / Pureblood Fire Hawk
[69228] = { id = 97581, sg = true }, -- Savage Raptor
[67151] = { id = 98718, sw = true }, -- Reins of Poseidus / Subdued Seahorse
[68824] = { id = 96499, sg = true }, -- Swift Zulian Panther
[69846] = { id = 98727, sf = true }, -- Winged Guardian

[66075] = { id = 93815 }, -- Bubbles
-- item 67600 Lil' Alexstrasza / Removed from game
[67601] = { id = 95787 }, -- Lil' Ragnaros
[68385] = { id = 95787 }, -- Lil' Ragnaros
[66073] = { id = 93817 }, -- Little Snail
[66070] = { id = 93818 }, -- Lizzy
[68384] = { id = 95786 }, -- Moonkin Egg
[68384] = { id = 95909 }, -- Moonkin Egg
[68618] = { id = 95786 }, -- Moonkin Hatchling
[68619] = { id = 95909 }, -- Moonkin Hatchling
[66080] = { id = 93813 }, -- Tiny Flamefly

['XS-93623'] = { id = 93623, sf = true }, -- Mottled Drake
[63125] = { id = 88990, sf = true }, -- Reins of the Dark Phoenix / Dark Phoenix
[62901] = { id = 88335, sf = true }, -- Reins of the Drake of the East Wind / Drake of the East Wind
[63040] = { id = 88742, sf = true }, -- Reins of the Drake of the North Wind / Drake of the North Wind
[63041] = { id = 88744, sf = true }, -- Reins of the Drake of the South Wind / Drake of the South Wind
[65356] = { id = 88741, sf = true }, -- Reins of the Drake of the West Wind / Drake of the West Wind
[63039] = { id = 88741, sf = true }, -- Reins of the Drake of the West Wind / Drake of the West Wind
[63042] = { id = 88718, sf = true }, -- Reins of the Phosphorescent Stone Drake / Phosphorescent Stone Drake
[63043] = { id = 88746, sf = true }, -- Reins of the Vitreous Stone Drake / Vitreous Stone Drake
[62900] = { id = 88331, sf = true }, -- Reins of the Volcanic Stone Drake / Volcanic Stone Drake
[65891] = { id = 93326, sf = true }, -- Vial of the Sands / Sandstone Drake

[54465] = { id = 75207, sw = 450, r = { zone = "VASHJIR,KELPTHAR_FOREST,SHIMMERING_EXPANSE,ABYSSAL_DEPTHS" } }, -- Abyssal Seahorse / Abyssal Seahorse
['XS-73629'] = { id = 73629, sg = true }, -- Exarch's Elekk / Draenai Paladin
[60954] = { id = 84751, sg = true }, -- Fossilized Raptor
['XS-89520'] = { id = 89520, sg = true }, -- Goblin Mini Hotrod
[62461] = { id = 87090, sg = true }, -- Goblin Trike Key / Goblin Trike
[62462] = { id = 87091, sg = true }, -- Goblin Turbo-Trike Key / Goblin Turbo-Trike
['XS-73630'] = { id = 73630, sg = true }, -- Great Exarch's Elekk / Draenai Paladin
['XS-69826'] = { id = 69826, sg = true }, -- Great Sunwalker Kodo / Tauren Paladin
[63044] = { id = 88748, sg = true }, -- Reins of the Brown Riding Camel / Brown Riding Camel
[62298] = { id = 90621, sg = true }, -- Reins of the Golden King / Golden King
[63046] = { id = 88750, sg = true }, -- Reins of the Grey Riding Camel / Grey Riding Camel
[67107] = { id = 93644, sg = true }, -- Reins of the Kron'Kar Annihilator / Kor'kron Annihilator
[64998] = { id = 92231, sg = true }, -- Reins of the Spectral Steed / Spectral Steed
[64999] = { id = 92232, sg = true }, -- Reins of the Spectral Wolf / Spectral Wolf
[63045] = { id = 88749, sg = true }, -- Reins of the Tan Riding Camel / Tan Riding Camel
[64883] = { id = 92155, sg = true }, -- Scepter of Azj'Aqir / Ultramarine Qiraji Battle Tank
['XS-69820'] = { id = 69820, sg = true }, -- Sunwalker Kodo / Tauren Paladin

[63398] = { id = 89670 }, -- Armadillo Pup
[65661] = { id = 78683 }, -- Blue Mini Jouster
[66067] = { id = 93823 }, -- Brazie's Sunflower Seeds / Brazie's Sunflower
-- item 64373 Chalice of the Mountain Kings
[64372] = { id = 90523 }, -- Clockwork Gnome
[60847] = { id = 84263 }, -- Crawling Claw
[63138] = { id = 89039 }, -- Dark Phoenix Hatchling
[60216] = { id = 82173 }, -- De-Weaponized Mechanical Companion
[67282] = { id = 93838 }, -- Elementium Geode
['XS-93836'] = { id = 93836 }, -- Enchanted Lantern
[60955] = { id = 84752 }, -- Fossilized Hatchling
[64403] = { id = 90637 }, -- Fox Kit
[65662] = { id = 78685 }, -- Gold Mini Jouster
[65363] = { id = 92397 }, -- Guild Herald
[65364] = { id = 92398 }, -- Guild Herald
[65361] = { id = 92395 }, -- Guild Page
[65362] = { id = 92396 }, -- Guild Page
[62769] = { id = 87863 }, -- Hardboiled Egg / Eat the Egg
[67128] = { id = 93624 }, -- Landro's Lil' XT
[62540] = { id = 87344 }, -- Lil' Deathwing
['XS-93837'] = { id = 93837 }, -- Magic Lamp
[66076] = { id = 93739 }, -- Mr. Grubbs
[60869] = { id = 84492 }, -- Pebble
[59597] = { id = 81937 }, -- Personal World Destroyer
['XS-89929'] = { id = 89929 }, -- Rumbling Rockling
[63355] = { id = 89472 }, -- Rustberg Gull / Rustberg Seagull
[64996] = { id = 89472 }, -- Rustberg Gull / Rustberg Seagull
[67418] = { id = 94070 }, -- Smoldering Murloc Egg / Deathy
['XS-89930'] = { id = 89930 }, -- Swirling Stormling
['XS-91343'] = { id = 91343 }, -- Tiny Shale Spider
['XS-89931'] = { id = 89931 }, -- Whirling Waveling
[46325] = { id = 65046 }, -- Withers

[54068] = { id = 74918, sg = 100 }, -- Wooly White Rhino

[56806] = { id = 78381 }, -- Mini Thor

[54069] = { id = 74856, sg = 100, sf = 280 }, -- Blazing Hippogryph
[54797] = { id = 75596, sg = true, sf = 280 }, -- Frosty Flying Carpet
[54860] = { id = 75973, sg = true, sf = true }, -- X-53 Touring Rocket
[51955] = { id = 72807, sf = 310 }, -- Reins of the Icebound Frostbrood Vanquisher / Icebound Frostbrood Vanquisher
[47840] = { id = 67336, sf = 310 }, -- Relentless Gladiator's Frost Wyrm

[54811] = { id = 75614, sg = true, sf = true }, -- Celestial Steed
[52200] = { id = 73313, sg = 100 }, -- Reins of the Crimson Deathcharger / Crimson Deathcharger

[53641] = { id = 74932 }, -- Ice Chip / Frigid Frostling
[54436] = { id = 75134 }, -- Blue Clockwork Rocket Bot
[54847] = { id = 75906 }, -- Lil' XT
['XS-75613'] = { id = 75613 }, -- Celestial Dragon
['XS-75936'] = { id = 75936 }, -- Murkimus the Gladiator

[51954] = { id = 72808, sf = 310 }, -- Reins of the Bloodbathed Frostbrood Vanquisher / Bloodbathed Frostbrood Vanquisher

[50250] = { id = 71342, sg = true, sf = true }, -- Big Love Rocket

[49662] = { id = 69535 }, -- Gryphon Hatchling
[50446] = { id = 71840 }, -- Toxic Wasteling
[49663] = { id = 69536 }, -- Wind Rider Cub

[50818] = { id = 72286, sg = 100, sf = 310 }, -- Invincible's Reins / Invincible

[37298] = { id = 48408 }, -- Competitor's Souvenir / Essence of Competition
[49646] = { id = 69452 }, -- Core Hound Pup
[34518] = { id = 45174 }, -- Golden Pig Coin / Golden Pig
[49912] = { id = 70613 }, -- Perky Pug
[34519] = { id = 45175 }, -- Silver Pig Coin / Silver Pig
[46398] = { id = 65358 }, -- Calico Cat
[22781] = { id = 28505 }, -- Polar Bear Collar / Poley

[49636] = { id = 69395, sf = 310 }, -- Reins of the Onyxian Drake / Onyxian Drake

[49046] = { id = 68056, sg = 100 }, -- Swift Horde Wolf
-- item 49288 Little Ivory Raptor Whistle
-- item 49289 Little White Stallion Bridle

[49287] = { id = 68767 }, -- Tuskarr Kite
[49693] = { id = 69677 }, -- Lil' Phylactery / Lil' K.T.
[49665] = { id = 69541 }, -- Pandaren Monk
[49343] = { id = 68810 }, -- Spectral Tiger Cub
[44810] = { id = 61773 }, -- Turkey Cage / Plump Turkey
[41133] = { id = 55068 }, -- Unhatched Mr. Chilly / Mr. Chilly
-- item 46831 Macabre Marionette
[49362] = { id = 69002 }, -- Onyxian Whelpling

[46708] = { id = 64927, sf = 310 }, -- Deadly Gladiator's Frost Wyrm
[44177] = { id = 60024, sf = 310 }, -- Reins of the Violet Proto-Drake / Violet Proto-Drake
[46813] = { id = 66087, sf = 280 }, -- Silver Covenant Hippogryph
[46814] = { id = 66088, sf = 280 }, -- Sunreaver Dragonhawk
[49286] = { id = 46199, sf = 280 }, -- X-51 Nether-Rocket X-TREME
[49285] = { id = 46197, sf = 150 }, -- X-51 Nether-Rocket

[47179] = { id = 66906, sg = 100 }, -- Argent Charger / Paladin
[47180] = { id = 67466, sg = 100 }, -- Argent Warhorse
[49282] = { id = 51412, sg = 100 }, -- Big Battle Bear
[49098] = { id = 68188, sg = 100 }, -- Crusader's Black Warhorse
[49096] = { id = 68187, sg = 100 }, -- Crusader's White Warhorse
[49290] = { id = 65917, sg = 100 }, -- Magic Rooster Egg / Magic Rooster
[47101] = { id = 66846, sg = 100 }, -- Ochre Skeletal Warhorse
[46815] = { id = 66090, sg = 100 }, -- Quel'dorei Steed
[49284] = { id = 42777, sg = 100 }, -- Reins of the Swift Spectral Tiger / Swift Spectral Tiger
[46816] = { id = 66091, sg = 100 }, -- Sunreaver Hawkstrider
[49044] = { id = 68057, sg = 100 }, -- Swift Alliance Steed
[46102] = { id = 64659, sg = 100 }, -- Whistle of the Venomhide Ravasaur / Venomhide Ravasaur
[49283] = { id = 42776, sg = 60 }, -- Reins of the Spectral Tiger / Spectral Tiger
[47100] = { id = 66847, sg = 60 }, -- Reins of the Striped Dawnsaber / Striped Dawnsaber

[46545] = { id = 65381 }, -- Curious Oracle Hatchling
[46544] = { id = 65382 }, -- Curious Wolvar Pup
[46802] = { id = 66030 }, -- Heavy Murloc Egg / Grunty
[46707] = { id = 44369 }, -- Pint-Sized Pink Pachyderm
[46820] = { id = 66096 }, -- Shimmering Wyrmling
[46821] = { id = 66096 }, -- Shimmering Wyrmling
[48112] = { id = 67413 }, -- Darting Hatchling
[48114] = { id = 67414 }, -- Deviate Hatchling
[48116] = { id = 67415 }, -- Gundrak Hatchling
[48118] = { id = 67416 }, -- Leaping Hatchling
[48120] = { id = 67417 }, -- Obsidian Hatchling
-- item 46397 Oracle Orphan Whistle
[48122] = { id = 67418 }, -- Ravasaur Hatchling
[48124] = { id = 67419 }, -- Razormaw Hatchling
[48126] = { id = 67420 }, -- Razzashi Hatchling
-- item 46396 Wolvar Orphan Whistle

[45801] = { id = 63956, sf = 310 }, -- Reins of the Ironbound Proto-Drake / Ironbound Proto-Drake

[46767] = { id = 65682 }, -- Warbot Ignition Key / Warbot

[45802] = { id = 63963, sf = 310 }, -- Reins of the Rusted Proto-Drake / Rusted Proto-Drake

[46750] = { id = 65641, sg = 100 }, -- Great Golden Kodo
[46745] = { id = 65637, sg = 100 }, -- Great Red Elekk
[46749] = { id = 65646, sg = 100 }, -- Swift Burgundy Wolf
[46752] = { id = 65640, sg = 100 }, -- Swift Gray Steed
[46744] = { id = 65638, sg = 100 }, -- Swift Moonsaber
[46743] = { id = 65644, sg = 100 }, -- Swift Purple Raptor
[46751] = { id = 65639, sg = 100 }, -- Swift Red Hawkstrider
[46748] = { id = 65643, sg = 100 }, -- Swift Violet Ram
[46747] = { id = 65642, sg = 100 }, -- Turbostrider
[46746] = { id = 65645, sg = 100 }, -- White Skeletal Warhorse

[45180] = { id = 63318 }, -- Murkimus' Little Spear / Murkimus the Gladiator

[46171] = { id = 65439, sf = 310 }, -- Furious Gladiator's Frost Wyrm

[45725] = { id = 63844, sf = 280 }, -- Argent Hippogryph
[44843] = { id = 61996, sf = 280 }, -- Blue Dragonhawk Mount / Blue Dragonhawk
[45693] = { id = 63796, sf = 310 }, -- Mimiron's Head
[44842] = { id = 61997, sf = 280 }, -- Red Dragonhawk Mount / Red Dragonhawk

[46101] = { id = 64656, sg = 100 }, -- Blue Skeletal Warhorse
[45593] = { id = 63635, sg = 100 }, -- Darkspear Raptor
[45591] = { id = 63637, sg = 100 }, -- Darnassian Nightsaber
[45590] = { id = 63639, sg = 100 }, -- Exodar Elekk
[45597] = { id = 63643, sg = 100 }, -- Forsaken Warhorse
[45589] = { id = 63638, sg = 100 }, -- Gnomeregan Mechanostrider
[45586] = { id = 63636, sg = 100 }, -- Ironforge Ram
[45595] = { id = 63640, sg = 100 }, -- Orgrimmar Wolf
[45596] = { id = 63642, sg = 100 }, -- Silvermoon Hawkstrider
[45125] = { id = 63232, sg = 100 }, -- Stormwind Steed
[45592] = { id = 63641, sg = 100 }, -- Thunder Bluff Kodo
[46308] = { id = 64977, sg = 60 }, -- Black Skeletal Horse
[46099] = { id = 64658, sg = 60 }, -- Horn of the Black Wolf / Black Wolf
[46109] = { id = 64731, sg = 0, sw = 0 }, -- Sea Turtle
[46100] = { id = 64657, sg = 60 }, -- White Kodo

[44984] = { id = 62562 }, -- Ammen Vale Lashling
[45022] = { id = 62746 }, -- Argent Gruntling
[44998] = { id = 62609 }, -- Argent Squire
[44970] = { id = 62508 }, -- Dun Morogh Cub
[44973] = { id = 62513 }, -- Durotar Scorpion
[44974] = { id = 62516 }, -- Elwynn Lamb
[44982] = { id = 62564 }, -- Enchanted Broom
[45002] = { id = 62674 }, -- Mechanopeep
[44980] = { id = 62542 }, -- Mulgore Hatchling
[45606] = { id = 63712 }, -- Sen'jin Fetish
[44794] = { id = 61725 }, -- Spring Rabbit's Foot / Spring Rabbit
[44983] = { id = 62561 }, -- Strand Crawler
[44965] = { id = 62491 }, -- Teldrassil Sproutling
[44971] = { id = 62510 }, -- Tirisfal Batling
-- item 45057 Wind-Up Train Wrecker
[44822] = { id = 10713 }, -- Albino Snake
-- item 44820 Red Ribbon Pet Leash
[45942] = { id = 64351 }, -- XS-001 Constructor Bot

[44164] = { id = 59976, sf = 310 }, -- Reins of the Black Proto-Drake / Black Proto-Drake

[44083] = { id = 61467, sg = 100 }, -- Reins of the Grand Black War Mammoth / Grand Black War Mammoth

[44175] = { id = 60021, sf = 310 }, -- Reins of the Plagued Proto-Drake / Plagued Proto-Drake

[44841] = { id = 61991 }, -- Little Fawn's Salt Lick / Little Fawn

[44707] = { id = 61294, sf = 280 }, -- Reins of the Green Proto-Drake / Green Proto-Drake
[44160] = { id = 59961, sf = 280 }, -- Reins of the Red Proto-Drake / Red Proto-Drake
[43959] = { id = 61465, sg = 100 }, -- Reins of the Grand Black War Mammoth / Grand Black War Mammoth

[39286] = { id = 52615 }, -- Frosty's Collar / Frosty
[44738] = { id = 61472 }, -- Kirin Tor Familiar
[44819] = { id = 61855 }, -- Baby Blizzard Bear
[39898] = { id = 61351 }, -- Cobra Hatchling

[44690] = { id = 61230, sf = 280 }, -- Armored Blue Wind Rider
[44689] = { id = 61229, sf = 280 }, -- Armored Snowy Gryphon
[44558] = { id = 61309, sg = true, sf = 280 }, -- Magnificent Flying Carpet
[44178] = { id = 60025, sf = 280 }, -- Reins of the Albino Drake / Albino Drake
[43952] = { id = 59567, sf = 280 }, -- Reins of the Azure Drake / Azure Drake
[43986] = { id = 59650, sf = 280 }, -- Reins of the Black Drake / Black Drake
[43953] = { id = 59568, sf = 280 }, -- Reins of the Blue Drake / Blue Drake
[44151] = { id = 59996, sf = 280 }, -- Reins of the Blue Proto-Drake / Blue Proto-Drake
[43951] = { id = 59569, sf = 280 }, -- Reins of the Bronze Drake / Bronze Drake
[43955] = { id = 59570, sf = 280 }, -- Reins of the Red Drake / Red Drake
[44168] = { id = 60002, sf = 280 }, -- Reins of the Time-Lost Proto-Drake / Time-Lost Proto-Drake
[43954] = { id = 59571, sf = 280 }, -- Reins of the Twilight Drake / Twilight Drake
[44554] = { id = 61451, sg = true, sf = 150 }, -- Flying Carpet

[44413] = { id = 60424, sg = 100 }, -- Mekgineer's Chopper
[44225] = { id = 60114, sg = 100 }, -- Reins of the Armored Brown Bear / Armored Brown Bear
[44226] = { id = 60116, sg = 100 }, -- Reins of the Armored Brown Bear / Armored Brown Bear
[44223] = { id = 60118, sg = 100 }, -- Reins of the Black War Bear / Black War Bear
[44224] = { id = 60119, sg = 100 }, -- Reins of the Black War Bear / Black War Bear
[43956] = { id = 59785, sg = 100 }, -- Reins of the Black War Mammoth / Black War Mammoth
[44077] = { id = 59788, sg = 100 }, -- Reins of the Black War Mammoth / Black War Mammoth
[43961] = { id = 61470, sg = 100 }, -- Reins of the Grand Ice Mammoth / Grand Ice Mammoth
[44086] = { id = 61469, sg = 100 }, -- Reins of the Grand Ice Mammoth / Grand Ice Mammoth
[43958] = { id = 59799, sg = 100 }, -- Reins of the Ice Mammoth / Ice Mammoth
[44080] = { id = 59797, sg = 100 }, -- Reins of the Ice Mammoth / Ice Mammoth
[44235] = { id = 61425, sg = 100 }, -- Reins of the Traveler's Tundra Mammoth / Traveler's Tundra Mammoth
[44234] = { id = 61447, sg = 100 }, -- Reins of the Traveler's Tundra Mammoth / Traveler's Tundra Mammoth
[43962] = { id = 54753, sg = 100 }, -- Reins of the White Polar Bear / White Polar Bear
[44230] = { id = 59791, sg = 100 }, -- Reins of the Wooly Mammoth / Wooly Mammoth
[44231] = { id = 59793, sg = 100 }, -- Reins of the Wooly Mammoth / Wooly Mammoth
-- item 44221 Loaned Gryphon Reins / Loaned Gryphon
-- item 44229 Loaned Wind Rider Reins / Loaned Wind Rider

[39973] = { id = 53316 }, -- Ghostly Skull
[43698] = { id = 59250 }, -- Giant Sewer Rat
[44723] = { id = 61357 }, -- Nurtured Penguin Egg / Pengu
[38658] = { id = 51851 }, -- Vampiric Batling
[44721] = { id = 61350 }, -- Proto-Drake Whelp
[39896] = { id = 61348 }, -- Tickbird Hatchling
[39899] = { id = 61349 }, -- White Tickbird Hatchling

[40775] = { id = 54729, sf = true }, -- Winged Steed of the Ebon Blade / Death Knight
[41508] = { id = 55531, sg = 100 }, -- Mechano-hog

[40653] = { id = 40990 }, -- Reeking Pet Carrier / Stinker
[21168] = { id = 25849 }, -- Baby Shark
-- item 37460 Rope Pet Leash

[43516] = { id = 58615, sf = 310 }, -- Brutal Nether Drake

[37828] = { id = 49379, sg = 100 }, -- Great Brewfest Kodo
[37719] = { id = 49322, sg = 100 }, -- Swift Zhevra
[37012] = { id = 48025, sg = true, sf = true }, -- The Horseman's Reins / Headless Horseman's Mount
[43599] = { id = 58983, sg = true }, -- Big Blizzard Bear
-- item 37011 Magic Broom

[37297] = { id = 48406 }, -- Gold Medallion / Spirit of Competition

[37676] = { id = 49193, sf = 310 }, -- Vengeful Nether Drake

[32498] = { id = 40406 }, -- Fortune Coin
[38628] = { id = 51716 }, -- Nether Ray Fry
[34955] = { id = 45890 }, -- Scorched Stone / Scorchling
[38050] = { id = 49964 }, -- Soul-Trader Beacon / Ethereal Soul-Trader
[39656] = { id = 53082 }, -- Tyrael's Hilt / Mini Tyrael

[35906] = { id = 48027, sg = 100 }, -- Reins of the Black War Elekk / Black War Elekk
[35513] = { id = 46628, sg = 100 }, -- Swift White Hawkstrider

-- item 35227 Goblin Weather Machine - Prototype 01-B
[35350] = { id = 46426 }, -- Chuck's Bucket / Chuck
[33818] = { id = 43698 }, -- Muckbreath's Bucket / Muckbreath
[35504] = { id = 46599 }, -- Phoenix Hatchling
[35349] = { id = 46425 }, -- Snarly's Bucket / Snarly
[33816] = { id = 43697 }, -- Toothy's Bucket / Toothy

[25596] = { id = 32345, sf = 310 }, -- Peep's Whistle / Peep the Phoenix Mount
[33999] = { id = 43927, sf = 280 }, -- Cenarion War Hippogryph
[34092] = { id = 44744, sf = 310 }, -- Merciless Nether Drake
[34061] = { id = 44151, sf = 280 }, -- Turbo-Charged Flying Machine Control / Turbo-Charged Flying Machine
[34060] = { id = 44153, sf = 150 }, -- Flying Machine Control / Flying Machine

[33809] = { id = 43688, sg = 100 }, -- Amani War Bear
[34129] = { id = 35028, sg = 100 }, -- Swift Warstrider

[34493] = { id = 45127 }, -- Dragon Kite
[34425] = { id = 54187 }, -- Clockwork Rocket Bot
[33993] = { id = 43918 }, -- Mojo
[34492] = { id = 45125 }, -- Rocket Chicken
[34478] = { id = 45082 }, -- Tiny Sporebat
[34535] = { id = 10696 }, -- Azure Whelpling

-- item 33182 Swift Flying Broom
-- item 33176 Flying Broom

-- item 33184 Swift Magic Broom
-- item 33183 Old Magic Broom
-- item 33189 Rickety Magic Broom

[33154] = { id = 42609 }, -- Sinister Squashling
[32233] = { id = 39709 }, -- Wolpertinger's Tankard / Wolpertinger

[33977] = { id = 43900, sg = 100 }, -- Swift Brewfest Ram
[33976] = { id = 43899, sg = 60 }, -- Brewfest Ram

[30609] = { id = 37015, sf = 310 }, -- Swift Nether Drake

[32458] = { id = 40192, sf = 310 }, -- Ashes of Al'ar

[32319] = { id = 39803, sf = 280 }, -- Blue Riding Nether Ray
[32314] = { id = 39798, sf = 280 }, -- Green Riding Nether Ray
[32316] = { id = 39801, sf = 280 }, -- Purple Riding Nether Ray
[32317] = { id = 39800, sf = 280 }, -- Red Riding Nether Ray
[32858] = { id = 41514, sf = 280 }, -- Reins of the Azure Netherwing Drake / Azure Netherwing Drake
[32859] = { id = 41515, sf = 280 }, -- Reins of the Cobalt Netherwing Drake / Cobalt Netherwing Drake
[32857] = { id = 41513, sf = 280 }, -- Reins of the Onyx Netherwing Drake / Onyx Netherwing Drake
[32860] = { id = 41516, sf = 280 }, -- Reins of the Purple Netherwing Drake / Purple Netherwing Drake
[32861] = { id = 41517, sf = 280 }, -- Reins of the Veridian Netherwing Drake / Veridian Netherwing Drake
[32862] = { id = 41518, sf = 280 }, -- Reins of the Violet Netherwing Drake / Violet Netherwing Drake
[32318] = { id = 39802, sf = 280 }, -- Silver Riding Nether Ray
[25473] = { id = 32242, sf = 280 }, -- Swift Blue Gryphon
[25528] = { id = 32290, sf = 280 }, -- Swift Green Gryphon
[25529] = { id = 32292, sf = 280 }, -- Swift Purple Gryphon
[25527] = { id = 32289, sf = 280 }, -- Swift Red Gryphon

[32768] = { id = 41252, sg = 100 }, -- Reins of the Raven Lord / Raven Lord

[32616] = { id = 40614 }, -- Egbert's Egg / Egbert
[32622] = { id = 40634 }, -- Elekk Training Collar / Peanut
[30360] = { id = 24988 }, -- Lurky's Egg / Lurky
[25535] = { id = 32298 }, -- Netherwhelp's Collar / Netherwhelp
[22114] = { id = 27241 }, -- Pink Murloc Egg / Gurky
[32617] = { id = 40613 }, -- Sleepy Willy
[29960] = { id = 36034 }, -- Captured Firefly / Firefly

[23712] = { id = 30152 }, -- White Tiger Cub

[25531] = { id = 32295, sf = 280 }, -- Swift Green Wind Rider
[25533] = { id = 32297, sf = 280 }, -- Swift Purple Wind Rider
[25477] = { id = 32246, sf = 280 }, -- Swift Red Wind Rider
[25532] = { id = 32296, sf = 280 }, -- Swift Yellow Wind Rider
[25475] = { id = 32244, sf = 150 }, -- Blue Wind Rider
[25471] = { id = 32239, sf = 150 }, -- Ebon Gryphon
[25470] = { id = 32235, sf = 150 }, -- Golden Gryphon
[25476] = { id = 32245, sf = 150 }, -- Green Wind Rider
[25472] = { id = 32240, sf = 150 }, -- Snowy Gryphon
[25474] = { id = 32243, sf = 150 }, -- Tawny Wind Rider

[29465] = { id = 22719, sg = 100 }, -- Black Battlestrider
[29466] = { id = 22718, sg = 100 }, -- Black War Kodo
[29467] = { id = 22720, sg = 100 }, -- Black War Ram
[29468] = { id = 22717, sg = 100 }, -- Black War Steed Bridle / Black War Steed
[30480] = { id = 36702, sg = 100 }, -- Fiery Warhorse's Reins / Fiery Warhorse
[29745] = { id = 35713, sg = 100 }, -- Great Blue Elekk
[29746] = { id = 35712, sg = 100 }, -- Great Green Elekk
[29747] = { id = 35714, sg = 100 }, -- Great Purple Elekk
[29469] = { id = 22724, sg = 100 }, -- Horn of the Black War Wolf / Black War Wolf
[29470] = { id = 22722, sg = 100 }, -- Red Skeletal Warhorse
[29471] = { id = 22723, sg = 100 }, -- Reins of the Black War Tiger / Black War Tiger
[31830] = { id = 39315, sg = 100 }, -- Reins of the Cobalt Riding Talbuk / Cobalt Riding Talbuk
[31829] = { id = 39315, sg = 100 }, -- Reins of the Cobalt Riding Talbuk / Cobalt Riding Talbuk
[29227] = { id = 34896, sg = 100 }, -- Reins of the Cobalt War Talbuk / Cobalt War Talbuk
[29102] = { id = 34896, sg = 100 }, -- Reins of the Cobalt War Talbuk / Cobalt War Talbuk
[28915] = { id = 39316, sg = 100 }, -- Reins of the Dark Riding Talbuk / Dark Riding Talbuk
[29228] = { id = 34790, sg = 100 }, -- Reins of the Dark War Talbuk / Dark War Talbuk
[31832] = { id = 39317, sg = 100 }, -- Reins of the Silver Riding Talbuk / Silver Riding Talbuk
[31831] = { id = 39317, sg = 100 }, -- Reins of the Silver Riding Talbuk / Silver Riding Talbuk
[29229] = { id = 34898, sg = 100 }, -- Reins of the Silver War Talbuk / Silver War Talbuk
[29104] = { id = 34898, sg = 100 }, -- Reins of the Silver War Talbuk / Silver War Talbuk
[31834] = { id = 39318, sg = 100 }, -- Reins of the Tan Riding Talbuk / Tan Riding Talbuk
[31833] = { id = 39318, sg = 100 }, -- Reins of the Tan Riding Talbuk / Tan Riding Talbuk
[29230] = { id = 34899, sg = 100 }, -- Reins of the Tan War Talbuk / Tan War Talbuk
[29105] = { id = 34899, sg = 100 }, -- Reins of the Tan War Talbuk / Tan War Talbuk
[31836] = { id = 39319, sg = 100 }, -- Reins of the White Riding Talbuk / White Riding Talbuk
[31835] = { id = 39319, sg = 100 }, -- Reins of the White Riding Talbuk / White Riding Talbuk
[29231] = { id = 34897, sg = 100 }, -- Reins of the White War Talbuk / White War Talbuk
[29103] = { id = 34897, sg = 100 }, -- Reins of the White War Talbuk / White War Talbuk
[29223] = { id = 35025, sg = 100 }, -- Swift Green Hawkstrider
[28936] = { id = 33660, sg = 100 }, -- Swift Pink Hawkstrider
[29224] = { id = 35027, sg = 100 }, -- Swift Purple Hawkstrider
[29472] = { id = 22721, sg = 100 }, -- Whistle of the Black War Raptor / Black War Raptor
[29221] = { id = 35022, sg = 60 }, -- Black Hawkstrider
[29220] = { id = 35020, sg = 60 }, -- Blue Hawkstrider
[28481] = { id = 34406, sg = 60 }, -- Brown Elekk
[29744] = { id = 35710, sg = 60 }, -- Gray Elekk
[29743] = { id = 35711, sg = 60 }, -- Purple Elekk
[29222] = { id = 35018, sg = 60 }, -- Purple Hawkstrider
[28927] = { id = 34795, sg = 60 }, -- Red Hawkstrider

[32588] = { id = 40549 }, -- Banana Charm / Bananas
[29958] = { id = 36031 }, -- Blue Dragonhawk Hatchling
[29901] = { id = 35907 }, -- Blue Moth Egg / Blue Moth
[29364] = { id = 35239 }, -- Brown Rabbit Crate / Brown Rabbit
[29953] = { id = 36027 }, -- Golden Dragonhawk Hatchling
[27445] = { id = 33050 }, -- Magical Crawdad Box / Magical Crawdad
[29363] = { id = 35156 }, -- Mana Wyrmling
[31760] = { id = 39181 }, -- Miniwing
[29956] = { id = 36028 }, -- Red Dragonhawk Hatchling
[29902] = { id = 35909 }, -- Red Moth Egg / Red Moth
[29957] = { id = 36029 }, -- Silver Dragonhawk Hatchling
[29904] = { id = 35911 }, -- White Moth Egg / White Moth Egg
[29903] = { id = 35910 }, -- Yellow Moth Egg / Yellow Moth

[23720] = { id = 30174, sg = 60 }, -- Riding Turtle

[23713] = { id = 30156 }, -- Hippogryph Hatchling

[8628] = { id = 10792, sg = 60 }, -- Reins of the Spotted Nightsaber / Spotted Panther
-- item 16339 Commander's Steed
-- item 8627 Reins of the Nightsaber

[19055] = { id = 23531 }, -- Green Dragon Orb / Tiny Green Dragon
[19054] = { id = 23530 }, -- Red Dragon Orb / Tiny Red Dragon
[18964] = { id = 23429 }, -- Turtle Egg (Loggerhead) / Loggerhead Snapjaw


['XS-33943'] = { id = 33943, sf = 150 }, -- Flight Form / Druid
['XS-40120'] = { id = 40120, sf = 280 }, -- Swift Flight Form / Druid
['XS-48778'] = { id = 48778, sg = 100 }, -- Acherus Deathcharger / Death Knight
['XS-23214'] = { id = 23214, sg = 100 }, -- Charger / Paladin
['XS-23161'] = { id = 23161, sg = 100 }, -- Dreadsteed / Warlock
['XS-5784'] = { id = 5784, sg = 60 }, -- Felsteed / Warlock
['XS-34767'] = { id = 34767, sg = 100 }, -- Summon Charger / Blood Elf Paladin
['XS-34769'] = { id = 34769, sg = 60 }, -- Summon Warhorse / Blood Elf Paladin
['XS-13819'] = { id = 13819, sg = 60 }, -- Warhorse / Paladin

[50435] = { id = 71810, sf = 310 }, -- Wrathful Gladiator's Frost Wyrm

[21176] = { id = 26656, sg = 100 }, -- Black Qiraji Resonating Crystal / Black Qiraji Battle Tank
[13328] = { id = 17461, sg = 100 }, -- Black Ram
[13335] = { id = 17481, sg = 100 }, -- Deathcharger's Reins / Rivendare's Deathcharger
[13329] = { id = 17460, sg = 100 }, -- Frost Ram
[18794] = { id = 23249, sg = 100 }, -- Great Brown Kodo
[18795] = { id = 23248, sg = 100 }, -- Great Gray Kodo
[18793] = { id = 23247, sg = 100 }, -- Great White Kodo
[15292] = { id = 18991, sg = 100 }, -- Green Kodo
[13334] = { id = 17465, sg = 100 }, -- Green Skeletal Warhorse
[12351] = { id = 16081, sg = 100 }, -- Horn of the Arctic Wolf / Winter Wolf
[19029] = { id = 23509, sg = 100 }, -- Horn of the Frostwolf Howler / Frostwolf Howler
[12330] = { id = 16080, sg = 100 }, -- Horn of the Red Wolf / Red Wolf
[18796] = { id = 23250, sg = 100 }, -- Horn of the Swift Brown Wolf / Swift Brown Wolf
[18798] = { id = 23252, sg = 100 }, -- Horn of the Swift Gray Wolf / Swift Gray Wolf
[18797] = { id = 23251, sg = 100 }, -- Horn of the Swift Timber Wolf / Swift Timber Wolf
[13327] = { id = 17459, sg = 100 }, -- Icy Blue Mechanostrider Mod A
[12354] = { id = 16082, sg = 100 }, -- Palomino Bridle / Palomino
[18791] = { id = 23246, sg = 100 }, -- Purple Skeletal Warhorse
[12302] = { id = 16056, sg = 100 }, -- Reins of the Ancient Frostsaber / Ancient Frostsaber
[12303] = { id = 16055, sg = 100 }, -- Reins of the Nightsaber / Black Nightsaber
[18766] = { id = 23221, sg = 100 }, -- Reins of the Swift Frostsaber / Swift Frostsaber
[18767] = { id = 23219, sg = 100 }, -- Reins of the Swift Mistsaber / Swift Mistsaber
[18902] = { id = 23338, sg = 100 }, -- Reins of the Swift Stormsaber / Swift Stormsaber
[13086] = { id = 17229, sg = 100 }, -- Reins of the Winterspring Frostsaber / Winterspring Frostsaber
[19030] = { id = 23510, sg = 100 }, -- Stormpike Battle Charger
[18788] = { id = 23241, sg = 100 }, -- Swift Blue Raptor
[18786] = { id = 23238, sg = 100 }, -- Swift Brown Ram
[18777] = { id = 23229, sg = 100 }, -- Swift Brown Steed
[18787] = { id = 23239, sg = 100 }, -- Swift Gray Ram
[18772] = { id = 23225, sg = 100 }, -- Swift Green Mechanostrider
[18789] = { id = 23242, sg = 100 }, -- Swift Olive Raptor
[18790] = { id = 23243, sg = 100 }, -- Swift Orange Raptor
[18776] = { id = 23227, sg = 100 }, -- Swift Palomino
[19872] = { id = 24242, sg = 100 }, -- Swift Razzashi Raptor
[18773] = { id = 23223, sg = 100 }, -- Swift White Mechanostrider
[18785] = { id = 23240, sg = 100 }, -- Swift White Ram
[18778] = { id = 23228, sg = 100 }, -- Swift White Steed
[18774] = { id = 23222, sg = 100 }, -- Swift Yellow Mechanostrider
[19902] = { id = 24252, sg = 100 }, -- Swift Zulian Tiger
[15293] = { id = 18992, sg = 100 }, -- Teal Kodo
[13317] = { id = 17450, sg = 100 }, -- Whistle of the Ivory Raptor / Ivory Raptor
[8586] = { id = 16084, sg = 100 }, -- Whistle of the Mottled Red Raptor / Mottled Red Raptor
[13326] = { id = 15779, sg = 100 }, -- White Mechanostrider Mod B
[12353] = { id = 16083, sg = 100 }, -- White Stallion Bridle / White Stallion
[2411] = { id = 470, sg = 60 }, -- Black Stallion Bridle
[8595] = { id = 10969, sg = 60 }, -- Blue Mechanostrider
[21218] = { id = 25953, sg = 100, r = { zone = "AHNQIRAJ,AHNQIRAJ_RUINS" } }, -- Blue Qiraji Resonating Crystal / Blue Qiraji Battle Tank
[13332] = { id = 17463, sg = 60 }, -- Blue Skeletal Horse
[37827] = { id = 50869, sg = 60 }, -- Brewfest Kodo
[5656] = { id = 458, sg = 60 }, -- Brown Horse Bridle / Brown Horse
[15290] = { id = 18990, sg = 60 }, -- Brown Kodo
[5872] = { id = 6899, sg = 60 }, -- Brown Ram
[13333] = { id = 17464, sg = 60 }, -- Brown Skeletal Horse
[5655] = { id = 6648, sg = 60 }, -- Chestnut Mare Bridle / Chestnut Mare
[15277] = { id = 18989, sg = 60 }, -- Gray Kodo
[5864] = { id = 6777, sg = 60 }, -- Gray Ram
[13321] = { id = 17453, sg = 60 }, -- Green Mechanostrider
[21323] = { id = 26056, sg = 100, r = { zone = "AHNQIRAJ,AHNQIRAJ_RUINS" } }, -- Green Qiraji Resonating Crystal / Green Qiraji Battle Tank
[5668] = { id = 6654, sg = 60 }, -- Horn of the Brown Wolf / Brown Wolf
[5665] = { id = 6653, sg = 60 }, -- Horn of the Dire Wolf / Dire Wolf
[1132] = { id = 580, sg = 60 }, -- Horn of the Timber Wolf / Timber Wolf
[2414] = { id = 472, sg = 60 }, -- Pinto Bridle / Pinto
[8563] = { id = 10873, sg = 60 }, -- Red Mechanostrider
[21321] = { id = 26054, sg = 100, r = { zone = "AHNQIRAJ,AHNQIRAJ_RUINS" } }, -- Red Qiraji Resonating Crystal / Red Qiraji Battle Tank
[13331] = { id = 17462, sg = 60 }, -- Red Skeletal Horse
[8632] = { id = 10789, sg = 60 }, -- Reins of the Spotted Frostsaber / Spotted Frostsaber
[8631] = { id = 8394, sg = 60 }, -- Reins of the Striped Frostsaber / Striped Frostsaber
[8629] = { id = 10793, sg = 60 }, -- Reins of the Striped Nightsaber / Striped Nightsaber
[13322] = { id = 17454, sg = 60 }, -- Unpainted Mechanostrider
[8588] = { id = 8395, sg = 60 }, -- Whistle of the Emerald Raptor / Emerald Raptor
[8591] = { id = 10796, sg = 60 }, -- Whistle of the Turquoise Raptor / Turquoise Raptor
[8592] = { id = 10799, sg = 60 }, -- Whistle of the Violet Raptor / Violet Raptor
[5873] = { id = 6898, sg = 60 }, -- White Ram
[21324] = { id = 26055, sg = 100, r = { zone = "AHNQIRAJ,AHNQIRAJ_RUINS" } }, -- Yellow Qiraji Resonating Crystal / Yellow Qiraji Battle Tank

[8494] = { id = 10682 }, -- Parrot Cage (Hyacinth Macaw) / Hyacinth Macaw
[20371] = { id = 24696 }, -- Blue Murloc Egg / Murky
[23083] = { id = 28871 }, -- Captured Flame / Spirit of Summer
[13584] = { id = 17708 }, -- Diablo Stone / Mini Diablo
[13583] = { id = 17707 }, -- Panda Collar / Panda Cub
[13582] = { id = 17709 }, -- Zergling Leash / Zergling
[19450] = { id = 23811 }, -- A Jubling's Tiny Home / Jubling
[11023] = { id = 10685 }, -- Ancona Chicken
[10360] = { id = 10714 }, -- Black Kingsnake
[10361] = { id = 10716 }, -- Brown Snake
[8491] = { id = 10675 }, -- Cat Carrier (Black Tabby) / Black Tabby Cat
[8485] = { id = 10673 }, -- Cat Carrier (Bombay) / Bombay Cat
[8486] = { id = 10674 }, -- Cat Carrier (Cornish Rex) / Cornish Rex Cat
[8487] = { id = 10676 }, -- Cat Carrier (Orange Tabby) / Orange Tabby Cat
[8490] = { id = 10677 }, -- Cat Carrier (Siamese) / Siamese Cat
[8488] = { id = 10678 }, -- Cat Carrier (Silver Tabby) / Silver Tabby Cat
[8489] = { id = 10679 }, -- Cat Carrier (White Kitten) / White Kitten
[11110] = { id = 13548 }, -- Chicken Egg / Westfall Chicken
[10393] = { id = 10688 }, -- Cockroach
[10392] = { id = 10717 }, -- Crimson Snake
[10822] = { id = 10695 }, -- Dark Whelpling
[20769] = { id = 25162 }, -- Disgusting Oozeling
[8500] = { id = 10707 }, -- Great Horned Owl
[21301] = { id = 26533, r = { item = "17202x1" } }, -- Green Helper Box / Father Winter's Helper
[8501] = { id = 10706 }, -- Hawk Owl
[21308] = { id = 26529, r = { item = "17202x1" } }, -- Jingling Bell / Winter Reindeer
[15996] = { id = 19772 }, -- Lifelike Mechanical Toad / Lifelike Toad
[11826] = { id = 15049 }, -- Lil' Smoky
[10398] = { id = 12243 }, -- Mechanical Chicken
[4401] = { id = 4055 }, -- Mechanical Squirrel Box / Mechanical Squirrel
[8496] = { id = 10680 }, -- Parrot Cage (Cockatiel) / Cockatiel
[8492] = { id = 10683 }, -- Parrot Cage (Green Wing Macaw) / Green Wing Macaw
[8495] = { id = 10684 }, -- Parrot Cage (Senegal) / Senegal
[11825] = { id = 15048 }, -- Pet Bombling
[15048] = { id = 28739 }, -- Piglet's Collar / Mr. Wiggles
[10394] = { id = 10709 }, -- Prairie Dog Whistle / Brown Prairie Dog
[8497] = { id = 10711 }, -- Rabbit Crate (Snowshoe) / Snowshoe Rabbit
[23015] = { id = 28740 }, -- Rat Cage / Whiskers the Rat
[21305] = { id = 26541, r = { item = "17202x1" } }, -- Red Helper Box / Winter's Little Helper
-- item 22200 Silver Shafted Arrow
[12529] = { id = 16450 }, -- Smolderweb Carrier / Smolderweb Hatchling
[21309] = { id = 26045, r = { item = "17202x1" } }, -- Snowman Kit / Tiny Snowman
[11474] = { id = 15067 }, -- Sprite Darter Egg / Sprite Darter Hatchling
[8499] = { id = 10697 }, -- Tiny Crimson Whelpling / Crimson Whelpling
[8498] = { id = 10698 }, -- Tiny Emerald Whelpling / Emerald Whelpling
[21277] = { id = 26010 }, -- Tranquil Mechanical Yeti
[11026] = { id = 10704 }, -- Tree Frog Box / Tree Frog
[22235] = { id = 27570 }, -- Truesilver Shafted Arrow / Peddlefeet
[23002] = { id = 28738 }, -- Turtle Box / Speedy
[19462] = { id = 23811 }, -- Unhatched Jubling Egg
[11027] = { id = 10703 }, -- Wood Frog Box / Wood Frog
[12264] = { id = 15999 }, -- Worg Carrier / Worg Pup

}


-- build pets and mounts array
local key = nil
local cd
for item, spell in pairs( ArkInventory.Const.CompanionTranslationData ) do
	
	if type( item ) == "number" and type( spell.id ) == "number" then
		
		-- item to spell
		key = string.format( "item:%s", item )
		if not ArkInventory.Const.ItemSpellCrossReference[key] then
			ArkInventory.Const.ItemSpellCrossReference[key] = { }
		end
		ArkInventory.Const.ItemSpellCrossReference[key][string.format( "spell:%s", spell.id )] = true
		
		-- spell to item(s)
		key = string.format( "spell:%s", spell.id )
		if not ArkInventory.Const.ItemSpellCrossReference[key] then
			ArkInventory.Const.ItemSpellCrossReference[key] = { }
		end
		ArkInventory.Const.ItemSpellCrossReference[key][string.format( "item:%s", item )] = true
		
	end
	
	if type( spell.id ) == "number" then
		
		-- companion spell data
		
		if not ArkInventory.Const.CompanionData[spell.id] then
			ArkInventory.Const.CompanionData[spell.id] = { }
		end
		cd = ArkInventory.Const.CompanionData[spell.id]
		
		cd.speed = {
			ground = spell.sg,
			flying = spell.sf,
			water = spell.sw,
		}
		
		cd.usable = {
			ground = not not spell.sg,
			flying = not not spell.sf,
			water = not not spell.sw,
		}
		
		cd.r = spell.r
		
	end
	
end

wipe( ArkInventory.Const.CompanionTranslationData )
ArkInventory.Const.CompanionTranslationData = nil




function ArkInventory.CompanionDataCorrect( )
	
	-- put user corrected data back into the companionData table
	
	local companionData = ArkInventory.Const.CompanionData
	local fixed = { }
	
	-- add missing mounts and pets
	for _, companionType in pairs( { "MOUNT", "CRITTER" } ) do
		local n = GetNumCompanions( companionType )
		for companionIndex = 1, n do
			local companionID, companionName, companionSpellID, texture, active = GetCompanionInfo( companionType, companionIndex )
			if not companionData[companionSpellID] then
				companionData[companionSpellID] = { unknown = true, speed = { }, usable = { } }
			end
		end
	end
	
	
	-- undo all corrections
	for _, v in pairs( companionData )  do
		if v.corrected then
			v.corrected = nil
			v.usable.ground = not not v.speed.ground
			v.usable.flying = not not v.speed.flying
			v.usable.water = not not v.speed.water
		end
	end
	
	
	-- apply user corrections
	for _, mountType in pairs( { "flying", "ground", "water" } ) do
		
		for companionSpellID, newValue in pairs( ArkInventory.db.global.option.ldb.mounts[mountType].corrected ) do
			
			if not companionData[companionSpellID] then
				-- mising (corrected) companion from alt
				companionData[companionSpellID] = { unknown = true, speed = { }, usable = { } }
			end
			
			companionData[companionSpellID].corrected = true
			companionData[companionSpellID].usable[mountType] = newValue
			
			if ( not not companionData[companionSpellID].speed[mountType] ) == ( not not newValue ) then
				-- looks like we fixed the code, get rid of the user correction later on
				fixed[companionSpellID] = mountType
			end
			
		end
		
	end
	
	-- remove any user corrections for things we've fixed
	for companionSpellID, mountType in pairs( fixed ) do
		--ArkInventory.Output( "fixed ", mountType, " (", companionSpellID, ") has been removed from user corrections" )
		ArkInventory.db.global.option.ldb.mounts[mountType].corrected[companionSpellID] = nil
		companionData[companionSpellID].corrected = nil
	end
	
	table.wipe( fixed )
	fixed = nil
	
end
