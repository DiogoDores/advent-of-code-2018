package.path = "?.lua;../?.lua"
local input = require "input"

function eliminate(polymer, del)
	local buf = {}
	for i = 1, #polymer do
		local unit = polymer:byte(i)
		if unit ~= del and unit ~= del + 32 then
			buf[#buf + 1] = string.char(unit)
		end
	end

	return table.concat(buf, "")
end

function collapse(polymer)
	local buf = {}
	for i = 1, #polymer do
		local unit = polymer:byte(i)
		local tail = buf[#buf]
		if tail and (tail == unit + 32 or tail == unit - 32) then
			-- Destroy the opposite units
			buf[#buf] = nil
		else
			-- Append the new unit
			buf[#buf + 1] = unit
		end
	end

	return buf
end

function solve(input)
	
	local polymer = input[1]
	local t0 = os.clock()
	
	-- 65-90, 97-122

	local min = nil
	for i = 65, 90 do
		local poly = eliminate(polymer, i)
		local buf = collapse(poly)
		if not min then 
			min = #buf
		else 
			min = math.min(min, #buf)
		end
	end

	local time = os.clock() - t0
	print(string.format("Elapsed time: %.4f", time))

	return min
end

local input = input.read_file("input.txt")
print("Solution: " .. (solve(input) or "not found"))