keyToNameList = {
    {vk = 0x30, key = "0"},
    {vk = 0x31, key = "1"},
    {vk = 0x32, key = "2"},
    {vk = 0x33, key = "3"},
    {vk = 0x34, key = "4"},
    {vk = 0x35, key = "5"},
    {vk = 0x36, key = "6"},
    {vk = 0x37, key = "7"},
    {vk = 0x38, key = "8"},
    {vk = 0x39, key = "9"},
    {vk = 0x41, key = "A"},
    {vk = 0x42, key = "B"},
    {vk = 0x43, key = "C"},
    {vk = 0x44, key = "D"},
    {vk = 0x45, key = "E"},
    {vk = 0x46, key = "F"},
    {vk = 0x47, key = "G"},
    {vk = 0x48, key = "H"},
    {vk = 0x49, key = "I"},
    {vk = 0x4A, key = "J"},
    {vk = 0x4B, key = "K"},
    {vk = 0x4C, key = "L"},
    {vk = 0x4D, key = "M"},
    {vk = 0x4E, key = "N"},
    {vk = 0x4F, key = "O"},
    {vk = 0x50, key = "P"},
    {vk = 0x51, key = "Q"},
    {vk = 0x52, key = "R"},
    {vk = 0x53, key = "S"},
    {vk = 0x54, key = "T"},
    {vk = 0x55, key = "U"},
    {vk = 0x56, key = "V"},
    {vk = 0x57, key = "W"},
    {vk = 0x58, key = "X"},
    {vk = 0x59, key = "Y"},
    {vk = 0x5A, key = "Z"},
    {vk = 0x60, key = "0"},
    {vk = 0x61, key = "1"},
    {vk = 0x62, key = "2"},
    {vk = 0x63, key = "3"},
    {vk = 0x64, key = "4"},
    {vk = 0x65, key = "5"},
    {vk = 0x66, key = "6"},
    {vk = 0x67, key = "7"},
    {vk = 0x68, key = "8"},
    {vk = 0x69, key = "9"},
    {vk = 0x20, key = " "},
    {vk = 0xBA, key = ";"},
    {vk = 0xBB, key = "="},
    {vk = 0xBC, key = ","},
    {vk = 0xBD, key = "-"},
    {vk = 0xBE, key = "."},
    {vk = 0xBF, key = "/"},
    {vk = 0xC0, key = "`"},
    {vk = 0xDB, key = "["},
    {vk = 0xDC, key = "\\"},
    {vk = 0xDD, key = "]"},
    {vk = 0xDE, key = "\'"},
    {vk = 0x6A, key = "*"},
    {vk = 0x6B, key = "+"},
    {vk = 0x6D, key = "-"},
    {vk = 0x6E, key = "."},
    {vk = 0x6F, key = "/"},
    {vk = 0x70, key = "F1"},
    {vk = 0x71, key = "F2"},
    {vk = 0x72, key = "F3"},
    {vk = 0x73, key = "F4"},
    {vk = 0x74, key = "F5"},
    {vk = 0x75, key = "F6"},
    {vk = 0x76, key = "F7"},
    {vk = 0x77, key = "F8"},
    {vk = 0x78, key = "F9"},
    {vk = 0x79, key = "F10"},
    {vk = 0x80, key = "F11"},
    {vk = 0x81, key = "F12"},
    {vk = 0x0D, key = "Enter"},
    {vk = 0x26, key = "Up Arrow"},	
    {vk = 0x28, key = "Down Arrow"}	
}

function convertVKToKey(vk)
    for i=1, #keyToNameList do
      local key = keyToNameList[i]
      if key.vk == vk then
        return tostring(key.key)
      end
    end
  end

  menuKeys = {
    open = 0x74,
    up = 0,
    down = 0x28,
    select = 0,
    back = 0,
    sideScrollLeft = 0,
    sideScrollRight = 0
}

function loadControls()
    local ini = require("Rimuru\\libs\\ini_parser")
    local cfg = ini.parse "Rimuru\\controls.ini"

    if cfg then
       menuKeys.open = cfg.Controls.open
       menuKeys.up = cfg.Controls.up
       menuKeys.down = cfg.Controls.down
       menuKeys.select = cfg.Controls.select
       menuKeys.back = cfg.Controls.back
       menuKeys.sideScrollLeft = cfg.Controls.sideScrollLeft
       menuKeys.sideScrollRight = cfg.Controls.sideScrollRight
    else
        menu.notify("Failed to find controls.ini")
    end
end loadControls()