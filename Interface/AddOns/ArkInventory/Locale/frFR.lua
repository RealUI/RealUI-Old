local L = LibStub( "AceLocale-3.0" ):NewLocale( "ArkInventory", "frFR" )
if not L then return end

-- post updated translations at http://groups.google.com/group/wow-arkinventory (modify this file and include as an attachment)
-- note: when creating a new locale do not leave any english translations in your file, comment them out by placing -- at the start of the line


-- Translated by: Mahrak











--	wow zone names - must match exactly what is in game
--	L["WOW_ZONE_AHNQIRAJ"] = ""
--	L["WOW_ZONE_VASHJIR"] = ""
	L["WOW_ZONE_KELPTHAR_FOREST"] = "Forêt de Varech'thar"
	L["WOW_ZONE_SHIMMERING_EXPANSE"] = "Étendues Chatoyantes"
	L["WOW_ZONE_ABYSSAL_DEPTHS"] = "Profondeurs Abyssales"
	
	
--	wow tooltip text - must match exactly what is in game
	L["WOW_ITEM_TOOLTIP_FOOD"] = "Vous devez rester assis pendant que vous mangez"
	L["WOW_ITEM_TOOLTIP_DRINK"] = "Vous devez rester assis pendant que vous buvez"
	L["WOW_ITEM_TOOLTIP_POTION_HEAL"] = "Rend %d+ point de vie en %d+ sec"
	L["WOW_ITEM_TOOLTIP_POTION_MANA"] = "Rend %d+ point de mana en %d+ sec"
	L["WOW_ITEM_TOOLTIP_ELIXIR_BATTLE"] = "Elixir de bataille"
	L["WOW_ITEM_TOOLTIP_ELIXIR_GUARDIAN"] = "Elixir du gardien"
	
	
--	location names
	L["LOCATION_ALL"] = "Tous"
	L["LOCATION_BANK"] = "Banque"
	L["LOCATION_WEARING"] = "Vêtements"
	
	
--	subframe names
	L["SUBFRAME_NAME_TITLE"] = "Titre"
	L["SUBFRAME_NAME_BAGCHANGER"] = "Echangeur de sac"
	
	
-- status bar/bag text
	L["STATUS_NO_DATA"] = "Aucune information"
	L["STATUS_FULL"] = "Plein"
	L["STATUS_PURCHASE"] = "Acheté"
	
	
--	restack
	L["RESTACK"] = "Empiler les objets"
	L["RESTACK_TEXT"] = "Empiler les objets pouvant l'être et essai de remplir les emplacements vide des sacs spéciaux"
	L["RESTACK_FAIL_WAIT"] = "Une opération d'empilage est en cours, veuillez attendre qu'elle se termine"
	L["RESTACK_FAIL_ACCESS"] = "Vous n'avez pas l'autorisation pour empiler le casier %2$s de la %1$s"
	
	
--	vault tab tooltips
	L["VAULT_TAB_ACCESS_NONE"] = "Pas d'accès"
	L["VAULT_TAB_NAME"] = "Casier: |cffffffff%1$s - %2$s|r"
	L["VAULT_TAB_ACCESS"] = "Accès: |cffffffff%1$s|r"
	L["VAULT_TAB_REMAINING_WITHDRAWALS"] = "Retrait journalier restant: |cffffffff%1$s|r"
	
	
--	category "header" descriptions  (does not have to match wow)
	L["CATEGORY_RULE"] = "Règle"
	
	
--	system category descriptions
	L["CATEGORY_SYSTEM_CORE_MATS"] = "Matière première"
	L["CATEGORY_SYSTEM_EQUIPMENT"] = "Equipement non lié"
	L["CATEGORY_SYSTEM_EQUIPMENT_SOULBOUND"] = "Equipement lié"
	
	
--	consumable category descriptions
	L["CATEGORY_CONSUMABLE_FOOD_PET"] = "Nourriture pour familier"
	L["CATEGORY_CONSUMABLE_POTION_MANA"] = "Mana (Potion/Gemme)"
	L["CATEGORY_CONSUMABLE_POTION_HEAL"] = "Soin (Potion/Pierre de soins)"
	L["CATEGORY_CONSUMABLE_ELIXIR_BATTLE"] = "Elixir de bataille"
	L["CATEGORY_CONSUMABLE_ELIXIR_GUARDIAN"] = "Elixir du gardien"
	
	
--	bag names - used to name the empty slots in the status frame
	L["STATUS_NAME_BAG"] = "Sac"
	L["STATUS_NAME_CRITTER"] = "Comp"
	L["STATUS_NAME_ENCHANTING"] = "Ench"
	L["STATUS_NAME_ENGINEERING"] = "Ing"
	L["STATUS_NAME_GEAR"] = "Equip"
	L["STATUS_NAME_GEM"] = "Gemme"
	L["STATUS_NAME_HERB"] = "Herbe"
	L["STATUS_NAME_INSCRIPTION"] = "Calli"
	L["STATUS_NAME_KEY"] = "Clé"
	L["STATUS_NAME_LEATHERWORKING"] = "Cuir"
	L["STATUS_NAME_MAIL"] = "Courrier"
	L["STATUS_NAME_MINING"] = "Minerai"
	L["STATUS_NAME_MOUNT"] = "Monture"
	L["STATUS_NAME_TOKEN"] = "Insigne"
--	L["STATUS_NAME_TACKLE"] = ""
	
	
--	main menu
--	L["MENU"] = ""
	
	L["MENU_CHARACTER_SWITCH"] = "Changer de personnage"
	L["MENU_CHARACTER_SWITCH_TEXT"] = "Afficher le contenu d'un autre personnage"
	L["MENU_CHARACTER_SWITCH_CHOOSE_NONE"] = "Pas de données d'autres personnages"
	L["MENU_CHARACTER_SWITCH_CHOOSE_TEXT"] = "Changer l'affichage actuel pour %1$s"
	L["MENU_CHARACTER_SWITCH_ERASE"] = "Effacer les données de %s"
	L["MENU_CHARACTER_SWITCH_ERASE_TEXT"] = "Effacer les données de %1$s pour %2$s"
	
	L["MENU_LOCATION_SWITCH"] = "Autres emplacements"
	L["MENU_LOCATION_SWITCH_TEXT"] = "Ouvrir la fenêtre de %1$s"
	
	
--	actions menu
--	L["MENU_ACTION"] = ""
	L["MENU_ACTION_REFRESH"] = "Réactualiser"
	L["MENU_ACTION_REFRESH_TEXT"] = "Réactualiser la fenêtre"
	L["MENU_ACTION_RELOAD_TEXT"] = "Recharger la fenêtre."
	L["MENU_ACTION_EDITMODE"] = "Mode édition"
	L["MENU_ACTION_EDITMODE_TEXT"] = "Basculer en mode édition, ce qui vous permet de changer la catégorie des objets"
	L["MENU_ACTION_BAGCHANGER"] = "Echangeur de sacs"
	L["MENU_ACTION_BAGCHANGER_TEXT"] = "Basculer vers l'afficher les sacs, ce qui vous permet d'en ajouter et de les remplacer"
	
	
--	item menu
	L["MENU_ITEM_TITLE"] = "Options des objets"
	L["MENU_ITEM_ITEM"] = "Objet"
	L["MENU_ITEM_DEFAULT_RESET"] = "Remettre valeur par défaut"
	L["MENU_ITEM_DEFAULT_RESET_TEXT"] = "Cliquer pour remettre la catégorie de cette objet à sa valeur par défaut (ne modifie pas les règles)"
	L["MENU_ITEM_ASSIGN_CHOICES"] = "Catégories assignable"
	L["MENU_ITEM_ASSIGN_THIS"] = "Assigner la catégorie"
	L["MENU_ITEM_ASSIGN_THIS_TEXT"] = "Assigner cette objet à une catégorie spécifique"
	L["MENU_ITEM_RULE_NEW"] = "Créer une nouvelle règle"
	L["MENU_ITEM_RULE_ADD"] = "Ajouter un objet à cette règle"
	L["MENU_ITEM_CUSTOM_NEW"] = "Créer une nouvelle catégorie personnelle"
	L["MENU_ITEM_DEBUG"] = "Info de déboguage"
	L["MENU_ITEM_DEBUG_BAG"] = "Sac"
	L["MENU_ITEM_DEBUG_SLOT"] = "Emplacement"
--	L["MENU_ITEM_DEBUG_BAG_TYPE"] = ""
--	L["MENU_ITEM_DEBUG_PET_ID"] = ""
	L["MENU_ITEM_DEBUG_AI_ID_SHORT"] = "ID court"
	L["MENU_ITEM_DEBUG_AI_ID_CACHE"] = "ID cache"
	L["MENU_ITEM_DEBUG_AI_ID_RULE"] = "ID de règle"
	L["MENU_ITEM_DEBUG_AI_ID_CATEGORY"] = "ID catégorie"
	L["MENU_ITEM_DEBUG_LVL_ITEM"] = "Niveau de l'objet (stat)"
	L["MENU_ITEM_DEBUG_LVL_USE"] = "Niveau de l'objet (utilisation)"
--	L["MENU_ITEM_DEBUG_TYPE"] = ""
	L["MENU_ITEM_DEBUG_SUBTYPE"] = "Sous-type"
	L["MENU_ITEM_DEBUG_EQUIP"] = "Emplacement"
	L["MENU_ITEM_DEBUG_ID"] = "ID Blizzard"
	L["MENU_ITEM_DEBUG_FAMILY"] = "Famille"
--	L["MENU_ITEM_DEBUG_PT"] = ""
--	L["MENU_ITEM_DEBUG_PT_TEXT"] = ""
--	L["MENU_ITEM_DEBUG_PT_NONE"] = ""
--	L["MENU_ITEM_DEBUG_PT_TITLE"] = ""
	
	
--	bar menu
	L["MENU_BAR_TITLE"] = "Groupe %1$s"
	L["MENU_BAR_CATEGORY"] = "Catégorie"
	L["MENU_BAR_CATEGORY_TEXT"] = "Assigner la catégorie %1$s à ce groupe"
	L["MENU_BAR_CATEGORY_CURRENT"] = "Assignation actuel"
	L["MENU_BAR_CATEGORY_ASSIGN"] = "Catégories assignables"
	L["MENU_BAR_CATEGORY_REMOVE_TEXT"] = "Cliquer pour supprimer %1$s du groupe %2$s et la remettre dans le groupe par défaut"
	L["MENU_BAR_CATEGORY_HIDDEN_TEXT"] = "Cliquer pour changer le status cacher de la catégorie.\n\nLes objets dans la catégorie cachée n'apparaitront pas en mode normal"
--	L["MENU_BAR_CATEGORY_MOVE_START_TEXT"] = ""
--	L["MENU_BAR_CATEGORY_MOVE_COMPLETE_TEXT"] = ""
	L["MENU_BAR_OPTIONS"] = "Options des groupes"
	L["MENU_BAR_CLEAR_TEXT"] = "Supprimer toutes les catégories assignées actuellement à ce groupe sauf la catégorie par défaut"
	L["MENU_BAR_INSERT_TEXT"] = "Insérer un groupe vide ici en déplacant toutes les catégories d'un groupe vers le haut"
	L["MENU_BAR_REMOVE_TEXT"] = "Remettre toutes les catégories de ce groupe vers le groupe par défaut et déplacer tous les groupes au-dessus de celui-ci d'un groupe vers le bas.\n\nSi la catégorie par défaut est dans ce groupe elle va retourner vers le groupe 1"
--	L["MENU_BAR_MOVE_START_TEXT"] = ""
--	L["MENU_BAR_MOVE_COMPLETE_TEXT"] = ""
--	L["MENU_BAR_SORTKEY_TEXT"] = ""
--	L["MENU_BAR_SORTKEY_DEFAULT_RESET_TEXT"] = ""
	
	
--	changer bag menu
	L["MENU_BAG_TITLE"] = "Options de sac"
	L["MENU_BAG_SHOW"] = "Affichage"
	L["MENU_BAG_SHOW_TEXT"] = "Afficher le contenu de ce sac"
	L["MENU_BAG_ISOLATE"] = "Isoler"
	L["MENU_BAG_ISOLATE_TEXT"] = "Afficher seulement le contenu de ce sac"
	L["MENU_BAG_SHOWALL"] = "Afficher tous"
	L["MENU_BAG_SHOWALL_TEXT"] = "Afficher le contenu de tous les sacs de cette emplacement"
--	L["MENU_BAG_EMPTY"] = ""
--	L["MENU_BAG_EMPTY_TEXT"] = ""
	
	
--	configuration options
	L["CONFIG"] = "Config"
	L["CONFIG_TEXT"] = "Menu de configuration"
	
--	configuration options > system
	L["CONFIG_SYSTEM"] = "Système"
	L["CONFIG_SYSTEM_TEXT"] = "Options système"
	
	L["CONFIG_SYSTEM_FONT_TEXT"] = "Sélectionner la police de caractère à utiliser"
	
--	L["CONFIG_SYSTEM_FRAMESTRATA"] = ""
--	L["CONFIG_SYSTEM_FRAMESTRATA_TEXT"] = ""
--	L["CONFIG_SYSTEM_FRAMESTRATA_LEVEL_LOW"] = ""
--	L["CONFIG_SYSTEM_FRAMESTRATA_LEVEL_MEDIUM"] = ""
--	L["CONFIG_SYSTEM_FRAMESTRATA_LEVEL_HIGH"] = ""
	
	L["CONFIG_SYSTEM_TOOLTIP"] = "Bulle d'information"
	L["CONFIG_SYSTEM_TOOLTIP_ENABLE_TEXT"] = "Montrer les informations supplémentaires dans la bulle d'information"
	L["CONFIG_SYSTEM_TOOLTIP_EMPTY_ADD"] = "Ligne vide"
	L["CONFIG_SYSTEM_TOOLTIP_EMPTY_ADD_TEXT"] = "Mettre une ligne vide entre le texte de base de la bulle d'information et le texte personnalisé à ajouter"
	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_ADD"] = "Quantité d'objet"
	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_ADD_TEXT"] = "Montrer la quantité d'objets dans la bulle d'information"
	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_COLOUR_TEXT"] = "Définir la couleur du texte pour la quantité d'objets"
--	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_VAULT_TABS"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_ITEMCOUNT_VAULT_TABS_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_SCALE_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_CLASSCOLOUR_TEXT"] = ""
	L["CONFIG_SYSTEM_TOOLTIP_SELF_ONLY"] = "Personnage seul"
	L["CONFIG_SYSTEM_TOOLTIP_SELF_ONLY_TEXT"] = "Montrer la quantité d'objets seulement pour ce personnage"
--	L["CONFIG_SYSTEM_TOOLTIP_FACTION_ONLY"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_FACTION_ONLY_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_VAULT_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_BATTLEPET_SOURCE_TEXT"] = ""
--	L["CONFIG_SYSTEM_TOOLTIP_BATTLEPET_DESCRIPTION_TEXT"] = ""
	
	L["CONFIG_SYSTEM_BUGFIX"] = "Corriger/Contourner le bogue"
	L["CONFIG_SYSTEM_BUGFIX_TEXT"] = "Activer le code pour corriger ou contourner ce problème"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL"] = "FrameLevel"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_TEXT"] = "Un bogue dans l'API CreateFrame de Blizzard peut faire apparaitre le fond des cadres devant l'avant-plan, les fenêtres d'aide des objets n'apparaissent pas et il est impossible de cliquer sur quelque chose dans la fenêtre."
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_TEXT"] = "Définir comment sont afficher les alertes de la correction du bogue de FrameLevel"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE0"] = "Désactivée"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE0_TEXT"] = "Les alertes de la correction du bogue ne seront pas affichées"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE1"] = "Courte"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE1_TEXT"] = "Afficher un court texte des alertes de la correction du bogue"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE2"] = "Complète"
	L["CONFIG_SYSTEM_BUGFIX_FRAMELEVEL_ALERT_STYLE2_TEXT"] = "Afficher le texte complet des alertes de la correction du bogue"
--	L["CONFIG_SYSTEM_BUGFIX_ZEROSIZEBAG"] = ""
--	L["CONFIG_SYSTEM_BUGFIX_ZEROSIZEBAG_TEXT"] = ""
--	L["CONFIG_SYSTEM_BUGFIX_ZEROSIZEBAG_ALERT_TEXT"] = ""
--	L["BUGFIX_TAINTED_ALERT_MOUSEOVER_TEXT"] = ""
--	L["BUGFIX_TAINTED_ALERT_OPEN_TEXT"] = ""
	
--	L["CONFIG_SYSTEM_MESSAGES"] = ""
--	L["CONFIG_SYSTEM_MESSAGES_TRANSLATION"] = ""
--	L["CONFIG_SYSTEM_MESSAGES_TRANSLATION_INTERIM"] = ""
--	L["CONFIG_SYSTEM_MESSAGES_TRANSLATION_INTERIM_TEXT"] = ""
--	L["CONFIG_SYSTEM_MESSAGES_TRANSLATION_FINAL"] = ""
--	L["CONFIG_SYSTEM_MESSAGES_TRANSLATION_FINAL_TEXT"] = ""
	
	
--	configuration options > auto
	L["CONFIG_AUTO"] = "Ouvrir/Fermer automatique"
	
	L["CONFIG_AUTO_OPEN"] = "Ouvre le %2$s %1$s quand vous ouvrez %3$s"
	L["CONFIG_AUTO_OPEN_BANK"] = "la banque"
	L["CONFIG_AUTO_OPEN_VAULT"] = "la banque de guilde"
	L["CONFIG_AUTO_OPEN_MAIL"] = "une boîte aux lettres"
	L["CONFIG_AUTO_OPEN_MERCHANT"] = "un marchand/vendeur"
	L["CONFIG_AUTO_OPEN_TRADE"] = "la fenêtre d'échange"
	L["CONFIG_AUTO_OPEN_AUCTION"] = "un hotel des ventes"
	
	L["CONFIG_AUTO_CLOSE"] = "Fermer le %2$s %1$s quand vous fermez %3$s"
	L["CONFIG_AUTO_CLOSE_BANK"] = "la banque"
	L["CONFIG_AUTO_CLOSE_VAULT"] = "la banque de guilde"
	L["CONFIG_AUTO_CLOSE_MAIL"] = "une boîte aux lettres"
	L["CONFIG_AUTO_CLOSE_MERCHANT"] = "un marchand/vendeur"
	L["CONFIG_AUTO_CLOSE_TRADE"] = "la fenêtre d'échange"
	L["CONFIG_AUTO_CLOSE_AUCTION"] = "un hotel des ventes"
	L["CONFIG_AUTO_CLOSE_COMBAT"] = "entrez en combat"
	
	
--	configuration options > control
	L["CONFIG_CONTROL"] = "Contrôle"
	
	L["CONFIG_CONTROL_MONITOR"] = "Surveiller"
	L["CONFIG_CONTROL_MONITOR_TEXT"] = "Surveiller les changements dans les données de %1$s pour le personnage (%2$s)"
	L["CONFIG_CONTROL_SAVE_TEXT"] = "Sauver les données de %1$s pour le personnage (%2$s) pour que vous puissiez le voir depuis un autre personnage"
--	L["CONFIG_CONTROL_NOTIFY_ERASE"] = ""
--	L["CONFIG_CONTROL_NOTIFY_ERASE_TEXT"] = ""
	L["CONFIG_CONTROL_OVERRIDE"] = "Remplacer"
	L["CONFIG_CONTROL_OVERRIDE_TEXT"] = "Remplacer le %2$s original de Blizzard pour qu'%1$s le contrôle\n\nDésactiver cette option vous fera revenir aux fonctionnalitées de %2$s standards de Blizzard\n\nIl sera toujours possible d'ouvrir le %2$s d'%1$s quand cette option est désactivée mais vous devrez configurer et utiliser une combinaison de touche à la place"
	L["CONFIG_CONTROL_ANCHOR_LOCK_TEXT"] = "Vérrouiller la fenêtre %1$s pour qu'elle ne puisse plus être déplacée"
--	L["CONFIG_CONTROL_REPOSITION_NOW"] = ""
--	L["CONFIG_CONTROL_REPOSITION_NOW_TEXT"] = ""
--	L["CONFIG_CONTROL_REPOSITION_ONLOAD"] = ""
--	L["CONFIG_CONTROL_REPOSITION_ONLOAD_TEXT"] = ""
	L["CONFIG_CONTROL_SETTINGS_TEXT"] = "Sélectionner quels paramètres utiliser lors de la génération de la fenêtre %1$s"
	
	
--	configuration options > settings
	L["CONFIG_SETTINGS"] = "Paramètres"
	
	L["CONFIG_SETTINGS_FRAME"] = "Fenêtre"
	
--	L["CONFIG_SETTINGS_FRAME_HIDE_TEXT"] = ""
	
	L["CONFIG_SETTINGS_FRAME_SCALE_TEXT"] = "Définir l'échelle. Agrandie ou diminue la taille de la fenêtre"
	L["CONFIG_SETTINGS_FRAME_PADDING_TEXT"] = "Définir l'espace entre le bord de la fenêtre et les groupes"
	L["CONFIG_SETTINGS_FRAME_WIDTH_TEXT"] = "Définir le nombre maximum d'objets à afficher sur une ligne"
	L["CONFIG_SETTINGS_FRAME_BACKGROUND_COLOUR_TEXT"] = "Définir la couleur de fond de la fenêtre principale"
	L["CONFIG_SETTINGS_FRAME_BORDER_SHOW_TEXT"] = "Afficher une bordure autour de la fenêtre principale"
	L["CONFIG_SETTINGS_FRAME_BORDER_STYLE_TEXT"] = "Définir le style de la bordure de la fenêtre principale"
	L["CONFIG_SETTINGS_FRAME_BORDER_COLOUR_TEXT"] = "Définir la couleur de la bordure de la fenêtre principale"
	
	L["CONFIG_SETTINGS_FRAME_CHANGER_HIGHLIGHT"] = "Couleur de surbrillance du sac"
--	L["CONFIG_SETTINGS_FRAME_CHANGER_HIGHLIGHT_TEXT"] = ""
	L["CONFIG_SETTINGS_FRAME_CHANGER_HIGHLIGHT_COLOUR_TEXT"] = "Définir la couleur utilisée pour mettre en surbrillance les emplacements quand la souris passe sur un sac"
	L["CONFIG_SETTINGS_FRAME_CHANGER_FREE"] = "Compteur d'emplacement vide"
	L["CONFIG_SETTINGS_FRAME_CHANGER_FREE_TEXT"] = "Montrer le compteur d'emplacements vides sur les sacs"
	L["CONFIG_SETTINGS_FRAME_CHANGER_FREE_COLOUR_TEXT"] = "Définir la couleur du texte du compteur d'emplacements vides"
	
--	L["CONFIG_SETTINGS_FRAME_STATUS_EMPTY"] = ""
--	L["CONFIG_SETTINGS_FRAME_STATUS_EMPTY_TEXT"] = ""
	
--	L["CONFIG_SETTINGS_FRAME_TITLE_SIZE_NORMAL"] = ""
--	L["CONFIG_SETTINGS_FRAME_TITLE_SIZE_THIN"] = ""
	
	L["CONFIG_SETTINGS_BARS"] = "Groupes"
	L["CONFIG_SETTINGS_BARS_PER_ROW"] = "Nombre par Ligne"
	L["CONFIG_SETTINGS_BARS_PER_ROW_TEXT"] = "Définir le nombre de groupes à afficher pour chaque ligne"
	L["CONFIG_SETTINGS_BARS_BACKGROUND_TEXT"] = "Définir la couleur de fond des groupes"
	L["CONFIG_SETTINGS_BARS_COMPACT"] = "Compacte"
	L["CONFIG_SETTINGS_BARS_COMPACT_TEXT"] = "Afficher tous les groupes non vides par ordre séquentiel"
	L["CONFIG_SETTINGS_BARS_SHOW_EMPTY"] = "Afficher quand vides"
	L["CONFIG_SETTINGS_BARS_SHOW_EMPTY_TEXT"] = "Afficher les groupes vides"
	L["CONFIG_SETTINGS_BARS_PADDING_INTERNAL_TEXT"] = "Définir l'espace entre le groupe et les objets"
	L["CONFIG_SETTINGS_BARS_PADDING_EXTERNAL_TEXT"] = "Définir l'espace entre les groupes"
	L["CONFIG_SETTINGS_BARS_BORDER_TEXT"] = "Afficher une bordure autour de chaque groupe"
	L["CONFIG_SETTINGS_BARS_BORDER_STYLE_TEXT"] = "Définir le style de bordure des groupes"
	L["CONFIG_SETTINGS_BARS_BORDER_COLOUR_TEXT"] = "Définir la couleur de la bordure des groupes"
	L["CONFIG_SETTINGS_BARS_NAME_TEXT"] = "Définir le nom de ce groupe"
	L["CONFIG_SETTINGS_BARS_NAME_SHOW_TEXT"] = "Afficher le nom des groupes"
	L["CONFIG_SETTINGS_BARS_NAME_COLOUR_TEXT"] = "Définir la couleur du nom de groupe"
--	L["CONFIG_SETTINGS_BARS_NAME_HEIGHT_TEXT"] = ""
--	L["CONFIG_SETTINGS_BARS_NAME_ANCHOR_TEXT"] = ""
	
	L["CONFIG_SETTINGS_ITEMS"] = "Objets"
	L["CONFIG_SETTINGS_ITEMS_PADDING_TEXT"] = "Définir le nombre d'espace entre les emplacements d'objet"
	L["CONFIG_SETTINGS_ITEMS_HIDDEN"] = "Montrer caché"
	L["CONFIG_SETTINGS_ITEMS_HIDDEN_TEXT"] = "Montrer les catégories cachées"
	L["CONFIG_SETTINGS_ITEMS_FADE"] = "Assombrir inaccessible"
	L["CONFIG_SETTINGS_ITEMS_FADE_TEXT"] = "Assombrir les objets inaccessibles"
	L["CONFIG_SETTINGS_ITEMS_TINT_USABLE"] = "Teinter inutilisable"
	L["CONFIG_SETTINGS_ITEMS_TINT_USABLE_TEXT"] = "Teinter les objets inutilisables en rouge"
	L["CONFIG_SETTINGS_ITEMS_BORDER_SHOW_TEXT"] = "Montrer une bordure autour des objets"
	L["CONFIG_SETTINGS_ITEMS_BORDER_STYLE_TEXT"] = "Définir le style de bordure des objets"
	L["CONFIG_SETTINGS_ITEMS_BORDER_RARITY"] = "Couleur de rareté"
	L["CONFIG_SETTINGS_ITEMS_BORDER_RARITY_TEXT"] = "Colorer la bordure des objets en fonction de leurs raretés (Commun, Rare, Epique, etc)"
--	L["CONFIG_SETTINGS_ITEMS_BORDER_RARITY_CUTOFF"] = ""
--	L["CONFIG_SETTINGS_ITEMS_BORDER_RARITY_CUTOFF_TEXT"] = ""
	L["CONFIG_SETTINGS_ITEMS_BORDER_TEXTURE_OFFSET_TEXT"] = "Définir le nombre de pixels entre le bord extérieur des images et l'intérieur de la bordure (Utiliser pour réaligner la bordure sur la texture des objets)"
	L["CONFIG_SETTINGS_ITEMS_AGE"] = "Nouveaux objets"
	L["CONFIG_SETTINGS_ITEMS_AGE_SHOW_TEXT"] = "Basculer l'afficher de l'indicateur de nouvel objet pour la fenêtre de %s"
	L["CONFIG_SETTINGS_ITEMS_AGE_COLOUR_TEXT"] = "Définir la couleur de texte de l'indicateur de nouveaux objets"
--	L["CONFIG_SETTINGS_ITEMS_AGE_CUTOFF"] = ""
--	L["CONFIG_SETTINGS_ITEMS_AGE_CUTOFF_TEXT"] = ""
	L["CONFIG_SETTINGS_ITEMS_AGE_RESET_TEXT"] = "Effacer le status nouvel objet pour tous les objets de cette emplacement"
--	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_SHOW_TEXT"] = ""
--	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_GLOBAL"] = ""
--	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_GLOBAL_TEXT"] = ""
--	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_COMBAT"] = ""
--	L["CONFIG_SETTINGS_ITEMS_COOLDOWN_COMBAT_TEXT"] = ""
	
	L["CONFIG_SETTINGS_SORTING_OPEN"] = "Ouverture de la fenêtre"
	L["CONFIG_SETTINGS_SORTING_OPEN_TEXT"] = "Activer pour faire un tri à l'ouverture de la fenêtre"
	L["CONFIG_SETTINGS_SORTING_INSTANT"] = "Instantané"
	L["CONFIG_SETTINGS_SORTING_INSTANT_TEXT"] = "Activer le mode de tri instantané\n\nActiver : fait un tri dès que quelque chose change\n\nDésactiver : le tri est fait seulement à l'ouverture de la fenêtre ou quand vous faites un réactualiser"
	
	L["CONFIG_SETTINGS_EMPTY"] = "Emplacements vide"
	L["CONFIG_SETTINGS_EMPTY_ICON"] = "Utiliser icône"
	L["CONFIG_SETTINGS_EMPTY_ICON_TEXT"] = "Utiliser une icône comme fond des emplacements vides"
	L["CONFIG_SETTINGS_EMPTY_CLUMP"] = "Remplir"
	L["CONFIG_SETTINGS_EMPTY_CLUMP_TEXT"] = "Remplir les emplacements vides avec la couleur des emplacements non vide"
	L["CONFIG_SETTINGS_EMPTY_BORDER"] = "Bordures colorées"
	L["CONFIG_SETTINGS_EMPTY_BORDER_TEXT"] = "Colorer la bordure des emplacements vides avec la couleur du type de sac"
	L["CONFIG_SETTINGS_EMPTY_COLOUR"] = "Couleurs d'emplacement"
	L["CONFIG_SETTINGS_EMPTY_COLOUR_TEXT"] = "Définir la couleur de bordure et de fond des emplacements %1$s"
--	L["CONFIG_SETTINGS_EMPTY_STATUS"] = ""
	
	
-- sorting
--	L["CONFIG_SORTMETHOD"] = ""
	
	L["CONFIG_SORTMETHOD_SORT"] = "Tri"
	
	L["CONFIG_SORTMETHOD_STYLE_BAGSLOT"] = "Sac / Emplacement"
	L["CONFIG_SORTMETHOD_STYLE_BAGSLOT_TEXT"] = "Trier vos objets par sac et numéro d'emplacement"
	L["CONFIG_SORTMETHOD_STYLE_USER"] = "Défini par l'utilisateur"
	L["CONFIG_SORTMETHOD_STYLE_USER_TEXT"] = "Trier vos objets selon l'odre que vous avez défini"
	L["CONFIG_SORTMETHOD_STYLE_TEXT"] = "Choisir comment vous voulez trier vos objets"
	
	L["CONFIG_SORTMETHOD_INCLUDE_NAME"] = "Nom d'objet"
	L["CONFIG_SORTMETHOD_INCLUDE_NAME_TEXT"] = "Inclure le nom de l'objet dans le tri de l'inventaire"
	L["CONFIG_SORTMETHOD_INCLUDE_NAME_REVERSE"] = "Ordre inversé des noms"
	L["CONFIG_SORTMETHOD_INCLUDE_NAME_REVERSE_TEXT"] = "Utiliser l'ordre inverser des noms pour trier l'inventaire.\n\nex. Potion de Soins Majeure devient Majeure Soins de Potion"
	L["CONFIG_SORTMETHOD_INCLUDE_QUALITY"] = "Rareté des objets"
	L["CONFIG_SORTMETHOD_INCLUDE_QUALITY_TEXT"] = "Inclure la rareté des objets pour trier l'inventaire"
	L["CONFIG_SORTMETHOD_INCLUDE_LOCATION"] = "Localisation d'équipement"
	L["CONFIG_SORTMETHOD_INCLUDE_LOCATION_TEXT"] = "Inclure l'emplacement d'équipement des objets pour trier l'inventaire.\n\nNote : Affecte seulement les objets qui peuvent être équiper"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMTYPE"] = "Type et sous-type d'objet"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMTYPE_TEXT"] = "Inclure les type et sous-type des objets pour trier l'inventaire"
	L["CONFIG_SORTMETHOD_INCLUDE_CATEGORY"] = "Catégorie d'objet"
	L["CONFIG_SORTMETHOD_INCLUDE_CATEGORY_TEXT"] = "Inclure la catégorie des objets pour trier l'inventaire"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMUSELEVEL"] = "Niveau utilisable d'objet"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMUSELEVEL_TEXT"] = "Inclure le niveau utilisable des objets pour trier l'inventaire"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMSTATLEVEL"] = "Niveau statistique d'objet"
	L["CONFIG_SORTMETHOD_INCLUDE_ITEMSTATLEVEL_TEXT"] = "Inclure le niveau statistique des objets pour trier l'inventaire"
--	L["CONFIG_SORTMETHOD_INCLUDE_ITEMAGE"] = ""
--	L["CONFIG_SORTMETHOD_INCLUDE_ITEMAGE_TEXT"] = ""
	L["CONFIG_SORTMETHOD_INCLUDE_VENDORPRICE"] = "Prix du vendeur"
	L["CONFIG_SORTMETHOD_INCLUDE_VENDORPRICE_TEXT"] = "inclure le prix des vendeurs (par taille de pile) pour trier l'inventaire"
	
	L["CONFIG_SORTMETHOD_DIRECTION_TEXT"] = "Définir dans quel sens vous voulez trier vos objets"
	L["CONFIG_SORTMETHOD_ORDER"] = "Ordre de tri"
	L["CONFIG_SORTMETHOD_MOVE_UP_TEXT"] = "Déplacer %1$s vers le haut dans l'ordre de tri"
	L["CONFIG_SORTMETHOD_MOVE_DOWN_TEXT"] = "Déplacer %1$s vers le bas dans l'ordre de tri"
	L["CONFIG_SORTMETHOD_NOT_INCLUDED"] = "* Pas inclus actuellement dans le tri *"
	
--	L["CONFIG_SORTMETHOD_ADD"] = ""
--	L["CONFIG_SORTMETHOD_ADD_TEXT"] = ""
--	L["CONFIG_SORTMETHOD_RENAME_TEXT"] = ""
--	L["CONFIG_SORTMETHOD_DELETE_TEXT"] = ""
	
	
--	rules
	L["CONFIG_RULES"] = "Règles"
	L["CONFIG_RULES_SHOWDISABLED"] = "Afficher les règles désactivées"
	L["CONFIG_RULES_SHOWDISABLED_TEXT"] = "Basculer vers l'affichage des règles désactivées"
	
	
--	configuration options > categories
	L["CONFIG_CATEGORY"] = "Catégories"
	
	L["CONFIG_CATEGORY_CUSTOM"] = "Catégories personnelles"
--	L["CONFIG_CATEGORY_DELETED"] = ""
	
--	L["CONFIG_CATEGORY_ADD"] = ""
--	L["CONFIG_CATEGORY_ADD_TEXT"] = ""
--	L["CONFIG_CATEGORY_RENAME_TEXT"] = ""
--	L["CONFIG_CATEGORY_DELETE_TEXT"] = ""
	
	
--	configuration options > debug
	L["CONFIG_DEBUG"] = "Mode de déboguage"
	L["CONFIG_DEBUG_TEXT"] = "Activer le mode de déboguage"
	
	
--	configuration options > generic
--	L["BORDER_SCALE_TEXT"] = ""
	L["BORDER_TEXTURE_TEXT"] = "Options de texture de bordure"
	L["BORDER_TEXTURE_FILE_TEXT"] = "La texture à utiliser pour la bordure"
	L["BORDER_TEXTURE_HEIGHT_TEXT"] = "La hauteur (en pixels) de la texture"
	
	
--	rules frame
	L["RULE"] = "Règle"
	L["RULE_HIDDEN"] = "Caché"
	L["RULE_FORMULA"] = "Formule"
	L["RULE_LIST_ENABLED"] = "Utilisé"
	L["RULE_LIST_DAMAGED"] = "Emdommagé"
	L["RULE_LIST_ID"] = "Règle"
	
	L["RULE_DAMAGED"] = "La règle %s est marquée comme emdommagée et ne sera plus utilisée avant d'être réparée"
--	L["RULE_FAILED"] = ""
	L["RULE_FAILED_KEY_NIL"] = "La clé passé est vide"
	L["RULE_FAILED_DATA_NIL"] = "La donné passé est vide"
	L["RULE_FAILED_DESCRIPTION_NIL"] = "La description est manquante"
	L["RULE_FAILED_FORMULA_NIL"] = "La formule est manquante"
--	L["RULE_FAILED_FORMULA_BAD"] = ""
--	L["RULE_FAILED_ARGUMENT_IS_NIL"] = ""
--	L["RULE_FAILED_ARGUMENT_IS_INVALID"] = ""
--	L["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"] = ""
	
	
--	new item indicators
--	L["NEW_ITEM_INCREASE"] = ""
--	L["NEW_ITEM_DECREASE"] = ""
	
	
--	slash commands
--	L["SLASH_UI"] = ""
	L["SLASH_UI_TEXT"] = "Option d'interface."
--	L["SLASH_UI_RESET"] = ""
	L["SLASH_UI_RESET_TEXT"] = "Centre l'interface à l'écran."
	L["SLASH_UI_RESET_COMPLETE_TEXT"] = "Toutes les fenêtres sont centrées à l'écran."
--	L["SLASH_DB"] = ""
	L["SLASH_DB_TEXT"] = "Options de base de données."
--	L["SLASH_DB_RESET"] = ""
	L["SLASH_DB_RESET_TEXT"] = "Remet toutes les options à défaut."
--	L["SLASH_DB_RESET_CONFIRM"] = ""
	L["SLASH_DB_RESET_CONFIRM_TEXT"] = "Confirme la remise à zéro des options."
	L["SLASH_DB_RESET_COMPLETE_TEXT"] = "Le profile a été remis à zéro. Toutes les options ont été remises à zéro."
--	L["SLASH_CACHE"] = ""
	L["SLASH_CACHE_TEXT"] = "Options de cache"
--	L["SLASH_CACHE_ERASE"] = ""
	L["SLASH_CACHE_ERASE_TEXT"] = "Efface toutes les données du cache."
--	L["SLASH_CACHE_ERASE_CONFIRM"] = ""
	L["SLASH_CACHE_ERASE_CONFIRM_TEXT"] = "Confirme l'effacement des données du cache."
	L["SLASH_CACHE_ERASE_COMPLETE_TEXT"] = "Toutes les données de tous les personnages ont été effacées."
--	L["SLASH_MISC"] = ""
	L["SLASH_MISC_TEXT"] = "Options diverses."
--	L["SLASH_TRACK"] = ""
--	L["SLASH_TRACK_TEXT"] = ""
	
	
--	misc chat stuff
	L["UPGRADE_PROFILE"] = "Mise à jour des données de profile pour [%1$s] vers v%2$d"
	L["UPGRADE_GLOBAL"] = "Mise à jour global des données de %1$s vers v%2$d"
--	L["UPGRADE_CHAR"] = ""
	
	L["MISC_ALERT"] = "Alerte !"
	L["MISC_ALERT_FRAMELEVEL_1"] = "Correction de bogue complète"
	L["MISC_ALERT_FRAMELEVEL_2"] = "Le FrameLevel pour la fenêtre %1$s est actuellement a %2$s et a été réinitialisé a %3$s pour être sur qu'il reste fonctionnel. Désolé pour le temps pris pour la correction de ce bogue."
	
	
--	item count tooltip
--	L["TOOLTIP_COUNT_ME"] = ""
--	L["TOOLTIP_VAULT_TABS"] = ""
	
	
--	generic text
--	L["AUTOMATIC"] = ""
	L["BOTTOMLEFT"] = "Bas Gauche"
	L["BOTTOMRIGHT"] = "Bas Droite"
	L["TOPLEFT"] = "Haut Gauche"
	L["TOPRIGHT"] = "Haut Droite"
--	L["TOP"] = ""
--	L["BOTTOM"] = ""
--	L["LEFT"] = ""
--	L["RIGHT"] = ""
--	L["HORIZONTAL"] = ""
--	L["VERTICAL"] = ""
	L["CLOSE_MENU"] = "Fermer Menu"
	L["ANCHOR"] = "Point d'ancrage"
	L["ANCHOR_TEXT1"] = "Définir le point d'ancrage pour la fenêtre %1$s"
	L["ANCHOR_TEXT2"] = "Définir le point d'ancrage pour %1$s"
	L["BORDER_TEXT"] = "Options de bordures"
	L["SHOW"] = "Montrer"
	L["FILE"] = "Fichier"
	L["HEIGHT"] = "Hauteur"
	L["SCALE"] = "Echelle"
--	L["TEXTURE"] = ""
	L["FONT"] = "Police de caractères"
	L["BACKGROUND_COLOUR"] = "Couleur de fond"
--	L["STYLE"] = ""
	L["ENABLED"] = "Activer"
	L["ALERT"] = "Alerte"
	L["PADDING"] = "Contour"
	L["INTERNAL"] = "Interne"
	L["EXTERNAL"] = "Externe"
	L["WIDTH"] = "Largeur"
	L["REALM"] = "Serveur"
	L["VIEW"] = "Voir"
	L["EDIT"] = "Editer"
	L["DIRECTION"] = "Sens"
	L["ASCENDING"] = "Ascendant"
	L["DECENDING"] = "Descendant"
	L["LOCATION"] = "Emplacement"
	L["CLEAR"] = "Nettoyer"
--	L["DHMS"] = ""
--	L["OPEN"] = ""
--	L["RANDOM"] = ""
--	L["RELOAD"] = ""
	L["MOVE_UP"] = "Déplacer vers le haut"
	L["MOVE_DOWN"] = "Déplacer vers le bas"
--	L["SORT_METHOD"] = ""
--	L["SORT_BY_NAME"] = ""
--	L["SORT_BY_NUMBER"] = ""
	L["HIDE"] = "Cacher"
--	L["MOVE"] = ""
	L["INSERT"] = "Ajouter un groupe vide"
	L["CURRENT"] = "actuel"
	L["OFFSET"] = "Décallage"
--	L["NUMBER"] = ""
--	L["STRING"] = ""
--	L["COOLDOWN"] = ""
--	L["FRAMES"] = ""
--	L["CLICK_TO_SELECT"] = ""
--	L["CLICK_TO_DESELECT"] = ""
--	L["CLICK_TO_IGNORE"] = ""	
	L["ORDER"] = "Ordre"
	
	
-- libdatabroker
--	L["LDB"] = ""
--	L["LDB_BAGS_COLOUR_USE"] = ""
--	L["LDB_BAGS_COLOUR_USE_TEXT"] = ""
--	L["LDB_BAGS_STYLE"] = ""
--	L["LDB_BAGS_STYLE_TEXT"] = ""
--	L["LDB_BAGS_INCLUDE_TYPE"] = ""
--	L["LDB_BAGS_INCLUDE_TYPE_TEXT"] = ""
--	L["LDB_TRACKING_CURRENCY"] = ""
--	L["LDB_PETS_SUMMON"] = ""
--	L["LDB_MOUNTS_NOT_HERE"] = ""
--	L["LDB_MOUNTS_GROUND"] = ""
--	L["LDB_MOUNTS_FLYING_DISMOUNT"] = ""
--	L["LDB_MOUNTS_FLYING_DISMOUNT_TEXT"] = ""
--	L["LDB_MOUNTS_FLYING_DISMOUNT_WARNING"] = ""
--	L["LDB_MOUNTS_SUMMON"] = ""
--	L["LDB_MOUNTS_NODATA"] = ""
--	L["LDB_MOUNTS_TOOLTIP_MODE"] = ""
--	L["LDB_MOUNTS_TOOLTIP_SELECTION"] = ""
--	L["LDB_COMPANION_MISSING"] = ""
--	L["LDB_COMPANION_NONE"] = ""
--	L["LDB_COMPANION_RESTRICTED"] = ""
--	L["LDB_COMPANION_RESTRICTED_ZONE"] = ""
--	L["LDB_COMPANION_RESTRICTED_ITEM"] = ""
--	L["LDB_COMPANION_RESTRICTED_EVENT"] = ""
--	L["LDB_COMPANION_RESTRICTED_UNKNOWN"] = ""
--	L["LDB_COMPANION_NODATA"] = ""
--	L["LDB_COMPANION_NODATA_TEXT"] = ""
--	L["LDB_COMPANION_SELECT"] = ""
--	L["LDB_COMPANION_DESELECT"] = ""
--	L["LDB_COMPANION_IGNORE"] = ""
