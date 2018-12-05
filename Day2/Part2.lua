local lines = {}
local result

function checkIfDiffers(str1, str2)
    for i = 1, #str1 do
        if string.sub(str1, i, i) ~= string.sub(str2, i, i) then
            return string.sub(str1, i + 1) == string.sub(str2, i + 1)
        end
    end
    return false
end

for line in io.lines("/home/dpain/Documents/advent-of-code-2018/testValues.txt") do
  table.insert(lines, line)
end

for i = 1, #lines do
    for j = i + 1, #lines do
        result = checkIfDiffers(lines[i], lines[j])
        if result then
            print(lines[i], "\n", lines[j])
        end
    end
end