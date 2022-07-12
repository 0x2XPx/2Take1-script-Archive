-- GeeSkid v1.03

function _GF_is_pid_intrr(_pid)
	if _GF_valid_pid(_pid) then
		if interior.get_interior_from_entity(player.get_player_ped(_pid)) == 0 then
			if _GF_is_intrr_pos(_pid) then
				return true
			end
		elseif not _GT_non_intrr2[interior.get_interior_from_entity(player.get_player_ped(_pid))] or _GF_is_intrr_pos(_pid) then
			return true
		end
	end
	return false
end

function _GF_is_intrr_pos(_pid) --more will be added when i find them. Any time a player is stuck between entering interior and being in interior their pos.z will bounce up and down. Im not sure if this is because of your distance to them, gta loading problem, or both.
	local plyr_pos = player.get_player_coords(_pid)
	if plyr_pos.z < -179 then
		return true
	elseif plyr_pos.z ~= -50 and plyr_pos.z < 0 then 
		if plyr_pos.y > -1200 then
			if _GF_pos_xy_in_range(plyr_pos,216,242,-1010,-961) then -- 10 car garage
				return true
			elseif _GF_pos_xy_in_range(plyr_pos,-1369,-1318.5,134.5,170.5) then -- autoshop
				return true
			elseif _GF_pos_xy_in_range(plyr_pos,1080,1170,190,275) then --casino momentarily doesnt show as interior
				return true
			elseif _GF_pos_xy_in_range(plyr_pos,1520,1600,345,425) then --sometimes the kosatka interior makes poz.z bounce between -49.678 and -180
				return true
			elseif _GF_pos_xy_in_range(plyr_pos,1553,1568,361,452) then -- kosatka -60,-45
				return true
			elseif _GF_pos_xy_in_range(plyr_pos,504,535,4744,4756) then -- avenger -72,-63
				return true
			elseif _GF_pos_xy_in_range(plyr_pos,310,510,4755,4885) then --Facility -67,-51
				return true
			end
		elseif plyr_pos.x > 0 then	
			if _GF_pos_xy_in_range(plyr_pos,995,1017,-3179.5,-3142.5) then
				return true
			elseif _GF_pos_xy_in_range(plyr_pos,926.5,1014.5,-3039.5,-2985) then -- "Vehicle Warehouse"
				return true
			elseif _GF_pos_xy_in_range(plyr_pos,800,1200,-3300,-2900) then --interiors located at the docks dont always register as in interior
				return true
			elseif _GF_pos_xy_in_range(plyr_pos,822,955,-3253,-3061) then -- bunker -102,-92
				return true
			elseif _GF_pos_xy_in_range(plyr_pos,1097,1109,-3017,-3009) then -- MOC -44,-35
				return true
			end
		else
			if _GF_pos_xy_in_range(plyr_pos,-1308,-1225,-3073,-2956) then -- hangar -49,-25
				return true
			elseif _GF_pos_xy_in_range(plyr_pos,-1648,-1564,-3022,-2983) then -- nightclub -82,-70
				return true
			elseif _GF_pos_xy_in_range(plyr_pos,-1526,-1499,-3048,-2971) then	--nightclub basement -86,-75
				return true
			elseif _GF_pos_xy_in_range(plyr_pos,1093,1128,-3170,-3137) then	--mc clubhouse -41,-33
				return true
			elseif _GF_pos_xy_in_range(plyr_pos,-1426,-1416,-3019,-3006) then -- terrorbyte -84,-75
				return true
			end
		end
	end
	return false
end

function _GF_intrr_str(_pid)
	local int = interior.get_interior_from_entity(player.get_player_ped(_pid))
	local plyr_pos = player.get_player_coords(_pid)
	if plyr_pos.y > -4 then
		if plyr_pos.x > 1000 then
			if _GF_pos_xy_in_range(plyr_pos,1553,1568,361,452) then
				if _GF_pos_xy_in_range(plyr_pos,1558.603-.05,1558.603+.05,387.263-.05,387.263+.05) or _GF_pos_xy_in_range(plyr_pos,1558.603-.05,1558.603+.05,388.663-.05,388.663+.05) then
					return "Kosataka Guided Missile"
				end
				return "Kosatka"
			elseif int == 275457 or _GF_pos_xy_in_range(plyr_pos,1248,1315,2218,264) then
				return "Penthouse Garage"
			elseif _GF_pos_xy_in_range(plyr_pos,1537,1583,233,263) then
				return "Music Locker"
			elseif int == 275201 or _GF_pos_xy_in_range(plyr_pos,1082,1168,191,286) then
				return "Casino"
			elseif int == 274945 or _GF_pos_xy_in_range(plyr_pos,1333,1413,178,259) then
				return "Casino garage"
			elseif int == 201729 or _GF_pos_xy_in_range(plyr_pos,1172,1189,2635,2644) then
				return "LSC Sandy Shores"
			end
		else
			if _GF_pos_xy_in_range(plyr_pos,-824,-738,295,363) then
				return "Eclipse Towers"
			elseif _GF_pos_xy_in_range(plyr_pos,-1369,-1318.5,134.5,170.5) then
				return "Auto-shop"
			elseif _GF_pos_xy_in_range(plyr_pos,147,233,5155,5218) then
				return "Arena"
			elseif _GF_pos_xy_in_range(plyr_pos,511,517,4816,4906) then
				return "Submarine Mission"
			elseif _GF_pos_xy_in_range(plyr_pos,310,511,4755,4885) then
				if _GF_pos_xy_in_range(plyr_pos,453,511,4759,4844) then -- a sliver of the garage by the chernobog will not be detected due to the placement of the submarine mission
					return "Facility Garage"
				elseif _GF_dist_xy_pospos(plyr_pos,v3(328.5,4828.5,-58)) < 10 then
					return "Facility Orbital"
				elseif _GF_dist_xy_pospos(plyr_pos,v3(349,4870,-60)) < 10 then
					return "Facility Planning"
				end
				return "Facility"
			elseif _GF_pos_xy_in_range(plyr_pos,504,535,4744,4756) then
				return "Avenger"
			elseif int == 179457 or _GF_pos_xy_in_range(plyr_pos,98,115,6613,6631) then
				return "Beeker's Garage"
			elseif _GF_pos_xy_in_range(plyr_pos,932,994,-3,84) then --this is why its -4
				return "Penthouse"
			end
		end
	else
		if plyr_pos.x > 1150 then
			if _GF_pos_xy_in_range(plyr_pos,3500,5950,-6300,-3990) then
				return "Cayo Perico"
			elseif _GF_pos_xy_in_range(plyr_pos,2990,3130,-4830,-4510) then
				return "USS Lexington"
			elseif _GF_pos_xy_in_range(plyr_pos,2673,2744,-403,-348) then
				return "Arcade"
			elseif _GF_pos_xy_in_range(plyr_pos,1155,1175,-3201,-3188) then
				return "Document Forgery"
			end
		elseif plyr_pos.x > 900 then
			if _GF_pos_xy_in_range(plyr_pos,1093,1128,-3170,-3137) then
				return "MC Clubhouse"
			elseif _GF_pos_xy_in_range(plyr_pos,1113,1141,-3200,-3191) then
				return "Counterfeit Cash"
			elseif _GF_pos_xy_in_range(plyr_pos,995,1017,-3179.5,-3142.5) then
				return "MC Clubhouse"
			elseif _GF_pos_xy_in_range(plyr_pos,926.5,1014.5,-3039.5,-2985) then
				return "Vehicle Warehouse"
			elseif _GF_pos_xy_in_range(plyr_pos,995,1019,-3204,-3191) then
				return "Meth Lab"
			elseif _GF_pos_xy_in_range(plyr_pos,1084,1104,-3201,-3185) then
				return "Cocaine Lockup"
			elseif _GF_pos_xy_in_range(plyr_pos,1029,1068,-3210,-3178) then
				return "Weed Farm"
			elseif _GF_pos_xy_in_range(plyr_pos,1097,1109,-3017,-3009) then
				return "MOC"
			end
		elseif plyr_pos.x > 0 then
			if _GF_pos_xy_in_range(plyr_pos,216,242,-1010,-961) then
				return "10-Car Garage"
			elseif _GF_pos_xy_in_range(plyr_pos,822,955,-3253,-3061) then
				return "Bunker"
			elseif _GF_pos_xy_in_range(plyr_pos,74,193,-797,-699) then
				return "FIB Building"
			elseif _GF_pos_xy_in_range(plyr_pos,345,407,-98,-32) then 
				return "Agency"
			elseif int == 153601 or _GF_pos_xy_in_range(plyr_pos,723,738,-1094,-1064) then
				return "LSC City East"
			end
		elseif plyr_pos.x > -1100 then
			if _GF_pos_xy_in_range(plyr_pos,-1047,-987,-795,-708) or _GF_pos_xy_in_range(plyr_pos,-1044,-989,-448,-402) or _GF_pos_xy_in_range(plyr_pos,-610,-568,-727,-704) then
				return "Agency"
			elseif _GF_pos_xy_in_range(plyr_pos,-1084,-1058,-93,-60) then
				return "Agency Garage"
			elseif _GF_pos_xy_in_range(plyr_pos,-118,-29,-868,-773) then
				return "Maze Tower"
			elseif int == 234753 or _GF_pos_xy_in_range(plyr_pos,-355,-319,-147,-121) then
				return "LSC City North"
			end
		else
			if _GF_pos_xy_in_range(plyr_pos,-1308,-1225,-3073,-2956) then
				return "Hangar"
			elseif _GF_pos_xy_in_range(plyr_pos,-1648,-1564,-3022,-2983) then
				return "Nightclub"
			elseif _GF_pos_xy_in_range(plyr_pos,-1526,-1480,-3048,-2960) then
				return "Nightclub Basement"
			elseif _GF_pos_xy_in_range(plyr_pos,-1421,-1328,-511,-440) then
				return "Maze Building"
			elseif int == 164353 or _GF_pos_xy_in_range(plyr_pos,-1170,-1139,-2026,-2007) then
				return "LSC Near Airport"	
			elseif _GF_pos_xy_in_range(plyr_pos,-1426,-1416,-3019,-3006) then
				return "Terrorbyte"
			end
		end
	end
	if int == 285697 then
		return "LS Car Meet"
	elseif int == 196609 then
		return "Benny's"
	end
	return "Interior"
end

-- 145665 del perro hieghts
-- 141313 4 integrity way
-- 143361 richard majestic apartments

_GT_non_intrr = { --many parking garages, tunnels, buildings, etc report as interior to gta. I drove around and recorded all I could find that should be excluded
0 ,
20482,
167681,
770	,
1026	,
2306	,
2818	,
4098	,
4354	,
4610	,
5634	,
6402	,
6658	,
8450	,
8962	,
9218	,
9986	,
10498	,
11010	,
11522	,
11778	,
12290	,
12546	,
13570	,
14082	,
14594	,
14850	,
15362	,
16642	,
17410	,
18434	,
18946	,
20738	,
21506	,
23298	,
23554	,
23810	,
24066	,
24322	,
24834	,
25346	,
25858	,
26114	,
26370	,
26626	,
26882	,
27394	,
27906	,
28930	,
29186	,
29954	,
30210	,
31234	,
32514	,
33538	,
33794	,
34050	,
34562	,
35842	,
36098	,
36610	,
37634	,
38146	,
38402	,
39170	,
40706	,
41218	,
41730	,
42242	,
42498	,
43010	,
43266	,
43778	,
44034	,
44290	,
44546	,
44802	,
45058	,
45314	,
45826	,
46082	,
46594	,
47106	,
47618	,
48386	,
48642	,
48898	,
49666	,
50434	,
51202	,
51458	,
51714	,
51970	,
52738	,
52994	,
53506	,
53762	,
54018	,
54274	,
54530	,
54786	,
55298	,
55810	,
56066	,
56322	,
56578	,
56834	,
57090	,
57346	,
57858	,
58114	,
58370	,
59394	,
59650	,
61698	,
62210	,
63234	,
63746	,
64258	,
65282	,
65794	,
66818	,
67330	,
67842	,
68098	,
68354	,
68610	,
68866	,
69378	,
70658	,
71426	,
71938	,
72194	,
72962	,
73218	,
73730	,
74242	,
74498	,
75266	,
75522	,
76034	,
76546	,
77058	,
77314	,
77570	,
77826	,
78082	,
78594	,
79362	,
79618	,
81410	,
81922	,
82434	,
82946	,
83458	,
83714	,
84226	,
84482	,
84738	,
84994	,
85506	,
86786	,
87042	,
87298	,
88578	,
89858	,
91138	,
91906	,
92162	,
92418	,
92930	,
93698	,
93954	,
94466	,
95746	,
96002	,
96514	,
97794	,
98050	,
98306	,
98562	,
99330	,
99586	,
100098	,
101890	,
102402	,
102658	,
103426	,
103682	,
104962	,
104706	,
105474	,
106754	,
107010	,
107266	,
107522	,
108546	,
109058	,
109314	,
109570	,
109826	,
110594	,
111874	,
112130	,
114434	,
115202	,
116482	,
116738	,
117250	,
118786	,
119554	,
120066	,
120322	,
120578	,
134657	,
135169	,
135937	,
136193	,
136449	,
136705	,
137217	,
137473	,
137729	,
138241	,
138497	,
138753	,
140289	,
140801	,
153857	,
154113	,
154369	,
154625	,
154881	,
155137	,
155393	,
155649	,
156417	,
163329	,
163585	,
164609	,
165633	,
166145	,
167169	,
167425	,
167937	,
168193	,
168449	,
169217	,
169473	,
169729	,
169985	,
170241	,
170753	,
171265	,
175105	,
175361	,
175617	,
175873	,
176129	,
176385	,
176641	,
177153	,
177409	,
177665	,
178689	,
178945	,
179713	,
180481	,
180993	,
181249	,
181505	,
182017	,
182273	,
182529	,
182785	,
183041	,
183297	,
183553	,
183809	,
184065	,
184577	,
184833	,
185089	,
192257	,
192513	,
192769	,
193025	,
196865	,
198401	,
199169	,
199681	,
200705	,
200961	,
201473	,
202497	,
203265	,
204801	,
235265	,
248065,	
250369,
250113,
249857,
249601,
249345,
249089,
248833,
248577,
}

_GT_non_intrr2 = {
[0] = true,
[20482] = true,
[167681] = true,
[770] = true,
[1026] = true,
[2306] = true,
[2818] = true,
[4098] = true,
[4354] = true,
[4610] = true,
[5634] = true,
[6402] = true,
[6658] = true,
[8450] = true,
[8962] = true,
[9218] = true,
[9986] = true,
[10498] = true,
[11010] = true,
[11522] = true,
[11778] = true,
[12290] = true,
[12546] = true,
[13570] = true,
[14082] = true,
[14594] = true,
[14850] = true,
[15362] = true,
[16642] = true,
[17410] = true,
[18434] = true,
[18946] = true,
[20738] = true,
[21506] = true,
[23298] = true,
[23554] = true,
[23810] = true,
[24066] = true,
[24322] = true,
[24834] = true,
[25346] = true,
[25858] = true,
[26114] = true,
[26370] = true,
[26626] = true,
[26882] = true,
[27394] = true,
[27906] = true,
[28930] = true,
[29186] = true,
[29954] = true,
[30210] = true,
[31234] = true,
[32514] = true,
[33538] = true,
[33794] = true,
[34050] = true,
[34562] = true,
[35842] = true,
[36098] = true,
[36610] = true,
[37634] = true,
[38146] = true,
[38402] = true,
[39170] = true,
[40706] = true,
[41218] = true,
[41730] = true,
[42242] = true,
[42498] = true,
[43010] = true,
[43266] = true,
[43778] = true,
[44034] = true,
[44290] = true,
[44546] = true,
[44802] = true,
[45058] = true,
[45314] = true,
[45826] = true,
[46082] = true,
[46594] = true,
[47106] = true,
[47618] = true,
[48386] = true,
[48642] = true,
[48898] = true,
[49666] = true,
[50434] = true,
[51202] = true,
[51458] = true,
[51714] = true,
[51970] = true,
[52738] = true,
[52994] = true,
[53506] = true,
[53762] = true,
[54018] = true,
[54274] = true,
[54530] = true,
[54786] = true,
[55298] = true,
[55810] = true,
[56066] = true,
[56322] = true,
[56578] = true,
[56834] = true,
[57090] = true,
[57346] = true,
[57858] = true,
[58114] = true,
[58370] = true,
[59394] = true,
[59650] = true,
[61698] = true,
[62210] = true,
[63234] = true,
[63746] = true,
[64258] = true,
[65282] = true,
[65794] = true,
[66818] = true,
[67330] = true,
[67842] = true,
[68098] = true,
[68354] = true,
[68610] = true,
[68866] = true,
[69378] = true,
[70658] = true,
[71426] = true,
[71938] = true,
[72194] = true,
[72962] = true,
[73218] = true,
[73730] = true,
[74242] = true,
[74498] = true,
[75266] = true,
[75522] = true,
[76034] = true,
[76546] = true,
[77058] = true,
[77314] = true,
[77570] = true,
[77826] = true,
[78082] = true,
[78594] = true,
[79362] = true,
[79618] = true,
[81410] = true,
[81922] = true,
[82434] = true,
[82946] = true,
[83458] = true,
[83714] = true,
[84226] = true,
[84482] = true,
[84738] = true,
[84994] = true,
[85506] = true,
[86786] = true,
[87042] = true,
[87298] = true,
[88578] = true,
[89858] = true,
[91138] = true,
[91906] = true,
[92162] = true,
[92418] = true,
[92930] = true,
[93698] = true,
[93954] = true,
[94466] = true,
[95746] = true,
[96002] = true,
[96514] = true,
[97794] = true,
[98050] = true,
[98306] = true,
[98562] = true,
[99330] = true,
[99586] = true,
[100098] = true,
[101890] = true,
[102402] = true,
[102658] = true,
[103426] = true,
[103682] = true,
[104706] = true,
[104962] = true,
[105474] = true,
[106754] = true,
[107010] = true,
[107266] = true,
[107522] = true,
[108546] = true,
[109058] = true,
[109314] = true,
[109570] = true,
[109826] = true,
[110594] = true,
[111874] = true,
[112130] = true,
[114434] = true,
[115202] = true,
[116482] = true,
[116738] = true,
[117250] = true,
[118786] = true,
[119554] = true,
[120066] = true,
[120322] = true,
[120578] = true,
[134657] = true,
[135169] = true,
[135937] = true,
[136193] = true,
[136449] = true,
[136705] = true,
[137217] = true,
[137473] = true,
[137729] = true,
[138241] = true,
[138497] = true,
[138753] = true,
[140289] = true,
[140801] = true,
[153857] = true,
[154113] = true,
[154369] = true,
[154625] = true,
[154881] = true,
[155137] = true,
[155393] = true,
[155649] = true,
[156417] = true,
[163329] = true,
[163585] = true,
[164609] = true,
[165633] = true,
[166145] = true,
[167169] = true,
[167425] = true,
[167937] = true,
[168193] = true,
[168449] = true,
[169217] = true,
[169473] = true,
[169729] = true,
[169985] = true,
[170241] = true,
[170753] = true,
[171265] = true,
[175105] = true,
[175361] = true,
[175617] = true,
[175873] = true,
[176129] = true,
[176385] = true,
[176641] = true,
[177153] = true,
[177409] = true,
[177665] = true,
[178689] = true,
[178945] = true,
[179713] = true,
[180481] = true,
[180993] = true,
[181249] = true,
[181505] = true,
[182017] = true,
[182273] = true,
[182529] = true,
[182785] = true,
[183041] = true,
[183297] = true,
[183553] = true,
[183809] = true,
[184065] = true,
[184577] = true,
[184833] = true,
[185089] = true,
[192257] = true,
[192513] = true,
[192769] = true,
[193025] = true,
[196865] = true,
[198401] = true,
[199169] = true,
[199681] = true,
[200705] = true,
[200961] = true,
[201473] = true,
[202497] = true,
[203265] = true,
[204801] = true,
[235265] = true,
[248065] = true,
[250369] = true,
[250113] = true,
[249857] = true,
[249601] = true,
[249345] = true,
[249089] = true,
[248833] = true,
[248577] = true,
}
