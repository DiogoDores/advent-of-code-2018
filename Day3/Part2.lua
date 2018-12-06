local lines = {}
local map = {}
local squareInches = 0
local x1, y1, width, height
local notOver = false
local newX
local coords = {}

function fillMap(x, y, width, height)
    local notOverlaping = true
    local returnValue = true

    for i = 0, height-1 do
        for j = 0, width-1 do
            if map[y][x] ~= 0 then
                notOverlaping = false
            end
            map[y][x] = map[y][x] + 1
            x = x + 1
        end
        y = y + 1
        x = x1
    end


    return notOverlaping
end

function checkIfOverlaps(x, y, newW, newH)
    local notOverlaping = true

    for i = 0, newH-1 do
        for j = 0, newW-1 do
            if map[y][x] ~= 1 then
                notOverlaping = false
            end
            x = x + 1
        end
        y = y + 1
        x = newX
    end

    return notOverlaping
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
    local id = lines[i]:sub(lines[i]:find("#") + 1, lines[i]:find("@") - 2)
    local coord1 = lines[i]:sub(lines[i]:find("@") + 2, lines[i]:find(":") - 1)
    x1 = tonumber(coord1:sub(0, coord1:find(",") - 1)) + 1
    y1 = tonumber(coord1:sub(coord1:find(",") + 1, #coord1)) + 1

    local initSize1 = lines[i]:sub(lines[i]:find(":") + 2, #lines[i])
    local width = tonumber(initSize1:sub(0, initSize1:find("x") - 1))
    local height = tonumber(initSize1:sub(initSize1:find("x") + 1, #initSize1))

    notOver = fillMap(x1, y1, width, height)

    if notOver then
        coords[#coords+1] = {x1, y1, width, height, id}
        --print(coords[#coords][5])
    end
end

for i = 1, #coords do
    newX = coords[i][1]
    local newY = coords[i][2]
    local newW = coords[i][3]
    local newH = coords[i][4]

    local result = checkIfOverlaps(newX, newY, newW, newH)

    if result then
        print(coords[i][5])
    end
end