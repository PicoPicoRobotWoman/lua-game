local sc = {}

function sc.moveisCorrect(comand)

    symbolsCorrect = {l = true, u = true, d = true, r = true}
    numbersCorrect = {["0"] = true, ["1"] = true, ["2"] = true, ["3"] = true, ["4"] = true, ["5"] = true, ["6"] = true, ["7"] = true, ["8"] = true, ["9"] = true }

    if type(comand) ~= "string" then return false end
    if string.len(comand) ~= 4 then return false end
    if string.sub(comand, 1, 1 ) ~= "m" then return false end
    if not symbolsCorrect[string.sub( comand, 4, 4)] then print(4); return false end
    if not numbersCorrect[string.sub( comand, 2, 2)] then return  false end
    if not numbersCorrect[string.sub( comand, 3, 3)] then return  false end

    return true
end

return sc