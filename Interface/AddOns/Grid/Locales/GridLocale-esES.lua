--[[--------------------------------------------------------------------
	Grid Localization
	esES/esMX | Spanish (Europe/Latin America) | Español (Europa/America Latina)
----------------------------------------------------------------------]]

if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end

local _, Grid = ...
local L = { }
Grid.L = L

------------------------------------------------------------------------
--	GridCore

L["Debug"] = "Depurar"
L["Debugging"] = "Depuración"
L["Hide minimap icon"] = "Ocultar icono del minimapa"
L["Module debugging menu."] = "Depuración por los módulos"
L["Toggle debugging for %s."] = "Activar mensajes de depuración por %s"

------------------------------------------------------------------------
--	GridFrame

L["Adjust the font outline."] = "Ajustar el perfil de la fuente."
L["Adjust the font settings"] = "Ajustar la configuración de la fuente."
L["Adjust the font size."] = "Ajustar el tamaño de la fuente."
L["Adjust the height of each unit's frame."] = "Ajustar la altura de cada marco."
L["Adjust the size of the border indicators."] = "Ajustar el tamaño del borde del marco."
L["Adjust the size of the center icon."] = "Ajustar el tamaño del icono central."
L["Adjust the size of the center icon's border."] = "Ajustar el tamaño del borde del icono central."
L["Adjust the size of the corner indicators."] = "Ajustar el tamaño de los indicadores de la esquina."
L["Adjust the texture of each unit's frame."] = "Establecer la textura de las barras."
L["Adjust the width of each unit's frame."] = "Ajustar el ancho de cada marco."
L["Always"] = "Siempre"
L["Bar Options"] = "Opciones para las barras"
L["Border"] = "Borde"
L["Border Size"] = "Tamaño de borde"
L["Bottom Left Corner"] = "Esquina inferior izquierda"
L["Bottom Right Corner"] = "Esquina inferior derecha"
L["Center Icon"] = "Icono central"
L["Center Text"] = "Texto central"
L["Center Text 2"] = "Texto central 2"
L["Center Text Length"] = "Longitud de texto central"
L["Color the healing bar using the active status color instead of the health bar color."] = "Colorea la barra de curación usando el color del estado activo en lugar del color de la barra de vida." -- Needs review
L["Corner Size"] = "Tamaño de esquina"
L["Enable Mouseover Highlight"] = "Activar resaltar con ratón"
L["Enable %s"] = "Activar %s"
L["Enable %s indicator"] = "Activar el indicador %s"
L["Font"] = "Fuente"
L["Font Outline"] = "Perfil de fuente"
L["Font Shadow"] = "Sombra de fuente"
L["Font Size"] = "Tamaño de fuente"
L["Frame"] = "Marcos"
L["Frame Alpha"] = "Opacidad de marco"
L["Frame Height"] = "Altura de marco"
L["Frame Texture"] = "Textura de barra"
L["Frame Width"] = "Ancho de marco"
L["Healing Bar"] = "Barra de sanación"
L["Healing Bar Opacity"] = "Opacidad de la barra de sanación"
L["Healing Bar Uses Status Color"] = "Barra de Curación usa el color de la Barra de Estado" -- Needs review
L["Health Bar"] = "Barra de salud"
L["Health Bar Color"] = "Color de la barra de salud"
L["Horizontal"] = "Horizontal"
L["Icon Border Size"] = "Tamaño del borde del icono"
L["Icon Cooldown Frame"] = "Cooldown en icono central"
L["Icon Options"] = "Opciones para los iconos"
L["Icon Size"] = "Tamaño de icono"
L["Icon Stack Text"] = "Texto de dosis en icono"
L["Indicators"] = "Indicadores"
L["Invert Bar Color"] = "Invertir colores de barra"
L["Never"] = "Nunca"
L["None"] = "Ninguno"
L["Number of characters to show on Center Text indicator."] = "Mostrar este número de caracteres en el indicador de texto central."
L["OOC"] = "FDC"
L["Options for assigning statuses to indicators."] = "Opciones para la asignación de estados a los indicadores."
L["Options for GridFrame."] = "Opciones para los marcos de Grid"
L["Options for %s indicator."] = "Opciones para el indicador %s"
L["Options related to bar indicators."] = "Opciones para los indicadores de tipo barra."
L["Options related to icon indicators."] = "Opciones para los indicadores de tipo icono."
L["Options related to text indicators."] = "Opciones para los indicadores de tipo texto."
L["Orientation of Frame"] = "Orientación de marco"
L["Orientation of Text"] = "Orientación de texto"
L["Set frame orientation."] = "Establecer la orientación de los marcos."
L["Set frame text orientation."] = "Establecer la orientación del texto."
L["Sets the opacity of the healing bar."] = "Ajustar la opacidad de la barra de sanación."
L["Show Tooltip"] = "Mostrar tooltip"
L["Show unit tooltip.  Choose 'Always', 'Never', or 'OOC'."] = "Mostrar tooltip de unidad. Eligir 'Siempre', 'Nunca' o 'FDC'."
L["Statuses"] = "Estados"
L["Swap foreground/background colors on bars."] = "Cambiar los colores de primer plano y fondo de la barra de salud."
L["Text Options"] = "Opciones para el texto"
L["Thick"] = "Grueso"
L["Thin"] = "Fino"
L["Throttle Updates"] = "Limitar actualizaciones"
L["Throttle updates on group changes. This option may cause delays in updating frames, so you should only enable it if you're experiencing temporary freezes or lockups when people join or leave your group."] = "Limitar actualizaciones para cambios de grupo. Esta opción puede causar retrasos en la actualización de los marcos; sólo se activará si tienes problems con tu FPS cuando personages entran o salen de tu grupo."
L["Toggle center icon's cooldown frame."] = "Activar/desactivar el cooldown en el icono central."
L["Toggle center icon's stack count text."] = "Activar/desactivar el texto de contador del icono central."
L["Toggle mouseover highlight."] = "Activar/desactivar resaltado con ratón"
L["Toggle status display."] = "Activar visualización de estado"
L["Toggle the font drop shadow effect."] = "Mostrar la sombra de la fuente."
L["Toggle the %s indicator."] = "Activar/desactivar el indicador %s"
L["Top Left Corner"] = "Esquina superior izquierda"
L["Top Right Corner"] = "Esquina superior derecha"
L["Vertical"] = "Vertical"

------------------------------------------------------------------------
--	GridLayout

L["10 Player Raid Layout"] = "Diseño - Banda de 10"
L["25 Player Raid Layout"] = "Diseño - Banda de 25"
L["Adjust background color and alpha."] = "Ajustar el color y la opacidad del fondo."
L["Adjust border color and alpha."] = "Ajustar el color y la opacidad del borde."
L["Adjust frame padding."] = "Ajustar la separación entre los marcos y la ventana que los contiene."
L["Adjust frame spacing."] = "Ajustar la separación de un marco de otro."
L["Adjust Grid scale."] = "Ajustar la escala de Grid."
L["Advanced"] = "Avanzado"
L["Advanced options."] = "Opciones avanzadas"
L["Allows mouse click through the Grid Frame."] = "Permiter hacer clic a través de la ventana de Grid."
L["Alt-Click to permanantly hide this tab."] = "Alt + clic para ocultar permanentemente esta pestaña."
L["Arena Layout"] = "Diseño - Arena"
L["Background color"] = "Color de fondo"
L["Battleground Layout"] = "Diseño - Campo de Batalla"
L["Beast"] = "Bestia"
L["Border color"] = "Color de borde"
L["Border Texture"] = "Textura del borde"
L["Bottom"] = "Abajo"
L["Bottom Left"] = "Inferior-Izquierda"
L["Bottom Right"] = "Inferior-Derecha"
L["By Creature Type"] = "Por tipo de criatura"
L["By Owner Class"] = "Por clase del dueño"
L["Center"] = "Centro"
L["Choose the layout border texture."] = "Selecciona la textura del borde de la ventana de Grid."
L["Clamped to screen"] = "Bloqueado a la pantalla"
L["Class colors"] = "Colores de clases"
L["Click through the Grid Frame"] = "Clic a través de Grid"
L["Color for %s."] = "Color de %s"
L["Color of pet unit creature types."] = "Color del tipo de criatura de la mascota."
L["Color of player unit classes."] = "Color de las clases del jugador."
L["Color of unknown units or pets."] = "Color de mascotas o unidades desconocidas."
L["Color options for class and pets."] = "Opciones para los colores de clases y mascotas."
L["Colors"] = "Colores"
L["Creature type colors"] = "Color de tipo de criatura"
L["Demon"] = "Demonio"
L["Do not show the tab when Grid is unlocked."] = "No mostrar la pestaña cuando Grid está desbloqueado."
L["Dragonkin"] = "Dragonante"
L["Drag this tab to move Grid."] = "Arrastrar esta pestaña para mover Grid."
L["Elemental"] = "Elemental"
L["Fallback colors"] = "Colores alternativos"
L["Frame lock"] = "Bloquear ventana"
L["Group Anchor"] = "Ancla de grupo"
L["Hide tab"] = "Ocultar pestaña"
L["Horizontal groups"] = "Grupos horizontales"
L["Humanoid"] = "Humanoide"
L["Layout"] = "Diseño"
L["Layout Anchor"] = "Ancla de ventana"
L["Left"] = "Izquierda"
L["Lock Grid to hide this tab."] = "Bloquear Grid para ocultar esta pestaña."
L["Locks/unlocks the grid for movement."] = "Bloquear/desbloquear el movimiento de Grid."
L["Not specified"] = "No especificado"
L["Options for GridLayout."] = "Opciones para el diseño de Grid."
L["Padding"] = "Relleno"
L["Party Layout"] = "Diseño - Grupo"
L["Pet color"] = "Color de mascota"
L["Pet coloring"] = "Coloreado de mascotas"
L["Reset Position"] = "Restaurar posición"
L["Resets the layout frame's position and anchor."] = "Restaurar la posición y el ancla de la ventana."
L["Right"] = "Derecha"
L["Scale"] = "Escala"
L["Select which layout to use when in a 10 player raid."] = "Seleccionar qué diseño quieres usar cuando estás en banda de 10 jugadores."
L["Select which layout to use when in a 25 player raid."] = "Seleccionar qué diseño quieres usar cuando estás en banda de 25 jugadores."
L["Select which layout to use when in a battleground."] = "Seleccionar qué diseño quieres usar cuando estás en campo de batalla."
L["Select which layout to use when in an arena."] = "Seleccionar qué diseño quieres usar cuando estás en arena."
L["Select which layout to use when in a party."] = "Seleccionar qué diseño quieres usar cuando estás en grupo."
L["Select which layout to use when not in a party."] = "Seleccionar qué diseño quieres usar cuando no estás en grupo."
L["Sets where Grid is anchored relative to the screen."] = "Establecer dónde se ancla grid relativo a la pantalla."
L["Sets where groups are anchored relative to the layout frame."] = "Establecer donde se anclan los grupos relativos a la ventana de Grid."
L["Set the coloring strategy of pet units."] = "Establecer la regla de coloreado de mascotas."
L["Set the color of pet units."] = "Establecer el color oara mascotas."
L["Show Frame"] = "Mostrar marco"
L["Solo Layout"] = "Diseño - Solo"
L["Spacing"] = "Espaciamiento"
L["Switch between horizontal/vertical groups."] = "Cambiar entre grupos horizontales/verticales."
L["The color of unknown pets."] = "El color de mascotas desconocidas."
L["The color of unknown units."] = "El color de unidades desconocidas."
L["Toggle whether to permit movement out of screen."] = "Permitir o no, moverlo fuera de la pantalla."
L["Top"] = "Arriba"
L["Top Left"] = "Superior-Izquierda"
L["Top Right"] = "Superior-Derecha"
L["Undead"] = "No muerto"
L["Unknown Pet"] = "Mascota desconocida"
L["Unknown Unit"] = "Unidad desconocida"
L["Using Fallback color"] = "Usando el color alternativo"

------------------------------------------------------------------------
--	GridLayoutLayouts

L["By Class 10"] = "Grupo de 10 por clases"
L["By Class 10 w/Pets"] = "Grupo de 10 por clases con mascotas"
L["By Class 25"] = "Grupo de 25 por clases"
L["By Class 25 w/Pets"] = "Grupo de 25 por clases con mascotas"
L["By Group 10"] = "Grupo de 10"
L["By Group 10 w/Pets"] = "Grupo de 10 con mascotas"
L["By Group 15"] = "Grupo de 15"
L["By Group 15 w/Pets"] = "Grupo de 15 con mascotas"
L["By Group 25"] = "Grupo de 25"
L["By Group 25 w/Pets"] = "Grupo de 25 con mascotas"
L["By Group 25 w/Tanks"] = "Grupo de 25 con tanques"
L["By Group 40"] = "Grupo de 40"
L["By Group 40 w/Pets"] = "Grupo de 40 con mascotas"
L["By Group 5"] = "Grupo de 5"
L["By Group 5 w/Pets"] = "Grupo de 5 con mascotas"
L["None"] = "Ninguno"

------------------------------------------------------------------------
--	GridLDB

L["Click to toggle the frame lock."] = "Haz clic para bloquear/desbloquear el movimiento de Grid."
L["Right-Click to open the options menu."] = "Haz clic derecho para ver más opciones."

------------------------------------------------------------------------
--	GridRoster


------------------------------------------------------------------------
--	GridStatus

L["Color"] = "Color"
L["Color for %s"] = "Color de %s"
L["Enable"] = "Activar"
L["Options for %s."] = "Opciones para %s"
L["Priority"] = "Prioridad"
L["Priority for %s"] = "Prioridad de %s"
L["Range filter"] = "Filtro de rango"
L["Reset class colors"] = "Restaurar colores de clase"
L["Reset class colors to defaults."] = "Restaurar los colores de clase por defecto."
L["Show status only if the unit is in range."] = "Filtro de rango de %s" -- Needs review
L["Status"] = "Estado"
L["Status: %s"] = "Estado: %s"
L["Text"] = "Texto"
L["Text to display on text indicators"] = "Texto para mostrar en el indicador de texto"

------------------------------------------------------------------------
--	GridStatusAggro

L["Aggro"] = "Amenaza"
L["Aggro alert"] = "Alerta de amenaza"
L["Aggro color"] = "Color de amenaza"
L["Color for Aggro."] = "Color de amenaza"
L["Color for High Threat."] = "Color de gran amenaza"
L["Color for Tanking."] = "Color de tanque"
L["High"] = "Alto"
L["High Threat color"] = "Color de gran amenaza"
L["Show more detailed threat levels."] = "Mostrar niveles de amenaza más detallados"
L["Tank"] = "Tanque"
L["Tanking color"] = "Color de tanque"
L["Threat"] = "Amenaza"

------------------------------------------------------------------------
--	GridStatusAuras

L["Add new Buff"] = "Añadir beneficio"
L["Add new Debuff"] = "Añadir un nuevo perjuicio"
L["Adds a new buff to the status module"] = "Añadir un otro beneficio al módulo de estado"
L["Adds a new debuff to the status module"] = "Añadir un nuevo perjuicio al módulo de estado"
L["Auras"] = "Auras"
L["<buff name>"] = "<nombre del beneficio>"
L["Buff: %s"] = "Beneficio: %s"
-- L["Change what information is shown by the status color."] = ""
-- L["Change what information is shown by the status color and text."] = ""
-- L["Change what information is shown by the status text."] = ""
L["Class Filter"] = "Filtro de Clases"
-- L["Color"] = ""
-- L["Color to use when the %s is above the high count threshold values."] = ""
-- L["Color to use when the %s is between the low and high count threshold values."] = ""
-- L["Color when %s is below the low threshold value."] = ""
L["Curse"] = "Maldición"
L["<debuff name>"] = "<nombre del perjuicio>"
L["(De)buff name"] = "Nombre del (De)buff " -- Needs review
L["Debuff: %s"] = "Perjuicio: %s"
L["Debuff type: %s"] = "Tipo de perjuicio: %s"
L["Delete (De)buff"] = "Borrar beneficio o perjuicio"
L["Deletes an existing debuff from the status module"] = "Borrar un beneficio o perjuicio del módulo de estado"
L["Disease"] = "Enfermedad"
L["Display status only if the buff is not active."] = "Mostrar el estado sólo si el beneficio no está activo"
L["Display status only if the buff was cast by you."] = "Mostrar el estado sólo si el beneficio fue lanzado por ti"
L["Ghost"] = "Fantasma"
-- L["High color"] = ""
-- L["High threshold"] = ""
-- L["Low color"] = ""
-- L["Low threshold"] = ""
L["Magic"] = "Magia"
-- L["Middle color"] = ""
L["Pet"] = "Mascota" -- Needs review
L["Poison"] = "Veneno"
-- L["Present or missing"] = ""
L["Refresh interval"] = "Intervalo de actualización" -- Needs review
L["Remove %s from the menu"] = "Eliminar %s del menú"
L["%s colors"] = "%s colores" -- Needs review
L["%s colors and threshold values."] = "%s colores y valores de umbral." -- Needs review
L["Show duration"] = "Mostrar duración"
L["Show if mine"] = "Mostrar si es mío"
L["Show if missing"] = "Mostrar si falta"
L["Show on pets and vehicles."] = "Mostrar en mascotas y vehículos." -- Needs review
L["Show on %s players."] = "Mostrar en %s." -- Needs review
L["Show status for the selected classes."] = "Mostrar el estado para las clases seleccionadas."
-- L["Show the time left to tenths of a second, instead of only whole seconds."] = ""
L["Show the time remaining, for use with the center icon cooldown."] = "Mostrar el tiempo restante, para usar con el cooldown del icono central"
-- L["Show time left to tenths"] = ""
-- L["%s is high when it is at or above this value."] = ""
-- L["%s is low when it is at or below this value."] = ""
-- L["Stack count"] = ""
-- L["Status Information"] = ""
-- L["Text"] = ""
-- L["Time in seconds between each refresh of the status time left."] = ""
L["Time left"] = "Tiempo restante" -- Needs review

------------------------------------------------------------------------
--	GridStatusHeals

L["Heals"] = "Sanaciones"
L["Ignore heals cast by you."] = "Ignorar las sanaciones en curso de lanzamiento por tu mismo."
L["Ignore Self"] = "Ignorar las propias"
L["Incoming heals"] = "Próximas sanaciones"
L["Minimum Value"] = "Cantidad mínima"
L["Only show incoming heals greater than this amount."] = "Mostrar sólo las sanaciones en curso de lanzamiento superior a esta candidad."

------------------------------------------------------------------------
--	GridStatusHealth

L["Color deficit based on class."] = "Mostrar déficit basado en clase"
L["Color health based on class."] = "Color de la vida basado en la clase"
L["DEAD"] = "Muerto"
L["Death warning"] = "Alerta de muerte"
L["FD"] = "FM"
L["Feign Death warning"] = "Alerta de Fingir Muerte"
L["Health"] = "Salud"
L["Health deficit"] = "Falta de salud"
L["Health threshold"] = "Límite de salud"
L["Low HP"] = "Poca vida"
L["Low HP threshold"] = "Límite de salud baja"
L["Low HP warning"] = "Alerta de salud baja"
L["Offline"] = "Desconectado"
L["Offline warning"] = "Alerta de desconectado"
L["Only show deficit above % damage."] = "Mostrar déficit sobre % de daño"
L["Set the HP % for the low HP warning."] = "Establece el % límite para la alerta de salud baja"
L["Show dead as full health"] = "Mostrar muerto como vida completa"
L["Treat dead units as being full health."] = "Trata las unidades muertas como si tuvieran la salud al completo"
L["Unit health"] = "Salud de la unidad"
L["Use class color"] = "Usar color de clase"

------------------------------------------------------------------------
--	GridStatusMana

L["Low Mana"] = "Poco maná"
L["Low Mana warning"] = "Alerta de maná bajo"
L["Mana"] = "Maná"
L["Mana threshold"] = "Límite de maná"
L["Set the percentage for the low mana warning."] = "Establece el porcentaje para la alerta de maná bajo"

------------------------------------------------------------------------
--	GridStatusName

L["Color by class"] = "Color por clase"
L["Unit Name"] = "Nombre de unidad"

------------------------------------------------------------------------
--	GridStatusRange

L["Out of Range"] = "Fuera de alcance"
L["Range"] = "Rango"
L["Range check frequency"] = "Frecuencia de revisiones de rango" -- Needs review
L["Seconds between range checks"] = "Segundos entre revisiones de rango" -- Needs review

------------------------------------------------------------------------
--	GridStatusReadyCheck

L["?"] = "?"
L["AFK"] = "AFK"
L["AFK color"] = "Color de AFK"
L["Color for AFK."] = "Color de AFK."
L["Color for Not Ready."] = "Color para el que no está preparado."
L["Color for Ready."] = "Color para el que está preparado."
L["Color for Waiting."] = "Color para la espera."
L["Delay"] = "Retraso"
L["Not Ready color"] = "Color para el que no está preparado"
L["R"] = "R"
L["Ready Check"] = "Ready Check"
L["Ready color"] = "Color de preparado"
L["Set the delay until ready check results are cleared."] = "Establece el retraso hasta que los resultados del Ready Check se limpien"
L["Waiting color"] = "Color de espera"
L["X"] = "X"

------------------------------------------------------------------------
--	GridStatusTarget

L["Target"] = "Objetivo"
L["Your Target"] = "Tu objetivo"

------------------------------------------------------------------------
--	GridStatusVehicle

L["Driving"] = "Conduciendo"
L["In Vehicle"] = "En vehículo"

------------------------------------------------------------------------
--	GridStatusVoiceComm

L["Talking"] = "Hablando"
L["Voice Chat"] = "Chat de voz"
