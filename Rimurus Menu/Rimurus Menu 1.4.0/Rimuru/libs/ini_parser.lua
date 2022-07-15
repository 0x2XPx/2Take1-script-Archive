---@diagnostic disable: undefined-global
-- Author: well in that case#0082 (700091773695033505)
-- INI Parser: An object-oriented approach to parsing INI configuration files.
--
-- Licensing:
--      - You're granted the four essential freedoms of free software (https://www.gnu.org/philosophy/free-sw.html#four-freedoms) under these conditions:
--          - You don't claim you've originally made this script.
--          - If you modify this script, you include a link to the original source on GitLab (found below) inside of your repository or source:
--              - https://gitlab.com/wellinthatcase/2take1-scripts-case/-/blob/main/ini_parser.lua
--
-- Previously Recent Change (0.1.5):
--      - Memory optimizations:
--          - Mild for small files, but absolutely massive for medium to larger ones.
--              - There were some serious dead-strings laying around with the accumulator. Using a table instead with table.concat resolved this.
--
--      - Addition of skip_keys parameter to Table.save:
--          - Self-evident, it'll skip saving keys that you specify.
--
--      - Reimplemented automatic file creation when ini.parse(path) path = nil file.
--
-- Most Recent Change (0.1.6) (~ = slightly variable due to hardware, I use an AMD FX6300 @ 4.1Ghz):
--      - Significant optimizations for medium to large files (30kb-1499kb):
--          - Performance optimizations during parsing:
--              - Version 0.1.5 took around ~11.5s to parse 1499kb of randomized INI @ 55,000 lines. Following 0.1.6, it's ~42% faster @ ~7.5s.
--		        - Version 0.1.5 took around ~240ms to parse 30kb of randomized INI @ 1000 lines. Following 0.1.6, it's ~43% faster @ ~140ms.
--              - Furthermore, the average INI size seemed to be ~4kb, which is parsed in ~15ms. A.k.a, rarely even a noticable stutter.
--
--          - Memory optimizations during saving:
--              - Version 0.1.4 reached the highest allocation of ~380kb. Following, 0.1.6, the highest allocation was ~261kb, or 37% less memory.

local ini = {
    version = "0.1.6",
    __debug = false
}

-----------------------
--  Debug Utilities  --
-----------------------
function ini._Case_Ini_Recurse(tab, tab_name)
    for key, val in pairs(tab) do
        if type(val) == "table" then
            ini._Case_Ini_Recurse(val, key)
        else
            tab = tostring(tab)
            print("KEY: "..key.."\nTYPE: "..type(val).."\nVALUE: "..tostring(val).."\nTABLE: "..(tab_name or tab).."\n")
        end
    end
end

-------------------------
-- Beginning of Parser --
-------------------------

-- str:sub previously in parseStringIntoLuaValue created a new string * amount of lines in the file.
-- I learned during profiling that I created upwards of 55,000 dead-strings, along with using tonumber on all of them.
-- So, this table looks less visually appealing, but it's significantly better for medium to large files, should they ever exist.
local luaBoolValues = {
    ["nil"] = "nil",
    [" nil"] = "nil",
    ["nil "] = nil,
    ["true"] = true,
    [" true"] = true,
    ["true "] = true,
    ["false"] = false,
    [" false"] = false,
    ["false "] = false
}

-- A lot of local functions could be removed because they existed only to describe the action.
-- This can't be 'inlined' because it's called several different times in several different locations.
local function serializeKey(str)
    if str:sub(-1) == " " then
        str = str:sub(1, #str - 1)
    end

    return str
end

-- Parse an INI file from `path`.
-- `cwd` is an optional parameter to specify the current working directory. Useful for relative importing.
--
-- This function tries to dicipher if `path` is already absolute by checking if it leads to an existing file.
-- If it does, then path isn't modified. However, if it does not, then cwd is concatenated before path then we check again.
-- If that check proves to be fruitful, then we consider cwd .. path to be the full path. That's effectively a relative import.
--
-- To note though, in some rare circumstances, a file may exist in both the absolute path you've passed, and in the CWD.
-- If this happens, then `path` is left as-is, and the absolute path is preferred over the relative one.
function ini.parse(path, cwd)
    do
        cwd = tostring(cwd or utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\")
        local f1 = utils.file_exists(path)
        local f2 = utils.file_exists(cwd..path)

        if f1 then
            path = path
        elseif f2 and not f1 then
            path = cwd..path
        elseif not (f1 and f2) then
            local status, _ = pcall(function ()
                local f = io.open(path, "a+")
                f:close()
            end)

            if status then
                path = path
            else
                status, _ = pcall(function ()
                    local f = io.open(cwd .. path, "a+")
                    f:close()
                end)

                if not status then
                    print("Err Paths:\n1:"..cwd..path.."\n2:"..path)
                    error "ini.parse path leads to nil file. Check debug console for err paths."
                else
                    path = cwd .. path
                end
            end
        end
    end

    local res = {}
    local currcat = nil

    for str in io.lines(path) do
        local lc = str:sub(-1)
        local fc = str:sub(1, 1)

        if not (fc == ";" or fc == " " or fc == "\\n") then
            if fc == "[" and lc == "]" then
                local name = str:sub(2, -2)

                if currcat ~= name then
                    currcat = serializeKey(name)
                end
            else
                for key, value in str:gmatch "%s*([^=]*)=([^=]*)%f[%s%z]" do
                    local serialized_val = value
                    local serialized_key = serializeKey(key)

                    local nVal = tonumber(serialized_val)
                    local bVal = luaBoolValues[serialized_val]

                    if nVal then
                        serialized_val = nVal
                    elseif bVal ~= nil then
                        if bVal == "nil" then
                            serialized_val = nil
                        else
                            serialized_val = bVal
                        end
                    end

                    if currcat then
                        if not res[currcat] then
                            res[currcat] = {}
                        end

                        res[currcat][serialized_key] = serialized_val
                    else
                        res[serialized_key] = serialized_val
                    end
                end
            end
        end
    end

    res.save = function (_path, skip_keys)
        local cats, resl = {}, {}

        local function legalKey(key)
            if type(skip_keys) == "table" then
                for _, k in next, skip_keys do
                    if tostring(key) == tostring(k) then
                        return false
                    end
                end
            end
            return true
        end

        for key, value in pairs(res) do
            if legalKey(key) and type(value) == "table" then
                table.insert(cats, key)
            end
        end

        for key, value in pairs(res) do
            if legalKey(key) and type(value) ~= "table" and type(value) ~= "function" then
                key = tostring(key)
                value = tostring(value)

                if value:sub(1, 1) == " " then
                    value = value:gsub(2, #value)
                end

                resl[#resl + 1] = key .. "=" .. value
            end
        end

        for _, tab in pairs(cats) do
            resl[#resl + 1] = "[" .. tab .. "]"

            for key, value in pairs(res[tab]) do
                key = tostring(key)
                value = tostring(value)

                if value:sub(1, 1) == " " then
                    value = value:gsub(2, #value)
                end

                resl[#resl + 1] = key .. "=" .. value
            end
        end

        local status, _ = pcall(function ()
            local f = io.open(_path or path, "w+")
            f:write(table.concat(resl, "\n"))
            f:close()
        end)

        return status
    end

    setmetatable(res, {
        __index = function (_, k)
            res[k] = {}

            setmetatable(res[k], {
                __newindex = function (tab, key, val)
                    local mt = getmetatable(tab)
                    local ni = nil

                    if mt then
                        ni = mt.__newindex
                        mt.__newindex = nil
                    end

                    res[k][key] = val

                    if ni then
                        mt.__newindex = ni
                    end
                end
            })

            return res[k]
        end
    })

    return res
end

if ini.__debug == true then
    menu.add_feature("Run _Case_Ini_Recurse Debug Test", "action", 0, function ()
        --------------------------------
        -- Test: Profiling functions: --
        --------------------------------
        do
            local dir = utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\"
            local profiler = require "profiler" -- https://github.com/charlesmallah/lua-profiler | @License MIT (LICENSE.md), Charles Mallah, (c) 2018-2020
            profiler.attachPrintFunction(function (a)
                print(a)
            end, true)
            profiler.configuration({
                outputFile="profiler.lua"
            })
            profiler.start()
            ini.parse "autorun\\example.ini"
            profiler.stop()
            profiler.report(dir.."profiler_result.txt")
            print "INI Parser debug, finished profiling."
        end

        ---------------------------------
        -- Test: Absolute path parsing --
        ---------------------------------
        do
            local p = utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\"
            print "INI Parser debug, absolute path parsing, parsing file."
            local c = ini.parse(p.."example.ini")
            print "INI Parser debug, absolute path parsing, ini._Case_Ini_Recurse call:"
            ini._Case_Ini_Recurse(c)
            print "INI Parser debug, absolute path parsing, ini._Case_Ini_Recurse call finished."
        end

        ---------------------------------
        -- Test: Relative path parsing --
        ---------------------------------
        do
            -- Stage 1: Testing default CWD

            print "INI Parser debug, relative path parsing stage 1, parsing file."
            local c = ini.parse "example.ini"
            print "INI Parser debug, relative path parsing stage 1, ini._Case_Ini_Recurse call:"
            ini._Case_Ini_Recurse(c)
            print "INI Parser debug, relative path parsing stage 1, ini._Case_Ini_Recurse call finished."

            -- Stage 2: Testing different CWDs

            print "INI Parser debug, relative path parsing stage 2, parsing file."
            local w = ini.parse("example.ini", utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\INI Parser Debug\\")
            print "INI Parser debug, relative path parsing stage 2, ini._Case_Ini_Recurse call:"
            ini._Case_Ini_Recurse(w)
            print "INI Parser debug, relative path parsing stage 2, ini._Case_Ini_Recurse call finished."
        end

        -----------------------
        -- Test: File saving --
        -----------------------
        do
            print "INI Parser debug, parsing file to be saved."
            local c = ini.parse "example.ini"
            print "INI Parser debug, parsed file, changing/adding key and saving."
            c.debug.toggle = not c.debug.toggle
            c.save()
            print "INI Parser debug, saved file, re-parsing and calling ini._Case_Ini_Recurse."
            c = ini.parse "example.ini"
            ini._Case_Ini_Recurse(c, "main")
            print "INI Parser debug, finished file saving testing."
        end

        -----------------------------------------------
        -- Test: Automatic file creation, if needed: --
        -----------------------------------------------
        do
            print "INI Parser debug, parsing filse to be created."
            local c = ini.parse "non_existant_rel_file.ini"
            print "INI Parser debug, relative file created. Creating absolute path file."
            local d = ini.parse(utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\non_existant_abs_file.ini")
            d.debug.toggle = not d.debug.toggle
            d.othercat.toggle = not d.othercat.toggle
            d.str = "hello world"
            d.save()
            print "INI Parser debug, absolute file created."
        end

        print "INI Parser debug, finished."
    end)
end

return ini
