local gameModel = require("lua.game.gameModel")
local gameInit = require("lua.game.gameInput")
local gameRender = require("lua.game.gameRender")

local gameController = {}

function gameController.start()
    
    gameModel.init()
    local area = gameModel.dump()
    gameRender.render(area)

    while gameModel.getStatus() ~= "end" do

        if gameModel.getStatus() == "wait" then

            local comand = gameInit.input()
            gameModel.tick(comand)

        else 

            gameModel.tick()

        end

        area = gameModel.dump()
        gameRender.render(area)
                
    end
    gameRender.endGame()

end

return gameController