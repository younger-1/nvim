return function()
    local gl = require("galaxyline")

    local colors = {
        fg = "#E5E9F0",
        bg = "#2E3440",
        yellow = "#d4d198",
        green = "#98C379",
        black = "#2b2e36",
        blue = "#5d8ac2",
        grey = "#3B4048",
        purple = "#c487b9",
        red = "#d94848",
        light_blue = "#8fc6e3",
        blue_green = "#4EC9B0",
        line_color = "#353c4a",
    }

    local mode_color = {
        n = colors.blue,
        i = colors.green,
        v = colors.purple,
        c = colors.yellow,
        V = colors.purple,
        [""] = colors.red,
    }

    local files = {
        ["cs"] = "C#",
        ["cpp"] = "C++",
    }

    local conditions = {
        buffer_not_empty = function()
            return vim.fn.empty(vim.fn.expand("%:t")) ~= 1 and vim.bo.modifiable == true
        end,
        hide_in_width = function()
            return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
            local filepath = vim.fn.expand("%:p:h")
            local gitdir = vim.fn.finddir(".git", filepath .. ";")
            return gitdir and #gitdir > 0 and #gitdir < #filepath and vim.bo.filetype ~= "alpha"
        end,

        if_alpha = function()
            if vim.bo.filetype == "alpha" then
                return true
            end
        end,
    }
    local gls = gl.section
    local diagnostic = require("galaxyline.providers.diagnostic")
    local vcs = require("galaxyline.providers.vcs")
    local fileinfo = require("galaxyline.providers.fileinfo")

    gls.left[1] = {
        ModeColorLeft = {
            provider = "FileSize",
            icon = "   ",
            highlight = { colors.green, colors.purple },
            separator = "",
            separator_highlight = { colors.purple, colors.darkblue },
        }
    }
end
