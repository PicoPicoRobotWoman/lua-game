local copyist = require("lua.lib.copyist")

local mi = {}

function mi.lines3Exist(matrix, binaryPredicate)
    
    for r = 2, #matrix - 1, 1 do

        for c = 1, #matrix[r], 1 do
            if binaryPredicate(matrix[r - 1][c], matrix[r][c]) and binaryPredicate(matrix[r][c], matrix[r + 1][c]) then return true end
        end

    end

    for r = 1, #matrix, 1 do

        for c = 2, #matrix[r] - 1, 1 do
            if binaryPredicate(matrix[r][c - 1], matrix[r][c]) and binaryPredicate(matrix[r][c], matrix[r][c + 1]) then return true end
        end

    end

    return false
end

function mi.search(matrix, predicate)

    for r = 1, #matrix, 1 do
        
        for c = 1, #matrix[r], 1 do
            if predicate(matrix[r][c]) then return true end
        end
    end

    return false
end

return mi