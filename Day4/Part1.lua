local lines = {}
local guard = {}
local guardID
local maxGuardID = -1
local startedSleeping
local chosenGuard = -1
local chosenMinute = -1

function checkGuardID()
    if guardID > maxGuardID then
        maxGuardID = guardID
    end
end

for line in io.lines("/home/dpain/Documents/advent-of-code-2018/testValues.txt") do
    table.insert(lines, line)
end

table.sort(lines)

for i = 1, #lines do
    local info = lines[i]:sub(lines[i]:find("]") + 2)
    local minute = tonumber(lines[i]:sub(lines[i]:find(":") + 1, lines[i]:find("]") - 1))

    if info == "wakes up" then
        for j = startedSleeping, minute do
            guard[guardID][j + 1] = guard[guardID][j + 1] + 1
        end
        guard[guardID][61] = guard[guardID][61] + (minute - startedSleeping)
    elseif info == "falls asleep" then
        startedSleeping = minute
    else
        guardID = tonumber(info:sub(info:find("#") + 1, info:find(" ", info:find("#"))))
        checkGuardID()
        if guard[guardID] == nil then
            guard[guardID] = {
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
            0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
        end
    end
end

for i = 0, maxGuardID do
    if guard[i] ~= nil then
        if guard[i][61] > chosenGuard then
            chosenGuard = i
        end
    end
end

for i = 1, 60 do
    if guard[chosenGuard][i] > chosenMinute then
        chosenMinute = i
    end
end

print(chosenGuard * (chosenMinute - 1))
