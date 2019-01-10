package.path = "?.lua;../?.lua"
local input = require "input"

function parse(str)
	local x, y = str:match("(%d+), (%d+)")
	return tonumber(x), tonumber(y)
end

function solve(input)

	local t0 = os.clock()

	-- Find the smallest rectangular area that contains all given coordinates
	local min_x = 10000
	local max_x = 0
	local min_y = 10000
	local max_y = 0
	local coords = {}
	for i = 1, #input do
		local x, y = parse(input[i])
		coords[#coords + 1] = { x = x, y = y }
		min_x = math.min(min_x, x)
		max_x = math.max(max_x, x)
		min_y = math.min(min_y, y)
		max_y = math.max(max_y, y)
	end

	-- Note: this implementation assumes that no location outside of the 
	-- bounding box of the coordinates is part of the solution

	local abs = math.abs -- Faster with a local
	local distances = {}
	for y = min_y, max_y do
		for x = min_x, max_x do
			local d = 0
			for k = 1, #coords do
				local c = coords[k]
				local distance = abs(c.x - x) + abs(c.y - y)
				d = d + distance
			end

			distances[#distances + 1] = d
		end
	end

	table.sort(distances)
	local area = 0
	for _, i in ipairs(distances) do
		if i >= 10000 then break end
		area = area + 1
	end

	local time = os.clock() - t0
	print(string.format("Elapsed time: %.4f", time))

	return area
end

local input = input.read_file("input.txt")
print("Solution: " .. (solve(input) or "not found"))