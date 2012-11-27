--[[--------------------------------------------------------------------
	Grid
	Compact party and raid unit frames.
	Copyright (c) 2006-2012 Kyle Smith (a.k.a. Pastamancer), A. Kinley (a.k.a. Phanx) <addons@phanx.net>
	All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info5747-Grid.html
	http://www.wowace.com/addons/grid/
	http://www.curse.com/addons/wow/grid
------------------------------------------------------------------------
	GridLocale-itIT.lua
	Italian (Italiano) localization.
	Contributors: Holydeath1984, kappesante
----------------------------------------------------------------------]]

if GetLocale() ~= "itIT" then return end

local _, Grid = ...
local L = { }
Grid.L = L

------------------------------------------------------------------------
--	GridCore

L["Debug"] = "Elimina errori"
L["Debugging"] = "Eliminazione errori"
L["Hide minimap icon"] = "Nascondi l'icona della Minimappa"
L["Module debugging menu."] = "Menu del modulo di correzione errori." -- Needs review
-- L["Toggle debugging for %s."] = ""

------------------------------------------------------------------------
--	GridFrame

L["Adjust the font outline."] = "Regola il contorno del carattere"
L["Adjust the font settings"] = "Regola le opzioni del carattere"
L["Adjust the font size."] = "Regola la dimensione del carattere"
L["Adjust the height of each unit's frame."] = "Regola l'altezza di ogni riquadro delle unità"
L["Adjust the size of the border indicators."] = "Regola la dimensione degli indicatori al margine"
L["Adjust the size of the center icon."] = "Regola la dimensione dell'icona centrale"
L["Adjust the size of the center icon's border."] = "Regola la dimensione del margine dell'icona centrale"
L["Adjust the size of the corner indicators."] = "Regola la dimensione degli indicatori agli angoli"
L["Adjust the texture of each unit's frame."] = "Regola la trama di ogni riquadro delle unità"
L["Adjust the width of each unit's frame."] = "Regola la larghezza di ogni riquadro delle unità"
L["Always"] = "Sempre"
L["Bar Options"] = "Opzioni della barra"
L["Border"] = "Margine"
L["Border Size"] = "Dimensione del margine"
L["Bottom Left Corner"] = "Angolo in basso a sinistra"
L["Bottom Right Corner"] = "Angolo in basso a destra"
L["Center Icon"] = "Icona centrale"
L["Center Text"] = "Testo centrale"
L["Center Text 2"] = "Testo Centrale 2"
L["Center Text Length"] = "Lunghezza del testo centrale"
-- L["Color the healing bar using the active status color instead of the health bar color."] = ""
L["Corner Size"] = "Dimensione dell'indicatore in angolo"
-- L["Darken the text color to match the inverted bar."] = ""
L["Enable Mouseover Highlight"] = "Abilita l'illuminazione al passaggio del mouse"
-- L["Enable %s"] = ""
L["Enable %s indicator"] = "Abilita l'indicatore %s"
L["Font"] = "Carattere"
L["Font Outline"] = "Contorno del carattere"
L["Font Shadow"] = "Ombra del carattere"
L["Font Size"] = "Dimensione del carattere"
L["Frame"] = "Riquadro"
L["Frame Alpha"] = "Trasparenza del riquadro"
L["Frame Height"] = "Altezza del riquadro"
L["Frame Texture"] = "Trama del riquadro"
L["Frame Width"] = "Larghezza del riquadro"
L["Healing Bar"] = "Barra delle Cure"
L["Healing Bar Opacity"] = "Opacita' della Barra delle Cure"
L["Healing Bar Uses Status Color"] = "LA barra cure usa il colore di Stato" -- Needs review
L["Health Bar"] = "Barra della salute"
L["Health Bar Color"] = "Colore della barra della salute"
L["Horizontal"] = "Orizzontale"
L["Icon Border Size"] = "Dimensione dell'icona sul bordo"
-- L["Icon Cooldown Frame"] = ""
L["Icon Options"] = "Opzioni dell'icona"
L["Icon Size"] = "Dimensione dell'icona"
-- L["Icon Stack Text"] = ""
-- L["Indicators"] = ""
L["Invert Bar Color"] = "Inverti il Colore della Barra"
-- L["Invert Text Color"] = ""
-- L["Make the healing bar use the status color instead of the health bar color."] = ""
L["Never"] = "Mai"
L["None"] = "Nessuno"
L["Number of characters to show on Center Text indicator."] = "Numero di caratteri da mostrare nell'indicatore del Testo Centrale"
L["OOC"] = "NIC" -- Needs review
-- L["Options for assigning statuses to indicators."] = ""
L["Options for GridFrame."] = "Opzioni per i riquadri di Grid"
L["Options for %s indicator."] = "Opzioni per gli indicatori %s" -- Needs review
L["Options related to bar indicators."] = "Opzioni degli indicatori della barra"
L["Options related to icon indicators."] = "Opzioni relative agli indicatori a icona" -- Needs review
L["Options related to text indicators."] = "Opzioni relative agli indicatori di testo" -- Needs review
L["Orientation of Frame"] = "Orientamento del riquadro"
L["Orientation of Text"] = "Orientamento del Testo"
L["Set frame orientation."] = "Regola l'orientamento del riquadro"
L["Set frame text orientation."] = "Stabilisci l'orientamento del testo nel riquadro" -- Needs review
L["Sets the opacity of the healing bar."] = "Stabilisce l'opacità della barra delle cure" -- Needs review
L["Show Tooltip"] = "Mostra suggerimenti"
L["Show unit tooltip.  Choose 'Always', 'Never', or 'OOC'."] = "Mostra suggerimenti unità. Scegli 'Sempre', 'Mai', o 'NIC' " -- Needs review
L["Statuses"] = "Stati" -- Needs review
L["Swap foreground/background colors on bars."] = "Inverti i colori di primo piano e sfondo sulle barre."
L["Text Options"] = "Opzioni di testo"
L["Thick"] = "Spesso"
L["Thin"] = "Sottile"
-- L["Throttle Updates"] = ""
-- L["Throttle updates on group changes. This option may cause delays in updating frames, so you should only enable it if you're experiencing temporary freezes or lockups when people join or leave your group."] = ""
-- L["Toggle center icon's cooldown frame."] = ""
-- L["Toggle center icon's stack count text."] = ""
L["Toggle mouseover highlight."] = "Mostra/nascondi illuminazione al passaggio del mouse." -- Needs review
L["Toggle status display."] = "Mostra/nascondi stato" -- Needs review
L["Toggle the font drop shadow effect."] = "Attiva/disattiva l'effetto ombra del carattere." -- Needs review
L["Toggle the %s indicator."] = "Attiva/disattiva l'indicatore %s" -- Needs review
L["Top Left Corner"] = "Angolo in alto a sinistra" -- Needs review
L["Top Right Corner"] = "Angolo in alto a destra" -- Needs review
L["Vertical"] = "Verticale" -- Needs review

------------------------------------------------------------------------
--	GridLayout

-- L["10 Player Raid Layout"] = ""
-- L["25 Player Raid Layout"] = ""
L["Adjust background color and alpha."] = "Regola colore e trasparenza dello sfondo." -- Needs review
L["Adjust border color and alpha."] = "Regola colore e trasparenza del margine." -- Needs review
L["Adjust frame padding."] = "Regola spazio interno del riquadro." -- Needs review
L["Adjust frame spacing."] = "Regola lo spazio tra i riquadri." -- Needs review
L["Adjust Grid scale."] = "Regola la scala di Grid" -- Needs review
L["Advanced"] = "Avanzato" -- Needs review
L["Advanced options."] = "Opzioni avanzate." -- Needs review
L["Allows mouse click through the Grid Frame."] = "Permetti click del mouse attraverso il riquadro di Grid." -- Needs review
-- L["Alt-Click to permanantly hide this tab."] = ""
-- L["Arena Layout"] = ""
L["Background color"] = "Colore sfondo" -- Needs review
-- L["Battleground Layout"] = ""
-- L["Beast"] = ""
L["Border color"] = "Colore margine" -- Needs review
L["Border Texture"] = "Trama margine" -- Needs review
L["Bottom"] = "Basso" -- Needs review
L["Bottom Left"] = "In basso a sinistra" -- Needs review
L["Bottom Right"] = "In basso a destra" -- Needs review
L["By Creature Type"] = "Per tipo di creatura" -- Needs review
-- L["By Owner Class"] = ""
L["Center"] = "Centro" -- Needs review
L["Choose the layout border texture."] = "Scegli la trama del bordo della disposizione" -- Needs review
L["Clamped to screen"] = "Mantieni all'interno dello schermo" -- Needs review
-- L["Class colors"] = ""
-- L["Click through the Grid Frame"] = ""
-- L["Color for %s."] = ""
-- L["Color of pet unit creature types."] = ""
-- L["Color of player unit classes."] = ""
-- L["Color of unknown units or pets."] = ""
-- L["Color options for class and pets."] = ""
-- L["Colors"] = ""
-- L["Creature type colors"] = ""
-- L["Demon"] = ""
-- L["Do not show the tab when Grid is unlocked."] = ""
-- L["Dragonkin"] = ""
-- L["Drag this tab to move Grid."] = ""
-- L["Elemental"] = ""
-- L["Fallback colors"] = ""
-- L["Frame lock"] = ""
-- L["Group Anchor"] = ""
-- L["Hide tab"] = ""
-- L["Horizontal groups"] = ""
-- L["Humanoid"] = ""
-- L["Layout"] = ""
-- L["Layout Anchor"] = ""
-- L["Left"] = ""
-- L["Lock Grid to hide this tab."] = ""
-- L["Locks/unlocks the grid for movement."] = ""
-- L["Not specified"] = ""
-- L["Options for GridLayout."] = ""
-- L["Padding"] = ""
-- L["Party Layout"] = ""
-- L["Pet color"] = ""
-- L["Pet coloring"] = ""
-- L["Reset Position"] = ""
-- L["Resets the layout frame's position and anchor."] = ""
-- L["Right"] = ""
-- L["Scale"] = ""
-- L["Select which layout to use when in a 10 player raid."] = ""
-- L["Select which layout to use when in a 25 player raid."] = ""
-- L["Select which layout to use when in a battleground."] = ""
-- L["Select which layout to use when in an arena."] = ""
-- L["Select which layout to use when in a party."] = ""
-- L["Select which layout to use when not in a party."] = ""
-- L["Sets where Grid is anchored relative to the screen."] = ""
-- L["Sets where groups are anchored relative to the layout frame."] = ""
-- L["Set the coloring strategy of pet units."] = ""
-- L["Set the color of pet units."] = ""
-- L["Show Frame"] = ""
-- L["Solo Layout"] = ""
-- L["Spacing"] = ""
-- L["Switch between horizontal/vertical groups."] = ""
-- L["The color of unknown pets."] = ""
-- L["The color of unknown units."] = ""
-- L["Toggle whether to permit movement out of screen."] = ""
-- L["Top"] = ""
-- L["Top Left"] = ""
-- L["Top Right"] = ""
-- L["Undead"] = ""
-- L["Unknown Pet"] = ""
-- L["Unknown Unit"] = ""
-- L["Using Fallback color"] = ""

------------------------------------------------------------------------
--	GridLayoutLayouts

-- L["By Class 10"] = ""
-- L["By Class 10 w/Pets"] = ""
-- L["By Class 25"] = ""
-- L["By Class 25 w/Pets"] = ""
-- L["By Group 10"] = ""
-- L["By Group 10 w/Pets"] = ""
-- L["By Group 15"] = ""
-- L["By Group 15 w/Pets"] = ""
-- L["By Group 25"] = ""
-- L["By Group 25 w/Pets"] = ""
-- L["By Group 25 w/Tanks"] = ""
-- L["By Group 40"] = ""
-- L["By Group 40 w/Pets"] = ""
-- L["By Group 5"] = ""
-- L["By Group 5 w/Pets"] = ""
-- L["None"] = ""

------------------------------------------------------------------------
--	GridLDB

-- L["Click to toggle the frame lock."] = ""
-- L["Right-Click to open the options menu."] = ""

------------------------------------------------------------------------
--	GridRoster


------------------------------------------------------------------------
--	GridStatus

-- L["Color"] = ""
-- L["Color for %s"] = ""
-- L["Enable"] = ""
-- L["Options for %s."] = ""
-- L["Priority"] = ""
-- L["Priority for %s"] = ""
-- L["Range filter"] = ""
-- L["Reset class colors"] = ""
-- L["Reset class colors to defaults."] = ""
-- L["Show status only if the unit is in range."] = ""
-- L["Status"] = ""
-- L["Status: %s"] = ""
-- L["Text"] = ""
-- L["Text to display on text indicators"] = ""

------------------------------------------------------------------------
--	GridStatusAggro

-- L["Aggro"] = ""
-- L["Aggro alert"] = ""
-- L["Aggro color"] = ""
-- L["Color for Aggro."] = ""
-- L["Color for High Threat."] = ""
-- L["Color for Tanking."] = ""
-- L["High"] = ""
-- L["High Threat color"] = ""
-- L["Show more detailed threat levels."] = ""
-- L["Tank"] = ""
-- L["Tanking color"] = ""
-- L["Threat"] = ""

------------------------------------------------------------------------
--	GridStatusAuras

-- L["Add new Buff"] = ""
-- L["Add new Debuff"] = ""
-- L["Adds a new buff to the status module"] = ""
-- L["Adds a new debuff to the status module"] = ""
-- L["Auras"] = ""
-- L["<buff name>"] = ""
-- L["Buff: %s"] = ""
-- L["Change what information is shown by the status color."] = ""
-- L["Change what information is shown by the status color and text."] = ""
-- L["Change what information is shown by the status text."] = ""
-- L["Class Filter"] = ""
-- L["Color"] = ""
-- L["Color to use when the %s is above the high count threshold values."] = ""
-- L["Color to use when the %s is between the low and high count threshold values."] = ""
-- L["Color when %s is below the low threshold value."] = ""
-- L["Curse"] = ""
-- L["<debuff name>"] = ""
-- L["(De)buff name"] = ""
-- L["Debuff: %s"] = ""
-- L["Debuff type: %s"] = ""
-- L["Delete (De)buff"] = ""
-- L["Deletes an existing debuff from the status module"] = ""
-- L["Disease"] = ""
-- L["Display status only if the buff is not active."] = ""
-- L["Display status only if the buff was cast by you."] = ""
-- L["Ghost"] = ""
-- L["High color"] = ""
-- L["High threshold"] = ""
-- L["Low color"] = ""
-- L["Low threshold"] = ""
-- L["Magic"] = ""
-- L["Middle color"] = ""
-- L["Pet"] = ""
-- L["Poison"] = ""
-- L["Present or missing"] = ""
-- L["Refresh interval"] = ""
-- L["Remove %s from the menu"] = ""
L["%s colors"] = "colori %s" -- Needs review
L["%s colors and threshold values."] = "colori e soglia %s" -- Needs review
-- L["Show duration"] = ""
-- L["Show if mine"] = ""
-- L["Show if missing"] = ""
-- L["Show on pets and vehicles."] = ""
-- L["Show on %s players."] = ""
-- L["Show status for the selected classes."] = ""
-- L["Show the time left to tenths of a second, instead of only whole seconds."] = ""
-- L["Show the time remaining, for use with the center icon cooldown."] = ""
-- L["Show time left to tenths"] = ""
L["%s is high when it is at or above this value."] = "%s è alto se maggiore o uguale a questo valore." -- Needs review
-- L["%s is low when it is at or below this value."] = ""
-- L["Stack count"] = ""
-- L["Status Information"] = ""
-- L["Text"] = ""
-- L["Time in seconds between each refresh of the status time left."] = ""
-- L["Time left"] = ""

------------------------------------------------------------------------
--	GridStatusHeals

-- L["Heals"] = ""
-- L["Ignore heals cast by you."] = ""
-- L["Ignore Self"] = ""
-- L["Incoming heals"] = ""
-- L["Minimum Value"] = ""
-- L["Only show incoming heals greater than this amount."] = ""

------------------------------------------------------------------------
--	GridStatusHealth

-- L["Color deficit based on class."] = ""
-- L["Color health based on class."] = ""
-- L["DEAD"] = ""
-- L["Death warning"] = ""
-- L["FD"] = ""
-- L["Feign Death warning"] = ""
-- L["Health"] = ""
-- L["Health deficit"] = ""
-- L["Health threshold"] = ""
-- L["Low HP"] = ""
-- L["Low HP threshold"] = ""
-- L["Low HP warning"] = ""
-- L["Offline"] = ""
-- L["Offline warning"] = ""
-- L["Only show deficit above % damage."] = ""
-- L["Set the HP % for the low HP warning."] = ""
-- L["Show dead as full health"] = ""
-- L["Treat dead units as being full health."] = ""
-- L["Unit health"] = ""
-- L["Use class color"] = ""

------------------------------------------------------------------------
--	GridStatusMana

-- L["Low Mana"] = ""
-- L["Low Mana warning"] = ""
-- L["Mana"] = ""
-- L["Mana threshold"] = ""
-- L["Set the percentage for the low mana warning."] = ""

------------------------------------------------------------------------
--	GridStatusName

-- L["Color by class"] = ""
-- L["Unit Name"] = ""

------------------------------------------------------------------------
--	GridStatusRange

-- L["Out of Range"] = ""
-- L["Range"] = ""
-- L["Range check frequency"] = ""
-- L["Seconds between range checks"] = ""

------------------------------------------------------------------------
--	GridStatusReadyCheck

-- L["?"] = ""
-- L["AFK"] = ""
-- L["AFK color"] = ""
-- L["Color for AFK."] = ""
-- L["Color for Not Ready."] = ""
-- L["Color for Ready."] = ""
-- L["Color for Waiting."] = ""
-- L["Delay"] = ""
-- L["Not Ready color"] = ""
-- L["R"] = ""
-- L["Ready Check"] = ""
-- L["Ready color"] = ""
-- L["Set the delay until ready check results are cleared."] = ""
-- L["Waiting color"] = ""
-- L["X"] = ""

------------------------------------------------------------------------
--	GridStatusTarget

-- L["Target"] = ""
L["Your Target"] = "Tuo bersaglio" -- Needs review

------------------------------------------------------------------------
--	GridStatusVehicle

L["Driving"] = "Alla guida" -- Needs review
L["In Vehicle"] = "In un Veicolo" -- Needs review

------------------------------------------------------------------------
--	GridStatusVoiceComm

L["Talking"] = "Parlando" -- Needs review
L["Voice Chat"] = "Chat Vocale" -- Needs review
