--[[--------------------------------------------------------------------
	Grid Localization
	frFR | French | Français
----------------------------------------------------------------------]]

if GetLocale() ~= "frFR" then return end

local _, Grid = ...
local L = { }
Grid.L = L

------------------------------------------------------------------------
--	GridCore

L["Debug"] = "Déboger"
L["Debugging"] = "Débogage"
L["Hide minimap icon"] = "Cacher icône minicarte"
L["Module debugging menu."] = "Menu du module de débogage."
L["Toggle debugging for %s."] = "Active ou non le débogage pour %s."

------------------------------------------------------------------------
--	GridFrame

L["Adjust the font outline."] = "Modifie le coutour de la police d'écriture."
L["Adjust the font settings"] = "Modifie les paramètres de la police d'écriture."
L["Adjust the font size."] = "Modifie la taille de la police d'écriture."
L["Adjust the height of each unit's frame."] = "Modifie la hauteur utilisée par chaque cellule d'unité."
L["Adjust the size of the border indicators."] = "Modifie la taille des indicateurs dans les bords."
L["Adjust the size of the center icon."] = "Modifie la taille de l'icône centrale."
L["Adjust the size of the center icon's border."] = "Modifie la taille de la bordure de l'icône centrale."
L["Adjust the size of the corner indicators."] = "Modifie la taille des indicateurs dans les coins."
L["Adjust the texture of each unit's frame."] = "Modifie la texture utilisée par chaque cellule d'unité."
L["Adjust the width of each unit's frame."] = "Modifie la longueur de chaque cellule d'unité."
L["Always"] = "Toujours"
L["Bar Options"] = "Option des Barres"
L["Border"] = "Bordure"
L["Border Size"] = "Taille des bordures"
L["Bottom Left Corner"] = "Coin inférieur gauche"
L["Bottom Right Corner"] = "Coin inférieur droit"
L["Center Icon"] = "Icône central"
L["Center Text"] = "Texte central"
L["Center Text 2"] = "Texte central 2"
L["Center Text Length"] = "Longueur du texte central"
-- L["Color the healing bar using the active status color instead of the health bar color."] = ""
L["Corner Size"] = "Taille des coins"
-- L["Darken the text color to match the inverted bar."] = ""
L["Enable Mouseover Highlight"] = "Activer la surbrillance au survol"
L["Enable %s"] = "Active %s."
L["Enable %s indicator"] = "Activer l'indicateur %s"
L["Font"] = "Police d'écriture"
L["Font Outline"] = "Contour de police"
L["Font Shadow"] = "Ombre du texte"
L["Font Size"] = "Taille de la police"
L["Frame"] = "Cellules"
L["Frame Alpha"] = "Transparence"
L["Frame Height"] = "Hauteur des cellules"
L["Frame Texture"] = "Texture des cellules"
L["Frame Width"] = "Longueur des cellules"
L["Healing Bar"] = "Barre de soins"
L["Healing Bar Opacity"] = "Opacité de la barre de soins"
-- L["Healing Bar Uses Status Color"] = ""
L["Health Bar"] = "Barre de vie"
L["Health Bar Color"] = "Couleur de la barre de vie"
L["Horizontal"] = "Horizontal"
L["Icon Border Size"] = "Taille de la bordure de l'icône"
L["Icon Cooldown Frame"] = "Texte du temps de recharge sur l'icône"
L["Icon Options"] = "Options des Icônes"
L["Icon Size"] = "Taille de l'icône"
L["Icon Stack Text"] = "Texte du cumul sur l'icône"
L["Indicators"] = "Indicateurs"
L["Invert Bar Color"] = "Inverser la couleur de la barre"
-- L["Invert Text Color"] = ""
-- L["Make the healing bar use the status color instead of the health bar color."] = ""
L["Never"] = "Jamais"
L["None"] = "Aucun"
L["Number of characters to show on Center Text indicator."] = "Détermine le nombre de caractère à afficher pour le texte central."
L["OOC"] = "Hors combat"
L["Options for assigning statuses to indicators."] = "Options pour assigner des statuts aux indicateurs"
L["Options for GridFrame."] = "Options concernant GridFrame."
L["Options for %s indicator."] = "Options concernant l'indicateur %s."
L["Options related to bar indicators."] = "Options relatives aux barres d'indicateurs"
L["Options related to icon indicators."] = "Options relatives aux icônes d'indicateurs"
L["Options related to text indicators."] = "Options relatives aux indicateurs textuels"
L["Orientation of Frame"] = "Orientation de la grille"
L["Orientation of Text"] = "Orientation du texte"
L["Set frame orientation."] = "Détermine l'orientation de la grille."
L["Set frame text orientation."] = "Détermine l'orientation du texte de la grille."
L["Sets the opacity of the healing bar."] = "Définit l'opacité de la barre de soins."
L["Show Tooltip"] = "Afficher les bulles d'aide"
L["Show unit tooltip.  Choose 'Always', 'Never', or 'OOC'."] = "Affiche les bulles d'aide des unités. Choississez 'Toujours', 'Jamais' ou 'Hors combat'."
L["Statuses"] = "Statuts"
L["Swap foreground/background colors on bars."] = "Permute la couleur de l'avant-plan et de l'arrière-plan des barres."
L["Text Options"] = "Options de Texte"
L["Thick"] = "Épais"
L["Thin"] = "Mince"
-- L["Throttle Updates"] = ""
-- L["Throttle updates on group changes. This option may cause delays in updating frames, so you should only enable it if you're experiencing temporary freezes or lockups when people join or leave your group."] = ""
L["Toggle center icon's cooldown frame."] = "Active ou non le texte indiquant le temps de recharge sur l'icône centrale."
L["Toggle center icon's stack count text."] = "Active ou non le texte indiquant le cumul sur l'icône centrale."
L["Toggle mouseover highlight."] = "Active ou non la surbrillance lors du passage de la souris."
L["Toggle status display."] = "Active ou non l'affichage de ce statut."
-- L["Toggle the font drop shadow effect."] = ""
L["Toggle the %s indicator."] = "Active ou non l'indicateur %s."
L["Top Left Corner"] = "Coin supérieur gauche"
L["Top Right Corner"] = "Coin supérieur droit"
L["Vertical"] = "Vertical"

------------------------------------------------------------------------
--	GridLayout

L["10 Player Raid Layout"] = "Disposition en raid 10"
L["25 Player Raid Layout"] = "Disposition en raid 25"
L["Adjust background color and alpha."] = "Modifie la transparence et la couleur de l'arrière-plan."
L["Adjust border color and alpha."] = "Modifie la transparence et la couleur de la bordure."
L["Adjust frame padding."] = "Modifie l'espacement entre les cellules."
L["Adjust frame spacing."] = "Modifie l'espacement entre les cellules et la bordure."
L["Adjust Grid scale."] = "Modifie l'échelle de Grid."
L["Advanced"] = "Avancé"
L["Advanced options."] = "Options avancées."
L["Allows mouse click through the Grid Frame."] = "Permet les clics à travers le cadre de Grid."
L["Alt-Click to permanantly hide this tab."] = "Alt+clic gauche pour cacher cet onglet de façon permanente."
L["Arena Layout"] = "Disposition en arène"
L["Background color"] = "Arrière-plan"
L["Battleground Layout"] = "Disposition en CdB"
L["Beast"] = "Bête"
L["Border color"] = "Bordure"
L["Border Texture"] = "Texture de la bordure"
L["Bottom"] = "Bas"
L["Bottom Left"] = "Basgauche"
L["Bottom Right"] = "Basdroite"
L["By Creature Type"] = "Selon le type de créature"
L["By Owner Class"] = "Selon la classe du maître"
L["Center"] = "Centre"
L["Choose the layout border texture."] = "Choix de la texture de la bordure"
L["Clamped to screen"] = "Garder à l'écran"
L["Class colors"] = "Couleur des classes"
L["Click through the Grid Frame"] = "Cliquer à travers Grid"
L["Color for %s."] = "Couleur pour %s."
L["Color of pet unit creature types."] = "Couleurs des familiers par type de créature."
L["Color of player unit classes."] = "Couleurs des classes de joueurs."
L["Color of unknown units or pets."] = "Couleur des unités ou familiers inconnus."
L["Color options for class and pets."] = "Options de couleurs des classes et des familiers."
L["Colors"] = "Couleurs"
L["Creature type colors"] = "Couleurs des types de créatures"
L["Demon"] = "Démon"
L["Do not show the tab when Grid is unlocked."] = "N'affiche pas l'onglet quand Grid est déverrouillé."
L["Dragonkin"] = "Draconien"
L["Drag this tab to move Grid."] = "Saississez cet onglet pour déplacer Grid."
L["Elemental"] = "Elémentaire"
L["Fallback colors"] = "Couleurs par défaut"
L["Frame lock"] = "Verrouiller"
L["Group Anchor"] = "Ancrage du groupe"
L["Hide tab"] = "Cacher l'onglet"
L["Horizontal groups"] = "Disposition horizontale"
L["Humanoid"] = "Humanoïde"
L["Layout"] = "Grille"
L["Layout Anchor"] = "Ancrage de la grille"
L["Left"] = "Gauche"
L["Lock Grid to hide this tab."] = "Verrouillez Grid pour cacher cet onglet."
L["Locks/unlocks the grid for movement."] = "(Dé)verrouille la grille afin qu'elle puisse être déplacée."
L["Not specified"] = "Non spécifié"
L["Options for GridLayout."] = "Options concernant GridLayout."
L["Padding"] = "Espacement (cellules)"
L["Party Layout"] = "Disposition en groupe"
L["Pet color"] = "Couleur des familiers"
L["Pet coloring"] = "Coloration des familiers"
L["Reset Position"] = "RÀZ de la position"
L["Resets the layout frame's position and anchor."] = "Réinitialise la position et l'ancrage du cadre de style."
L["Right"] = "Droite"
L["Scale"] = "Échelle"
L["Select which layout to use when in a 10 player raid."] = "Sélectionnez la disposition à utiliser quand vous êtes dans un raid de 10 joueurs."
L["Select which layout to use when in a 25 player raid."] = "Sélectionnez la disposition à utiliser quand vous êtes dans un raid de 25 joueurs."
L["Select which layout to use when in a battleground."] = "Sélectionnez la disposition à utiliser quand vous êtes dans un champ de bataille."
L["Select which layout to use when in an arena."] = "Sélectionnez la disposition à utiliser quand vous êtes dans dans une arène."
L["Select which layout to use when in a party."] = "Sélectionnez la disposition à utiliser quand vous êtes dans un groupe."
L["Select which layout to use when not in a party."] = "Sélectionnez la disposition à utiliser quand vous êtes tout seul."
L["Sets where Grid is anchored relative to the screen."] = "Détermine où Grid est ancré par rapport à l'écran."
L["Sets where groups are anchored relative to the layout frame."] = "Détermine où les groupes sont ancrés par rapport à la grille."
L["Set the coloring strategy of pet units."] = "Définir la stratégie de coloration des familiers"
L["Set the color of pet units."] = "Ajuster la couleur des familiers"
L["Show Frame"] = "Afficher la grille"
L["Solo Layout"] = "Disposition quand seul"
L["Spacing"] = "Espacement (grille)"
L["Switch between horizontal/vertical groups."] = "Dispose les groupes horizontalement si coché."
L["The color of unknown pets."] = "Couleur des familiers inconnus."
L["The color of unknown units."] = "Couleur des unités inconnues."
L["Toggle whether to permit movement out of screen."] = "Permet ou non de déplacer la grille hors de l'écran."
L["Top"] = "Haut"
L["Top Left"] = "Haut Gauche"
L["Top Right"] = "Haut Droite"
L["Undead"] = "Mort-vivant"
L["Unknown Pet"] = "Familier inconnu"
L["Unknown Unit"] = "Unité inconnue"
L["Using Fallback color"] = "En utilisant la couleur par défaut"

------------------------------------------------------------------------
--	GridLayoutLayouts

L["By Class 10"] = "Groupe de 10 par classe"
L["By Class 10 w/Pets"] = "Groupe de 10 par classe avec familiers"
L["By Class 25"] = "Groupe de 25 par classe"
L["By Class 25 w/Pets"] = "Groupe de 25 par classe avec familiers"
L["By Group 10"] = "Raid de 10"
L["By Group 10 w/Pets"] = "Raid de 10 avec familiers"
L["By Group 15"] = "Raid de 15"
L["By Group 15 w/Pets"] = "Raid de 15 avec familiers"
L["By Group 25"] = "Raid de 25"
L["By Group 25 w/Pets"] = "Raid de 25 avec familiers"
L["By Group 25 w/Tanks"] = "Raid de 25 avec tanks"
L["By Group 40"] = "Raid de 40"
L["By Group 40 w/Pets"] = "Raid de 40 avec familiers"
L["By Group 5"] = "Groupe de 5"
L["By Group 5 w/Pets"] = "Groupe de 5 avec familiers"
L["None"] = "Aucun"

------------------------------------------------------------------------
--	GridLDB

L["Click to toggle the frame lock."] = "Clic gauche pour vérouiller/dévérouiller la grille."
L["Right-Click to open the options menu."] = "Clic droit pour afficher la fenêtre d'options."

------------------------------------------------------------------------
--	GridRoster


------------------------------------------------------------------------
--	GridStatus

L["Color"] = "Couleur"
L["Color for %s"] = "Couleur concernant %s."
L["Enable"] = "Activer"
L["Options for %s."] = "Options concernant %s."
L["Priority"] = "Priorité"
L["Priority for %s"] = "Priorité concernant %s."
L["Range filter"] = "Filtrer si pas à portée"
L["Reset class colors"] = "Réinitialisez la couleur des classes"
L["Reset class colors to defaults."] = "Réinitialisez la couleur des classes par défaut."
L["Show status only if the unit is in range."] = "Afficher uniquement si l'unité est à portée."
L["Status"] = "Statut"
L["Status: %s"] = "Statut : %s"
L["Text"] = "Texte"
L["Text to display on text indicators"] = "Le texte à afficher sur les indicateurs textuels."

------------------------------------------------------------------------
--	GridStatusAggro

L["Aggro"] = "Aggro"
L["Aggro alert"] = "Prise d'aggro"
L["Aggro color"] = "Couleur Aggro"
L["Color for Aggro."] = "Couleur à utiliser pour l'aggro."
L["Color for High Threat."] = "Couleur à utiliser pour la menace haute."
L["Color for Tanking."] = "Couleur à utiliser pour les tanks."
L["High"] = "Haut"
L["High Threat color"] = "Couleur Menace haute"
L["Show more detailed threat levels."] = "Affiche des niveaux de menace plus détaillés."
L["Tank"] = "Tank"
L["Tanking color"] = "Couleur Tank"
L["Threat"] = "Menace"

------------------------------------------------------------------------
--	GridStatusAuras

L["Add new Buff"] = "Ajouter un nouveau buff"
L["Add new Debuff"] = "Ajouter un nouveau débuff"
L["Adds a new buff to the status module"] = "Ajoute un nouveau buff au module Statut."
L["Adds a new debuff to the status module"] = "Ajoute un nouveau débuff au module Statut."
L["Auras"] = "Auras"
L["<buff name>"] = "<nom du buff>"
L["Buff: %s"] = "Buff : %s"
-- L["Change what information is shown by the status color."] = ""
-- L["Change what information is shown by the status color and text."] = ""
-- L["Change what information is shown by the status text."] = ""
L["Class Filter"] = "Filtrer les classes"
-- L["Color"] = ""
-- L["Color to use when the %s is above the high count threshold values."] = ""
-- L["Color to use when the %s is between the low and high count threshold values."] = ""
-- L["Color when %s is below the low threshold value."] = ""
L["Curse"] = "Malédiction"
L["<debuff name>"] = "<nom du débuff>"
-- L["(De)buff name"] = ""
L["Debuff: %s"] = "Débuff : %s"
L["Debuff type: %s"] = "Type de débuff : %s"
L["Delete (De)buff"] = "Supprimer (dé)buff"
L["Deletes an existing debuff from the status module"] = "Supprime un (dé)buff existant du module Statut."
L["Disease"] = "Maladie"
L["Display status only if the buff is not active."] = "Affiche le statut uniquement si le buff n'est pas actif."
L["Display status only if the buff was cast by you."] = "Affiche le statut uniquement si le buff est le vôtre."
L["Ghost"] = "Fantôme"
-- L["High color"] = ""
-- L["High threshold"] = ""
-- L["Low color"] = ""
-- L["Low threshold"] = ""
L["Magic"] = "Magie"
-- L["Middle color"] = ""
-- L["Pet"] = ""
L["Poison"] = "Poison"
-- L["Present or missing"] = ""
-- L["Refresh interval"] = ""
L["Remove %s from the menu"] = "Enlève %s du menu."
-- L["%s colors"] = ""
-- L["%s colors and threshold values."] = ""
L["Show duration"] = "Afficher la durée"
L["Show if mine"] = "Afficher si le mien"
L["Show if missing"] = "Afficher si manquant"
-- L["Show on pets and vehicles."] = ""
L["Show on %s players."] = "Affiche le statut pour la classe %s."
L["Show status for the selected classes."] = "Affiche le statut pour les classes sélectionnées."
-- L["Show the time left to tenths of a second, instead of only whole seconds."] = ""
L["Show the time remaining, for use with the center icon cooldown."] = "Affiche le temps restant. À utiliser avec le temps de recharge de l'icône centrale."
-- L["Show time left to tenths"] = ""
-- L["%s is high when it is at or above this value."] = ""
-- L["%s is low when it is at or below this value."] = ""
-- L["Stack count"] = ""
-- L["Status Information"] = ""
-- L["Text"] = ""
-- L["Time in seconds between each refresh of the status time left."] = ""
-- L["Time left"] = ""

------------------------------------------------------------------------
--	GridStatusHeals

L["Heals"] = "Soins"
L["Ignore heals cast by you."] = "Ignore les soins que vous incantez."
L["Ignore Self"] = "Vous ignorer"
L["Incoming heals"] = "Soins entrants"
L["Minimum Value"] = "Valeur minimale"
L["Only show incoming heals greater than this amount."] = "Montrer uniquement les soins entrants supérieurs à cette valeur."

------------------------------------------------------------------------
--	GridStatusHealth

L["Color deficit based on class."] = "Colorie le déficit selon la classe de l'unité."
L["Color health based on class."] = "Colorie la vie selon la classe de l'unité."
L["DEAD"] = "MORT"
L["Death warning"] = "Alerte Mort"
L["FD"] = "FM"
L["Feign Death warning"] = "Alerte Feindre la mort"
L["Health"] = "Vie"
L["Health deficit"] = "Déficit en vie"
L["Health threshold"] = "Seuil de vie"
L["Low HP"] = "Vie f."
L["Low HP threshold"] = "Seuil de vie faible"
L["Low HP warning"] = "Alerte Vie faible"
L["Offline"] = "Déco."
L["Offline warning"] = "Alerte Hors-ligne"
L["Only show deficit above % damage."] = "Affiche uniquement le déficit en dessous de ce pourcentage de dégâts."
L["Set the HP % for the low HP warning."] = "Détermine le pourcentage de vie à partir duquel s'enclenche l'avertissement Vie faible."
L["Show dead as full health"] = "Afficher les morts avec vie pleine"
L["Treat dead units as being full health."] = "Considère les unités décédées comme ayant toute leur vie."
L["Unit health"] = "Vie de l'unité"
L["Use class color"] = "Utiliser les couleurs de classe"

------------------------------------------------------------------------
--	GridStatusMana

L["Low Mana"] = "Mana faible"
L["Low Mana warning"] = "Alerte Mana faible"
L["Mana"] = "Mana"
L["Mana threshold"] = "Seuil du mana"
L["Set the percentage for the low mana warning."] = "Détermine le pourcentage de mana à partir duquel s'enclenche l'avertissement Mana faible."

------------------------------------------------------------------------
--	GridStatusName

L["Color by class"] = "Colorer selon la classe"
L["Unit Name"] = "Nom de l'unité"

------------------------------------------------------------------------
--	GridStatusRange

L["Out of Range"] = "Hors de portée"
L["Range"] = "Portée"
L["Range check frequency"] = "Fréquence des vérifications"
L["Seconds between range checks"] = "Le nombre de secondes entre chaque vérification de portée."

------------------------------------------------------------------------
--	GridStatusReadyCheck

L["?"] = "?"
L["AFK"] = "ABS"
L["AFK color"] = "Couleur ABS"
L["Color for AFK."] = "La couleur à utiliser pour les absents."
L["Color for Not Ready."] = "La couleur de ceux qui ne sont pas prêts."
L["Color for Ready."] = "La couleur à utiliser pour ceux qui sont prêts."
L["Color for Waiting."] = "La couleur à  utiliser pour ceux qui n'ont pas encore répondu."
L["Delay"] = "Délai"
L["Not Ready color"] = "Couleur Pas prêt"
L["R"] = "V"
L["Ready Check"] = "Appel"
L["Ready color"] = "Couleur Prêt"
L["Set the delay until ready check results are cleared."] = "Définit le délai avant que les résultats de l'appel ne soient effacés."
L["Waiting color"] = "Couleur En attente"
L["X"] = "X"

------------------------------------------------------------------------
--	GridStatusTarget

L["Target"] = "Cible"
L["Your Target"] = "Votre cible"

------------------------------------------------------------------------
--	GridStatusVehicle

L["Driving"] = "Conduit"
L["In Vehicle"] = "Dans un véhicule"

------------------------------------------------------------------------
--	GridStatusVoiceComm

L["Talking"] = "Parle"
L["Voice Chat"] = "Discussion vocale"
