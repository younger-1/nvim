local snake_config = {
    fps = 50,
    name = 'snake',
}

-- init function is invoked only once at the start
-- config.init = function (grid)
-- end

-- update function
snake_config.update = function (grid)
    for i = 1, #grid do
        local prev = grid[i][#(grid[i])]
        for j = 1, #(grid[i]) do
            grid[i][j], prev = prev, grid[i][j]
        end
    end
    return true
end

require("cellular-automaton").register_animation(snake_config)
