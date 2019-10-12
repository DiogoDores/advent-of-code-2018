local io = require "io"
local file = io.open ("input.txt", "r")

first = {}
second = {}
sequence = {}
to_do = {}
workers = {".", ".", ".", ".", "."}
times = {0, 0, 0, 0, 0}
totalTime = 0
firstChars = {}
inSequence = false
running = true
worker1 = {}
worker2 = {}
worker3 = {}
worker4 = {}
worker5 = {}

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
    
    for i = 1, #firstChars, 1 do
        table.insert(to_do, firstChars[i])
    end

end

for line in file:lines() do
    table.insert(first, string.sub(line, 6, 6))
    table.insert(second, string.sub(line, 37, 37))
end

getFirstChars()

--workers[1] = sequence[1]
--times[1] = string.byte(sequence[1]) - 64

local timeout = 200
local alreadyDoing = false

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

    for k = 1, #workers, 1 do
        if workers[k] ~= "." then
            if times[k] == 0 then
                table.insert(sequence, workers[k])
                workers[k] = "."
            else 
                times[k] = times[k] - 1
            end
        end
    end

    for i = 0, #to_do, 1 do
        for j = 0, #sequence, 1 do
            if to_do[i] == sequence[j] then
                inSequence = true
            end
        end

        if not inSequence then
            for k = 1, #workers, 1 do
                if workers[k] == "." then
                    for x = 1, #workers, 1 do
                        if to_do[i] == workers[x] then
                            alreadyDoing = true
                        end
                    end

                    if not alreadyDoing then
                        times[k] = string.byte(to_do[i]) - 64
                        workers[k] = to_do[i]

                        break
                    end


                    if k == 1 then
                        table.insert(worker1, to_do[i])
                    elseif k == 2 then
                        table.insert(worker2, to_do[i])
                    elseif k == 3 then
                        table.insert(worker3, to_do[i])
                    elseif k == 4 then
                        table.insert(worker4, to_do[i])
                    elseif k == 5 then
                        table.insert(worker5, to_do[i])
                    end

                    alreadyDoing = false
                end
                
            end
        end
        inSequence = false
    end

    print(table.concat(workers))


    timeout = timeout - 1

    for i = 1, #workers, 1 do
       -- if workers[i] ~= "." then
           -- running = true
           -- break
        --end
        --running = false
    end
end

sequence = removeDupes(sequence)
print(table.concat(sequence))

local sumTimes = 0
for i = 1, #worker1, 1 do
    sumTimes = sumTimes + 60 + (string.byte(worker1[i]) - 64)
end

print(sumTimes)