local copyist = {}

    function copyist.deepCopy(tbl)
        
        if type(tbl) ~= "table" then
            return tbl
        end

        local result = {}
        for k, v in pairs(tbl) do
            result[k] = copyist.deepCopy(v)
        end

        return result
        
    end

return copyist