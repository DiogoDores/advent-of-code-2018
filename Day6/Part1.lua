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

	local abs = math.abs -- Faster with a local
	local counts = {}
	local infinite_indexes = {}
	for y = min_y, max_y do
		for x = min_x, max_x do
			local best_distance = 1000
			local closest_indexes = {}
			
			for k = 1, #coords do
				local c = coords[k]
				local distance = abs(c.x - x) + abs(c.y - y)
				if distance == best_distance then
					closest_indexes[#closest_indexes + 1] = k
				elseif distance < best_distance then
					best_distance = distance
					closest_indexes = { k }
				end
			end

			if #closest_indexes == 1 then
				local closest_index = closest_indexes[1]
				if x == min_x or x == max_x or y == min_y or y == max_y then
					-- Mark the index of this area as infinite
					infinite_indexes[closest_index] = 1
				else
					-- There is one more location closest to this coordinate
					counts[closest_index] = (counts[closest_index] or 0) + 1
				end
			end
		end
	end

	-- Clear all indexes of infinite areas from the array of areas
	for i, _ in pairs(infinite_indexes) do counts[i] = 0 end

	-- Find the area with the largest area
	local largest_area = 0
	for _, v in ipairs(counts) do
		if v > largest_area then largest_area = v end
	end

	local time = os.clock() - t0
	print(string.format("Elapsed time: %.4f", time))

	return largest_area
end

local input = input.read_file("input.txt")
print("Solution: " .. (solve(input) or "not found"))