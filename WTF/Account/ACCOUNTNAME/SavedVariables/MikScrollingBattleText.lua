
MSBTProfiles_SavedVars = {
	["profiles"] = {
		["RealUI"] = {
			["critFontName"] = "pixel_lr_large",
			["stickyCritsDisabled"] = true,
			["animationSpeed"] = 70,
			["triggers"] = {
				["MSBT_TRIGGER_LOW_HEALTH"] = {
					["mainEvents"] = "UNIT_HEALTH{unitID;;eq;;player;;threshold;;lt;;25}",
					["iconSkill"] = "3273",
					["disabled"] = true,
					["soundFile"] = "Omen: Aoogah!",
				},
				["Custom2"] = {
					["message"] = "New Trigger",
					["alwaysSticky"] = true,
				},
				["MSBT_TRIGGER_LOCK_AND_LOAD"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_TIDAL_WAVES"] = {
					["disabled"] = true,
				},
				["Custom1"] = {
					["message"] = "New Trigger",
					["alwaysSticky"] = true,
				},
				["MSBT_TRIGGER_MAELSTROM_WEAPON"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_NIGHTFALL"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SWORD_AND_BOARD"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_LAVA_SURGE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SUDDEN_DEATH"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SHADOW_ORB"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_BLOODSURGE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SHOOTING_STARS"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_LOW_PET_HEALTH"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_MOLTEN_CORE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_ECLIPSE_SOLAR"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_BRAIN_FREEZE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_RIME"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SHADOW_INFUSION"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_CLEARCASTING"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_THE_ART_OF_WAR"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_ECLIPSE_LUNAR"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_IMPACT"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_HOT_STREAK"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_KILLING_MACHINE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_VICTORY_RUSH"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_LOW_MANA"] = {
					["mainEvents"] = "UNIT_MANA{unitID;;eq;;player;;threshold;;lt;;25}",
					["disabled"] = true,
				},
				["MSBT_TRIGGER_TASTE_FOR_BLOOD"] = {
					["disabled"] = true,
				},
			},
			["textShadowingDisabled"] = true,
			["creationVersion"] = "5.4.78",
			["critFontSize"] = 8,
			["normalOutlineIndex"] = 5,
			["events"] = {
				["NOTIFICATION_PC_KILLING_BLOW"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_MONEY"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_ITEM_BUFF_FADE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_REP_LOSS"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_SKILL_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_LOOT"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_SOUL_SHARD_CREATED"] = {
					["alwaysSticky"] = false,
				},
				["INCOMING_HEAL_CRIT"] = {
					["fontSize"] = false,
				},
				["NOTIFICATION_POWER_LOSS"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_HOLY_POWER_FULL"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_MONSTER_EMOTE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_ITEM_BUFF"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_POWER_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_BUFF"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_BUFF_STACK"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_CP_FULL"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_EXTRA_ATTACK"] = {
					["alwaysSticky"] = false,
					["disabled"] = true,
				},
				["NOTIFICATION_BUFF_FADE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_HOLY_POWER_CHANGE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_CP_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_COOLDOWN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_HONOR_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_PET_COOLDOWN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_REP_GAIN"] = {
					["disabled"] = true,
				},
			},
			["hideFullOverheals"] = true,
			["scrollAreas"] = {
				["Outgoing"] = {
					["direction"] = "Up",
					["behavior"] = "MSBT_NORMAL",
					["stickyDirection"] = "Up",
					["scrollHeight"] = 150,
					["offsetX"] = 166,
					["stickyBehavior"] = "MSBT_NORMAL",
					["scrollWidth"] = 130,
					["offsetY"] = 10,
					["animationStyle"] = "Straight",
					["stickyAnimationStyle"] = "Static",
				},
				["Notification"] = {
					["direction"] = "Up",
					["critFontSize"] = 16,
					["scrollHeight"] = 100,
					["offsetX"] = -150,
					["stickyAnimationStyle"] = "Static",
					["stickyDirection"] = "Up",
					["offsetY"] = 60,
					["scrollWidth"] = 300,
					["normalFontSize"] = 16,
				},
				["Static"] = {
					["disabled"] = true,
					["offsetY"] = -65,
				},
				["Incoming"] = {
					["direction"] = "Up",
					["behavior"] = "MSBT_NORMAL",
					["stickyDirection"] = "Up",
					["scrollWidth"] = 130,
					["offsetX"] = -296,
					["scrollHeight"] = 150,
					["stickyBehavior"] = "MSBT_NORMAL",
					["offsetY"] = 10,
					["animationStyle"] = "Straight",
					["stickyAnimationStyle"] = "Static",
				},
			},
			["normalFontName"] = "pixel_lr_small",
			["critOutlineIndex"] = 5,
			["normalFontSize"] = 8,
		},
		["Default"] = {
			["critFontName"] = "pixel_lr_large",
			["stickyCritsDisabled"] = true,
			["animationSpeed"] = 70,
			["triggers"] = {
				["MSBT_TRIGGER_LOW_HEALTH"] = {
					["mainEvents"] = "UNIT_HEALTH{unitID;;eq;;player;;threshold;;lt;;25}",
					["iconSkill"] = "3273",
					["disabled"] = true,
					["soundFile"] = "Omen: Aoogah!",
				},
				["Custom2"] = {
					["message"] = "New Trigger",
					["alwaysSticky"] = true,
				},
				["MSBT_TRIGGER_LOCK_AND_LOAD"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_TIDAL_WAVES"] = {
					["disabled"] = true,
				},
				["Custom1"] = {
					["message"] = "New Trigger",
					["alwaysSticky"] = true,
				},
				["MSBT_TRIGGER_MAELSTROM_WEAPON"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_NIGHTFALL"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SWORD_AND_BOARD"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_LAVA_SURGE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SUDDEN_DEATH"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SHADOW_ORB"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_BLOODSURGE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SHOOTING_STARS"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_LOW_PET_HEALTH"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_MOLTEN_CORE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_ECLIPSE_SOLAR"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_BRAIN_FREEZE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_RIME"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SHADOW_INFUSION"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_CLEARCASTING"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_THE_ART_OF_WAR"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_ECLIPSE_LUNAR"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_IMPACT"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_HOT_STREAK"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_KILLING_MACHINE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_VICTORY_RUSH"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_LOW_MANA"] = {
					["mainEvents"] = "UNIT_MANA{unitID;;eq;;player;;threshold;;lt;;25}",
					["disabled"] = true,
				},
				["MSBT_TRIGGER_TASTE_FOR_BLOOD"] = {
					["disabled"] = true,
				},
			},
			["textShadowingDisabled"] = true,
			["creationVersion"] = "5.4.78",
			["critFontSize"] = 8,
			["normalOutlineIndex"] = 5,
			["events"] = {
				["NOTIFICATION_PC_KILLING_BLOW"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_MONEY"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_ITEM_BUFF_FADE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_REP_LOSS"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_SKILL_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_LOOT"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_SOUL_SHARD_CREATED"] = {
					["alwaysSticky"] = false,
				},
				["INCOMING_HEAL_CRIT"] = {
					["fontSize"] = false,
				},
				["NOTIFICATION_POWER_LOSS"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_HOLY_POWER_FULL"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_MONSTER_EMOTE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_ITEM_BUFF"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_POWER_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_BUFF"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_BUFF_STACK"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_CP_FULL"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_EXTRA_ATTACK"] = {
					["alwaysSticky"] = false,
					["disabled"] = true,
				},
				["NOTIFICATION_BUFF_FADE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_HOLY_POWER_CHANGE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_CP_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_COOLDOWN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_HONOR_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_PET_COOLDOWN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_REP_GAIN"] = {
					["disabled"] = true,
				},
			},
			["hideFullOverheals"] = true,
			["scrollAreas"] = {
				["Outgoing"] = {
					["direction"] = "Up",
					["stickyBehavior"] = "MSBT_NORMAL",
					["stickyDirection"] = "Up",
					["scrollHeight"] = 150,
					["offsetX"] = 166,
					["scrollWidth"] = 130,
					["behavior"] = "MSBT_NORMAL",
					["offsetY"] = 10,
					["animationStyle"] = "Straight",
					["stickyAnimationStyle"] = "Static",
				},
				["Notification"] = {
					["direction"] = "Up",
					["stickyDirection"] = "Up",
					["scrollWidth"] = 300,
					["offsetX"] = -150,
					["stickyAnimationStyle"] = "Static",
					["scrollHeight"] = 100,
					["offsetY"] = 60,
					["critFontSize"] = 16,
					["normalFontSize"] = 16,
				},
				["Static"] = {
					["disabled"] = true,
					["offsetY"] = -65,
				},
				["Incoming"] = {
					["direction"] = "Up",
					["behavior"] = "MSBT_NORMAL",
					["stickyDirection"] = "Up",
					["scrollHeight"] = 150,
					["offsetX"] = -296,
					["stickyBehavior"] = "MSBT_NORMAL",
					["scrollWidth"] = 130,
					["offsetY"] = 10,
					["animationStyle"] = "Straight",
					["stickyAnimationStyle"] = "Static",
				},
			},
			["normalFontName"] = "pixel_lr_small",
			["critOutlineIndex"] = 5,
			["normalFontSize"] = 8,
		},
		["RealUI-HR"] = {
			["critFontName"] = "pixel_hr_large",
			["stickyCritsDisabled"] = true,
			["animationSpeed"] = 70,
			["normalFontSize"] = 8,
			["textShadowingDisabled"] = true,
			["creationVersion"] = "5.4.78",
			["critFontSize"] = 8,
			["critOutlineIndex"] = 5,
			["events"] = {
				["NOTIFICATION_PC_KILLING_BLOW"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_HONOR_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_ITEM_BUFF_FADE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_REP_LOSS"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_PET_COOLDOWN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_LOOT"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_SOUL_SHARD_CREATED"] = {
					["alwaysSticky"] = false,
				},
				["INCOMING_HEAL_CRIT"] = {
					["fontSize"] = false,
				},
				["NOTIFICATION_POWER_LOSS"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_HOLY_POWER_FULL"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_MONSTER_EMOTE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_REP_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_POWER_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_SKILL_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_MONEY"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_BUFF_STACK"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_EXTRA_ATTACK"] = {
					["alwaysSticky"] = false,
					["disabled"] = true,
				},
				["NOTIFICATION_COOLDOWN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_HOLY_POWER_CHANGE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_CP_GAIN"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_BUFF_FADE"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_CP_FULL"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_BUFF"] = {
					["disabled"] = true,
				},
				["NOTIFICATION_ITEM_BUFF"] = {
					["disabled"] = true,
				},
			},
			["hideFullOverheals"] = true,
			["scrollAreas"] = {
				["Incoming"] = {
					["direction"] = "Up",
					["stickyBehavior"] = "MSBT_NORMAL",
					["stickyDirection"] = "Up",
					["scrollWidth"] = 130,
					["offsetX"] = -316,
					["scrollHeight"] = 150,
					["behavior"] = "MSBT_NORMAL",
					["offsetY"] = 10,
					["animationStyle"] = "Straight",
					["stickyAnimationStyle"] = "Static",
				},
				["Outgoing"] = {
					["direction"] = "Up",
					["stickyBehavior"] = "MSBT_NORMAL",
					["stickyDirection"] = "Up",
					["scrollWidth"] = 130,
					["offsetX"] = 186,
					["scrollHeight"] = 150,
					["behavior"] = "MSBT_NORMAL",
					["offsetY"] = 10,
					["animationStyle"] = "Straight",
					["stickyAnimationStyle"] = "Static",
				},
				["Static"] = {
					["disabled"] = true,
					["offsetY"] = -65,
				},
				["Notification"] = {
					["direction"] = "Up",
					["critFontSize"] = 16,
					["scrollWidth"] = 300,
					["offsetX"] = -150,
					["normalFontSize"] = 16,
					["scrollHeight"] = 100,
					["offsetY"] = 60,
					["stickyDirection"] = "Up",
					["stickyAnimationStyle"] = "Static",
				},
			},
			["normalFontName"] = "pixel_hr_small",
			["normalOutlineIndex"] = 5,
			["triggers"] = {
				["MSBT_TRIGGER_LOW_HEALTH"] = {
					["soundFile"] = "Omen: Aoogah!",
					["iconSkill"] = "3273",
					["mainEvents"] = "UNIT_HEALTH{unitID;;eq;;player;;threshold;;lt;;25}",
					["disabled"] = true,
				},
				["Custom2"] = {
					["message"] = "New Trigger",
					["alwaysSticky"] = true,
				},
				["MSBT_TRIGGER_LOCK_AND_LOAD"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_TIDAL_WAVES"] = {
					["disabled"] = true,
				},
				["Custom1"] = {
					["message"] = "New Trigger",
					["alwaysSticky"] = true,
				},
				["MSBT_TRIGGER_MAELSTROM_WEAPON"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_NIGHTFALL"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SWORD_AND_BOARD"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_LAVA_SURGE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SUDDEN_DEATH"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SHADOW_ORB"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_BLOODSURGE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SHOOTING_STARS"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_LOW_PET_HEALTH"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_MOLTEN_CORE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_ECLIPSE_SOLAR"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_LOW_MANA"] = {
					["mainEvents"] = "UNIT_MANA{unitID;;eq;;player;;threshold;;lt;;25}",
					["disabled"] = true,
				},
				["MSBT_TRIGGER_RIME"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_SHADOW_INFUSION"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_CLEARCASTING"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_VICTORY_RUSH"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_KILLING_MACHINE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_HOT_STREAK"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_IMPACT"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_ECLIPSE_LUNAR"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_THE_ART_OF_WAR"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_BRAIN_FREEZE"] = {
					["disabled"] = true,
				},
				["MSBT_TRIGGER_TASTE_FOR_BLOOD"] = {
					["disabled"] = true,
				},
			},
		},
	},
}
MSBT_SavedMedia = {
	["fonts"] = {
	},
	["sounds"] = {
	},
}
