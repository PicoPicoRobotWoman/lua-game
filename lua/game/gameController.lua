local gameModel = require("lua.game.gameModel")
local gameInit = require("lua.game.gameInput")
local gameRender = require("lua.game.gameRender")

local gameController = {}
local running = true

function gameController.start()
    
    gameModel.init()
    local board = gameModel.dump()
    gameRender.render(board)

    while running do

        if not gameModel.isRunning() then

            local answer = gameInit.input()

            if answer.comand == "mix" then gameModel.mix() end
            if answer.comand == "q" then running = false end
            if answer.comand == "move" then gameModel.move(answer.from, answer.to) end
            
        end
        
        gameModel.tick()
        
        board = gameModel.dump()
        gameRender.render(board)        
        
    end
    gameRender.endGame()

end

return gameController