local two = 0
local three = 0
local foundTwo = false
local foundThree = false

function countOccurrences(code)
    for i = 1, #code do
        local letter = string.sub(code, i, i)
        local letterCount = countSubstring(code, letter)

        if letterCount == 2 and foundTwo == false then
            two = two + 1
            foundTwo = true
        elseif letterCount == 3 and foundThree == false then
            three = three + 1
            foundThree = true
        end
    end

    foundTwo = false
    foundThree = false
end

function countSubstring(s1, s2)
    return select(2, s1:gsub(s2, ""))
end

local lines = {}
-- read the lines in table 'lines'
for line in io.lines("/home/dpain/Documents/advent-of-code-2018/testValues.txt") do
  table.insert(lines, line)
end

for i = 1, #lines do
  countOccurrences(lines[i])
end

print(two * three)
