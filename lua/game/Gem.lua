local gf = {}

local allowedColors = {"A", "B", "C", "D", "E", "F"}
local emptyColor = "0"
local emptyType = "empty"

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

function gf.getEmptyColor()
    return emptyColor
end

function gf.getEmptyType()
    return emptyType
end

function gf.convertToEmpty(gem)

    gem.type = emptyType
    gem.color = emptyColor

end

function gf.isEmpty(gem)
    return gem.type == emptyType
end


return gf