local M = {}

function M.read_file(file) 
	local lines = {}

  	for line in io.lines(file) do 
    	lines[#lines + 1] = line
  	end

  	return lines
end

return M