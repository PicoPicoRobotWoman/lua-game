local mi = require("lua.lib.matrixInfo")
local copyist = require("lua.lib.copyist")

local mc = {}


function mc.getEmptyMatrix(rows, collums, getEmpty)

    matrix = {}
    for r = 1, rows, 1 do

        matrix[r] = {}
        for c = 1, collums, 1 do
            matrix[r][c] = getEmpty()
        end

    end

    return matrix
end

function mc.mix(matrix, getElement)

    repeat

        for r = 1, #matrix, 1 do

            for c = 1, #matrix[r] do
                matrix[r][c] = getElement()
            end
    
        end

    until not mi.lines3Exist(matrix)
    


end

function mc.swap(matrix, r1, c1, r2, c2)
    matrix[r1][c1], matrix[r2][c2] = matrix[r2][c2], matrix[r1][c1]
end

function mc.convert3lines(matrix, convert) 
    
    local virtualmatrix = copyist.deepCopy(matrix)

    for r = 2, #matrix - 1, 1 do

        for c = 1, #matrix[r], 1 do
            if matrix[r - 1][c] == matrix[r][c] and matrix[r][c] == matrix[r + 1][c] then 

                virtualmatrix[r - 1][c] = convert(matrix[r - 1][c])
                virtualmatrix[r][c] = convert(matrix[r][c])
                virtualmatrix[r + 1][c] = convert(matrix[r + 1][c])

            end
        end

    end

    for r = 1, #matrix, 1 do

        for c = 2, #matrix[r] - 1, 1 do
            if matrix[r][c - 1] == matrix[r][c] and matrix[r][c] == matrix[r][c + 1] then

                virtualmatrix[r][c - 1] = convert(matrix[r][c - 1])
                virtualmatrix[r][c] = convert(matrix[r][c])
                virtualmatrix[r][c + 1] = convert(matrix[r][c + 1])

            end
        end

    end

    return virtualmatrix

end

function mc.convert(matrix, converters)
    
    for i = 1, #converters, 1 do 

        for  r = 1, #matrix, 1 do
            for c = 1, #matrix[r], 1 do    
                
                if converters[i].predicate(matrix[r][c]) then
                    converters[i].action(matrix, r, c) 
                end
                
            end
        end
    end

end


return mc