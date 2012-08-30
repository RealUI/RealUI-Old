
local strfind = string.find
local prevLineId, result, triggers = 0, nil, {
	"wowstead",
	"guildlaunch",
	"corplaunch",
	"enjin",
	"re[cq]rui?t",
	"^wtb guild",
	"^wtb %d+%+? guild",
	"^wtb %d+%+? level guild$",
	"^wtb a guild", --WTB a guild around lvl 15, make me an offer!
	"looking for.*join [ou][us]r?",--<> is Looking for Dedicated and skilled DPS and Healer classes to join us in the current 10 man  raids and expand to 25 man raids. Raids on mon,wed,thurs,sunday 21.00-24.00 18+
	"www.*apply", --pls go to www.*.com to apply or wisp me for extra info.
	"looking.*members", -- <<>> is a social levelling looking for all members no lvl requirement, Once we have more members were looking to do Raids and PvP premades, /w if you would like to join please or  /w me for info.
	"guild.*join", --<> is a lvling guild but as soon as we have enough 85 we will raid  we are here not 2 take the game 2 serously and 2 have fun if u wanna join wisper me or <> any lvl welcome :)
	"levell?in.*guild", --<> Easy Going Leveling Guild LFM of any levels, we are friendly, helpfull and have 6 guild tabs available.
	"apply.*www", --<> We Are Looking For people Item lvl 333+ for our25man Cataclysm Raiding team. Must Be over 18+ to Apply or Have some insane Skills. If you Got Any Questions Go to www.<>.net Or contact me or a officer.
	"gu?ilde?.*[/w][/w]", --<> is a newly formed social guild for all classes and levels. Our aim is to have fun and we hope to do raids when we are big enough. For any more info or an invite /w me. Thank You.
	"pvp.*pve.*wh?isper", --instead of joining solo and end up loosing with randoms. Ofcourse we group up for Random HCs with both PvP and PvE players aswell and if the PvE group need an extra player for the raid, PvP guys can get invited. Whisper me for more info.
	"looking for.*http", --<> Looking for: Resto shaman&Tank. You need skill, focus and patience to learn and pass the fights. If you want to clear bosses before the nerfs then this is the right place for you /w or go to http://<>.info
	"guild.*pst",--<> an adult guild looking for more players who are active ,like to have fun ,talk in vent & will help others. LVL 5 GUILD !we'd like fun people to enjoy the new content of CATA,all lvls, classes, races are welcome PST FOR MORE INFO/INVI
	"guild.*bank.*tabs", --Looking for a guild to relax after a hard day of work or school? <> is layed back and alota fun. We are a lev 7 guild and have 7 Guild Bank tabs. we have vent as well so stop by and check us out. come run some dungeons..
	"guild.*wh?isper m[ey]", -- <> is a layed-back social level 10  heroic/raiding guild. We organize a few heroics/raids a week and ALWAYS use teamspeak while doing so. Is this something you like to do? Whisper me!
	"looking.*strengthen.*raid", --<> is looking for, 1 ele sham, 1 balance druid, 1 holy pala,  to strengthen our raid teams for the current 10 man raids. Raids 21.00-24.00 Mon,Wed,Thurs,Sun. 349+ gear req age 18+
	"looking for.*/w.*info", --<><level10>Is looking for more people to start raiding with. We are in need of everything and dps needs to do atleast 10k+ dps and have atleast 345 Item level, /w me for an inv, or for more info
	"guild.*welcome", -->< is a new dungeon/raid guild we are setting up our raid/HC group. ofc every lvl is welcome in our guild but we preff 60-85 all classes/races. You also have to be an active player
	"guild.*looking", -->< raiding guild. (5/12) we are looking for exp/dedicated players for our 10mans. slowly moving into 25mans. must have a ilvl 350+ (need 1 tank, 2 ranged(pref. boomkin), 1 melee(pref enhance)
	"lookk?ing.*welcome", --<> is a lvl 11 recuiting for their 10man group, lookking for people with experiance with a min 348 ilvl (2ranged dps ) all other players are welcome we are 6/12 with cataclysm bosses - raid times are mon - thurs 8:00pm to 12:00am (midnight) Pst
	"le?ve?l.*open.*raid", --<> <lvl 23> has openings in its' 25 man raid group, Raids are Sunday - Thurs 9-12. see xyz.com for info
	"looking.*raidtimes.*/w", --Knixxs Order of the Darkside -  Lvl 25. We are on the lookout for Tanks and Healers for our raidteam. We are currently 5/12 and looking to progress further. Our raidtimes are: Wed, Thurs and Sunday, 21:15 realm time. For more info /w me. Thanks :)
	"social.*leveling.*looking", --<> <level 6> Is a social leveling looking for people to fill out raiding spots. Currently in need of dps and healers. Starting firelands trash runs & eventually boss runs.
	"looking.*player.*social", --<> (6) Looking for more players to set our first raiding team and also our first RBG team! We are looking for social players that is experienced of either Raiding or PvP. Whisper me if you want more information about us and our plans!
	"team.*looking.*raiders", --<> is trying to gather a exceptional raiding team to raid FL hc and DS, we are curently looking for skilled raiders who knows the bosses, have decent gear and have a fair amount of raiding exp, we raid Mondays and Thursday 20:00 - 23:00
	"looking for.*raid.*progress", --<> is currently looking for a Warlock ready for raiding DS10 HC. We're currently 5/8 HC and progressing every week. You have to know what you're doing and your gear must be ready to go tonight. We prefer Swedes
	"social.*looking.*join", --Hello there! :D  * (lvl25)  is looking for socials. We're looking for pvp, old raid, chat or leveling oriented ppl or ppl who like to chat. We got spots for social/alt raids aswell, if u like to raid. Fancy joining? /W me! hf :D
	"new.*guild.*rate", --<*> is a newly formed pvp guild, aiming to do rated bgs. No lvl requirement atm
	"need.*apply", --[*]  7/8 HC ,in need of 1x melee  DPS &1x range dps and 1x healer . exceptionals are always  welcome to apply @ *, com  , /w for more info
	"progress.*raid.*interest", --<*>  is 1/8 DS 10 HC, working @ progress in DS Heroic. We look for ppl who love progress like a team. Atm we need all clases. We raid Wednesday and Thursday (alt run). /w me if u are interested to progress.
	"social.*member.*inv", --* Focus on PvP, we are social and friendly. We do lots of random BG's 2gether, Arenas and also RBG! We got TS server. We give you FREE Gems! we care about our members. For more info or an [invite] just /w me. Req is lvl 85.
	"le?ve?l.*looking.*social", --<*> [lvl 25] is currently expanding!. looking for more social and enthusiastic PvP'ers. Hpala/Rshamans pref /w me for a short chat! only taking 2k+ arena or RBG. the exp must be on current char.
	"le?ve?l.*looking.*experience", -- * (lvl25) Is looking for, 1 exceptional holy paladin. And a resto druid/shaman with a dps offspec. we're raiding 5 days a week. /w me with your experience and interests. You need to be a cut above the rest.
	"join.*social.*guild", --Lowbies of Azeroth, join <*>> (level 23) and level together in this social & fun guild. ! Earn gold by doing guild challenges!
	"join.*le?ve?l.*guild", --Join our level 19 PVP guild! And get paid 30g per arena win! while playin' with guildies!
	"guild.*casual.*repair", --* (level 25 guild) is LF more pvers to complete our raiding teams! We are a casual raiding guild. (Some HC) We have guild funded repairs,  our own vent, active old raid achi runs, etc. We have many achievements unlocked.
	"raid.*social.*progress", --Are you a dedicated raider that wants in a regular team and like to socialise? Are you that player that is trustworthy and shows up at the raid? Then your the guy we want. ATM all classes are accepted, progress: 8/8, 2/8 hc ds. Whisper me for more info.
	"looking.*active.*join", --<*> [3] Is looking for active players to join the ranks and start raiding. Looking for all roles for Dragon Soul /w For [Inv]
	"social.*guild.*invite", --<*> (Lvl: 20) Social Raiding guild, raid 2 nights a week. Currently 8/8 10N 1/8 10HC. Invites are open for all.
	"searching.*people.*progress", --<*> Is searching for more people for our 10 man raiding team! we are full on healers and need some imba dpses and 1 tank to continue our progress right now we are 8/8 normal /w me!!
	"le?ve?l.*looking.*class", --<*>lvl 25 5/8hc is looking for 1tank  and 1rdps(prefsp or lock ) for our DS 10man hc raid group  we raid at sun-mon-wed ftom19:00-23:00 be at least 390ilvl and know your class 100% then /w me so we can speak
	"looking.*social.*guild", --LOOKING FOR 25 SOCIAL GUILD ROGUE LVL 85!!
	"looking.*progress.*info", --<*> is seeking a Tank for our DS10 Runs. Bring ilvl 395+. We have 4/8 HC. Looking to progress to 5/8 HC asap.  Raid days are Wed / Fri 20:00 - 23:00. /w for more info
	"player.*clear.*info", --<*> LF PVE Player  We Cleared DS 10 Man and We need  1 Healer (Druid or Paladin) 2 Spot For RDPS Warlock and Boomkin  /w me for more info
	"searching.*raiders.*progress", -- * We are searching for hardcore raiders for HC DS progression, You will need 395+ Ilvl, Achievement (8/8 Normal, Minimum), Microphone and to be above 16+. Searching for Druid (Tank) or a Death Knight (Tank).

	--Dutch
	"guild.*zoek naar.*social", -- [25] Nederlands sprekende Guild <*> zijn op zoek naar Tanks: Geen / Melee dps: Warrior / Ranger dps: warlock, Mage / Healers: Paladin / raid tijden ma, di ,do van 20:00ST tot 23:00ST, social [invite] is ook mogelijk whisper voor meer info.

	--Swedish
	"rekryt", --<*> rekryterar. Vi söker aktiva spelare från Sverige och Norge. Vi är i behov av DPS (SPriest, Boomkin, DK) och en tank (warr, DK) med dps OS. Progress: 3/8 HC, raidar onsd, sön & mån 20-23. Socials är alltid välkomna!. /w för mer info
	"guild.*söker", -- *  är ett svenskt  LvL25  guild som nu söker nya members. Vi kör Dragon Soul 10-manna. Vi söker PvE till Raid, PvP:are till RBG:s och även sociala spelare som vill ha ett bra ställe att hänga på :)
	"guild.*folk.*whisp", --<*> Nystartad, svensk, seriös PvE-guild som satsar på att få in seriöst folk till våra 10-manna DS Heroics. Raidar fre 20-00 samt sön 19-22. Låter detta intressant så whispar DU mig för vidare information.
	"söker.*guild", --<*> Söker nu efter aktiva gamers som vill ingå ett helt fresh RBG team inom guilden. Vårat mål är 2.4-HOTA. T2/legendary/Bra pve items är STORT PLUS. REQ: 2.2k exp RBG/ARENA. Störst behov: Boomkin, Rshaman eller Rdruid och Disc
	"söker.*progg?ress", --<*> DS 2/8 HC Söker nu efter 1 healer (hpala,dpriest,rshammy) för HC proggress i DS /w mig så tar vi ett snack.
	"guild.*letar.*spelare", --Guilden "*" Letar efter nya spelare till Ds 10, Vi har 4 hc on farm och letar efter mer folk som kan bidra till en full Hcclear inom sin tid!
	"guild.*info.*välkommna", --HEJ ! nu startar vi en ny svensk guild för barna runt 13 år . Vi kommer köra raids som BH , FL , DS kanske börja lite lätt med BwD och BoT , vi vill gärna att ni ska ha skype :) w spec och class / w för mer info!!! ni är välkommna :)
	"letar.*söker.*info", --<*> letar efter raiders till vårat DS 10 manna team. Just nu så söker vi efter 1 warrior tank och en paladin tank, 1 disc präst och 1 holy paladin och 1 Mage. Vi kommer att raida från 19:00-22:30.  Viska mig för mer info

	--Norwegian
	"søker.*medlemmer", --"*" Søker flere norske medlemmer. Vi er nyoppstarta og begynner med DS10 + noen HC i denne uka. /w for mer info. Social er også velkomne

	--Danish
	"søger.*medlemmer", --* søger flere medlemmer danskere svenskere og nordmæn
	"leder efter.*members.*social", --* er lvl3 atm leder efter flere members til raid mangler healers tanks og ranged dps alle er velkommen selv om i vil raid eller være sociale bare kom med det gode humør du skal være dansk for at join eller kunne snakke det nogen lunde rent.

	--Finnish
	"kilta.*etsii", --*, Suomalainen PvE-kilta joka etsii vain pelaajia jotka osaavat liikkua tulesta ja joita kiinnostaisi raidata 10man DS normaalia ja heroiccia jatkossa, tähtäämme parempaan tasoon kuin suurin osa servun suomikilloista! /w jos kysyttävää
	"etsimme.*pelaajia.*yhteyttä", --<*> lvl 25 Progress DS 1/8 hc. Etsimme hc koitoksiin aktiivisia pelaajia. Erityiseti healerille on tarvetta. Myös 85 lvl sosiaalit on tervetulleita. Ota yhteyttä jos kiinnostuit.
	"etsii.*kilta", --<*> Etsii suomalaisia pelaajia joukkoonsa. Kilta on casual PvE/PvP/social. Kaikki ovat tervetulleita! Nyt haetaan pelaajia aloittamaan DS10 progress.
	"etsii.*ihmisiä.*progress", --[*] Etsii suomalaisia, raidaamisesta kiinnostuneita motivoituneita ihmisiä liittymään meidän HC Main-raid grouppiin. Nykyinen progress 5/8 Hc ja eteenpäin mennään.
	"kilta.*tarvetta olisi", --<*> On juuri tehty Suomalainen PvP Kilta rennolla meiningillä. Aloitamme rbg:een kunhan saamme kelvollisen setupin. Tarvetta olisi Fc:lle (Warru), Hiiluja (Pally, Shaman, Priest) ja depsuja melkein kaikki classit. Whisperillä lisää infoa.

	--German
	"sucht.*willkommen", --<> sucht für ihre 10er Raids Mi + Fr 19.30-23.00 (10/12) noch tatkräftige Unterstützung! Hirn, flinke Finger, wache Augen und ein sehr! gutes Klassenverständnis sind uns in jeder Klasse willkommen. [www.xyz.de]
	"such[et]n?.*%.de", --Die "" (Glvl5) suchen noch Mitglieder, egal ob groß oder klein, zum gemeinsamen leveln, Instanzen(und HC's)-, PvP- und später Cata-Raid erleben. Weitere Infos findet ihr auf [www.xyz.de]  Ts Vorhanden
	"such[et]n?.*gilde", --Hi wir suchen für unsere LvL-Gilde <>(Stufe 2) noch Member. Wir wollen zusammen Leveln und Instanzen laufen. Den 5% ep Bonus gibts auch dazu. Hast du lust? Dann melde dich bei mir :)
	"bewerbung.*www.*/w", --noch gute und zuverlässige Member für weitere 10er Stammgruppen später 25er.Gesucht werden:Heiler;Pala,Dudu - DD;Eule,Feral,Mage,Verstärker!Raidzeiten Mi,Do,So 19-22:30!Bewerbung unter [www.xyz.de] für Infos /w me
	"gu?ilde?.*pvp.*raid", --Die PvP und Twink Gilde <> sucht gute PvPler für gemeinsame Events,Raids und Bgs. Aufgenommen wird ab lvl.50! w me oder Geilertyp
	"gu?ilde?.*raid.*bank", --Die neue Gilde "<>" sucht noch nette Mitspieler zum Leveln, Questen, Raiden und Spaß haben. Ts³ und Gildenbank ist vorhanden.
	"gilde.*such[et]", --Moin, der lustige Haufen (Gilde) "<>" suchen noch ältere Spieler (22+) für Instanzen, Questen, Heros und 10er; Spielspaß ist dabei die absolute Mussbedingung! Wenn du dich angesprochen fühlst, schreib uns einfach mal:) [www.<>.de]
	"gilde.*inte?rr?esse", --Die Gilde <> sucht nette Mitspieler zum gemeinsamen questen, spass haben, heros abfarmen, pvp zocken usw... Sind keine raidgilde und wollen es auch nicht werden. Neuanfänger sowie lowlvl gerne willkommen. Intresse? pls w/m

	--Turkish
	"raid.*deneyimi.*aran?maktadır", --*  5/8 HC  Raidlere düzenli katılım saglayacak Hc deneyimi olan Mage  ve Holy Pala aranmaktadır
	"ekibi.*oyuncu.*sosyal", --*/10m  5/8 HC  2. RAID ekibi için  390 ve üstü ilvl a sahip, raidlere düzenli takılabilecek HER CLASS VE SPECC ten oyuncu alımları yapılacaktır. Sosyal alımlarımız bulunmaktadır. Basvuru ıcın /w
	"guild.*aranıyor", --Guildimize beraber lvl kasmak isteyen arkadaşlar aranıyor. 1lvl %50 deyiz......
	--* [25] 5/8 HC  Progressimize Düzenli katilim saglayacan Heroic deneyimi olan Mage,Lock aramaktadir.Social alimi da gerceklestirilmektedir . Detayli bilgi icin /w
	"progres.*so[cs][iy]al", --* [25 Lvl]10M5/8 HC Progresimizi ilerletmeye yardimci olabilecek HC Tecrubesi olan Mage Lock sp alimi yapilacaktir. Ayrica sosyal alimimiz da vardir
	"progres.*arıyor", --* (25 lvl) 6/8 hc progress, Spine ve Madness progressine katkıda bulunabilecek online süresi yüksek yeterli gear ve oyunculuk seviyesine sahip 1 melee dps arıyor. Bilgi için /w
	"progres.*aran?maktadır", --*/10m  5/8 HC  ACIL OLARAK, PROGRESS ekibi için en az 3 boss HC deneyimi olan 395-400 arasında ilvl a sahip, raidlere düzenli takılabilecek ELEM SHMY, BLANCE DRUID ve LOCK oyuncular aranmaktadır. Basvuru ve bilgi icin /w.
	"progres.*guild", --8:30 da basliycak olan hc progresimize 1 burst dps gerek! guild run 6/8 hc progresimiz war Spine hc icin sabırlı 1 dps lazim ''*'' !!! Spine dan baslanıcak!!!
	"aran?maktadır.*progres", --*  - * yeni transfer olmustur ve suanki tier ve MOP icin kadrosuna classina hakim oyuncular aramaktadır ,Suanki 1/8 HC progressimiz devam ettirmek istiyoruz oncelikli Tank ve Healer alimi vardir.
	"guild.*raid.*oyuncu", --* guildi kurulmuş olan 25 man kadrosunu güçlendiriyor. Raidlere istekli katılacak, saygılı ve paylaşımı seven türk oyuncuları bekliyoruz.
	"başvuru.*www", --Hurish Başvuru için lütfen "www.*.com" adresine giriş yaparak formu doldurunuz.
	"aranmaktadır.*bilgi.*/w", --* (7/8 Hc) Hc Madness ve MoP icin Off-tank(warrior-paladin) aranmaktadır. Daha fazla bilgi icin /w

	--Croatian
	"le?ve?l.*primamo.*igrace", -- * (lvl25) za sve one koji ovo razumeju. Primamo sve zainteresovane igrace 85lvl koji igru pre svega shvataju kao zabavu a ne obavezu. Za vise informacija/w

	--Hungarian
	"guild.*játékosokat keres", --* Guild játékosokat keres.Létszámtól függően Old Dungeon,RBG,Content Raid szervezése.Fejlödö szintü karaktereket is várunk.
}

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", function(_,event,msg,player,_,_,_,_,chanId,_,_,_,lineId)
	if lineId == prevLineId then
		return result
	else
		prevLineId, result = lineId, nil
		if chanId == 0 or chanId == 25 then return end --Don't scan custom channels or GuildRecruitment channel
		if not CanComplainChat(lineId) or UnitIsInMyGuild(player) then return end --Don't filter ourself/friends
		msg = msg:lower() --Lower all text, remove capitals
		for i = 1, #triggers do
			if strfind(msg, triggers[i]) then --Found a match
				if BadBoyLog then BadBoyLog("Guilded", event, player, msg) end
				result = true
				return true --found a trigger, filter
			end
		end
	end
end)


local whispers = {
	"would.*join my.*guild", --Would you like to join my social raiding guild?.. lv1 but it will grow fast with your help :D and lottery. u can win 50g a week. MORE later!!
	"would.*join our.*guild", --Would you like to join our guild ? if you join We will pay your all repair costrs...
	"would.*join a.*guild", --Would You Like To Join a New Guild ? Help us Grow. That Will Give You Free Repair When You Reach Lvl 5! wen you reach 85 u will Get 2000g
	"would.*join.*social.*guild", --Hello <>,how are you? would you like to join <> a newly created socialplayer guild!
	"would.*join.*team.*members", --Hey you! Would you like to join *? We will make a core raiding team when we got the ppl for it. If we get many members we can also make more than 1 raiding team, and maybe when we have enough we could make it a 25 man raid.
	"want.*join.*social.*guild", --hey m8 u want to join in 14 level social guild with 10% more xp from quest and 30 gold every day free repair??
	"invite.*social.*guild.*join", --Hello *! You have been invited to * a newly founded social guild, hope you join! Cant wait to see you!:)
	"wanna.*join.*guild.*le?ve?l", --Heya wanna join Guild * lvl 25 for faster lvling? :)
	"hello.*intere?sted.*join.*guild", --Hello,  intersted in joining a guild? :)
	"would.*join.*please.*accept", --Would you like to join [[*]] please press Accept!o _O
	"interest.*join.*le?ve?l", --Hey bro are you interested in joining *? We just reformed currently leveling and setting up going to be raiding once we're ready!

	"looking for.*members.*join", --Hello, <> is looking for more members to join our ranks, we are both recruiting socials/levelers and raiders for our raiding team! We would like you, <>, to join our ranks.
	"raid.*guild.*looking for", --Social casual raiding Guild 8/8 <> is looking for raiders for our DS run, we are in need of 3 healers. perfer with os dps. our main raidday is wednesday...
	"recruit.*member.*join", --<> is recruiting members. We raid,quest and dungeon together feel free to join.

	"social guild.*wh?ant.*players", --Hello. Were a social guild that whants to help new players to get better. In oure stab we have a Raid Leader from the guild <> and a member of the guild. With good experience from DS and been playing Since TBC. And we whant to help you to get better !
	"guild.*recruit.*social", --Hello, were a lvl 2 guild looking to recruit members of all lvl's.We're a social guild looking for members to help us reach lvl 25
	"new.*social guild.*repair", --Greetings <>! <> is a newly started social guild where you have a possibility to advance into high-end content. We'll soon be providing with guild repairs as well as hosting events! Come, take part of the community! We have 10% XP, REP an
	"join.*guild.*member", --Hi * , please join our Level 15 guild for for weekly raids & rbgs and %10 extra XP. We do dungeon runs to help our low level members too.
	"social.*guild.*repair.*join", --Hi, * is a fun, friendly social guild. enjoy the free guild repairs and boosts.. and also our 1st ever perk..  =>=>  [Fast Track] <=<=.. so why dont you join our community??? u wont regret it :)

	"guild.*please come.*bonus", --Our guild have %10 xp %10 Mount Speed and % 100 Spirit speed boost please come and lvl at our guild if you hit from 80 lvl to 85 lvl while in this guild you will get a bonus 1.5 k gold
	"join.*community.*gbank", --Hello <> Come And Join <> now and be part of a fast growing community we have a Gbank :) we may be lvl 1 but we are aiming high for the sky and thats why we need you
	"%d.*perks.*social.*guild", --<> 6/8 HC DS , Take advatage of our perks and socials lvl 25 guild.
	"guild.*friendly.*player.*repair", --Hey, we are a levelling guild that plans to be very friendly and reward our players for helping the guild. We will provide higher rewards for pro-active players. Once the guild properly starts guild repairs will be provided for everyone. Give us a shot!!
	"new.*guild.*casual.*raid", --* is a new started Guild, that will be a Casual guild from the start. But when we get peoples we will start doing Rbg, Raids etc. On a casual level
	"recruit.*player.*raid.*whisp", --"*" now recruiting new players! Need all classes and all specs! Ready for raiding, but we just need the people, Whisper for more! Levelers and pvpers welcome!
	"social guild.*member.*join", --Hello *. * (25) is a  social guild with 900+ members join us and have fun
	"guild.*invite.*boost.*join", --THIS IS THE BEST GUILD YOU'LL EVER BE INVITED TO, SO GO ON AND DO WHAT YOU KNOW YOU MUST DO ......... accept the [invite] ;) plus there's a 10% exp boost for joining :P
	"guild.*recruit.*faster", --Hi! * <<*>> is the BEST Guild in THE WORLD and WE are recruiting YOU cause YOU PWN, does that make sense?? - NO... but who cares? (((( 5% xp bonus (soon 10%) and 10% faster mount))))
	"recruit.*player.*social", --Hello *, * is recruiting players of all levels and skills as socials along with end game experienced raiders for our newly formed friendly guild, english speaking mature players, click accept now to join :)
	"guild.*join.*repair", --Hello *, sorry to bother you but * is a lvl 25 guild and is the biggest growing guild on the server! Join us and gain Guild Repair and 10% more XP, Honor and Justice Points! We have hundreds of level 85 characters already!
	"guild.*looking.*member", --<*> is a level 3 guild looking for members. Come enjoy [Fast Track], [Mount Up] and more!
	"recr?uit.*casual.*repair", --<*> is now recuiting! We are a casual and fun guild atm but will focus on both PvE and PvP when the time is right! We want you who is active and like to play much! We will soon have guild repair and a open guildbank!
	"want.*friendly.*pv[pe].*environment", --Do you want to a friendly environment with both PvE and PvP events every week. We are altso capable of helping with your character. "specc - gemming and how to optimize your dps/healing. We hope you will find our environment suited for you!
	"social.*le?ve?l.*guild", --* Its only for the sirs of sirs so if you think your sir enough for the sirs of sirs then whisper the best sir of sirs (me) and join the soon to be best social,leveling,questing,SIRING,raiding,pvping guild EVER!! .......Like a Sir!
	"join.*le?ve?l.*mount.*rep", --Join for Faster leveling! Faster Mount! More reputation gains and more!!
	"guild.*recruit.*repair", --Hi, <*> is a newly formed leveling and questing level 16 guild which is now recruiting more people ! Come on * , give it a shot ! Guild repairs are also available !
	"hello.*guild.*raid.*join", --Hello there Fancy a guild that doesnt just focus on it's 10 man  team with friendships made and other stuff apart from just raiding? Then this might be the guild for you From a rebuilt transferred guild we offer u the chance to join in on our WoW exp.
	"guild.*looking.*social", --Hello, * is a newly formed guild transfered from *, with DS experienced leadership. We are currenlty looking for active people to help us level up the guild, and continue our DS progress. Socials are always welcome aswell.
	"guild.*raid.*le?ve?l.*join", --Hey mate :) <*> is a new PvP Guild! Our main focus will ofc be in MoP! We will also set up Raids, and have a few groups for raiding :) In the beginning we will focus on levling, getting people geared, skilled and exp'ed. Please join if u PvP:
	"guild.*repair.*join", --Hey there!, i noticed your new? ;D. i've just started off a guild with free repairs, and bank tab use, along with perks to come, care to join? :) ... Let me know :)!
	"recruit.*guild.*join", --Hello *! <*> is now recruiting!Awsome guild!, join now!
	"guild.*le?ve?l.*raid.*player", --Guild * Level 9. HI *. We are a good guild and there you can do everything. RAID ARENA RBG BG DG achiv. You say us wht you want to do and we try to organise it! we are not too much so you will be in a great family of good player
	"le?ve?l.*bonus.*join.*guild", --Hi * ! We've got 2 guild bank tabs filled with FREE items and enchants to help You leveling aswell as bonus 5% exp from Fast Track perk. Join our guild and lvl up faster!
	"le?ve?l.*guild.*repair", --* LvL 16 Guild! Be active and mature! 100g FREE Guild repair everyday!
	"guild.*social.*welcome", --Hello :) * is Level 25 guild : %10 more exp, %10 Mount speed, Mass Summon, Mass Resurrection, Bountiful Bags (proc on your professions!!),  Raiding, Leveling and social guild. All welcome and Feel free to [invite] everyone :)
	"le?ve?l.*recruit.*guild", --<*> (level 12) is now recruiting. Do you just love PvP? Then this is the guild for you! We will be doing World PvP/ RBG/ arenas/ premades. And much more! We will have weekly events aswell.
	"join.*le?ve?l.*guild", --Hello *! Wanna join *? we are lvl 18!! Its  a leveling guild. 10% more xp
	"extra.*durability.*join", --Hi *, want to get an extra 10% xp? And other bonuses like profession points and durability free? With over 550 members, you should join us!
	"guild.*join.*le?ve?l", --Hi my friend. Me and some others has just started a new guild and we would like if you join.  we are a pvp guild and we do doungens too. And our level 85 people would love you help you level up.
	"partof.*guild.*invite", --*? Well, hopefully not. But you can be part of an epic guild called * if you like. I'll shoot you an [invite] chief, you decide.
	"join.*repair.*le?ve?l", --Would you like to join *? Free repairs to all, Where tking all lvl's
	"guild.*invite.*recruit", --Hey, I see that you are not in a Guild, So I thought I could [invite] you to my guild "*" :) You see we are recruiting players like is lvling, gearing and such. why not join and get several Gold Rewards on your way to the top :)?
	"join.*le?ve?l.*repair", --Hello *! Would you like to join * level (24)? Enjoy perks such as 10% extra EXP/Honor and free repairs! We run arenas, bg's, dungeons and more. Don't hesitate to join us today!
	"guild.*players.*join", --Hey!>>*<< Is a Raiding/PvP/Leveling guild. And we want more players to come join for our RBG's And DS. We are Very Friendly. We will use Ventrilo for our RBG's And DS. We will go one with DS HC soon.
	"guild.*players.*looking", --<*> is a PvP Guild formed by two super active players from other realm. We're looking for more ppl to play Arenas, Heroics and Bg's with!
	"join.*guild.*[ei]nviron?ment", --Hello , join to * and enjoy the adventures of WoW.We r making this guild to get prepared for cataclysm.We r offering a pleasant inviroment and a lot of fun.We will do bgs and dungeons to help u out. Join!
	"looking.*people.*guild", --<*> - We are looking for people who have a big interrest in PvP, the guild offers arena capping, rbg, and world pvping. You don't have to be Danish! We are lf Officers. /w me for more info!
	"recruit.*join.*guild", --YOLO Gaming Recruiting Peeps for Arenas, Rbgs, And Raiding.. join now for guild perks!
	"guild.*bonus.*perk", --* is a lvl 7 guild and are here to have fun :) We also got 10% xp bonus for levlers and other nice perks.
	"need.*join.*repair", --Mighty soldier we need your steel and magic in the defence of this world, join with us in <*> and fight our enimies and gain their riches. We will assist you with your armor repair, items and any other things you require while you slay your enemies
	"repair.*join.*guild", --Would you like to get free repairs and 10% more exp?! Then join *! You're very welcome to our guild, *!
	"le?ve?l.*looking.*players", --<*>lvl 1  looking for starting players, we helping get new gear, helping in dungeons and raids and giving gold. Looking players who need  achievements and who want go raid to get achievements
	"le?ve?l.*repair.*join", --* LVL 22. We do have 50g repair everyday for everyone and we're trying to be helpfull to those few members who actually joins.
	"join.*boost.*repair", --Join * - have a chance on winning 10 000g/week, FREE Boosts and Repairs CMON & Support the WoW Community!
	"looking.*social.*members", --<*> Is looking for more social members to chat and play bgs, dungeons and stuff with us!
	"looking.*member.*le?ve?l", --<<*>> looking member who need help with level and gear, we helping how we can, with gold level up and gear
	"guild.*looking.*people", --Hello New GUild * is looking for new people to join are core DS group and rbg group /w for inv.
	"new.*guild.*looking", --<*> is a new formed Pve,Pvp guild currently looking for all classes for our raid team/rbg team. We are gonna do Hc's also allot of dungeons and arena's. For more info or [inv] w/me.
	"recruit.*social.*player", --<*> Level 25 Recruiting for Dragon Soul 10 20:00 – 23:00 ST Mon, Tue, Thur / Tank: All Welcome / Healer: All Welcome / DPS: All Welcome. Also social players are welcome.
	"guild.*le?ve?l.*repair", --<*> RBG Guild for 1.7k+ XP'd PvP'ers!Looking for levelers, free repairs,help and advice! [:
	"guild.*le?ve?l.*join", --*, Newly formed guild rapidly leveling Join Us Now!
	"join.*rbg.*repair", --Join for arena partners and RBGs. Free repairs to come!
	"le?ve?l.*guild.*inte?rest", --Hello. I want to extend a invitation to you for a  new level 15 PvE guild. We just started this week and we are 3/8 Heroic in the Dragon Soul. If you are 385+ and know Dragon Soul then wisper me back if you are intrested in a guild spot and possibly core.
	"guild.*join.*recruit", --If you are already in a guild then you are still welcome to join but just know this message is automatic and it we did not check if you were guild. We are just recruiting your class.
	"guild.*members.*join", --Pvp/pve guild. over 300 active members accept and join us today!
	"new.*guild.*rbg.*accept", --<*> Is a newly formed PvP Guild! We are going to do lots of RBG's and normal BG's together. We dont play serious hardcore RBGs, we do it for fun! :) We will record YouTube vids of our events and BG's! Press Accept and become a PvPer TODAY!(:
	"join.*social.*perk", --Come and meet friendly ppl, while lvling up new chars, explore new areas and have a great time! Would you like to join us for some social fun? :) got nice perks :)
	"join.*guild.*repair", --JOIN OUR GUILD, FREE BANK REPAIRS + 500G to the most active player every week!
	"looking.*member.*guild", --* is looking for more friendly members! We have everything other guilds have but what makes us unique is our competition system where we hand out thousands of gold each week! We also have a website with irl introductions and pictures etc!
	"new.*le?ve?l.*guild.*join", --"<>" We are a new lvl 1 guild and we need you to join the ARMY :D JOIN US NOW!!! We are a nice guild :)
	"recruit.*guild.*welcome", --Hello! <> is recruiting! I will give everyone doing dungeons with me 100g per run! We will become a Raiding guild, but  right now everyone is welcome!
}

local tbl, whispPrevLineId, whispResult = {}, 0, nil
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", function(_,event,msg,player,_,_,_,flag,_,_,_,_,lineId)
	if lineId == whispPrevLineId then
		return whispResult
	else
		whispPrevLineId, whispResult = lineId, nil
		if not BADBOY_GWHISPER or tbl[player] or not CanComplainChat(player) or UnitIsInMyGuild(player) or UnitInRaid(player) or UnitInParty(player) or flag == "GM" or flag == "DEV" then return end
		msg = msg:lower() --Lower all text, remove capitals
		for i = 1, #whispers do
			if strfind(msg, whispers[i]) then --Found a match
				if BadBoyLog then BadBoyLog("Guilded", event, player, msg) end
				whispResult = true
				return true --found a trigger, filter
			end
		end
	end
end)

ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", function(_,_,_,player)
	if BADBOY_GWHISPER and not tbl[player] then tbl[player] = true end
end)

