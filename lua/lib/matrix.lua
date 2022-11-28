local matrixInfo = require("lua.lib.matrixInfo")
local copyist = require("lua.lib.copyist")

local matrix = {}

function matrix.createMatrix(rows, collums, generator)

    local matrix = {}
    for r = 1, rows, 1 do

        matrix[r] = {}
        for c = 1, collums, 1 do
            matrix[r][c] = generator()
        end

    end

    return matrix
end

function matrix.mix(matrix, generator, binaryPredicate)

    repeat

        for r = 1, #matrix, 1 do

            for c = 1, #matrix[r] do
                matrix[r][c] = generator()
            end
    
        end

    until not matrixInfo.lines3Exist(matrix, binaryPredicate)

end

function matrix.swap(matrix, from, to)
    matrix[from.row][from.col], matrix[to.row][to.col] = matrix[to.row][to.col], matrix[from.row][from.col]
end

function matrix.convert3lines(matrix, convert, binaryPredicate) 
    
    local virtualmatrix = copyist.deepCopy(matrix)

    for r = 2, #matrix - 1, 1 do

        for c = 1, #matrix[r], 1 do
            if binaryPredicate(matrix[r - 1][c], matrix[r][c]) and binaryPredicate(matrix[r][c], matrix[r + 1][c]) then 

                convert(virtualmatrix[r - 1][c])
                convert(virtualmatrix[r][c])
                convert(virtualmatrix[r + 1][c])

            end
        end

    end

    for r = 1, #matrix, 1 do

        for c = 2, #matrix[r] - 1, 1 do
            if binaryPredicate(matrix[r][c - 1], matrix[r][c]) and binaryPredicate(matrix[r][c], matrix[r][c + 1]) then

                convert(virtualmatrix[r][c - 1])
                convert(virtualmatrix[r][c])
                convert(virtualmatrix[r][c + 1])

            end
        end

    end

    return virtualmatrix

end

function matrix.convert(matrix, converters)
    
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

function matrix.falling(matrix, predicate, generator)    

    for c = #matrix[1], 1, -1 do
        
        for r = 2, #matrix, 1 do
            
            if predicate(matrix[r][c]) then

                matrix[r][c] , matrix[r - 1][c] = matrix[r - 1][c] , matrix[r][c]        

            end

        end

        if predicate(matrix[1][c]) then 
            matrix[1][c] = generator()
        end
        
    end

end

return matrix