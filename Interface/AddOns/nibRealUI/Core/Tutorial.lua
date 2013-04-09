local nibRealUI = LibStub("AceAddon-3.0"):GetAddon("nibRealUI")

local loc = GetLocale()

local ToolTipColors = {"|cFFFF8000", "|cFFFFAE5E", "|cFFFFFFFF", "|cFF909090", "|cFFE0E0E0", "|cFF00D8FF"}
local ButtonTexts, ToolTipStrings, ToolTipTexts

---- Localizations
--[[Notes:

When editing Localizations, make sure not to touch any of the 'codes'
Codes:  |r  \n  |cff######

To test changes, first reload the ui (/rl) then reactive the tutorial (/run TestTutorial())

]]--

-- loc = "deDE"

if loc == "deDE" then	-- Deutsch
	ButtonTexts = {
		tutorial = "Führung",
		skip = "übergehen",
		finished = "fertig",
	}
	ToolTipStrings = {
		mouseover =			ToolTipColors[4].."(wird bei Mouseover angezeigt)|r",
		endbox =			ToolTipColors[2].."Kästchen am Ende:|r\n"..ToolTipColors[3].."Klasse/Feindseligkeit eingefärbt|r",
		statusindicators =	ToolTipColors[2].."Statusanzeigen:|r\n|cff00FF00Ausruhen|r\n|cffFFFF00AFK|r\n|cffFF0000Im Kampf|r\n|cff00FFFFAnführer|r",
		statustexts =		ToolTipColors[2].."Statustexte:|r\n"..ToolTipColors[3].."P = PvP\nE = Elite\n? = Boss\nR = Rar Elite\nr = Rar|r",
		setfocus =			ToolTipColors[6].."Shift+Click|r"..ToolTipColors[5].." als Fokus setzen.",
		ufconfig =			ToolTipColors[5].."Schreibe "..ToolTipColors[6].."/hud|r "..ToolTipColors[5].."zum Neupositionieren und "..ToolTipColors[6].."/realui|r "..ToolTipColors[5].."um Einstellungen zu ändern.|r",
		abconfig =			ToolTipColors[5].."Schreibe "..ToolTipColors[6].."/bar|r "..ToolTipColors[5].."zum konfigurieren.|r",
		buffconfig =		ToolTipColors[5].."Schreibe "..ToolTipColors[6].."/raven|r "..ToolTipColors[5].."zum konfigurieren.|r",
	}
	ToolTipTexts = {
		minimap =			ToolTipColors[1].."Minimap|r\n\n"..ToolTipColors[2].."Unten links: |r"..ToolTipColors[3].."Koordinaten|r\n"..ToolTipColors[2].."Unten rechts: |r"..ToolTipColors[3].."Feindseligkeit der Zone|r\n"..ToolTipColors[2].."Oben: |r"..ToolTipColors[3].."Steuerung |r"..ToolTipColors[4].."(mouseover)|r\n"..ToolTipColors[2].."Darunter: |r"..ToolTipColors[3].."Minimap Buttons |r"..ToolTipColors[4].."(mouseover)|r",
		buffs =				ToolTipColors[1].."Spieler-Buffs - Langzeit|r\n\n"..ToolTipColors[3].."Zeigt die Buffs des Spieler mit einer Dauer von > 1 Minute.|r\n\n"..ToolTipStrings.buffconfig,
		playerframe =		ToolTipColors[1].."Spieler-Frame|r\n\n"..ToolTipColors[2].."Kästchen am Ende:|r\n"..ToolTipColors[3].."Wird zum Pet- oder Fahrzeug-Frame wenn Du ein Pet hast oder in einem Fahrzeug bist.|r\n"..ToolTipColors[4].."(eingefärbt nach Klasse)|r\n\n"..ToolTipStrings.statusindicators.."\n\n"..ToolTipColors[2].."Statustexte:|r\n"..ToolTipColors[3].."P = PvP|r\n\n"..ToolTipStrings.setfocus.."\n\n"..ToolTipStrings.ufconfig,
		targetframe =		ToolTipColors[1].."Ziel-Frame|r\n\n"..ToolTipStrings.endbox.."\n\n"..ToolTipStrings.statusindicators.."\n\n"..ToolTipStrings.statustexts.."\n\n"..ToolTipStrings.setfocus.."\n\n"..ToolTipStrings.ufconfig,
		focusframes =		ToolTipColors[1].."Fokus/Fokusziel-Frames|r\n\n"..ToolTipStrings.endbox.."\n\n"..ToolTipStrings.statusindicators.."\n\n"..ToolTipStrings.statustexts.."\n\n"..ToolTipStrings.ufconfig,
		totframe =			ToolTipColors[1].."Ziel des Ziels-Frame|r\n\n"..ToolTipStrings.endbox.."\n\n"..ToolTipStrings.statusindicators.."\n\n"..ToolTipStrings.statustexts.."\n\n"..ToolTipStrings.setfocus.."\n\n"..ToolTipStrings.ufconfig,
		playerbuffs =		ToolTipColors[1].."Spieler-Buffs - Kurzzeit|r\n\n"..ToolTipColors[3].."Zeigt die Buffs des Spieler mit einer Dauer von <= 1 Minute.|r\n\n"..ToolTipStrings.buffconfig,
		playerdebuffs =		ToolTipColors[1].."Spieler-Debuffs|r\n\n"..ToolTipColors[3].."Zeigt alle Debuffs des Spieler.|r\n\n"..ToolTipStrings.buffconfig,
		targetbuffs =		ToolTipColors[1].."Ziel-Buffs|r\n\n"..ToolTipColors[3].."Zeigt Buffs auf dem Ziel.\n\n"..ToolTipColors[2].."Kriterien:\n"..ToolTipColors[3].."Cast durch den Spieler\nKann vom Spieler gecastet werden\nKann vom Spieler gestohlen werden\nCast durch ein Fahreug\nCast durch einen NPC\nDurch das Ziel gecastete Buffs mit unbegrenzter Dauer\n\nZeigt alle Buffs des Ziels in einem BG oder einer Arena.|r\n\n"..ToolTipStrings.buffconfig,
		targetdebuffs =		ToolTipColors[1].."Ziel-Debuffs|r\n\n"..ToolTipColors[3].."Displays Debuffs on your Target.\n\n"..ToolTipColors[2].."Critera:\n"..ToolTipColors[3].."Cast durch den Spieler\nKann vom Spieler gecastet werden\nKann vom Spieler dispelled werden\nCast durch ein Fahreug\nCast durch einen NPC|r\n\n"..ToolTipStrings.buffconfig,
		focusbuffs =		ToolTipColors[1].."Fokus-Buffs|r\n\n"..ToolTipColors[3].."Displays Buffs on your Focus target.\n\n"..ToolTipColors[2].."Critera:\n"..ToolTipColors[3].."Cast durch den Spieler\nKann vom Spieler gestohlen werden\nCast durch ein Fahreug\nCast durch einen NPC|r\n\n"..ToolTipStrings.buffconfig,
		totdebuffs =		ToolTipColors[1].."Ziel des Ziels-Debuffs|r\n\n"..ToolTipColors[3].."Displays Debuffs on your Target's Target.\n\n"..ToolTipColors[2].."Critera:\n"..ToolTipColors[3].."Cast durch den Spieler\nKann vom Spieler gecastet werden\nKann vom Spieler dispelled werden\nCast durch ein Fahreug\nCast durch einen NPC|r\n\n"..ToolTipStrings.buffconfig,
		actionbars =		ToolTipColors[1].."Primäre Aktionsleiste|r\n\n"..ToolTipColors[2].."Leisten:|r\n"..ToolTipColors[3].."Haltungsleiste|r\n"..ToolTipColors[3].."Leisten 1, 2, 3|r "..ToolTipColors[4].."(Hohe Aufl.)|r\n"..ToolTipColors[3].."Begleiterleiste|r\n\n"..ToolTipColors[2].."Sichtbarkeitsbedingungen:|r\n"..ToolTipColors[3].."Strg-Taste gedrückt\nFokus gesetzt\nAngreifbares Ziel ausgewählt\nIm Kampf\nIn einer Gruppe|r\n\n"..ToolTipStrings.abconfig,
		moactionbars1a =	ToolTipColors[1].."Sekundäre Aktionsleiste 1|r\n"..ToolTipStrings.mouseover.."\n\n"..ToolTipColors[2].."Leisten:|r\n"..ToolTipColors[3].."Leiste 4|r",
		moactionbars1b =	ToolTipColors[1].."Sekundäre Aktionsleiste 2|r\n"..ToolTipStrings.mouseover.."\n\n"..ToolTipColors[2].."Leisten:|r\n"..ToolTipColors[3].."Leiste 5|r",
		moactionbars2 =		ToolTipColors[1].."Sekundäre Aktionsleisten|r\n"..ToolTipStrings.mouseover.."\n\n"..ToolTipColors[2].."Leisten:|r\n"..ToolTipColors[3].."Leiste 4, 5|r",
		infolineright =		ToolTipColors[1].."Infozeile - Rechts|r\n\n"..ToolTipColors[2].."Elemente:|r\n"..ToolTipColors[3].."Uhr\nSchalter für Damage-Meter\nLayout-Wechsler|r\n|cff909090(DPS/Tank, Heilung, Niedr./Hohe Auflösung)|r\n"..ToolTipColors[3].."Spec-Wechsler, Ausrüst.-Manager\nFPS und Latenz|r",
		infolineleft =		ToolTipColors[1].."Infozeile - Links|r\n\n"..ToolTipColors[2].."Elemente:|r\n"..ToolTipColors[3].."Optionsbutton / Mikromenü\nNeue Mail-Anzeige\nGilde\nFreunde\nHaltbarkeit |r"..ToolTipColors[4].."(< 95%)|r\n"..ToolTipColors[3].."Leere Inventarplätze\nWährung\nXP / Ruf|r",
	}
-- elseif loc == "itIT" then	-- Italiano
	
elseif loc == "frFR" then	-- French
	ButtonTexts = {
		tutorial = "Tutoriel",
		skip = "Passer",
		finished = "Fini",
	}
	ToolTipStrings = {
		mouseover =			ToolTipColors[4].."(S'affiche au passage de la souris)|r",
		endbox =			ToolTipColors[2].."Rectangle à l'extrémité:|r\n"..ToolTipColors[3].."Couleur en fonction de Classe/Hostilité|r",
		statusindicators =	ToolTipColors[2].."Indicateurs de Statut:|r\n|cff00FF00Se Repose|r\n|cffFFFF00AFK|r\n|cffFF0000En Combat|r\n|cff00FFFFChef|r",
		statustexts =		ToolTipColors[2].."Testes de Statut:|r\n"..ToolTipColors[3].."P = PvP\nE = Elite\n? = Boss\nR = Elite Rare\nr = Rare|r",
		setfocus =			ToolTipColors[6].."Shift+Click|r"..ToolTipColors[5].." Pour définir le focus.",
		ufconfig =			ToolTipColors[5].."Taper "..ToolTipColors[6].."/hud|r "..ToolTipColors[5].."pour repositionner et "..ToolTipColors[6].."/realui|r "..ToolTipColors[5].."pour changer les réglages.|r",
		abconfig =			ToolTipColors[5].."Taper "..ToolTipColors[6].."/bar|r "..ToolTipColors[5].."pour configurer.|r",
		buffconfig =		ToolTipColors[5].."Taper "..ToolTipColors[6].."/raven|r "..ToolTipColors[5].."pour configurer.|r",
	}
	ToolTipTexts = {
		minimap =			ToolTipColors[1].."Minicarte|r\n\n"..ToolTipColors[2].."Inférieur Gauche: |r"..ToolTipColors[3].."Coordonnées|r\n"..ToolTipColors[2].."Inférieur Droit: |r"..ToolTipColors[3].."Hostilité de la zone|r\n"..ToolTipColors[2].."Dessus: |r"..ToolTipColors[3].."Contrôles |r"..ToolTipColors[4].."(mouseover)|r\n"..ToolTipColors[2].."En dessous: |r"..ToolTipColors[3].."Boutons de la minicarte |r"..ToolTipColors[4].."(mouseover)|r",
		buffs =				ToolTipColors[1].."Améliorations de Joueurs - Long Terme|r\n\n"..ToolTipColors[3].."Affiche les améliorations sur le joueur ayant une durée  > 1min.|r\n\n"..ToolTipStrings.buffconfig,
		playerframe =		ToolTipColors[1].."Cadre du Joueur|r\n\n"..ToolTipColors[2].."Rectangle à l'extrémité:|r\n"..ToolTipColors[3].."Deviens le cadre du Familier/véhicule Quand vous avez un familier ou êtes dans un véhicule.|r\n"..ToolTipColors[4].."(Prend la couleur de la classe)|r\n\n"..ToolTipStrings.statusindicators.."\n\n"..ToolTipColors[2].."Textes de Statut:|r\n"..ToolTipColors[3].."P = PvP|r\n\n"..ToolTipStrings.setfocus.."\n\n"..ToolTipStrings.ufconfig,
		targetframe =		ToolTipColors[1].."Cadre de le cible|r\n\n"..ToolTipStrings.endbox.."\n\n"..ToolTipStrings.statusindicators.."\n\n"..ToolTipStrings.statustexts.."\n\n"..ToolTipStrings.setfocus.."\n\n"..ToolTipStrings.ufconfig,
		focusframes =		ToolTipColors[1].."Cadres de la Focalisation/Cible de la Focalisation|r\n\n"..ToolTipStrings.endbox.."\n\n"..ToolTipStrings.statusindicators.."\n\n"..ToolTipStrings.statustexts.."\n\n"..ToolTipStrings.ufconfig,
		totframe =			ToolTipColors[1].."Cadre de la Cible de la Cible|r\n\n"..ToolTipStrings.endbox.."\n\n"..ToolTipStrings.statusindicators.."\n\n"..ToolTipStrings.statustexts.."\n\n"..ToolTipStrings.setfocus.."\n\n"..ToolTipStrings.ufconfig,
		playerbuffs =		ToolTipColors[1].."Amélioration du joueur - Court Terme|r\n\n"..ToolTipColors[3].."Affiche les améliorations sur le joueur ayant une durée <= 1min.|r\n\n"..ToolTipStrings.buffconfig,
		playerdebuffs =		ToolTipColors[1].."Corruption du joueur|r\n\n"..ToolTipColors[3].."Affiche toutes les corruptions sur le joueur.|r\n\n"..ToolTipStrings.buffconfig,
		targetbuffs =		ToolTipColors[1].."Améliorations de la cible|r\n\n"..ToolTipColors[3].."Affiche toutes les améliorations de la cible.\n\n"..ToolTipColors[2].."Critère:\n"..ToolTipColors[3].."Lancer par le joueur\nPeut être lancé par le joueur\nPeut être volé par le joueur\nLancer par un véhicule\nLancer par un PNJ\nAméliorations à durée illimitée lancées par la cible\n\nMontrera toutes les améliorations de la cible en BG ou en Arène.|r\n\n"..ToolTipStrings.buffconfig,
		targetdebuffs =		ToolTipColors[1].."Corruptions de la cible|r\n\n"..ToolTipColors[3].."Affiche toutes les corruptions de votre cible.\n\n"..ToolTipColors[2].."Critère:\n"..ToolTipColors[3].."Lancer par le joueur\nPeut être lancé par le joueur\nPeut être annulée par le joueur\nLancer par un véhicule\nLancer par un PNJ|r\n\n"..ToolTipStrings.buffconfig,
		focusbuffs =		ToolTipColors[1].."Améliorations du la Focalisation|r\n\n"..ToolTipColors[3].."Affiche les améliorations sur la focalisation.\n\n"..ToolTipColors[2].."Critère:\n"..ToolTipColors[3].."Lancer par le joueur\nPeut être volé par le joueur\nLancer par un véhicule\nLancer par un PNJ|r\n\n"..ToolTipStrings.buffconfig,
		totdebuffs =		ToolTipColors[1].."Corruptions de la cible de votre cible|r\n\n"..ToolTipColors[3].."Affiche les corruptions de la cible de votre cible.\n\n"..ToolTipColors[2].."Critère:\n"..ToolTipColors[3].."Lancer par le joueur\nPeut être lancé par le joueur\nPeut être annulé par le joueur\nLancer par un véhicule\nLancer par un PNJ|r\n\n"..ToolTipStrings.buffconfig,
		actionbars =		ToolTipColors[1].."Barres d'actions principales|r\n\n"..ToolTipColors[2].."Barres:|r\n"..ToolTipColors[3].."Barre de Posture/Présence|r\n"..ToolTipColors[3].."Barres 1, 2, 3|r "..ToolTipColors[4].."(Haute Res)|r\n"..ToolTipColors[3].."Barre de Familier|r\n\n"..ToolTipColors[2].."Conditions de visibilité:|r\n"..ToolTipColors[3].."Touche Ctrl pressée\nDefinir Focalisation\nCible Attaquable sélectionnée\nEn Combat\nDans un Group|r\n\n"..ToolTipStrings.abconfig,
		moactionbars1a =	ToolTipColors[1].."Barre d'actions secondaire 1|r\n"..ToolTipStrings.mouseover.."\n\n"..ToolTipColors[2].."Barres:|r\n"..ToolTipColors[3].."Barre 4|r",
		moactionbars1b =	ToolTipColors[1].."Barre d'actions secondaire 2|r\n"..ToolTipStrings.mouseover.."\n\n"..ToolTipColors[2].."Barres:|r\n"..ToolTipColors[3].."Barre 5|r",
		moactionbars2 =		ToolTipColors[1].."Barres d'actions secondaires|r\n"..ToolTipStrings.mouseover.."\n\n"..ToolTipColors[2].."Barres:|r\n"..ToolTipColors[3].."Barre 4, 5|r",
		infolineright =		ToolTipColors[1].."Ligne d'information - Droite|r\n\n"..ToolTipColors[2].."Eléments:|r\n"..ToolTipColors[3].."Horloge\nSelecteur de compteur de dégâts\nSélecteur de disposition|r\n|cff909090(DPS/Tank, Soigneur, Basse/Haute Résolution)|r\n"..ToolTipColors[3].."Sélecteur de Spec, Gestionnaire d'équipement\nIPS et Latence|r",
		infolineleft =		ToolTipColors[1].."Ligne d'information - Gauche|r\n\n"..ToolTipColors[2].."Eléments:|r\n"..ToolTipColors[3].."Boutons d'Options / Micromenu\nIndicateur de nouveaux messages\nGuilde\nAmis\nDurabilité |r"..ToolTipColors[4].."(< 95%)|r\n"..ToolTipColors[3].."Sacs : Emplacements libres\nDevise\nXP / Réputation|r",
	}
else	-- Default
	ButtonTexts = {
		tutorial = "Tutorial",
		skip = "Skip",
		finished = "Finished",
	}
	ToolTipStrings = {
		mouseover =			ToolTipColors[4].."(shows on mouseover)|r",
		endbox =			ToolTipColors[2].."End Box:|r\n"..ToolTipColors[3].."Class/Hostility Colored|r",
		statusindicators =	ToolTipColors[2].."Status Indicators:|r\n|cff00FF00Resting|r\n|cffFFFF00AFK|r\n|cffFF0000In Combat|r\n|cff00FFFFLeader|r",
		statustexts =		ToolTipColors[2].."Status Texts:|r\n"..ToolTipColors[3].."P = PvP\nE = Elite\n? = Boss\nR = Rare Elite\nr = Rare|r",
		setfocus =			ToolTipColors[6].."Shift+Click|r"..ToolTipColors[5].." to set as Focus.",
		ufconfig =			ToolTipColors[5].."Type "..ToolTipColors[6].."/hud|r "..ToolTipColors[5].."to reposition and\n"..ToolTipColors[6].."/realui|r "..ToolTipColors[5].."to change settings.|r",
		abconfig =			ToolTipColors[5].."Type "..ToolTipColors[6].."/bar|r "..ToolTipColors[5].."to configure.|r",
		buffconfig =		ToolTipColors[5].."Type "..ToolTipColors[6].."/raven|r "..ToolTipColors[5].."to configure.|r",
	}
	ToolTipTexts = {
		minimap =			ToolTipColors[1].."Minimap|r\n\n"..ToolTipColors[2].."Bottom Left: |r"..ToolTipColors[3].."Coordinates|r\n"..ToolTipColors[2].."Bottom Right: |r"..ToolTipColors[3].."Zone Hostility|r\n"..ToolTipColors[2].."Top: |r"..ToolTipColors[3].."Controls |r"..ToolTipColors[4].."(mouseover)|r\n"..ToolTipColors[2].."Underneath: |r"..ToolTipColors[3].."Minimap Buttons |r"..ToolTipColors[4].."(mouseover)|r",
		buffs =				ToolTipColors[1].."Player Buffs - Long Term|r\n\n"..ToolTipColors[3].."Displays Buffs on the Player with a duration > 1min.|r\n\n"..ToolTipStrings.buffconfig,
		playerframe =		ToolTipColors[1].."Player Frame|r\n\n"..ToolTipColors[2].."End Box:|r\n"..ToolTipColors[3].."Becomes the Pet/Vehicle Frame when you have a pet or are in a vehicle.|r\n"..ToolTipColors[4].."(will become class colored)|r\n\n"..ToolTipStrings.statusindicators.."\n\n"..ToolTipColors[2].."Status Texts:|r\n"..ToolTipColors[3].."P = PvP|r\n\n"..ToolTipStrings.setfocus.."\n\n"..ToolTipStrings.ufconfig,
		targetframe =		ToolTipColors[1].."Target Frame|r\n\n"..ToolTipStrings.endbox.."\n\n"..ToolTipStrings.statusindicators.."\n\n"..ToolTipStrings.statustexts.."\n\n"..ToolTipStrings.setfocus.."\n\n"..ToolTipStrings.ufconfig,
		focusframes =		ToolTipColors[1].."Focus/Focus Target Frames|r\n\n"..ToolTipStrings.endbox.."\n\n"..ToolTipStrings.statusindicators.."\n\n"..ToolTipStrings.statustexts.."\n\n"..ToolTipStrings.ufconfig,
		totframe =			ToolTipColors[1].."Target's Target Frame|r\n\n"..ToolTipStrings.endbox.."\n\n"..ToolTipStrings.statusindicators.."\n\n"..ToolTipStrings.statustexts.."\n\n"..ToolTipStrings.setfocus.."\n\n"..ToolTipStrings.ufconfig,
		playerbuffs =		ToolTipColors[1].."Player Buffs - Short Term|r\n\n"..ToolTipColors[3].."Displays Buffs on the Player that have a duration <= 1min.|r\n\n"..ToolTipStrings.buffconfig,
		playerdebuffs =		ToolTipColors[1].."Player Debuffs|r\n\n"..ToolTipColors[3].."Displays all Debuffs on the Player.|r\n\n"..ToolTipStrings.buffconfig,
		targetbuffs =		ToolTipColors[1].."Target Buffs|r\n\n"..ToolTipColors[3].."Displays Buffs on the Target.\n\n"..ToolTipColors[2].."Critera:\n"..ToolTipColors[3].."Cast by Player\nCastable by Player\nSpellstealable by Player\nCast by a Vehicle\nCast by an NPC\nUnlimited duration Buffs cast by Target\n\nWill show all Target Buffs when in a BG or Arena.|r\n\n"..ToolTipStrings.buffconfig,
		targetdebuffs =		ToolTipColors[1].."Target Debuffs|r\n\n"..ToolTipColors[3].."Displays Debuffs on your Target.\n\n"..ToolTipColors[2].."Critera:\n"..ToolTipColors[3].."Cast by Player\nCastable by Player\nDispellable by Player\nCast by a Vehicle\nCast by an NPC|r\n\n"..ToolTipStrings.buffconfig,
		focusbuffs =		ToolTipColors[1].."Focus Buffs|r\n\n"..ToolTipColors[3].."Displays Buffs on your Focus target.\n\n"..ToolTipColors[2].."Critera:\n"..ToolTipColors[3].."Cast by Player\nSpellstealable by Player\nCast by a Vehicle\nCast by an NPC|r\n\n"..ToolTipStrings.buffconfig,
		totdebuffs =		ToolTipColors[1].."Target's Target Debuffs|r\n\n"..ToolTipColors[3].."Displays Debuffs on your Target's Target.\n\n"..ToolTipColors[2].."Critera:\n"..ToolTipColors[3].."Cast by Player\nCastable by Player\nDispellable by Player\nCast by a Vehicle\nCast by an NPC|r\n\n"..ToolTipStrings.buffconfig,
		actionbars =		ToolTipColors[1].."Primary Action Bars|r\n\n"..ToolTipColors[2].."Bars:|r\n"..ToolTipColors[3].."Stance Bar|r\n"..ToolTipColors[3].."Bars 1, 2, 3|r "..ToolTipColors[4].."(High Res)|r\n"..ToolTipColors[3].."Pet Bar|r\n\n"..ToolTipColors[2].."Visibility Conditions:|r\n"..ToolTipColors[3].."Ctrl key pressed\nFocus set\nAttackable target selected\nIn Combat\nIn a Group|r\n\n"..ToolTipStrings.abconfig,
		moactionbars1a =	ToolTipColors[1].."Secondary Action Bar 1|r\n"..ToolTipStrings.mouseover.."\n\n"..ToolTipColors[2].."Bars:|r\n"..ToolTipColors[3].."Bar 4|r",
		moactionbars1b =	ToolTipColors[1].."Secondary Action Bar 2|r\n"..ToolTipStrings.mouseover.."\n\n"..ToolTipColors[2].."Bars:|r\n"..ToolTipColors[3].."Bar 5|r",
		moactionbars2 =		ToolTipColors[1].."Secondary Action Bars|r\n"..ToolTipStrings.mouseover.."\n\n"..ToolTipColors[2].."Bars:|r\n"..ToolTipColors[3].."Bar 4, 5|r",
		infolineright =		ToolTipColors[1].."Info Line - Right|r\n\n"..ToolTipColors[2].."Elements:|r\n"..ToolTipColors[3].."Clock\nDamage Meter Toggle\nLayout Changer|r\n|cff909090(DPS/Tank, Healing, Low/High Resolution)|r\n"..ToolTipColors[3].."Spec Changer, Equip Manager\nFPS and Latency|r",
		infolineleft =		ToolTipColors[1].."Info Line - Left|r\n\n"..ToolTipColors[2].."Elements:|r\n"..ToolTipColors[3].."Options Button / Micromenu\nNew Mail Indicator\nGuild\nFriends\nDurability |r"..ToolTipColors[4].."(< 95%)|r\n"..ToolTipColors[3].."Empty Bag Slots\nCurrency\nXP / Reputation|r",
	}
end
---- end Localizations


local rTB
RealUI_HelpPlate = {
	[1] = {	--minimap
		ButtonAnchor = "TOPLEFT",
		ButtonPos = { x = Minimap:GetWidth() + 2, y = -(Minimap:GetHeight()) + 84 },
		ToolTipDir = "RIGHT",
		ToolTipText = ToolTipTexts.minimap,
	},
	[2] = {	--buffs
		ButtonAnchor = "TOPRIGHT",
		ButtonPos = { x = -130, y = -27 },
		ToolTipDir = "DOWN",
		ToolTipText = ToolTipTexts.buffs,
	},
	[3] = {	--playerframe
		ButtonAnchor = "CENTER",
		ButtonPos = { x = -146, y = -38 },
		ToolTipDir = "RIGHT",
		ToolTipText = ToolTipTexts.playerframe,
	},
	[4] = {	--targetframe
		ButtonAnchor = "CENTER",
		ButtonPos = { x = 146, y = -38 },
		ToolTipDir = "LEFT",
		ToolTipText = ToolTipTexts.targetframe,
	},
	[5] = {	--focusframes
		ButtonAnchor = "CENTER",
		ButtonPos = { x = -146, y = -95 },
		ToolTipDir = "RIGHT",
		ToolTipText = ToolTipTexts.focusframes,
	},
	[6] = {	--totframe
		ButtonAnchor = "CENTER",
		ButtonPos = { x = 146, y = -95 },
		ToolTipDir = "LEFT",
		ToolTipText = ToolTipTexts.totframe,
	},
	[7] = {--playerbuffs
		ButtonAnchor = "CENTER",
		ButtonPos = { x = -450, y = -38 },
		ToolTipDir = "UP",
		ToolTipText = ToolTipTexts.playerbuffs,
	},
	[8] = {--playerdebuffs
		ButtonAnchor = "CENTER",
		ButtonPos = { x = -450, y = 0 },
		ToolTipDir = "UP",
		ToolTipText = ToolTipTexts.playerdebuffs,
	},
	[9] = {--targetbuffs
		ButtonAnchor = "CENTER",
		ButtonPos = { x = 450, y = -38 },
		ToolTipDir = "UP",
		ToolTipText = ToolTipTexts.targetbuffs,
	},
	[10] = {--targetdebuffs
		ButtonAnchor = "CENTER",
		ButtonPos = { x = 450, y = 0 },
		ToolTipDir = "UP",
		ToolTipText = ToolTipTexts.targetdebuffs,
	},
	[11] = {--focusbuffs
		ButtonAnchor = "CENTER",
		ButtonPos = { x = -388, y = -95 },
		ToolTipDir = "DOWN",
		ToolTipText = ToolTipTexts.focusbuffs,
	},
	[12] = {--totdebuffs
		ButtonAnchor = "CENTER",
		ButtonPos = { x = 388, y = -95 },
		ToolTipDir = "DOWN",
		ToolTipText = ToolTipTexts.totdebuffs,
	},
	[13] = {	--actionbars
		ButtonAnchor = "CENTER",
		ButtonPos = { x = 0, y = -155 },
		ToolTipDir = "UP",
		ToolTipText = ToolTipTexts.actionbars,
	},
	[14] = {	--infolineright
		ButtonAnchor = "BOTTOMRIGHT",
		ButtonPos = { x = -110, y = 17 },
		ToolTipDir = "UP",
		ToolTipText = ToolTipTexts.infolineright,
	},
	[15] = {--infolineleft
		ButtonAnchor = "BOTTOMLEFT",
		ButtonPos = { x = 170, y = 17 },
		ToolTipDir = "UP",
		ToolTipText = ToolTipTexts.infolineleft,
	},
}

-- Skin Help Plate frames
local function SkinHelpPlateFrames()
	local F = Aurora[1]
	if F then
		for i = 1, HelpPlateTooltip:GetNumRegions() do
			local region = select(i, HelpPlateTooltip:GetRegions())
			if region:GetObjectType() == "Texture" then
				region:SetTexture(nil)
			end
		end
		
		if F then
			F.SetBD(HelpPlateTooltip)
		end
	end
end

local HP_CP
function RealUITutorial_HelpPlate_AnimateOnFinished(self)
	-- Hide the parent button
	self.parent:Hide()
	self:SetScript("OnFinished", nil)

	-- Hide everything
	for i = 1, #HELP_PLATE_BUTTONS do
		local button = HELP_PLATE_BUTTONS[i]
		button.box:Hide()
		button.boxHighlight:Hide()
	end
	
	HP_CP = nil
	HelpPlate:Hide()
	tutorialStage = 0
end

function RealUITutorial_HelpPlate_AnimateOut()
    if ( HP_CP ) then
        for i = 1, #HELP_PLATE_BUTTONS do
            local button = HELP_PLATE_BUTTONS[i]
            button.tooltipDir = "RIGHT"
            if ( button:IsShown() ) then
                if ( button.animGroup_Show:IsPlaying() ) then
                    button.animGroup_Show:Stop()
                end
                button.animGroup_Show:SetScript("OnFinished", RealUITutorial_HelpPlate_AnimateOnFinished)
                button.animGroup_Show.translate:SetDuration(0.3)
                button.animGroup_Show.alpha:SetDuration(0.3)
                button.animGroup_Show:Play()
            end
        end
    end
end

local function RealUITutorial_HelpPlate_Show( self, parent, mainHelpButton )
	if ( HP_CP ) then return end
	
	HP_CP = self
	HP_CP.mainHelpButton = mainHelpButton
	for i = 1, #self do
		local button = HelpPlate_GetButton()
		button:ClearAllPoints()
		button:SetPoint( self[i].ButtonAnchor, HelpPlate, self[i].ButtonAnchor, self[i].ButtonPos.x, self[i].ButtonPos.y )
		button.tooltipDir = self[i].ToolTipDir
		button.toolTipText = self[i].ToolTipText
		button.viewed = false
		button:Show()
		button.BigI:Show()
		button.Ring:Show()
		button.Pulse:Play()
	end
	HelpPlate:SetPoint( "CENTER", parent, "CENTER", 0, 0 )
	HelpPlate:SetSize( UIParent:GetWidth(), UIParent:GetHeight() )
	HelpPlate.userToggled = true
	HelpPlate:Show()
end

local hasAdjustedPositions = false
function RealUIShowTutorial_Stage1()
	local helpPlate = RealUI_HelpPlate
	if ( helpPlate and not HelpPlate_IsShowing(helpPlate) ) then
		RealUITutorial_HelpPlate_Show( helpPlate, UIParent, rTB )
	end
	
	HelpPlate:EnableMouse(false)
	SkinHelpPlateFrames()
end

local function createClassBorder(parent)
	local cb = CreateFrame("Frame", nil, parent)
	cb:SetPoint("CENTER", parent, "CENTER", 0, 0)
	cb:SetWidth(108)
	cb:SetHeight(48)
	cb:SetBackdrop({
		bgFile = nibRealUI.media.textures.plain, 
		edgeFile = nibRealUI.media.textures.plain, 
		tile = false, tileSize = 0, edgeSize = 1, 
		insets = { left = 1, right = 1, top = 1, bottom = 1	}
	})
	cb:SetBackdropColor(0,0,0,0.1)
	cb:SetBackdropBorderColor(unpack(nibRealUI:GetClassColor(nibRealUI.class)))
end

local function createTextButton(name, parent)
	local btn = CreateFrame("Button", name, parent, "SecureActionButtonTemplate")
	btn:SetNormalFontObject(NumberFontNormal)
	btn:SetFrameStrata("DIALOG")
	btn:SetFrameLevel(50)
	btn:SetSize(110, 50)
	return btn
end

function nibRealUI:InitTutorial()
	-- Add Resolution specific buttons to RealUI_HelpPlate
	if nibRealUI.db.char.resolution == 1 then
		tinsert(RealUI_HelpPlate, {
			ButtonAnchor = "RIGHT",
			ButtonPos = { x = -21, y = 0 },
			ToolTipDir = "LEFT",
			ToolTipText = ToolTipTexts.moactionbars1a,
		})
		tinsert(RealUI_HelpPlate, {
			ButtonAnchor = "LEFT",
			ButtonPos = { x = 21, y = 0 },
			ToolTipDir = "RIGHT",
			ToolTipText = ToolTipTexts.moactionbars1b,
		})
		if not hasAdjustedPositions then
			RealUI_HelpPlate[7].ButtonPos.x = RealUI_HelpPlate[7].ButtonPos.x + 20
			RealUI_HelpPlate[8].ButtonPos.x = RealUI_HelpPlate[8].ButtonPos.x + 20
			RealUI_HelpPlate[9].ButtonPos.x = RealUI_HelpPlate[9].ButtonPos.x - 20
			RealUI_HelpPlate[10].ButtonPos.x = RealUI_HelpPlate[10].ButtonPos.x - 20
			RealUI_HelpPlate[11].ButtonPos.x = RealUI_HelpPlate[11].ButtonPos.x + 20
			RealUI_HelpPlate[12].ButtonPos.x = RealUI_HelpPlate[12].ButtonPos.x - 20
			hasAdjustedPositions = true
		end
	else
		tinsert(RealUI_HelpPlate, {
			ButtonAnchor = "RIGHT",
			ButtonPos = { x = -21, y = 0 },
			ToolTipDir = "LEFT",
			ToolTipText = ToolTipTexts.moactionbars2,
		})
		if not hasAdjustedPositions and nibRealUI.db.global.tags.ldOptimized then
			RealUI_HelpPlate[3].ButtonPos.x = RealUI_HelpPlate[3].ButtonPos.x - 28
			RealUI_HelpPlate[4].ButtonPos.x = RealUI_HelpPlate[4].ButtonPos.x + 28
			RealUI_HelpPlate[5].ButtonPos.x = RealUI_HelpPlate[5].ButtonPos.x - 28
			RealUI_HelpPlate[6].ButtonPos.x = RealUI_HelpPlate[6].ButtonPos.x + 28
			RealUI_HelpPlate[7].ButtonPos.x = RealUI_HelpPlate[7].ButtonPos.x - 28
			RealUI_HelpPlate[8].ButtonPos.x = RealUI_HelpPlate[8].ButtonPos.x - 28
			RealUI_HelpPlate[9].ButtonPos.x = RealUI_HelpPlate[9].ButtonPos.x + 28
			RealUI_HelpPlate[10].ButtonPos.x = RealUI_HelpPlate[10].ButtonPos.x + 28
			RealUI_HelpPlate[11].ButtonPos.x = RealUI_HelpPlate[11].ButtonPos.x - 28
			RealUI_HelpPlate[12].ButtonPos.x = RealUI_HelpPlate[12].ButtonPos.x + 28
			hasAdjustedPositions = true
		end
	end
	
	-- MainHelpPlateButton
	rTB = CreateFrame("Button", "RealUITutorialButton", UIParent, "MainHelpPlateButton")
	rTB:SetPoint("CENTER", UIParent, "CENTER", 0, -38)
	rTB:Hide()
	
	-- Dark BG
	local tBG = CreateFrame("Frame", "RealUITutorialBG", UIParent)
	tBG:SetParent(UIParent)
	tBG:SetPoint("CENTER", UIParent, "CENTER")
	tBG:SetFrameStrata("BACKGROUND")
	tBG:SetFrameLevel(0)
	tBG:SetWidth(UIParent:GetWidth() + 2000)
	tBG:SetHeight(UIParent:GetHeight() + 2000)
	tBG:SetBackdrop({
		bgFile = [[Interface\AddOns\nibRealUI\Media\Plain]],
	})
	tBG:SetBackdropColor(0, 0, 0, 0.4)
	
	-- Logo
	local rLogo = UIParent:CreateTexture("RealUITutorialLogo", "ARTWORK")
	rLogo:SetTexture([[Interface\AddOns\nibRealUI\Media\Logo]])
	rLogo:SetSize(32, 32)
	rLogo:SetPoint("CENTER", UIParent, "CENTER", 0, 55)
	
	-- Buttons
	local btnOpen = createTextButton("RealUITutorialButtonOpen", UIParent)
	btnOpen:SetPoint("CENTER", parent, "CENTER", 0, 0)
	btnOpen:SetText(ButtonTexts.tutorial)
	btnOpen:SetAttribute("type", "macro")
	btnOpen:SetAttribute("macrotext", "/tar "..nibRealUI.name.."\n/focus\n/run RealUIShowTutorial_Stage1()\n/run RealUITutorialButtonClose:Show()\n/run RealUITutorialButtonOpen:Hide()\n/run RealUITutorialButtonSkip:Hide()")
	btnOpen.classBorder = createClassBorder(btnOpen)
	
	local btnSkip = createTextButton("RealUITutorialButtonSkip", UIParent)
	btnSkip:SetPoint("CENTER", parent, "CENTER", 0, -54)
	btnSkip:SetText(ButtonTexts.skip)
	btnSkip:RegisterForClicks("LeftButtonUp")
	btnSkip:SetScript("OnClick", function()
		rTB:Hide()
		rLogo:Hide()
		btnOpen:Hide()
		btnSkip:Hide()
		tBG:Hide()
		nibRealUI.db.global.tags.tutorialdone = true
	end)
	btnSkip.classBorder = createClassBorder(btnSkip)
	
	local btnClose = createTextButton("RealUITutorialButtonClose", HelpPlate)
	btnClose:SetPoint("CENTER", parent, "CENTER", 0, 0)
	btnClose:SetText(ButtonTexts.finished)
	btnClose:SetAttribute("type", "macro")
	btnClose:SetAttribute("macrotext", "/clearfocus\n/run RealUITutorial_HelpPlate_AnimateOut()\n/run RealUITutorialButtonClose:Hide()\n/run UIFrameFadeOut(RealUITutorialBG, 0.3, 0.5, 0)\n/run RealUITutorialLogo:Hide()\n/run RealUI.db.global.tags.tutorialdone = true")
	btnClose:Hide()
	btnClose.classBorder = createClassBorder(btnClose)
	
	-- Skin Buttons
	local F = Aurora[1]
	if F then
		F.Reskin(btnOpen)
		F.Reskin(btnSkip)
		F.Reskin(btnClose)
	end
end

function TestTutorial()
	if RealUITutorialButton then
		RealUITutorialLogo:Show()
		RealUITutorialButtonOpen:Show()
		RealUITutorialButtonSkip:Show()
		RealUITutorialBG:Show()
	else
		nibRealUI:InitTutorial()
	end
end