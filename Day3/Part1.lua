local lines = {}
local map = {}
local squareInches = 0
local x1, y1, width, height

function fillMap(x, y, width, height)
    for i = 0, height-1 do
        for j = 0, width-1 do
            map[y][x] = map[y][x] + 1
            x = x + 1
        end
        y = y + 1
        x = x1
    end
end

for line in io.lines("/home/dpain/Documents/advent-of-code-2018/testValues.txt") do
    table.insert(lines, line)
end

for i = 0, 1200 do
    map[i] = {}
    for j = 0, 1200 do
        map[i][j] = 0
    end
end
  
for i = 1, #lines do
    local coord1 = lines[i]:sub(lines[i]:find("@") + 2, lines[i]:find(":") - 1)
    x1 = tonumber(coord1:sub(0, coord1:find(",") - 1)) + 1
    y1 = tonumber(coord1:sub(coord1:find(",") + 1, #coord1)) + 1

    local initSize1 = lines[i]:sub(lines[i]:find(":") + 2, #lines[i])
    local width = tonumber(initSize1:sub(0, initSize1:find("x") - 1))
    local height = tonumber(initSize1:sub(initSize1:find("x") + 1, #initSize1))

    fillMap(x1, y1, width, height)
end

for i = 0, 1200 do
    for j = 0, 1200 do
        if map[i][j] > 1 then
            squareInches = squareInches + 1
        end
    end
end

print(squareInches)