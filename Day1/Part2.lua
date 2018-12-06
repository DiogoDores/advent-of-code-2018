local count = 0
local seen = {}
local values = {}
local result = 0
local run = true

while true do
    local line = tonumber(io.read())
    if line == nil then break end
    table.insert(values, line)
end

while run do
    for i=1,#values do
      if seen[count] then
        print(count)
        return
      else
        seen[count] = true
      end
      count = count + values[i]
    end
end

--io.write(result, "\n")
