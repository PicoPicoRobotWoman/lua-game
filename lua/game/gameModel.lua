local deepCopy = require("lua.lib.deepCopy")
local matrix = require("lua.lib.matrix") 
local matrixInfo = require("lua.lib.matrixInfo")

local gemMaker = require("lua.game.Gem")

local rows = 10
local collums = 10
local board = {}
local running = false

local actionsBefore = {

    [1] = {
        predicate = function(gem)
            return gem.type == "usual"
        end,

        action = function(board, row, col)
            -- code
        end
    }

}

local actionsAfter = {

    [1] = {
        predicate = function(gem)
            return gemMaker.isEmpty(gem)
        end,
        action = function(board, row, col)
            -- code
        end
    }

}

local gameModel = {}

function gameModel.init()
    
    board = matrix.createMatrix(rows, collums, function() return "" end)   
    matrix.mix(board, gemMaker.createGem) 

end

function gameModel.tick(comand)

        
    if matrixInfo.search(board, gemMaker.isEmpty) then

        matrix.falling(board, gemMaker.isEmpty, gemMaker.createGem)

    elseif matrixInfo.lines3Exist(board) then

        matrix.apply(board, actionsBefore)
        board = matrix.convert3lines(board, gemMaker.convertToEmpty)
        matrix.apply(board, actionsAfter)
            
    else
        running = false
    end

    
end

function gameModel.mix()
    matrix.mix(board, gemMaker.createGem) 
end

function gameModel.move(from, to) 

    matrix.swap(board, from, to)
    if matrixInfo.lines3Exist(board) then 
        running = true
    else 
        matrix.swap(board, from, to)
    end

end

function gameModel.hint()
        


end

function gameModel.dump()
    return deepCopy(board)
end

function gameModel.isRunning()
    return running
end

return gameModel