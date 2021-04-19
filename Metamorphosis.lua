if MetamorphLoaded then
	ui.notify_above_map("Metamorphosis already loaded.", "Metamorphosis", 140)
	return
end
MetamorphLoaded = true

local OGHash = nil
local OGClothing = {}
local OGProps = {}
local BlockChange = true
local ModelTypes = {
	{Name="Ground Animals",Items={
		{Name="Bigfoot",Hash=0x61D4C771,IsInvisible=1},
		{Name="Bigfoot 2",Hash=0xAD340F5A,IsInvisible=1},
		{Name="Boar",Hash=0xCE5FF074},
		{Name="Cat",Hash=0x573201B8},
		{Name="Chimp",Hash=0xA8683715,IsDown=1},
		{Name="Chop",Hash=0x14EC17EA,IsInvisible=1},
		{Name="Cow",Hash=0xFCFA9E1E},
		{Name="Coyote",Hash=0x644AC75E},
		{Name="Deer",Hash=0xD86B5A95},
		{Name="German Shepherd",Hash=0x431FC24C,IsInvisible=1},
		{Name="Hen",Hash=0x6AF51FAF},
		{Name="Husky",Hash=0x4E8F95A2,IsInvisible=1},
		{Name="Mountain Lion",Hash=0x1250D7BA,IsInvisible=1},
		{Name="Pig",Hash=0xB11BAB56},
		{Name="Poodle",Hash=0x431D501C},
		{Name="Pug",Hash=0x6D362854},
		{Name="Rabbit",Hash=0xDFB55C81},
		{Name="Rat",Hash=0xC3B52966},
		{Name="Golden Retriever",Hash=0x349F33E1,IsInvisible=1},
		{Name="Rhesus",Hash=0xC2D06F53,IsDown=1},
		{Name="Rottweiler",Hash=0x9563221D,IsInvisible=1},
		{Name="Westy",Hash=0xAD7844BB}
	}},
	{Name="Water Animals",Callback=function()
		ui.notify_above_map("Note that these models will only work in water!", "Metamorphosis", 140)
		return HANDLER_POP
	end,Items={
		{Name="Dolphin",Hash=0x8BBAB455,IsWater=1},
		{Name="Fish",Hash=0x2FD800B7,IsWater=1},
		{Name="Hammer Shark",Hash=0x3C831724,IsWater=1},
		{Name="Humpback",Hash=0x471BE4B2,IsWater=1},
		{Name="Killer Whale",Hash=0x8D8AC8B9,IsWater=1},
		{Name="Tiger Shark",Hash=0x06C3F072,IsWater=1,IsInvisible=1},
		{Name="Stingray",Hash=0xA148614D,IsWater=1}
	}},
	{Name="Flying Animals",Items={
		{Name="Cormorant",Hash=0x56E29962},
		{Name="Chickenhawk",Hash=0xAAB71F62},
		{Name="Crow",Hash=0x18012A9F},
		{Name="Pigeon",Hash=0x06A20728},
		{Name="Seagull",Hash=0xD3939DFD}
	}},
	{Name="Standard Models",Items={
		{Name="Franklin",Hash=0x9B22DBAF},
		{Name="Michael",Hash=0x0D7114C9},
		{Name="Trevor",Hash=0x9B810FA2},
		{Name="MP Female",Hash=0x9C9EFFD8,IsInvisible=1},
		{Name="MP Male",Hash=0x705E61F2,IsInvisible=1}
	}},
	{Name="Miscellaneous",Items={
		{Name="Astronaut",Hash=0xE7B31432},
		{Name="Juggernaught",Hash=0x90EF5134},
		{Name="Ranger",Hash=0x3C438CD2},
		{Name="Zombie",Hash=0xAC4B4506}
	}},
}
local PedNames = {
	{Name="Abigail",Hash=1074457665},
	{Name="AbigailCutscene",Hash=-1988720319},
	{Name="Abner",Hash=-257153498},
	{Name="Acult01AMM",Hash=1413662315},
	{Name="Acult01AMO",Hash=1430544400},
	{Name="Acult01AMY",Hash=-1251702741},
	{Name="Acult02AMO",Hash=1268862154},
	{Name="Acult02AMY",Hash=-2132435154},
	{Name="AfriAmer01AMM",Hash=-781039234},
	{Name="Agent14",Hash=-67533719},
	{Name="Agent14Cutscene",Hash=1841036427},
	{Name="AgentCutscene",Hash=-680474188},
	{Name="AirHostess01SFY",Hash=1567728751},
	{Name="AirWorkerSMY",Hash=1644266841},
	{Name="AlDiNapoli",Hash=-252946718},
	{Name="AmandaTownley",Hash=1830688247},
	{Name="AmandaTownleyCutscene",Hash=-1779492637},
	{Name="AmmuCity01SMY",Hash=-1643617475},
	{Name="AmmuCountrySMM",Hash=233415434},
	{Name="Andreas",Hash=1206185632},
	{Name="AndreasCutscene",Hash=-413773017},
	{Name="AnitaCutscene",Hash=117698822},
	{Name="AntonB",Hash=-815646164},
	{Name="AntonCutscene",Hash=-1513650250},
	{Name="ArmBoss01GMM",Hash=-236444766},
	{Name="ArmGoon01GMM",Hash=-39239064},
	{Name="ArmGoon02GMY",Hash=-984709238},
	{Name="ArmLieut01GMM",Hash=-412008429},
	{Name="Armoured01",Hash=-839953400},
	{Name="Armoured01SMM",Hash=-1782092083},
	{Name="Armoured02SMM",Hash=1669696074},
	{Name="ArmyMech01SMY",Hash=1657546978},
	{Name="Ashley",Hash=2129936603},
	{Name="AshleyCutscene",Hash=650367097},
	{Name="Autopsy01SMY",Hash=-1306051250},
	{Name="AutoShop01SMM",Hash=68070371},
	{Name="Autoshop02SMM",Hash=-261389155},
	{Name="AviSchwartzman",Hash=939183526},
	{Name="AviSchwartzmanCutscene",Hash=-1734476390},
	{Name="Azteca01GMY",Hash=1752208920},
	{Name="BabyD",Hash=-636391810},
	{Name="BallaEast01GMY",Hash=-198252413},
	{Name="BallaOrig01GMY",Hash=588969535},
	{Name="Ballas01GFY",Hash=361513884},
	{Name="BallasOG",Hash=-1492432238},
	{Name="BallasOGCutscene",Hash=-1410400252},
	{Name="BallaSout01GMY",Hash=599294057},
	{Name="Bankman01",Hash=-1022961931},
	{Name="Bankman",Hash=-1868718465},
	{Name="BankmanCutscene",Hash=-1755309778},
	{Name="Barman01SMY",Hash=-442429178},
	{Name="Barry",Hash=797459875},
	{Name="BarryCutscene",Hash=1767447799},
	{Name="Bartender01SFY",Hash=2014052797},
	{Name="Baygor",Hash=1380197501},
	{Name="BayWatch01SFY",Hash=1250841910},
	{Name="BayWatch01SMY",Hash=189425762},
	{Name="Beach01AFM",Hash=808859815},
	{Name="Beach01AFY",Hash=-945854168},
	{Name="Beach01AMM",Hash=1077785853},
	{Name="Beach01AMO",Hash=-2077764712},
	{Name="Beach01AMY",Hash=-771835772},
	{Name="Beach02AMM",Hash=2021631368},
	{Name="Beach02AMY",Hash=600300561},
	{Name="Beach03AMY",Hash=-408329255},
	{Name="BeachVesp01AMY",Hash=2114544056},
	{Name="Beachvesp02AMY",Hash=-900269486},
	{Name="Benny",Hash=-994634286},
	{Name="BestMen",Hash=1464257942},
	{Name="Beverly",Hash=-1113448868},
	{Name="BeverlyCutscene",Hash=-1267809450},
	{Name="BevHills01AFM",Hash=-1106743555},
	{Name="Bevhills01AFY",Hash=1146800212},
	{Name="BevHills01AMM",Hash=1423699487},
	{Name="BevHills01AMY",Hash=1982350912},
	{Name="BevHills02AFM",Hash=-1606864033},
	{Name="BevHills02AFY",Hash=1546450936},
	{Name="BevHills02AMM",Hash=1068876755},
	{Name="BevHills02AMY",Hash=1720428295},
	{Name="Bevhills03AFY",Hash=549978415},
	{Name="BevHills04AFY",Hash=920595805},
	{Name="BikeHire01",Hash=1984382277},
	{Name="BikerChic",Hash=-96953009},
	{Name="BlackOps01SMY",Hash=-1275859404},
	{Name="BlackOps02SMY",Hash=2047212121},
	{Name="BlackOps03SMY",Hash=1349953339},
	{Name="Boar",Hash=-832573324},
	{Name="BoatStaff01F",Hash=848542878},
	{Name="BoatStaff01M",Hash=-933295480},
	{Name="BodyBuild01AFM",Hash=1004114196},
	{Name="Bouncer01SMM",Hash=-1613485779},
	{Name="Brad",Hash=-1111799518},
	{Name="BradCadaverCutscene",Hash=1915268960},
	{Name="BradCutscene",Hash=-270159898},
	{Name="BreakDance01AMY",Hash=933205398},
	{Name="Bride",Hash=1633872967},
	{Name="BrideCutscene",Hash=-2101379423},
	{Name="BurgerDrug",Hash=-1954728090},
	{Name="BurgerDrugCutscene",Hash=-1931689897},
	{Name="BusBoy01SMY",Hash=-654717625},
	{Name="Busicas01AMY",Hash=-1697435671},
	{Name="Business01AFY",Hash=664399832},
	{Name="Business01AMM",Hash=2120901815},
	{Name="Business01AMY",Hash=-912318012},
	{Name="Business02AFM",Hash=532905404},
	{Name="Business02AFY",Hash=826475330},
	{Name="Business02AMY",Hash=-1280051738},
	{Name="Business03AFY",Hash=-1366884940},
	{Name="Business03AMY",Hash=-1589423867},
	{Name="Business04AFY",Hash=-1211756494},
	{Name="Busker01SMO",Hash=-1382092357},
	{Name="Car3Guy1",Hash=-2063996617},
	{Name="Car3Guy1Cutscene",Hash=71501447},
	{Name="Car3Guy2",Hash=1975732938},
	{Name="Car3Guy2Cutscene",Hash=327394568},
	{Name="CarBuyerCutscene",Hash=-1932625649},
	{Name="Casey",Hash=-520477356},
	{Name="CaseyCutscene",Hash=-359228352},
	{Name="Cat",Hash=1462895032},
	{Name="CCrew01SMM",Hash=-907676309},
	{Name="Chef01SMY",Hash=261586155},
	{Name="Chef2",Hash=-2054645053},
	{Name="Chef2Cutscene",Hash=-1369710022},
	{Name="Chef",Hash=1240128502},
	{Name="ChefCutscene",Hash=-1555576182},
	{Name="ChemSec01SMM",Hash=788443093},
	{Name="ChemWork01GMM",Hash=-166363761},
	{Name="ChiBoss01GMM",Hash=-1176698112},
	{Name="ChickenHawk",Hash=-1430839454},
	{Name="ChiCold01GMM",Hash=275618457},
	{Name="ChiGoon01GMM",Hash=2119136831},
	{Name="ChiGoon02GMM",Hash=-9308122},
	{Name="Chimp",Hash=-1469565163},
	{Name="ChinGoonCutscene",Hash=-1463670378},
	{Name="Chip",Hash=610290475},
	{Name="Chop",Hash=351016938},
	{Name="CIASec01SMM",Hash=1650288984},
	{Name="Claude01",Hash=-1057787465},
	{Name="Clay",Hash=1825562762},
	{Name="ClayCutscene",Hash=-607414220},
	{Name="ClayPain",Hash=-1660909656},
	{Name="Cletus",Hash=-429715051},
	{Name="CletusCutscene",Hash=-890640939},
	{Name="Clown01SMY",Hash=71929310},
	{Name="CntryBar01SMM",Hash=436345731},
	{Name="ComJane",Hash=-1230338610},
	{Name="Construct01SMY",Hash=-673538407},
	{Name="Construct02SMY",Hash=-973145378},
	{Name="Cop01SFY",Hash=368603149},
	{Name="Cop01SMY",Hash=1581098148},
	{Name="CopCutscene",Hash=-1699520669},
	{Name="Cormorant",Hash=1457690978},
	{Name="Corpse01",Hash=773063444},
	{Name="Corpse02",Hash=228356856},
	{Name="Cow",Hash=-50684386},
	{Name="Coyote",Hash=1682622302},
	{Name="CrisFormage",Hash=678319271},
	{Name="CrisFormageCutscene",Hash=-1041006362},
	{Name="Crow",Hash=402729631},
	{Name="CustomerCutscene",Hash=-1538297973},
	{Name="Cyclist01",Hash=755956971},
	{Name="Cyclist01amy",Hash=-37334073},
	{Name="Dale",Hash=1182012905},
	{Name="DaleCutscene",Hash=216536661},
	{Name="DaveNorton",Hash=365775923},
	{Name="DaveNortonCutscene",Hash=-2054740852},
	{Name="Dealer01SMY",Hash=-459818001},
	{Name="DebraCutscene",Hash=-321892375},
	{Name="Deer",Hash=-664053099},
	{Name="Denise",Hash=-2113195075},
	{Name="DeniseCutscene",Hash=1870669624},
	{Name="DeniseFriendCutscene",Hash=-1249041111},
	{Name="Devin",Hash=1952555184},
	{Name="DevinCutscene",Hash=788622594},
	{Name="DevinSec01SMY",Hash=-1688898956},
	{Name="DHill01AMY",Hash=-12678997},
	{Name="DoaMan",Hash=1646160893},
	{Name="DockWork01SMM",Hash=349680864},
	{Name="DockWork01SMY",Hash=-2039072303},
	{Name="Doctor01SMM",Hash=-730659924},
	{Name="Dolphin",Hash=-1950698411},
	{Name="Dom",Hash=-1674727288},
	{Name="DomCutscene",Hash=1198698306},
	{Name="Doorman01SMY",Hash=579932932},
	{Name="DownTown01AFM",Hash=1699403886},
	{Name="DownTown01AMY",Hash=766375082},
	{Name="Dreyfuss",Hash=-628553422},
	{Name="DreyfussCutscene",Hash=1012965715},
	{Name="DrFriedlander",Hash=-872673803},
	{Name="DrFriedlanderCutscene",Hash=-1549575121},
	{Name="Drowned",Hash=1943971979},
	{Name="DWService01SMY",Hash=1976765073},
	{Name="DWService02SMY",Hash=-175076858},
	{Name="EastSA01AFM",Hash=-1656894598},
	{Name="EastSA01AFY",Hash=-173013091},
	{Name="EastSA01AMM",Hash=-106498753},
	{Name="Eastsa01AMY",Hash=-1538846349},
	{Name="EastSA02AFM",Hash=1674107025},
	{Name="EastSA02AFY",Hash=70821038},
	{Name="EastSa02AMM",Hash=131961260},
	{Name="EastSA02AMY",Hash=377976310},
	{Name="EastSA03AFY",Hash=1371553700},
	{Name="EdToh",Hash=712602007},
	{Name="Epsilon01AFY",Hash=1755064960},
	{Name="Epsilon01AMY",Hash=2010389054},
	{Name="Epsilon02AMY",Hash=-1434255461},
	{Name="ExArmy01",Hash=1161072059},
	{Name="Fabien",Hash=-795819184},
	{Name="FabienCutscene",Hash=1191403201},
	{Name="Factory01SFY",Hash=1777626099},
	{Name="Factory01SMY",Hash=1097048408},
	{Name="FamCA01GMY",Hash=-398748745},
	{Name="FamDD01",Hash=866411749},
	{Name="FamDNF01GMY",Hash=-613248456},
	{Name="FamFor01GMY",Hash=-2077218039},
	{Name="Families01GFY",Hash=1309468115},
	{Name="Farmer01AMM",Hash=-1806291497},
	{Name="FatBla01AFM",Hash=-88831029},
	{Name="FatCult01AFM",Hash=-1244692252},
	{Name="FatLatin01AMM",Hash=1641152947},
	{Name="FatWhite01AFM",Hash=951767867},
	{Name="FBISuit01",Hash=988062523},
	{Name="FBISuit01Cutscene",Hash=1482427218},
	{Name="FemBarberSFM",Hash=373000027},
	{Name="FIBArchitect",Hash=874722259},
	{Name="FIBMugger01",Hash=-2051422616},
	{Name="FIBOffice01SMM",Hash=-306416314},
	{Name="FIBOffice02SMM",Hash=653289389},
	{Name="FIBSec01",Hash=1558115333},
	{Name="FIBSec01SMM",Hash=2072724299},
	{Name="FilmDirector",Hash=728636342},
	{Name="FilmNoir",Hash=732742363},
	{Name="FinGuru01",Hash=1189322339},
	{Name="Fireman01SMY",Hash=-1229853272},
	{Name="Fish",Hash=802685111},
	{Name="Fitness01AFY",Hash=1165780219},
	{Name="Fitness02AFY",Hash=331645324},
	{Name="Floyd",Hash=-1313761614},
	{Name="FloydCutscene",Hash=103106535},
	{Name="FosRepCutscene",Hash=466359675},
	{Name="Franklin",Hash=-1692214353},
	{Name="FreemodeFemale01",Hash=-1667301416},
	{Name="FreeModeMale01",Hash=1885233650},
	{Name="G",Hash=-2078561997},
	{Name="Gaffer01SMM",Hash=-1453933154},
	{Name="GarbageSMY",Hash=-294281201},
	{Name="Gardener01SMM",Hash=1240094341},
	{Name="Gay01AMY",Hash=-775102410},
	{Name="Gay02AMY",Hash=-1519253631},
	{Name="GCutscene",Hash=-1567723049},
	{Name="GenFat01AMM",Hash=115168927},
	{Name="GenFat02AMM",Hash=330231874},
	{Name="GenHot01AFY",Hash=793439294},
	{Name="GenStreet01AFO",Hash=1640504453},
	{Name="GenStreet01AMO",Hash=-1386944600},
	{Name="GenStreet01AMY",Hash=-1736970383},
	{Name="GenStreet02AMY",Hash=891398354},
	{Name="GenTransportSMM",Hash=411102470},
	{Name="GlenStank01",Hash=1169888870},
	{Name="Golfer01AFY",Hash=2111372120},
	{Name="Golfer01AMM",Hash=-1444213182},
	{Name="Golfer01AMY",Hash=-685776591},
	{Name="Griff01",Hash=-1001079621},
	{Name="Grip01SMY",Hash=815693290},
	{Name="Groom",Hash=-20018299},
	{Name="GroomCutscene",Hash=2058033618},
	{Name="GroveStrDlrCutscene",Hash=-396800478},
	{Name="GuadalopeCutscene",Hash=261428209},
	{Name="Guido01",Hash=-961242577},
	{Name="GunVend01",Hash=-1289578670},
	{Name="GurkCutscene",Hash=-1022036185},
	{Name="Hacker",Hash=-1715797768},
	{Name="HairDress01SMM",Hash=1099825042},
	{Name="HammerShark",Hash=1015224100},
	{Name="Hao",Hash=1704428387},
	{Name="HaoCutscene",Hash=-325152996},
	{Name="HasJew01AMM",Hash=1809430156},
	{Name="HasJew01AMY",Hash=-512913663},
	{Name="Hen",Hash=1794449327},
	{Name="HighSec01SMM",Hash=-245247470},
	{Name="HighSec02SMM",Hash=691061163},
	{Name="Hiker01AFY",Hash=813893651},
	{Name="Hiker01AMY",Hash=1358380044},
	{Name="HillBilly01AMM",Hash=1822107721},
	{Name="HillBilly02AMM",Hash=2064532783},
	{Name="Hippie01",Hash=-264140789},
	{Name="Hippie01AFY",Hash=343259175},
	{Name="Hippy01AMY",Hash=2097407511},
	{Name="Hipster01AFY",Hash=-2109222095},
	{Name="Hipster01AMY",Hash=587703123},
	{Name="Hipster02AFY",Hash=-1745486195},
	{Name="Hipster02AMY",Hash=349505262},
	{Name="Hipster03AFY",Hash=-1514497514},
	{Name="Hipster03AMY",Hash=1312913862},
	{Name="Hipster04AFY",Hash=429425116},
	{Name="Hooker01SFY",Hash=42647445},
	{Name="Hooker02SFY",Hash=348382215},
	{Name="Hooker03SFY",Hash=51789996},
	{Name="HotPosh01",Hash=-1768198658},
	{Name="HughCutscene",Hash=1863555924},
	{Name="Humpback",Hash=1193010354},
	{Name="Hunter",Hash=-837606178},
	{Name="HunterCutscene",Hash=1531218220},
	{Name="Husky",Hash=1318032802},
	{Name="HWayCop01SMY",Hash=1939545845},
	{Name="ImpoRage",Hash=880829941},
	{Name="ImranCutscene",Hash=-482210853},
	{Name="Indian01AFO",Hash=-1160266880},
	{Name="Indian01AFY",Hash=153984193},
	{Name="Indian01AMM",Hash=-573920724},
	{Name="Indian01AMY",Hash=706935758},
	{Name="JackHowitzerCutscene",Hash=1153203121},
	{Name="Janet",Hash=225287241},
	{Name="JanetCutscene",Hash=808778210},
	{Name="JanitorCutscene",Hash=-1040164288},
	{Name="JanitorSMM",Hash=-1452549652},
	{Name="JayNorris",Hash=2050158196},
	{Name="Jesus01",Hash=-835930287},
	{Name="JetSki01AMY",Hash=767028979},
	{Name="JewelAss01",Hash=-254493138},
	{Name="JewelAss",Hash=257763003},
	{Name="JewelAssCutscene",Hash=1145088004},
	{Name="JewelSec01",Hash=-1395868234},
	{Name="JewelThief",Hash=-422822692},
	{Name="JimmyBoston",Hash=-308279251},
	{Name="JimmyBostonCutscene",Hash=60192701},
	{Name="JimmyDisanto",Hash=1459905209},
	{Name="JimmyDisantoCutscene",Hash=-1194552652},
	{Name="JoeMinuteman",Hash=-1105179493},
	{Name="JoeMinutemanCutscene",Hash=-258122199},
	{Name="JohnnyKlebitz",Hash=-2016771922},
	{Name="JohnnyKlebitzCutscene",Hash=-91572095},
	{Name="Josef",Hash=-518348876},
	{Name="JosefCutscene",Hash=1167549130},
	{Name="Josh",Hash=2040438510},
	{Name="JoshCutscene",Hash=1158606749},
	{Name="Juggalo01AFY",Hash=-619494093},
	{Name="Juggalo01AMY",Hash=-1849016788},
	{Name="Justin",Hash=2109968527},
	{Name="KarenDaniels",Hash=-346957479},
	{Name="KarenDanielsCutscene",Hash=1269774364},
	{Name="KerryMcintosh",Hash=1530648845},
	{Name="KillerWhale",Hash=-1920284487},
	{Name="KorBoss01GMM",Hash=891945583},
	{Name="Korean01GMY",Hash=611648169},
	{Name="Korean02GMY",Hash=-1880237687},
	{Name="KorLieut01GMY",Hash=2093736314},
	{Name="KTown01AFM",Hash=1388848350},
	{Name="KTown01AFO",Hash=1204772502},
	{Name="KTown01AMM",Hash=-782401935},
	{Name="KTown01AMO",Hash=355916122},
	{Name="KTown01AMY",Hash=452351020},
	{Name="KTown02AFM",Hash=1090617681},
	{Name="KTown02AMY",Hash=696250687},
	{Name="LamarDavis",Hash=1706635382},
	{Name="LamarDavisCutscene",Hash=1162230285},
	{Name="Lathandy01SMM",Hash=-1635724594},
	{Name="Latino01AMY",Hash=321657486},
	{Name="Lazlow",Hash=-538688539},
	{Name="LazlowCutscene",Hash=949295643},
	{Name="LesterCrest",Hash=1302784073},
	{Name="LesterCrestCutscene",Hash=-1248528957},
	{Name="LifeInvad01",Hash=1401530684},
	{Name="LifeInvad01Cutscene",Hash=1918178165},
	{Name="LifeInvad01SMM",Hash=-570394627},
	{Name="LifeInvad02",Hash=666718676},
	{Name="LineCookSMM",Hash=-610530921},
	{Name="Lost01GFY",Hash=-44746786},
	{Name="Lost01GMY",Hash=1330042375},
	{Name="Lost02GMY",Hash=1032073858},
	{Name="Lost03GMY",Hash=850468060},
	{Name="LSMetro01SMM",Hash=1985653476},
	{Name="Magenta",Hash=-52653814},
	{Name="MagentaCutscene",Hash=1477887514},
	{Name="Maid01SFM",Hash=-527186490},
	{Name="Malibu01AMM",Hash=803106487},
	{Name="Mani",Hash=-927261102},
	{Name="Manuel",Hash=-46035440},
	{Name="ManuelCutscene",Hash=-72125238},
	{Name="Mariachi01SMM",Hash=2124742566},
	{Name="Marine01SMM",Hash=-220552467},
	{Name="Marine01SMY",Hash=1702441027},
	{Name="Marine02SMM",Hash=-265970301},
	{Name="Marine02SMY",Hash=1490458366},
	{Name="Marine03SMY",Hash=1925237458},
	{Name="Markfost",Hash=479578891},
	{Name="Marnie",Hash=411185872},
	{Name="MarnieCutscene",Hash=1464721716},
	{Name="Marston01",Hash=943915367},
	{Name="MartinMadrazoCutscene",Hash=1129928304},
	{Name="Maryann",Hash=-1552967674},
	{Name="MaryannCutscene",Hash=161007533},
	{Name="Maude",Hash=1005070462},
	{Name="MaudeCutscene",Hash=-1127975477},
	{Name="MerryWeatherCutscene",Hash=1631478380},
	{Name="MethHead01AMY",Hash=1768677545},
	{Name="MexBoss01GMM",Hash=1466037421},
	{Name="MexBoss02GMM",Hash=1226102803},
	{Name="MexCntry01AMM",Hash=-578715987},
	{Name="MexGang01GMY",Hash=-1109568186},
	{Name="MexGoon01GMY",Hash=653210662},
	{Name="MexGoon02GMY",Hash=832784782},
	{Name="MexGoon03GMY",Hash=-1773333796},
	{Name="MexLabor01AMM",Hash=-1302522190},
	{Name="Mexthug01AMY",Hash=810804565},
	{Name="Michael",Hash=225514697},
	{Name="Michelle",Hash=-1080659212},
	{Name="MichelleCutscene",Hash=1890499016},
	{Name="Migrant01SFY",Hash=-715445259},
	{Name="Migrant01SMM",Hash=-317922106},
	{Name="MilitaryBum",Hash=1191548746},
	{Name="Milton",Hash=-886023758},
	{Name="MiltonCutscene",Hash=-1217776881},
	{Name="MimeSMY",Hash=1021093698},
	{Name="Miranda",Hash=1095737979},
	{Name="Mistress",Hash=1573528872},
	{Name="Misty01",Hash=-785842275},
	{Name="Molly",Hash=-1358701087},
	{Name="MollyCutscene",Hash=1167167044},
	{Name="Motox01AMY",Hash=1694362237},
	{Name="Motox02AMY",Hash=2007797722},
	{Name="MountainLion",Hash=307287994},
	{Name="MovAlien01",Hash=1684083350},
	{Name="MoviePremFemaleCutscene",Hash=1270514905},
	{Name="MoviePremMaleCutscene",Hash=-1922568579},
	{Name="MovieStar",Hash=894928436},
	{Name="MovPrem01SFY",Hash=587253782},
	{Name="MovPrem01SMM",Hash=-664900312},
	{Name="MovSpace01SMM",Hash=-407694286},
	{Name="MPros01",Hash=1822283721},
	{Name="MrK",Hash=-304305299},
	{Name="MrKCutscene",Hash=-1010001291},
	{Name="MrsPhillips",Hash=946007720},
	{Name="MrsPhillipsCutscene",Hash=-872569905},
	{Name="MrsThornhill",Hash=503621995},
	{Name="MrsThornhillCutscene",Hash=1334976110},
	{Name="MusclBeac01AMY",Hash=1264920838},
	{Name="MusclBeac02AMY",Hash=-920443780},
	{Name="Natalia",Hash=-568861381},
	{Name="NataliaCutscene",Hash=1325314544},
	{Name="NervousRon",Hash=-1124046095},
	{Name="NervousRonCutscene",Hash=2023152276},
	{Name="Nigel",Hash=-927525251},
	{Name="NigelCutscene",Hash=-515400693},
	{Name="Niko01",Hash=-287649847},
	{Name="OGBoss01AMM",Hash=1746653202},
	{Name="OldMan1A",Hash=1906124788},
	{Name="OldMan1aCutscene",Hash=518814684},
	{Name="OldMan2",Hash=-283816889},
	{Name="OldMan2Cutscene",Hash=-1728452752},
	{Name="Omega",Hash=1625728984},
	{Name="OmegaCutscene",Hash=-1955548155},
	{Name="Oneil",Hash=768005095},
	{Name="Orleans",Hash=1641334641},
	{Name="OrleansCutscene",Hash=-1389097126},
	{Name="Ortega",Hash=648372919},
	{Name="OrtegaCutscene",Hash=-1059388209},
	{Name="OscarCutscene",Hash=-199280229},
	{Name="Paige",Hash=357551935},
	{Name="PaigeCutscene",Hash=1528799427},
	{Name="Paparazzi01AMM",Hash=-322270187},
	{Name="Paparazzi",Hash=1346941736},
	{Name="Paper",Hash=-1717894970},
	{Name="PaperCutscene",Hash=1798879480},
	{Name="Paramedic01SMM",Hash=-1286380898},
	{Name="Party01",Hash=921110016},
	{Name="PartyTarget",Hash=-2114499097},
	{Name="Patricia",Hash=-982642292},
	{Name="PatriciaCutscene",Hash=-544533759},
	{Name="PestCont01SMY",Hash=1209091352},
	{Name="PestContDriver",Hash=994527967},
	{Name="PestContGunman",Hash=193469166},
	{Name="Pig",Hash=-1323586730},
	{Name="Pigeon",Hash=111281960},
	{Name="Pilot01SMM",Hash=-413447396},
	{Name="Pilot01SMY",Hash=-1422914553},
	{Name="Pilot02SMM",Hash=-163714847},
	{Name="Pogo01",Hash=-598109171},
	{Name="PoloGoon01GMY",Hash=1329576454},
	{Name="PoloGoon02GMY",Hash=-1561829034},
	{Name="Polynesian01AMM",Hash=-1445349730},
	{Name="Polynesian01AMY",Hash=-2088436577},
	{Name="Poodle",Hash=1125994524},
	{Name="Popov",Hash=645279998},
	{Name="PopovCutscene",Hash=1635617250},
	{Name="PoppyMich",Hash=602513566},
	{Name="PornDudesCutscene",Hash=793443893},
	{Name="Postal01SMM",Hash=1650036788},
	{Name="Postal02SMM",Hash=1936142927},
	{Name="Priest",Hash=1681385341},
	{Name="PriestCutscene",Hash=1299047806},
	{Name="Princess",Hash=-756833660},
	{Name="PrisGuard01SMM",Hash=1456041926},
	{Name="PrisMuscl01SMY",Hash=1596003233},
	{Name="Prisoner01",Hash=2073775040},
	{Name="Prisoner01SMY",Hash=-1313105063},
	{Name="PrologueDriver",Hash=-2057423197},
	{Name="PrologueDriverCutscene",Hash=-267695653},
	{Name="PrologueHostage01",Hash=-988619485},
	{Name="PrologueHostage01AFM",Hash=379310561},
	{Name="PrologueHostage01AMM",Hash=-1760377969},
	{Name="PrologueMournFemale01",Hash=-1576494617},
	{Name="PrologueMournMale01",Hash=-829029621},
	{Name="PrologueSec01",Hash=1888624839},
	{Name="PrologueSec01Cutscene",Hash=2141384740},
	{Name="PrologueSec02",Hash=666086773},
	{Name="PrologueSec02Cutscene",Hash=512955554},
	{Name="Pug",Hash=1832265812},
	{Name="Rabbit",Hash=-541762431},
	{Name="RampGang",Hash=-449965460},
	{Name="RampGangCutscene",Hash=-1031795266},
	{Name="RampHic",Hash=1165307954},
	{Name="RampHicCutscene",Hash=-2054384456},
	{Name="RampHipster",Hash=-554721426},
	{Name="RampHipsterCutscene",Hash=569740212},
	{Name="RampMarineCutscene",Hash=1634506681},
	{Name="RampMex",Hash=-424905564},
	{Name="RampMexCutscene",Hash=-162605104},
	{Name="Ranger01SFY",Hash=-1614285257},
	{Name="Ranger01SMY",Hash=-277793362},
	{Name="Rashkovsky",Hash=940326374},
	{Name="RashkovskyCutscene",Hash=411081129},
	{Name="Rat",Hash=-1011537562},
	{Name="ReporterCutscene",Hash=776079908},
	{Name="Retriever",Hash=882848737},
	{Name="Rhesus",Hash=-1026527405},
	{Name="RivalPaparazzi",Hash=1624626906},
	{Name="RoadCyc01AMY",Hash=-178150202},
	{Name="Robber01SMY",Hash=-1067576423},
	{Name="RoccoPelosi",Hash=-709209345},
	{Name="RoccoPelosiCutscene",Hash=-1436281204},
	{Name="Rottweiler",Hash=-1788665315},
	{Name="RsRanger01AMO",Hash=1011059922},
	{Name="Runner01AFY",Hash=-951490775},
	{Name="Runner01AMY",Hash=623927022},
	{Name="Runner02AMY",Hash=-2076336881},
	{Name="RurMeth01AFY",Hash=1064866854},
	{Name="RurMeth01AMM",Hash=1001210244},
	{Name="RussianDrunk",Hash=1024089777},
	{Name="RussianDrunkCutscene",Hash=1179785778},
	{Name="Salton01AFM",Hash=-569505431},
	{Name="Salton01AFO",Hash=-855671414},
	{Name="Salton01AMM",Hash=1328415626},
	{Name="Salton01AMO",Hash=539004493},
	{Name="Salton01AMY",Hash=-681546704},
	{Name="Salton02AMM",Hash=1626646295},
	{Name="Salton03AMM",Hash=-1299428795},
	{Name="Salton04AMM",Hash=-1773858377},
	{Name="SalvaBoss01GMY",Hash=-1872961334},
	{Name="SalvaGoon01GMY",Hash=663522487},
	{Name="SalvaGoon02GMY",Hash=846439045},
	{Name="SalvaGoon03GMY",Hash=62440720},
	{Name="SBikeAMO",Hash=1794381917},
	{Name="SCDressy01AFY",Hash=-614546432},
	{Name="Scientist01SMM",Hash=1092080539},
	{Name="ScreenWriter",Hash=-1689993},
	{Name="ScreenWriterCutscene",Hash=-1948177172},
	{Name="Scrubs01SFY",Hash=-1420211530},
	{Name="Seagull",Hash=-745300483},
	{Name="Security01SMM",Hash=-681004504},
	{Name="Shepherd",Hash=1126154828},
	{Name="Sheriff01SFY",Hash=1096929346},
	{Name="Sheriff01SMY",Hash=-1320879687},
	{Name="ShopHighSFM",Hash=-1371020112},
	{Name="ShopKeep01",Hash=416176080},
	{Name="ShopLowSFY",Hash=-1452399100},
	{Name="ShopMaskSMY",Hash=1846684678},
	{Name="ShopMidSFY",Hash=1055701597},
	{Name="SiemonYetarian",Hash=1283141381},
	{Name="SiemonYetarianCutscene",Hash=-1064078846},
	{Name="Skater01AFY",Hash=1767892582},
	{Name="Skater01AMM",Hash=-640198516},
	{Name="Skater01AMY",Hash=-1044093321},
	{Name="Skater02AMY",Hash=-1342520604},
	{Name="Skidrow01AFM",Hash=-1332260293},
	{Name="SkidRow01AMM",Hash=32417469},
	{Name="SnowCop01SMM",Hash=451459928},
	{Name="SoCenLat01AMM",Hash=193817059},
	{Name="Solomon",Hash=-2034368986},
	{Name="SolomonCutscene",Hash=-154017714},
	{Name="SouCent01AFM",Hash=1951946145},
	{Name="SouCent01AFO",Hash=1039800368},
	{Name="SouCent01AFY",Hash=744758650},
	{Name="SouCent01AMM",Hash=1750583735},
	{Name="SouCent01AMO",Hash=718836251},
	{Name="SouCent01AMY",Hash=-417940021},
	{Name="SouCent02AFM",Hash=-215821512},
	{Name="SouCent02AFO",Hash=-1519524074},
	{Name="SouCent02AFY",Hash=1519319503},
	{Name="SouCent02AMM",Hash=-1620232223},
	{Name="SouCent02AMO",Hash=1082572151},
	{Name="SouCent02AMY",Hash=-1398552374},
	{Name="SouCent03AFY",Hash=-2018356203},
	{Name="SouCent03AMM",Hash=-1948675910},
	{Name="SouCent03AMO",Hash=238213328},
	{Name="SouCent03AMY",Hash=-1007618204},
	{Name="SouCent04AMM",Hash=-1023672578},
	{Name="SouCent04AMY",Hash=-1976105999},
	{Name="SouCentMC01AFM",Hash=-840346158},
	{Name="SpyActor",Hash=-1408326184},
	{Name="SpyActress",Hash=1535236204},
	{Name="StagGrm01AMO",Hash=-1852518909},
	{Name="StBla01AMY",Hash=-812470807},
	{Name="Stbla02AMY",Hash=-1731772337},
	{Name="SteveHain",Hash=941695432},
	{Name="SteveHainsCutscene",Hash=-1528782338},
	{Name="Stingray",Hash=-1589092019},
	{Name="StLat01AMY",Hash=-2039163396},
	{Name="StLat02AMM",Hash=-1029146878},
	{Name="Stretch",Hash=915948376},
	{Name="StretchCutscene",Hash=-1992464379},
	{Name="Stripper01Cutscene",Hash=-1360365899},
	{Name="Stripper01SFY",Hash=1381498905},
	{Name="Stripper02Cutscene",Hash=-2126242959},
	{Name="Stripper02SFY",Hash=1846523796},
	{Name="StripperLite",Hash=695248020},
	{Name="StripperLiteSFY",Hash=1544875514},
	{Name="StrPerf01SMM",Hash=2035992488},
	{Name="StrPreach01SMM",Hash=469792763},
	{Name="StrPunk01GMY",Hash=-48477765},
	{Name="StrPunk02GMY",Hash=228715206},
	{Name="StrVend01SMM",Hash=-829353047},
	{Name="StrVend01SMY",Hash=-1837161693},
	{Name="StWhi01AMY",Hash=605602864},
	{Name="StWhi02AMY",Hash=919005580},
	{Name="SunBathe01AMY",Hash=-1222037748},
	{Name="Surfer01AMY",Hash=-356333586},
	{Name="SWAT01SMY",Hash=-1920001264},
	{Name="SweatShop01SFM",Hash=824925120},
	{Name="SweatShop01SFY",Hash=-2063419726},
	{Name="Talina",Hash=-409745176},
	{Name="Tanisha",Hash=226559113},
	{Name="TanishaCutscene",Hash=1123963760},
	{Name="TaoCheng",Hash=-597926235},
	{Name="TaoChengCutscene",Hash=-2006710211},
	{Name="TaosTranslator",Hash=2089096292},
	{Name="TaosTranslatorCutscene",Hash=1397974313},
	{Name="TapHillBilly",Hash=-1709285806},
	{Name="Tattoo01AMO",Hash=-1800524916},
	{Name="Tennis01AFY",Hash=1426880966},
	{Name="Tennis01AMM",Hash=1416254276},
	{Name="TennisCoach",Hash=-1573167273},
	{Name="TennisCoachCutscene",Hash=1545995274},
	{Name="Terry",Hash=1728056212},
	{Name="TerryCutscene",Hash=978452933},
	{Name="TigerShark",Hash=113504370},
	{Name="TomCutscene",Hash=1776856003},
	{Name="TomEpsilon",Hash=-847807830},
	{Name="TomEpsilonCutscene",Hash=-1945119518},
	{Name="Tonya",Hash=-892841148},
	{Name="TonyaCutscene",Hash=1665391897},
	{Name="Topless01AFY",Hash=-1661836925},
	{Name="Tourist01AFM",Hash=1347814329},
	{Name="Tourist01AFY",Hash=1446741360},
	{Name="Tourist01AMM",Hash=-929103484},
	{Name="Tourist02AFY",Hash=-1859912896},
	{Name="TracyDisanto",Hash=-566941131},
	{Name="TracyDisantoCutScene",Hash=101298480},
	{Name="TrafficWarden",Hash=1461287021},
	{Name="TrafficWardenCutscene",Hash=-567724045},
	{Name="Tramp01",Hash=1787764635},
	{Name="Tramp01AFM",Hash=1224306523},
	{Name="Tramp01AMM",Hash=516505552},
	{Name="Tramp01AMO",Hash=390939205},
	{Name="TrampBeac01AFM",Hash=-1935621530},
	{Name="TrampBeac01AMM",Hash=1404403376},
	{Name="TranVest01AMM",Hash=-521758348},
	{Name="TranVest02AMM",Hash=-150026812},
	{Name="Trevor",Hash=-1686040670},
	{Name="Trucker01SMM",Hash=1498487404},
	{Name="TylerDixon",Hash=1382414087},
	{Name="UndercoverCopCutscene",Hash=-277325206},
	{Name="UPS01SMM",Hash=-1614577886},
	{Name="UPS02SMM",Hash=-792862442},
	{Name="USCG01SMY",Hash=-905948951},
	{Name="Vagos01GFY",Hash=1520708641},
	{Name="VagosFun01",Hash=-995747907},
	{Name="VagosSpeak",Hash=-100858228},
	{Name="VagosSpeakCutscene",Hash=1224690857},
	{Name="Valet01SMY",Hash=999748158},
	{Name="VinDouche01AMY",Hash=-1047300121},
	{Name="Vinewood01AFY",Hash=435429221},
	{Name="VineWood01AMY",Hash=1264851357},
	{Name="Vinewood02AFY",Hash=-625565461},
	{Name="VineWood02AMY",Hash=1561705728},
	{Name="Vinewood03AFY",Hash=933092024},
	{Name="Vinewood03AMY",Hash=534725268},
	{Name="Vinewood04AFY",Hash=-85696186},
	{Name="Vinewood04AMY",Hash=835315305},
	{Name="Wade",Hash=-1835459726},
	{Name="WadeCutscene",Hash=-765011498},
	{Name="Waiter01SMY",Hash=-1387498932},
	{Name="WeiCheng",Hash=-1427838341},
	{Name="WeiChengCutscene",Hash=819699067},
	{Name="Westy",Hash=-1384627013},
	{Name="WillyFist",Hash=-1871275377},
	{Name="WinClean01SMY",Hash=1426951581},
	{Name="XMech01SMY",Hash=1142162924},
	{Name="XMech02SMY",Hash=-1105135100},
	{Name="Yoga01AFY",Hash=-1004861906},
	{Name="Yoga01AMY",Hash=-1425378987},
	{Name="Zimbor",Hash=188012277},
	{Name="ZimborCutscene",Hash=-357782800},
	{Name="Zombie01",Hash=-1404353274},
}

local function IsModelBlocked(isWater)
	if not BlockChange then return true end
	local LP = player.get_player_ped(player.player_id())
	if ped.is_ped_in_any_vehicle(LP) then
		ui.notify_above_map("Model Change in Vehicle not possible", "Metamorphosis", 140)
		return false
	end
	local pos = entity.get_entity_coords(LP)
	if isWater then
		if pos.z > -0.5 then
			ui.notify_above_map("Your current position doesnt allow a Water Animal", "Metamorphosis", 140)
			return false
		end
	else
		if pos.z < 0.5 then
			ui.notify_above_map("Your current position doesnt allow a Ground Animal", "Metamorphosis", 140)
			return false
		end
	end
	return true
end

local function ChangeModel(hash, isWater, isInvisible, isDown)
	if IsModelBlocked(isWater) then
		local LP = player.get_player_ped(player.player_id())
		if isDown then
			local pos = entity.get_entity_coords(LP)	
			pos.z = pos.z + 1.5
			entity.set_entity_coords_no_offset(LP, pos)	
		end
		streaming.request_model(hash)
		while not streaming.has_model_loaded(hash) do
			system.wait(0)
		end
		local pos = entity.get_entity_coords(LP)
		local rot = entity.get_entity_rotation(LP)
		player.set_player_model(hash)
		streaming.set_model_as_no_longer_needed(hash)
		system.wait(100)
		LP = player.get_player_ped(player.player_id())
		entity.set_entity_coords_no_offset(LP, pos)
		entity.set_entity_rotation(LP, rot)
		if isInvisible then
			system.wait(100)
			local change = ped.set_ped_component_variation(LP, 4, 0, 0, 2)	
		end
	end
end

local function SearchPedName()
	gameplay.display_onscreen_keyboard("Input ped name", "", 64)
	while not gameplay.update_onscreen_keyboard() do
		if not gameplay.is_onscreen_keyboard_active() then return HANDLER_POP end
		system.wait(0)
	end
	local ModelName = gameplay.get_onscreen_keyboard_result()
	for i=1,#PedNames do
		if ModelName:len() == 0 or PedNames[i].Name:lower():find(ModelName:lower(), 1, true) then
			PedNames[i].Feat.hidden = false
		else
			PedNames[i].Feat.hidden = true
		end
	end
	return HANDLER_POP
end

local function ToggleBlock()
	BlockChange = not BlockChange
	return HANDLER_POP
end

local function StoreModelHash()
	local LP = player.get_player_ped(player.player_id())
	local notif = OGHash ~= nil
	OGHash = entity.get_entity_model_hash(LP)
	for i=0,11 do
		local item = {}
		item.drawable = ped.get_ped_drawable_variation(LP, i)
		item.texture = ped.get_ped_texture_variation(LP, i)
		OGClothing[i] = item
	end
	for i=0,3 do
		local item = {}
		item.drawable = ped.get_ped_prop_index(LP, i)
		item.texture = ped.get_ped_prop_texture_index(LP, i)
		OGProps[i] = item
	end
	if notif then ui.notify_above_map("Updated model hash.", "Model Changer", 140) end
	return HANDLER_POP
end

local function ResetModel()
	local hash = OGHash
	if not hash then
		hash = 0x9B22DBAF
		ui.notify_above_map("Could not find original model hash. Reverting to Franklin.", "Metamorphosis", 140)
	end
	ChangeModel(hash)
	system.wait(100)
	local LP = player.get_player_ped(player.player_id())
	for i=0,11 do
		local item = OGClothing[i]
		if item then
			ped.set_ped_component_variation(LP, i, item.drawable, item.texture, 0)
		end
	end
	for i=0,3 do
		local item = OGProps[i]
		if item then
			ped.set_ped_prop_index(LP, i, item.drawable, item.texture, true)
		end
	end
	return HANDLER_POP
end

local function FixLoading()
	ChangeModel(0x9B22DBAF)
	system.wait(100)
	local LP = player.get_player_ped(player.player_id())
	ped.set_ped_health(LP, 0)
	return HANDLER_POP
end

function main()
	local parent = menu.add_feature("Metamorphosis", "parent", 0)

	for i=1,#ModelTypes do
		local type = ModelTypes[i]
		local typeName, typeCallback, typeItems = type.Name, type.Callback, type.Items
		local child = menu.add_feature(typeName, "parent", parent.id, typeCallback)
		for j=1,#typeItems do
			local item = typeItems[j]
			local name, hash, isWater, isInvisible, isDown = item.Name, item.Hash, item.IsWater, item.IsInvisible, item.IsDown
			menu.add_feature(name, "action", child.id, function()
				ChangeModel(hash, isWater, isInvisible, isDown)
				return HANDLER_POP
			end).threaded = false
		end
	end
	
	local child = menu.add_feature("Ped List", "parent", parent.id)
	menu.add_feature("Filter Ped List", "action", child.id, SearchPedName)
	for i=1,#PedNames do
		local ped = PedNames[i]
		local name, hash = ped.Name, ped.Hash
		PedNames[i].Feat = menu.add_feature(name, "action", child.id, function()
			ChangeModel(hash)
			return HANDLER_POP
		end)
		PedNames[i].Feat.threaded = false
	end

	menu.add_feature("Disable Safe Model Change", "toggle", parent.id, ToggleBlock)
	menu.add_feature("Try fix endless loading Screen", "action", parent.id,FixLoading).threaded = false
	menu.add_feature("Restore Saved Model", "action", parent.id,ResetModel).threaded = false
	menu.add_feature("Store Current Model", "action", parent.id,StoreModelHash).threaded = false
	
	StoreModelHash()
end

main()