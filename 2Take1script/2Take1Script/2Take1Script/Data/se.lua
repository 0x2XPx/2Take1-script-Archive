local script_events = {}

script_events[1] = {
	"CEO", {
		{"Ban", -738295409, {0, 1, 5, 0}},
		{"Dismiss", -1648921703, {0, 1, 5}},
		{"Terminate", -1648921703, {1, 1, 6}}
	}
}

script_events[2] = {
	"Passive", {
		{"Block", -909357184, {1, 1}},
		{"UN-Block", -909357184, {1, 0}}
	}
}

script_events[3] = {
	"Script-Host Curse", {
		{"Normal", -1975590661, {84857178, 61749268, -80053711, -78045655, 56341553, -78686524, -46044922, -22412109, 29388428, -56335450}},
		{"Fast", -922075519, {-17645264, -26800537, -66094971, -45281983, -24450684, -13000488, 59643555, 34295654, 91870118, -3283691}},
	}
}

script_events[4] = {
	"Send to Island", {
		{"Party Beach", 0x4d8b1e65, {1300962917}},
		{"Back to Los Santos", -171207973, {0, 0, 1, 0, 1, 1, 1, 1}}
	}
}

script_events[5] = {
	"Send to Mission", {
		{"Severe Weather", -545396442, {0}},
		{"Half Track", -545396442, {0, 1}},
		{"Night Shark AAT", -545396442, {0, 2}},
		{"APC Mission", -545396442, {0, 3}},
		{"MOC Mission", -545396442, {0, 4}},
		{"Tampa Mission", -545396442, {0, 5}},
		{"Opressor Mission 1", -545396442, {0, 6}},
		{"Opressor Mission 2", -545396442, {0, 7}}
	}
}

return script_events