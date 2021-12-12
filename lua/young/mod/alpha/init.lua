local M = {}

local alpha = require 'alpha'
local dashboard = require 'alpha.themes.dashboard'
local startify = require 'alpha.themes.startify'

M.done = function()
  -- Set header
  dashboard.section.header.val = {
    -- "                                                     ",
    -- "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    -- "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    -- "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    -- "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    -- "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    -- "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    -- "                       Younger                       ",

    [[=================     ===============     ===============   ========  ========]],
    [[\\ . . . . . . .\\   //. . . . . . .\\   //. . . . . . .\\  \\. . .\\// . . //]],
    [[||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\/ . . .||]],
    [[|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||]],
    [[||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||]],
    [[|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\ . . . . ||]],
    [[||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\_ . .|. .||]],
    [[|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\ `-_/| . ||]],
    [[||_-' ||  .|/    || ||    \|.  || `-_|| ||_-' ||  .|/    || ||   | \  / |-_.||]],
    [[||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \  / |  `||]],
    [[||    `'         || ||         `'    || ||    `'         || ||   | \  / |   ||]],
    [[||            .===' `===.         .==='.`===.         .===' /==. |  \/  |   ||]],
    [[||         .=='   \_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \/  |   ||]],
    [[||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \/  |   ||]],
    [[||   .=='    _-'          '-__\._-'         '-_./__-'         `' |. /|  |   ||]],
    [[||.=='    _-'                                                     `' |  /==.||]],
    [[=='    _-'                        N E O V I M                         \/   `==]],
    [[\   _-'                                                                `-_   /]],
    [[ `''                                                                      ``' ]],

    -- "                       .,,uod8B8bou,,.",
    -- "              ..,uod8BBBBBBBBBBBBBBBBRPFT?l!i:.",
    -- "         ,=m8BBBBBBBBBBBBBBBRPFT?!||||||||||||||",
    -- "         !...:!TVBBBRPFT||||||||||!!^^'''   ||||",
    -- "         !.......:!?|||||!!^^'''            ||||",
    -- "         !.........||||                     ||||",
    -- "         !.........||||  ##                 ||||",
    -- "         !.........||||                     ||||",
    -- "         !.........||||                     ||||",
    -- "         !.........||||                     ||||",
    -- "         !.........||||                     ||||",
    -- "         `.........||||                    ,||||",
    -- "          .;.......||||               _.-!!|||||",
    -- "   .,uodWBBBBb.....||||       _.-!!|||||||||!:'",
    -- "!YBBBBBBBBBBBBBBb..!|||:..-!!|||||||!iof68BBBBBb....",
    -- "!..YBBBBBBBBBBBBBBb!!||||||||!iof68BBBBBBRPFT?!::   `.",
    -- "!....YBBBBBBBBBBBBBBbaaitf68BBBBBBRPFT?!:::::::::     `.",
    -- "!......YBBBBBBBBBBBBBBBBBBBRPFT?!::::::;:!^'`;:::       `.",
    -- "!........YBBBBBBBBBBRPFT?!::::::::::^''...::::::;         iBBbo.",
    -- "`..........YBRPFT?!::::::::::::::::::::::::;iof68bo.      WBBBBbo.",
    -- "  `..........:::::::::::::::::::::::;iof688888888888b.     `YBBBP^'",
    -- "    `........::::::::::::::::;iof688888888888888888888b.     `",
    -- "      `......:::::::::;iof688888888888888888888888888888b.",
    -- "        `....:::;iof688888888888888888888888888888888899fT!",
    -- "          `..::!8888888888888888888888888888888899fT|!^''",
    -- "           `' !!988888888888888888888888899fT|!^''",
    -- "               `!!8888888888888888899fT|!^''",
    -- "                 `!988888888899fT|!^''",
    -- "                   `!9899fT|!^''",
    -- "                     `!^''",
    -- "                                                 ",
    -- "   ______________      .:.        ______________ ",
    -- "  |##############|  .:::::::.    |##############|",
    -- "  |##############|::::::::::::.  |##############|",
    -- "    |##########|:::::::::::::::::  |##########/  ",
    -- "    |##########|:::::::::::::::::/#########/     ",
    -- "    |##########|:::::::::::::::/#########/       ",
    -- "    |##########|:::::::::::::/########/:         ",
    -- "    |##########|:::::::::::/########/:::::.      ",
    -- "   .|##########|:::::::::/########/:::::::::.    ",
    -- " .::|##########|::::::/########/:::::::::::::::. ",
    -- "`:::|##########|::::/########/::::::::::::::::::`",
    -- "  `:|##########|::/#####****::::::::::::::::::`  ",
    -- "    |##########|/###### ####;:::::::::::::::`    ",
    -- "    |#################/ ****;:::::::::::::`      ",
    -- "    |###############/::####:::####:::####  ####  ",
    -- "    |#############/:::####:::##################  ",
    -- "    |###########/:::::####:::####:` ####  ####   ",
    -- "    |#########/ `::::####:::####`  ####  ####    ",
    -- "    |#######/     `::####:::####   ####  ####    ",
    -- "    |####/          ####:::####   ####  ####     ",
    -- "     ````              `:`                       ",
    -- "                                                 ",
  }

  -- Set menu
  dashboard.section.buttons.val = {
    dashboard.button('e', '  New file', ':ene <BAR> startinsert <CR>'),
    dashboard.button('f', '  Find file', ':Telescope frecency<CR>'),
    dashboard.button('p', '  Projects', ':Telescope projects<CR>'),
    dashboard.button('s', '  Open last session', ":lua require('persistence').load()<CR>"),
    dashboard.button('q', '  Quit NVIM', ':qa<CR>'),
  }

  alpha.setup(dashboard.opts)

  -- Disable folding on alpha buffer
  -- vim.cmd [[
  --   autocmd FileType alpha setlocal nofoldenable
  -- ]]
end

-- <https://github.com/rafamadriz/NeoCode/blob/main/lua/modules/plugins/alpha.lua>
--
-- M.config = function()
--     startify.section.header.val = vim.g.code_startify_header_ascii
--     startify.section.top_buttons.val = {
--         startify.button("e", "New file", ":enew<CR>"),
--         { type = "padding", val = 1 },
--         startify.button("f", "Find Files", ":Telescope find_files<CR>"),
--         startify.button("r", "Recent Files", ":Telescope oldfiles<CR>"),
--         startify.button("w", "Grep Word", ":Telescope live_grep<CR>"),
--         startify.button("h", "Help Tags", ":Telescope help_tags<CR>"),
--         startify.button("p", "Projects", ":Telescope projects<CR>"),
--         startify.button("s", "Last Session", ":lua require'persistence'.load({last = true})<CR>"),
--     }
--     startify.section.bottom_buttons.val = {
--         startify.file_button("~/.config/nvim/lua/config.lua", "c"),
--         startify.file_button("~/.config/nvim/init.lua", "i"),
--         startify.file_button("~/.config/nvim/lua/modules/plugins/init.lua", "l"),
--         { type = "padding", val = 1 },
--         startify.button("q", "Quit", ":quitall<CR>"),
--     }
--     startify.opts = {
--         layout = {
--             { type = "padding", val = 2 },
--             startify.section.header,
--             { type = "padding", val = 2 },
--             startify.section.top_buttons,
--             startify.section.mru,
--             { type = "padding", val = 1 },
--             startify.section.bottom_buttons,
--         },
--         opts = {
--             margin = 3,
--         },
--     }
--     alpha.setup(require("alpha.themes.startify").opts)
-- end

return M
