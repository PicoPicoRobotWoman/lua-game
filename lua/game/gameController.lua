local gm = require("lua.game.gameModel")
local gi = require("lua.game.gameInput")
local gr = require("lua.game.gameRender")

local gc = {}

function gc.start()
    
    gm.init()
    area = gm.dump()
    gr.render(area)


    while gm.getStatus() ~= "end" do

        if gm.getStatus() == "wait" then
            local comand = gi.input()
            gm.tick(comand)
        else 
            gm.tick()
        end

        area = gm.dump()
        gr.render(area)
                
    end
    gr.endGame()

end

return gc