
local savedID, result, triggers = 0, nil, {
	"%.wowstead%.com",
	"recruit",
	"looking for.*join [ou][us]r?",--<> is Looking for Dedicated and skilled DPS and Healer classes to join us in the current 10 man  raids and expand to 25 man raids. Raids on mon,wed,thurs,sunday 21.00-24.00 18+
	"www.*apply", --pls go to www.<>.com to apply or wisp me for extra info.
	"looking.*members", -- <<>> is a social levelling looking for all members no lvl requirement, Once we have more members were looking to do Raids and PvP premades, /w if you would like to join please or  /w me for info.
	"guild.*join", --<> is a lvling guild but as soon as we have enough 85 we will raid  we are here not 2 take the game 2 serously and 2 have fun if u wanna join wisper me or <> any lvl welcome :) 
	"levell?in.*guild", --<> Easy Going Leveling Guild LFM of any levels, we are friendly, helpfull and have 6 guild tabs available.
	"gilde.*inte?rr?esse", --Die Gilde <> sucht nette Mitspieler zum gemeinsamen questen, spass haben, heros abfarmen, pvp zocken usw... Sind keine raidgilde und wollen es auch nicht werden. Neuanfänger sowie lowlvl gerne willkommen. Intresse? pls w/m
	"apply.*www", --<> We Are Looking For people Item lvl 333+ for our25man Cataclysm Raiding team. Must Be over 18+ to Apply or Have some insane Skills. If you Got Any Questions Go to www.<>.net Or contact me or a officer.
	"gu?ilde?.*[/w][/w]", --<> is a newly formed social guild for all classes and levels. Our aim is to have fun and we hope to do raids when we are big enough. For any more info or an invite /w me. Thank You.
	"gu?ilde?.*pvp.*raid", --Die PvP und Twink Gilde <> sucht gute PvPler für gemeinsame Events,Raids und Bgs. Aufgenommen wird ab lvl.50! w me oder Geilertyp
	"gu?ilde?.*raid.*bank", --Die neue Gilde "<>" sucht noch nette Mitspieler zum Leveln, Questen, Raiden und Spaß haben. Ts³ und Gildenbank ist vorhanden.
	"gilde.*such[et]", --Moin, der lustige Haufen (Gilde) "<>" suchen noch ältere Spieler (22+) für Instanzen, Questen, Heros und 10er; Spielspaß ist dabei die absolute Mussbedingung! Wenn du dich angesprochen fühlst, schreib uns einfach mal:) [www.<>.de]
	"pvp.*pve.*wh?isper", --instead of joining solo and end up loosing with randoms. Ofcourse we group up for Random HCs with both PvP and PvE players aswell and if the PvE group need an extra player for the raid, PvP guys can get invited. Whisper me for more info.
	"looking for.*http", --<> Looking for: Resto shaman&Tank. You need skill, focus and patience to learn and pass the fights. If you want to clear bosses before the nerfs then this is the right place for you /w or go to http://<>.info
	"guild.*pst",--<> an adult guild looking for more players who are active ,like to have fun ,talk in vent & will help others. LVL 5 GUILD !we'd like fun people to enjoy the new content of CATA,all lvls, classes, races are welcome PST FOR MORE INFO/INVI
	"guild.*bank.*tabs", --Looking for a guild to relax after a hard day of work or school? <> is layed back and alota fun. We are a lev 7 guild and have 7 Guild Bank tabs. we have vent as well so stop by and check us out. come run some dungeons..
	"guild.*wh?isper m[ey]", -- <> is a layed-back social level 10  heroic/raiding guild. We organize a few heroics/raids a week and ALWAYS use teamspeak while doing so. Is this something you like to do? Whisper me!
	"www.*/w", --noch gute und zuverlässige Member für weitere 10er Stammgruppen später 25er.Gesucht werden:Heiler;Pala,Dudu - DD;Eule,Feral,Mage,Verstärker!Raidzeiten Mi,Do,So 19-22:30!Bewerbung unter [www.xyz.de] für Infos /w me
	"looking.*strengthen.*raid", --<> is looking for, 1 ele sham, 1 balance druid, 1 holy pala,  to strengthen our raid teams for the current 10 man raids. Raids 21.00-24.00 Mon,Wed,Thurs,Sun. 349+ gear req age 18+
	"looking for.*/w.*info", --<><level10>Is looking for more people to start raiding with. We are in need of everything and dps needs to do atleast 10k+ dps and have atleast 345 Item level, /w me for an inv, or for more info
	"guild.*welcome", -->< is a new dungeon/raid guild we are setting up our raid/HC group. ofc every lvl is welcome in our guild but we preff 60-85 all classes/races. You also have to be an active player
	"guild.*looking", -->< raiding guild. (5/12) we are looking for exp/dedicated players for our 10mans. slowly moving into 25mans. must have a ilvl 350+ (need 1 tank, 2 ranged(pref. boomkin), 1 melee(pref enhance)
	"lookk?ing.*welcome", --<> is a lvl 11 recuiting for their 10man group, lookking for people with experiance with a min 348 ilvl (2ranged dps ) all other players are welcome we are 6/12 with cataclysm bosses - raid times are mon - thurs 8:00pm to 12:00am (midnight) Pst
	"raid.*%.com", --<> <lvl 23> has openings in its' 25 man raid group, Raids are Sunday - Thurs 9-12. see xyz.com for info
	"sucht.*willkommen", --<> sucht für ihre 10er Raids Mi + Fr 19.30-23.00 (10/12) noch tatkräftige Unterstützung! Hirn, flinke Finger, wache Augen und ein sehr! gutes Klassenverständnis sind uns in jeder Klasse willkommen. [www.xyz.de]
	"such[et]n?.*%.de", --Die "" (Glvl5) suchen noch Mitglieder, egal ob groß oder klein, zum gemeinsamen leveln, Instanzen(und HC's)-, PvP- und später Cata-Raid erleben. Weitere Infos findet ihr auf [www.xyz.de]  Ts Vorhanden
	"such[et]n?.*gilde", --Hi wir suchen für unsere LvL-Gilde <>(Stufe 2) noch Member. Wir wollen zusammen Leveln und Instanzen laufen. Den 5% ep Bonus gibts auch dazu. Hast du lust? Dann melde dich bei mir :)
	"lookout.*raidtimes.*/w", --Knixxs Order of the Darkside -  Lvl 25. We are on the lookout for Tanks and Healers for our raidteam. We are currently 5/12 and looking to progress further. Our raidtimes are: Wed, Thurs and Sunday, 21:15 realm time. For more info /w me. Thanks :)
	"social leveling looking.*healer", --<> <level 6> Is a social leveling looking for people to fill out raiding spots. Currently in need of dps and healers. Starting firelands trash runs & eventually boss runs. 
}
ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", function(_,event,msg,player,_,_,_,_,chanid,_,_,_,id)
	if id == savedID then return result else savedID = id end --Incase a message is sent more than once
	if chanid == 0 or chanid == 25 then result = nil return end --Don't scan custom channels or GuildRecruitment channel
	if not CanComplainChat(id) or UnitIsInMyGuild(player) then result = nil return end --Don't filter ourself/friends
	msg = (msg):lower() --Lower all text, remove capitals
	for i = 1, #triggers do
		if (msg):find(triggers[i]) then --Found a match
			result = true
			if BadBoyLogger then BadBoyLogger("Guilded", event, player, msg) end
			return true --found a trigger, filter
		end
	end
	result = nil
end)

