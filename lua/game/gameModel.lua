local copyist = require("lua.lib.copyist")
local mtrx = require("lua.lib.matrix") 
local mi = require("lua.lib.matrixInfo")
local sc = require("lua.lib.syntaxCorrect")
local gf = require("lua.game.Gem")
local sleep = require("lua.lib.sleep")

local rows = 10
local collums = 10
local timeout = 0.5
local area = {}
local status = "wait"

local actionsBefore = {

    [1] = {
        predicate = function(gem)
            return gem.type == "usual"
        end,

        action = function(area, row, col)
            -- ignore
        end
    }

}

local actionsAfter = {

    [1] = {
        predicate = function(gem)
            return gem.type == "empty"
        end,
        action = function(area, row, col)
            -- ignore
        end
    }

}

local gm = {}

function gm.init()
    
    area = mtrx.createMatrix(rows, collums, gf.getEmptyGem)    
    mtrx.mix(area, gf.createGem)
  
end

function gm.tick(comand)

    if status == "wait" then

        if comand == "mix" then mtrx.mix(area, gf.createGem) end
        if comand == "q" then status = "end" end

        if sc.moveisCorrect(comand) then 

            gm.move(comand)
            print(mi.lines3Exist(area))
            if mi.lines3Exist(area) then

                status = "running"
                
            else

                gm.move(comand)

            end            

        end

    end

    if status == "running" then 
        
        if mi.search(area, gf.isEmpty) then

            mtrx.falling(area, gf.isEmpty, gf.createGem)

        elseif mi.lines3Exist(area) then

            mtrx.convert(area, actionsBefore)
            area = mtrx.convert3lines(area, gf.convertToEmpty)
            mtrx.convert(area, actionsAfter)
            
        else
            status = "wait"
        end
        
        --[[ if not (mi.search(area, gf.isEmpty) and mi.lines3Exist(area)) then

            status = "wait"

        end ]]--

        sleep(timeout)

    end

end

function gm.move(comand) 

    allowedValues = {[1] = true, [2] = true, [3] = true, [4] = true, [5] = true, [6] = true, [7] = true, [8] = true, [9] = true, [10] = true,}
    
    r1 = tonumber(string.sub(comand, 2, 2)) + 1 
    c1 = tonumber(string.sub(comand, 3, 3)) + 1

    direction = string.sub(comand, 4, 4)
    r2 = direction == "u" and r1 - 1 or (direction == "d" and r1 + 1 or r1)
    c2 = direction == "l" and c1 - 1 or (direction == "r" and c1 + 1 or c1) 

    if (allowedValues[r2]) and (allowedValues[c2]) then
        mtrx.swap(area, r1, c1, r2, c2)
    end

end

function gm.dump()
    return copyist.deepCopy(area)
end

function gm.getStatus()
    return status
end

return gm