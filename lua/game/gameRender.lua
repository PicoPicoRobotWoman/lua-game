local gr = {}

function gr.render(area)

    os.execute( "clear" )
    print("  0 1 2 3 4 5 6 7 8 9" )
    print("  -------------------" )

    for r = 1, #area, 1 do

        line = r - 1 .. "|"
        for c = 1, #area[r], 1 do
            line = line .. area[r][c].color .. " "
        end
        print(line)

    end

end

function gr.endGame()
    os.execute( "clear" )
    print("The End" )
end


return gr