package.path = "?.lua;../?.lua"
local input = require "input"

function solve(input)
	
	local polymer = input[1]
	local t0 = os.clock()
	
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

	local time = os.clock() - t0
	print(string.format("Elapsed time: %.4f", time))

	return #buf
end

local input = input.read_file("input.txt")
print("Solution: " .. (solve(input) or "not found"))