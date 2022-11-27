local mi = require("lua.lib.matrixInfo")
local copyist = require("lua.lib.copyist")

local mtrx = {}


function mtrx.createMatrix(rows, collums, generator)

    local matrix = {}
    for r = 1, rows, 1 do

        matrix[r] = {}
        for c = 1, collums, 1 do
            matrix[r][c] = generator()
        end

    end

    return matrix
end

function mtrx.mix(matrix, generator)

    repeat

        for r = 1, #matrix, 1 do

            for c = 1, #matrix[r] do
                matrix[r][c] = generator()
            end
    
        end

    until not mi.lines3Exist(matrix)

end

function mtrx.swap(matrix, r1, c1, r2, c2)
    matrix[r1][c1], matrix[r2][c2] = matrix[r2][c2], matrix[r1][c1]
end

function mtrx.convert3lines(matrix, convert) 
    
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

function mtrx.convert(matrix, converters)
    
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

function mtrx.falling(matrix, predicate, generator)    

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

return mtrx