local M = {}

function M.array_copy(t, s)
	local s = s or {}
	for i = 1, #t do s[i] = t[i] end
	return s
end

function M.array_append(t, val)
	t[#t + 1] = val
end

function M.array_map(t, f)
	local mapped = {}
	for _, v in ipairs(t) do mapped[#mapped + 1] = f(v) end
	return mapped
end

function M.array_contains_where(t, f)
	for _, v in ipairs(t) do
		if f(v) then return true end
	end
end

function M.array_first_where(t, f)
	for _, v in ipairs(t) do
		if f(v) then return v end
	end
end

function M.array_remove(t, val)
	for i, v in ipairs(t) do 
		if v == val then 
			if i ~= #t then
				t[i] = t[#t] -- Copy last to current index
			end
			t[#t] = nil	
		end
	end
end

function M.array_remove_where(t, f)
	for i, v in ipairs(t) do 
		if f(v) then
			if i ~= #t then
				t[i] = t[#t] -- Copy last to current index
			end
			t[#t] = nil	
		end
	end
end

function M.subarray(t, i, j)
	local sub = {}
	for k = i, j do sub[#sub + 1] = t[k] end
	return sub
end

function M.array_filter(t, f)
	local filtered = {}
	for _, v in ipairs(t) do 
		if f(v) then M.array_append(filtered, v) end
	end
	return filtered
end

function M.array_reverse(t)
	local i, j = 1, #t
	while i < j do
		t[i], t[j] = t[j], t[i]
		i = i + 1
		j = j - 1
	end
end

function M.array_print(t)
	print(M.array_description(t))
end

function M.array_description(t)
	for _, v in ipairs(t) do
		if type(v) == "table" then 
			return "Unsupported array element type for printing: table"
		end
	end

	local string = table.concat(t, ", ")
	return "[" .. string .. "]"	
end

function M.set_count(t)
	local c = 0
	for _, _ in pairs(t) do c = c + 1 end
	return c
end

function M.string_trim(str)
	return str:match("^%s*(.-)%s*$")
end

return M