--[[--------------------------------------------------------------------
	Grid Localization
	ruRU | Russian | Русский
----------------------------------------------------------------------]]

if GetLocale() ~= "ruRU" then return end

local _, Grid = ...
local L = { }
Grid.L = L

------------------------------------------------------------------------
--	GridCore

L["Debug"] = "Отладка"
L["Debugging"] = "Отладка"
L["Hide minimap icon"] = "Скрыть иконку на миникарте"
L["Module debugging menu."] = "Меню модуля отладки"
L["Toggle debugging for %s."] = "Показать отладку для  %s."

------------------------------------------------------------------------
--	GridFrame

L["Adjust the font outline."] = "Настройка контура шрифта"
L["Adjust the font settings"] = "Настройка параметров шрифта"
L["Adjust the font size."] = "Настройка размера шрифта"
L["Adjust the height of each unit's frame."] = "Настроить высоту фреймов."
L["Adjust the size of the border indicators."] = "Настроить размер гриниц индикаторов."
L["Adjust the size of the center icon."] = "Настройка размера значка в центре"
L["Adjust the size of the center icon's border."] = "Настраивает размер границы значка в центре."
L["Adjust the size of the corner indicators."] = "Настроить размер углов индикаторов."
L["Adjust the texture of each unit's frame."] = "Настроить текстуру игровых фреймов."
L["Adjust the width of each unit's frame."] = "Настроить ширину фреймов."
L["Always"] = "Всегда"
L["Bar Options"] = "Настройки панели"
L["Border"] = "Граница"
L["Border Size"] = "Размер границ"
L["Bottom Left Corner"] = "Нижний левый угол"
L["Bottom Right Corner"] = "Нижний правый угол"
L["Center Icon"] = "Иконка в центре"
L["Center Text"] = "Текст в центре"
L["Center Text 2"] = "Текст в центре 2"
L["Center Text Length"] = "Длина текста в центре"
-- L["Color the healing bar using the active status color instead of the health bar color."] = ""
L["Corner Size"] = "Размер Углов"
L["Enable Mouseover Highlight"] = "Выделение при наведении мышки."
L["Enable %s"] = "Включено %s"
L["Enable %s indicator"] = "Включить %s индикатор"
L["Font"] = "Шрифт"
L["Font Outline"] = "Контур шрифта"
L["Font Shadow"] = "Тень шрифта"
L["Font Size"] = "Размер шрифта"
L["Frame"] = "Фреймы"
L["Frame Alpha"] = "Прозрачность фреймов"
L["Frame Height"] = "Высота Фреймов"
L["Frame Texture"] = "Текстура Фреймов"
L["Frame Width"] = "Ширина Фреймов"
L["Healing Bar"] = "Полоса лечения"
L["Healing Bar Opacity"] = "Прозрачность полосы лечения"
-- L["Healing Bar Uses Status Color"] = ""
L["Health Bar"] = "Полоса здоровья"
L["Health Bar Color"] = "Цвет полосы здоровья"
L["Horizontal"] = "Горизонтально"
L["Icon Border Size"] = "Размер границы значка"
L["Icon Cooldown Frame"] = "Фрейм перерыва (cooldown) значка"
L["Icon Options"] = "Настройки иконки"
L["Icon Size"] = "Размер иконки"
L["Icon Stack Text"] = "Текст множества значков"
L["Indicators"] = "Индикаторы"
L["Invert Bar Color"] = "Обратить цвет полос"
L["Never"] = "Никогда"
L["None"] = "нету"
L["Number of characters to show on Center Text indicator."] = "Количество символов для отображения текста в центре."
L["OOC"] = "Вне боя"
L["Options for assigning statuses to indicators."] = "Опция для присвоения статусов индикаторам" -- Needs review
L["Options for GridFrame."] = "Опции фреймов Grid"
L["Options for %s indicator."] = "Опции для %s индикаторов."
L["Options related to bar indicators."] = "Настройки связанные с индикатором панели."
L["Options related to icon indicators."] = "Настройки связанные с индикатором иконки."
L["Options related to text indicators."] = "Настройки связанные с индикатором текста."
L["Orientation of Frame"] = "Ориентация фреймов"
L["Orientation of Text"] = "Ориентация текста"
L["Set frame orientation."] = "Установить ориеетацию фреймов"
L["Set frame text orientation."] = "Установить ориентацию текста фреймов"
L["Sets the opacity of the healing bar."] = "Установить прозрачность полосы лечения."
L["Show Tooltip"] = "Показывать подсказки"
L["Show unit tooltip.  Choose 'Always', 'Never', or 'OOC'."] = "Показывать подсказку единицы.  Выберите 'Всегда', 'Никогда', или 'Вне боя'."
L["Statuses"] = "Статусы"
L["Swap foreground/background colors on bars."] = "Поменять местами цвет фасада/фона полос"
L["Text Options"] = "Настройки текста"
L["Thick"] = "Толстый"
L["Thin"] = "Тонкий"
L["Throttle Updates"] = "оптимальные обновления" -- Needs review
L["Throttle updates on group changes. This option may cause delays in updating frames, so you should only enable it if you're experiencing temporary freezes or lockups when people join or leave your group."] = "Оптимальные обновления на изменение группы. Данный вариант может привести к снижению к частоте кадров, вы можете включить данный параметр если у вас возникли временные \"зависания\" в момент присоединения людей к группе или когда люди покидают группу" -- Needs review
L["Toggle center icon's cooldown frame."] = "Показывать фрейм перерыва значка в центре"
L["Toggle center icon's stack count text."] = "Показывать количество значков в множестве"
L["Toggle mouseover highlight."] = "Вкл/Выкл выделение при наведении курсора мыши."
L["Toggle status display."] = "Переключить статус на дисплее."
L["Toggle the font drop shadow effect."] = "Переключение эффекта тени шрифта."
L["Toggle the %s indicator."] = "Показать %s индикатор."
L["Top Left Corner"] = "Верхний левый угол"
L["Top Right Corner"] = "Верхний правый угол"
L["Vertical"] = "Вертикально"

------------------------------------------------------------------------
--	GridLayout

L["10 Player Raid Layout"] = "Расположение для 10 игроков"
L["25 Player Raid Layout"] = "Расположение для 25 игроков"
L["Adjust background color and alpha."] = "Настроить цвет фона и прозрачность"
L["Adjust border color and alpha."] = "Настроить цвет границы и прозрачность"
L["Adjust frame padding."] = "Настроить заполнение фреймов"
L["Adjust frame spacing."] = "Настроить интервалы между фреймами"
L["Adjust Grid scale."] = "Настроиь масштаб Grid"
L["Advanced"] = "Дополнительно"
L["Advanced options."] = "Дополнительные настройки."
L["Allows mouse click through the Grid Frame."] = "Разрешает мышкой кликать сквозь окно Grid"
L["Alt-Click to permanantly hide this tab."] = "Alt-Клик скрывает данный ярлык."
L["Arena Layout"] = "Расположение на арене"
L["Background color"] = "Фон"
L["Battleground Layout"] = "Расположение на ПС"
L["Beast"] = "Животное"
L["Border color"] = "Граница"
L["Border Texture"] = "Текстуры границы"
L["Bottom"] = "Внизу"
L["Bottom Left"] = "Внизу Слева"
L["Bottom Right"] = "Внизу Справа"
L["By Creature Type"] = "По типу существа"
L["By Owner Class"] = "По классу владельца"
L["Center"] = "Центр"
L["Choose the layout border texture."] = "Выбор текстуры границы."
L["Clamped to screen"] = "В пределах экрана"
L["Class colors"] = "Цвет классов"
L["Click through the Grid Frame"] = "Выбирать через окно Grid"
L["Color for %s."] = "Цвет для %s."
L["Color of pet unit creature types."] = "Цвет типов питомцев созданий"
L["Color of player unit classes."] = "Цвет классов персонажей"
L["Color of unknown units or pets."] = "Цвет неизвестных единиц или питомцев"
L["Color options for class and pets."] = "Опции окраски для классов и питомцев"
L["Colors"] = "Цвета"
L["Creature type colors"] = "Цвет типов созданий"
L["Demon"] = "Демон"
L["Do not show the tab when Grid is unlocked."] = "Не отображать ярлык когда Grid откреплен."
L["Dragonkin"] = "Дракон"
L["Drag this tab to move Grid."] = "Перетаскивая этот ярлык вы перемстите Grid."
L["Elemental"] = "Элементаль"
L["Fallback colors"] = "Цвета неизветсных"
L["Frame lock"] = "Закрепить фреймы"
L["Group Anchor"] = "Пометка группы"
L["Hide tab"] = "Скрыть ярлык"
L["Horizontal groups"] = "Группы горизонтально"
L["Humanoid"] = "Гуманоид"
L["Layout"] = "Расположение"
L["Layout Anchor"] = "Пометка расположения"
L["Left"] = "Слева"
L["Lock Grid to hide this tab."] = "Закрепить Grid чтобы скрыть данный ярлык."
L["Locks/unlocks the grid for movement."] = "Закрепляет/открепляет окно для передвижения"
L["Not specified"] = "Не указано"
L["Options for GridLayout."] = "Опции для GridLayout"
L["Padding"] = "Заполнение"
L["Party Layout"] = "Расположение группы"
L["Pet color"] = "Цвет питомцев"
L["Pet coloring"] = "Окраска питомцев"
L["Reset Position"] = "Сбросить Позицию"
L["Resets the layout frame's position and anchor."] = "Сбросить положение фреймов и пометок"
L["Right"] = "Справа"
L["Scale"] = "Масштаб"
L["Select which layout to use when in a 10 player raid."] = "Выбрать какое расположение использовать в рейде для 10 игроков."
L["Select which layout to use when in a 25 player raid."] = "Выбрать какое расположение использовать в рейде для 25 игроков."
L["Select which layout to use when in a battleground."] = "Выбрать какое расположение использовать на полях сражений."
L["Select which layout to use when in an arena."] = "Выбрать какое расположение использовать на арене."
L["Select which layout to use when in a party."] = "Выбрать какое расположение использовать в группе."
L["Select which layout to use when not in a party."] = "Выбрать какое расположение использовать не находясь в группе."
L["Sets where Grid is anchored relative to the screen."] = "Установить пометку где будет находиться Grid на экране"
L["Sets where groups are anchored relative to the layout frame."] = "Установить пометку где будет находиться группа на экране"
L["Set the coloring strategy of pet units."] = "Установиь стратегию окраски питомцев."
L["Set the color of pet units."] = "Установить цвет питомцев."
L["Show Frame"] = "Отображение фреймов"
L["Solo Layout"] = "Расположение в соло"
L["Spacing"] = "Интервалы"
L["Switch between horizontal/vertical groups."] = "Переключить между группы вертикально/горизонтально."
L["The color of unknown pets."] = "Цвет неизветсных питомцев"
L["The color of unknown units."] = "Цвет неизвестной единицы"
L["Toggle whether to permit movement out of screen."] = "Не позволять перемещать окно за пределы экрана"
L["Top"] = "Вверху"
L["Top Left"] = "Вверху Слева"
L["Top Right"] = "Вверху Справа"
L["Undead"] = "Нежить"
L["Unknown Pet"] = "Неизвестные питомцы"
L["Unknown Unit"] = "Неизвестная единица"
L["Using Fallback color"] = "Использовать истинный цвет"

------------------------------------------------------------------------
--	GridLayoutLayouts

L["By Class 10"] = "По классам из 10 чел"
L["By Class 10 w/Pets"] = "По классам из 10 чел. с питомцами"
L["By Class 25"] = "По классам из 25 чел"
L["By Class 25 w/Pets"] = "По классам из 25 чел. с питомцами"
L["By Group 10"] = "Для Группы из 10 чел."
L["By Group 10 w/Pets"] = "Для Группы из 10 чел. с питомцами"
L["By Group 15"] = "Для Группы из 15 чел."
L["By Group 15 w/Pets"] = "Для Группы из 15 чел. с питомцами"
L["By Group 25"] = "Для Группы из 25 чел."
L["By Group 25 w/Pets"] = "Для Группы из 25 чел. с питомцами"
L["By Group 25 w/Tanks"] = "Для Группы из 25 чел. с танками"
L["By Group 40"] = "Для Группы из 40 чел."
L["By Group 40 w/Pets"] = "Для Группы из 40 чел. с питомцами"
L["By Group 5"] = "Для Группы из 5 чел."
L["By Group 5 w/Pets"] = "Для Группы из 5 чел. с питомцами"
L["None"] = "Нет"

------------------------------------------------------------------------
--	GridLDB

L["Click to toggle the frame lock."] = "Клик - вкл/выкл фиксацию фрейма."
L["Right-Click to open the options menu."] = "Правый-Клик - открывает окно настроек."

------------------------------------------------------------------------
--	GridRoster


------------------------------------------------------------------------
--	GridStatus

L["Color"] = "Цвет"
L["Color for %s"] = "Цвет для %s"
L["Enable"] = "Включено"
L["Options for %s."] = "Опции для %s."
L["Priority"] = "Приоритет"
L["Priority for %s"] = "Приоритет для %s"
L["Range filter"] = "Фильтр радиуса"
L["Reset class colors"] = "Сбросс окраски классов"
L["Reset class colors to defaults."] = "Сбросить окраску классов на значение по умолчанию."
L["Show status only if the unit is in range."] = "Фильтр радиуса для %s" -- Needs review
L["Status"] = "Статус"
L["Status: %s"] = "Статус: %s"
L["Text"] = "Текст"
L["Text to display on text indicators"] = "Отображаемый текст в индикаторе"

------------------------------------------------------------------------
--	GridStatusAggro

L["Aggro"] = "Агро"
L["Aggro alert"] = "Сигнал Агро"
L["Aggro color"] = "Цвет агро"
L["Color for Aggro."] = "Окраска агро"
L["Color for High Threat."] = "Окраска наивысшей угрозы."
L["Color for Tanking."] = "Окраска танкования"
L["High"] = "Наивысшая"
L["High Threat color"] = "Цвет наивысшей угрозы"
L["Show more detailed threat levels."] = "Отображение более подробного уровеня угрозы."
L["Tank"] = "Танк"
L["Tanking color"] = "Цвет танкования"
L["Threat"] = "Угроза"

------------------------------------------------------------------------
--	GridStatusAuras

L["Add new Buff"] = "Добавить новый бафф"
L["Add new Debuff"] = "Добавить новый дебафф"
L["Adds a new buff to the status module"] = "Добавляет новый бафф в можуль статуса"
L["Adds a new debuff to the status module"] = "Добавляет новый дебафф в модуль статуса"
L["Auras"] = "Ауры"
L["<buff name>"] = "<имя баффа>"
L["Buff: %s"] = "Бафф: %s"
-- L["Change what information is shown by the status color."] = ""
-- L["Change what information is shown by the status color and text."] = ""
-- L["Change what information is shown by the status text."] = ""
L["Class Filter"] = "Фильтр классов"
-- L["Color"] = ""
-- L["Color to use when the %s is above the high count threshold values."] = ""
-- L["Color to use when the %s is between the low and high count threshold values."] = ""
-- L["Color when %s is below the low threshold value."] = ""
L["Curse"] = "Проклятье"
L["<debuff name>"] = "<имя дебаффа>"
-- L["(De)buff name"] = ""
L["Debuff: %s"] = "Дебафф: %s"
L["Debuff type: %s"] = "Тип Дебаффа: %s"
L["Delete (De)buff"] = "Удалить бафф/дебафф"
L["Deletes an existing debuff from the status module"] = "Удаляет выбранный дебафф в модуле статуса модуль"
L["Disease"] = "Болезнь"
L["Display status only if the buff is not active."] = "Показывать статус только если баффы не активны"
L["Display status only if the buff was cast by you."] = "Показывать статус только если баффы применяются на вас"
L["Ghost"] = "Призрак"
-- L["High color"] = ""
-- L["High threshold"] = ""
-- L["Low color"] = ""
-- L["Low threshold"] = ""
L["Magic"] = "Магия"
-- L["Middle color"] = ""
-- L["Pet"] = ""
L["Poison"] = "Яды"
-- L["Present or missing"] = ""
-- L["Refresh interval"] = ""
L["Remove %s from the menu"] = "Удалите %s из меню"
-- L["%s colors"] = ""
-- L["%s colors and threshold values."] = ""
L["Show duration"] = "Длительность"
L["Show if mine"] = "Показать если моё"
L["Show if missing"] = "Показывать если пропущен"
-- L["Show on pets and vehicles."] = ""
L["Show on %s players."] = "Показать на %s." -- Needs review
L["Show status for the selected classes."] = "Показывает статус для выбранных классов."
-- L["Show the time left to tenths of a second, instead of only whole seconds."] = ""
L["Show the time remaining, for use with the center icon cooldown."] = "Показывать в центре иконки остаток времени."
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

L["Heals"] = "Лечения"
L["Ignore heals cast by you."] = "Игнорировать свои лечебные заклинания"
L["Ignore Self"] = "Игнорировать себя"
L["Incoming heals"] = "Поступающее лечения"
L["Minimum Value"] = "Мин. значение"
L["Only show incoming heals greater than this amount."] = "Показывать только входящее исцеление которое больше установленного значения."

------------------------------------------------------------------------
--	GridStatusHealth

L["Color deficit based on class."] = "Цвет дефицита в зависимости от класса"
L["Color health based on class."] = "Цвет полосы здоровья в зависимости от класса"
L["DEAD"] = "ТРУП"
L["Death warning"] = "Предупреждение о смерти"
L["FD"] = "ПМ"
L["Feign Death warning"] = "Предупреждение о Симуляции смерти"
L["Health"] = "Здоровье"
L["Health deficit"] = "Дефицит здоровья"
L["Health threshold"] = "Порог здоровья"
L["Low HP"] = "Мало ЗД"
L["Low HP threshold"] = "Порог \"Мало ЗД\""
L["Low HP warning"] = "Предупреждение Мало ЗД"
L["Offline"] = "Оффлайн"
L["Offline warning"] = "Предупреждение об оффлайне"
L["Only show deficit above % damage."] = "Показывать дефицит только после % урона."
L["Set the HP % for the low HP warning."] = "Установить % для предупреждения о том что у единицы мало здоровья."
L["Show dead as full health"] = "Показывать мертвых как-будто с полным здоровьем"
L["Treat dead units as being full health."] = "расматривать данные единицы как имеющие полное здоровье."
L["Unit health"] = "Здоровье единицы"
L["Use class color"] = "Использовать цвет классов"

------------------------------------------------------------------------
--	GridStatusMana

L["Low Mana"] = "Мало маны"
L["Low Mana warning"] = "Предупреждение о заканчивающейся мане"
L["Mana"] = "Мана"
L["Mana threshold"] = "Порог маны"
L["Set the percentage for the low mana warning."] = "Установить процент для предупреждения об окончании маны."

------------------------------------------------------------------------
--	GridStatusName

L["Color by class"] = "Цвет по классу"
L["Unit Name"] = "Имя единицы"

------------------------------------------------------------------------
--	GridStatusRange

L["Out of Range"] = "Слишком далеко"
L["Range"] = "Расстояние"
L["Range check frequency"] = "Частота проверки растояния"
L["Seconds between range checks"] = "Частота проверки в секундах"

------------------------------------------------------------------------
--	GridStatusReadyCheck

L["?"] = "?"
L["AFK"] = "Отсутствует"
L["AFK color"] = "Отсутствие"
L["Color for AFK."] = "Окраска отсутствующих"
L["Color for Not Ready."] = "Окраска не готовых"
L["Color for Ready."] = "Окраска готовых"
L["Color for Waiting."] = "Окраска ожидающих"
L["Delay"] = "Задержка"
L["Not Ready color"] = "НеЕ готов"
L["R"] = "R"
L["Ready Check"] = "Проверка готовности"
L["Ready color"] = "Готовности"
L["Set the delay until ready check results are cleared."] = "Установите задержку,временной простой перед очисткой результатов проверки готовности."
L["Waiting color"] = "Ожидиние"
L["X"] = "X"

------------------------------------------------------------------------
--	GridStatusTarget

L["Target"] = "Цель"
L["Your Target"] = "Ваша цель"

------------------------------------------------------------------------
--	GridStatusVehicle

L["Driving"] = "Управляет"
L["In Vehicle"] = "На транспорте"

------------------------------------------------------------------------
--	GridStatusVoiceComm

L["Talking"] = "Говорит"
L["Voice Chat"] = "Голосовой чат"
