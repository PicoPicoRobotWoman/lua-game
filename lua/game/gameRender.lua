local sleep = require("lua.lib.sleep")

local timeout = 0.7

local gameRender = {}

function gameRender.render(board)

    if not os.execute("clear") and not os.execute("cls") then
        for i = 1,100 do
            print("\n")
        end
    end

    print("  0 1 2 3 4 5 6 7 8 9" )
    print("  -------------------" )

    for r = 1, #board, 1 do

        line = r - 1 .. "|"
        for c = 1, #board[r], 1 do
            line = line .. board[r][c].color .. " "
        end
        print(line)

    end

    sleep(timeout)

end

function gameRender.endGame()
    os.execute( "clear" )
    print("The End" )
end


return gameRender