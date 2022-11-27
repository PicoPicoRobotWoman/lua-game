local gf = {}

local allowedColors = {"A", "B", "C", "D"}
--local allowedColors = {"A", "B", "C", "D", "E", "F"}
local emptyColor = "0"

local metatable = {}
function metatable.__eq(g1, g2)
    return g1.color == g2.color
end

function gf.createGem(type, color) 
    local gem = {

        type = type or "usual",
        color = color or allowedColors[math.random(1, #allowedColors)]

    }
    setmetatable(gem, metatable)
    return gem
end

function gf.getEmptyGem()

    local gem = {

        type = "usual",
        color = emptyColor

    }
    setmetatable(gem, metatable)
    return gem

end

function gf.getEmptyColor()
    return emptyColor
end

function gf.convertToEmpty(SRCgem)
    local gem = {
        type = SRCgem.type,
        color = emptyColor
    }
    return gem
end

function gf.getType(gem)
    return gem.type
end

return gf