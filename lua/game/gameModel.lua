local copyist = require("lua.lib.copyist")
local mc = require("lua.lib.matrixConstructor") 
local mi = require("lua.lib.matrixInfo")
local sc = require("lua.lib.syntaxCorrect")
local gf = require("lua.game.Gem")
local sleep = require("lua.lib.sleep")

local rows = 10
local collums = 10
local timeout = 1
local area = {}
local status = "wait"
local empty = "0"

local actvaters = {

    [1] = {
        predicate = function(gem)
            return gem.type == "usual"
        end,
        action = function(area, row, col)
            -- ignore
        end
    }

}


local createSpecials = {

    [1] = {
        predicate = function(gem)
            return gem.color == gf.getEmptyColor()
        end,
        action = function(area, row, col)
            -- ignore
        end
    }

}

local gm = {}

function gm.init()
    
    -- Инициализация Area и его первоночальное заполнение
    area = mc.getEmptyMatrix(rows, collums, gf.getEmptyGem)
    
    mc.mix(area, gf.createGem)
  
end

function gm.tick(comand)

    if status == "wait" then

        if comand == "mix" then mc.mix(area, gf.createGem) end
        if comand == "q" then status = "end" end

        if sc.moveisCorrect(comand) then 

            gm.move(comand)
            if mi.lines3Exist(area) then
                status = "running"
            else
                gm.move(comand)
            end            

        end

    end

    if status == "running" then 
        
        if mi.search(area, gf.getEmptyGem()) then
            
        elseif mi.lines3Exist() then

            mc.convert(area, actvaters)
            area = mc.convert3lines(area, gf.convertToEmpty)
            mc.convert(area, createSpecials)
            
        else 
            status = "wait"
        end
        --print("Ждём")
        --sleep(timeout)

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
        mc.swap(area, r1, c1, r2, c2)
    end

end

function gm.dump()
    return copyist.deepCopy(area)
end

function gm.getStatus()
    return status
end

return gm