-- Made by GhostOne
-- L00naMods "Even if you say L00na is a bitch just put my name in there somewhere"
-- Ghost's Lua Table Writer
--[[
nil			gltw.write(table table, string name, string path|nil (in same path as lua), table index exclusions) -- example gltw.write({name = "l00na", iq = -1}, "something", "folder1\\", {"name"})
table[]		gltw.read(string name, string path|nil(in same path as lua))
]]

gltw = {}

function gltw.write_table(file, tableTW, indentation, exclusions, exclude_empty)
	indentation = indentation or "	"
	--local concatTable = {}
	for k, v in pairs(tableTW) do
		if not exclusions[k] then
			local index = "[\""..k.."\"] = "
			if type(k) == "number" then
				index = "["..k.."] = "
			end
			if type(v) ~= "table" and type(v) ~= "function" and type(v) ~= "string" then
				file:write(indentation..index..tostring(v)..",\n")
				--concatTable[#concatTable + 1] = indentation..index..tostring(v)..",\n"
			elseif type(v) == "string" then
				file:write(indentation..index.."[["..v.."]],\n")
				--concatTable[#concatTable + 1] = indentation..index.."[["..v.."]],\n"
			end
		end
		--file:write(table.concat(concatTable, ""))
	end

	for k, v in pairs(tableTW) do
		if not exclusions[k] then
			if type(v) == "table" and (next(v) or not exclude_empty) then
				local index = "[\""..k.."\"] = "
				if type(k) == "number" then
					index = "["..k.."] = "
				end
				file:write(indentation..index.."{\n")
				gltw.write_table(file, v, indentation.."	", exclusions, exclude_empty)
				file:write(indentation.."},\n")
			end
		end
	end
end

function gltw.write(tableTW, name, path, exclusions, exclude_empty)
	local convertedExclusions = {}
	if exclusions then
		for k, v in pairs(exclusions) do
			convertedExclusions[v] = true
		end
	end

	name = name or "include a name next time"
	assert(tableTW, "no table was provided to write for file '"..name.."'")
	path = path or ""
	assert(type(name) == "string" and type(path) == "string", "name or path isn't a string")

	local file = io.open(path..name..".lua", "w+")
	assert(file, "'"..name.."' was not created.")

	file:write("return {\n")
	gltw.write_table(file, tableTW, nil, convertedExclusions, exclude_empty)
	file:write("}")

	file:flush()
	file:close()
end

function gltw.add_to_table(getTable, addToTable)
	assert(type(getTable) == "table" and type(addToTable) == "table", "args have to be tables")
	for k, v in pairs(getTable) do
		if type(v) ~= "table" then
			addToTable[k] = getTable[k]
		else
			if type(addToTable[k]) == "table" then
				gltw.add_to_table(getTable[k], addToTable[k])
			end
		end
	end
end

function gltw.read(name, path, addToTable, overrideError)
	--assert(utils.file_exists(path..name..".lua") or overrideError, "file does not exist.")
	if overrideError and not utils.file_exists(path..name..".lua") then
		return
	end
	
	path = path or ""
	if type(tableRT) == "string" then
		name, path = tableRT, name or path
		tableRT = nil
	end

	if addToTable then
		local readTable = dofile(path..name..".lua")
		assert(readTable, "file not found")
		gltw.add_to_table(readTable, addToTable)
	else
		return dofile(path..name..".lua")
	end
end