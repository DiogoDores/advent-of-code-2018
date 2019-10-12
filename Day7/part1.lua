local io = require "io"
local file = io.open ("input.txt", "r")

first = {}
second = {}
sequence = {}
to_do = {}
firstChars = {}
inSequence = false
running = true

function removeDupes(info)

    local temp = {}
    local hash = {}

    for _,v in ipairs(info) do
        if (not hash[v]) then
            temp[#temp+1] = v
            hash[v] = true
        end
    end

    return temp

end

function getFirstChars()

    local foundEqual = false

    for i = 1, #first, 1 do
        for j = 1, #first, 1 do
            if first[i] == second[j] then
                foundEqual = true
            end
        end

        if foundEqual == false then
            table.insert(firstChars, first[i])
        else
            foundEqual = false
        end
    end

    firstChars = removeDupes(firstChars)
    table.sort(firstChars)

    table.insert(sequence, firstChars[1])
    
    for i = 2, #firstChars, 1 do
        table.insert(to_do, firstChars[i])
    end

end

for line in file:lines() do
    table.insert(first, string.sub(line, 6, 6))
    table.insert(second, string.sub(line, 37, 37))
end

getFirstChars()

while running do

    for i = 1, #second, 1 do

        local test = {}

        for j = 1, #first, 1 do
            for k = 1, #sequence, 1 do
                if first[j] == sequence[k] and second[j] == second[i] then
                    table.insert(test, second[i])
                end
            end
        end
        
        local sumOccur = 0
        for z = 0, #second, 1 do 
            if test[1] == second[z] then
                sumOccur = sumOccur + 1
            end
        end

        if #test == sumOccur then
            table.insert(to_do, test[1])
        end
        sumOccur = 0

    end

    to_do = removeDupes(to_do)
    table.sort(to_do)

    for i = 0, #to_do, 1 do
        for j = 0, #sequence, 1 do
            if to_do[i] == sequence[j] then
                inSequence = true
            end
        end

        if not inSequence then
            table.insert(sequence, to_do[i])
            inSequence = false
            break
        end
        inSequence = false
    end

    if #removeDupes(second) == #sequence - #firstChars then
        running = false
    end
    
end

print(table.concat(sequence))