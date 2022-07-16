local text_func = {}

function text_func.split_string(string, splitter, mode)
    local parts = {}
    if mode == 2 then
        for match in string:gmatch("[^" .. splitter .. "]+")do
            table.insert(parts, match)
        end
    else
        for match in (string .. splitter):gmatch("(.-)" .. splitter) do
            table.insert(parts, match)
        end
    end
    return parts
end

function text_func.rgba_to_uint32_t(red, green, blue, alpha)
	alpha = alpha or 255
	return ((red & 0x0ff) << 0x00) | ((green & 0x0ff) << 0x08) | ((blue & 0x0ff) << 0x10) | ((alpha & 0x0ff) <<0x18)
end

function text_func.write(file, text)
    if file and text then
        io.output(file)
        io.write(text)
        io.close(file)
    end
end

function text_func.string_starts_with(string, start)
    if string.find(string, start) then
        local split_parts = text_func.split_string(string, start)
        if split_parts[1] == "" then
            return true
        else
            return false
        end
    else
        return false
    end
end

function text_func.string_cut(string, starts, ends)
    if string.find(string, starts) and string.find(string, ends) then
        local parts = text_func.split_string(string, starts)
        parts = text_func.split_string(parts[2], ends)
        return parts[1]
    else
        return string
    end
end

function text_func.string_ends_with(string, ends)
    if string.find(string, ends) then
        local split_parts = text_func.split_string(string, ends)
        if split_parts[#split_parts] == "" then
            return true
        else
            return false
        end
    else
        return false
    end
end

function text_func.string_replace(string, subject, replacement)
    if string.find(string, subject) then
        local split_parts = text_func.split_string(string, subject)
        local string_parts = {}
        local final_string = ""
        for i = 1, #split_parts do
            if split_parts[i] ~= split_parts[#split_parts] then
                string_parts[i] = "" .. split_parts[i] .. "" .. replacement .. ""
            else
                string_parts[i] = "" .. split_parts[i] .. ""
            end
        end
        for i = 1, #string_parts do
            final_string = final_string .. string_parts[i]
        end
        return final_string
    else
        return string
    end
end

function text_func.string_remove(string, subject)
    if string.find(string, subject) then
        local split_parts = text_func.split_string(string, subject)
        local final_string = ""
        for i = 1, #split_parts do
            final_string = final_string .. split_parts[i]
        end
        return final_string
    else
        return string
    end
end

function text_func.round(num)
	local floor = math.floor(num)
	if floor >= num - 0.4999999999 then
		return floor
	else
		return math.ceil(num)
	end
end

function text_func.round_one_dc(value)
	local value = value * 10
	local value = math.floor(value)
	local value = value / 10
	return value
end

function text_func.round_two_dc(value)
	local value = value * 100
	local value = math.floor(value)
	local value = value / 100
	return value
end

function text_func.round_three_dc(value)
	local value = value * 1000
	local value = math.floor(value)
	local value = value / 1000
	return value
end

function text_func.to_int(n)
    local s = tostring(n)
    local i, j = s:find("%.")
    if i then
        return tonumber(s:sub(1, i - 1))
    else
        return n
    end
end

return text_func