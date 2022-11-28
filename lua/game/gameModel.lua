local copyist = require("lua.lib.copyist")
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
            -- ignore
        end
    }

}

local actionsAfter = {

    [1] = {
        predicate = function(gem)
            return gemMaker.isEmpty(gem)
        end,
        action = function(board, row, col)
            -- ignore
        end
    }

}

local gameModel = {}

function gameModel.init()
    
    board = matrix.createMatrix(rows, collums, function() return "" end)   
    matrix.mix(board, gemMaker.createGem, function(gem1, gem2) return gem1.color == gem2.color end) 

end

function gameModel.tick(comand)

        
    if matrixInfo.search(board, gemMaker.isEmpty) then

        matrix.falling(board, gemMaker.isEmpty, gemMaker.createGem)

    elseif matrixInfo.lines3Exist(board, function(gem1, gem2) return gem1.color == gem2.color end) then

        matrix.convert(board, actionsBefore)
        board = matrix.convert3lines(board, gemMaker.convertToEmpty, function(gem1, gem2) return gem1.color == gem2.color end)
        matrix.convert(board, actionsAfter)
            
    else
        running = false
    end

    
end

function gameModel.mix()
    matrix.mix(board, gemMaker.createGem, function(gem1, gem2) return gem1.color == gem2.color end) 
end

function gameModel.move(from, to) 

    matrix.swap(board, from, to)
    if matrixInfo.lines3Exist(board, function(gem1, gem2) return gem1.color == gem2.color end) then 
        running = true
    else 
        matrix.swap(board, from, to)
    end

end

function gameModel.dump()
    return copyist.deepCopy(board)
end

function gameModel.isRunning()
    return running
end

return gameModel