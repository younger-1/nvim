return function()
	require("nvim-treesitter.install").compilers = { "clang" }

	local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

	parser_configs.norg = {
		install_info = {
			url = "https://github.com/nvim-neorg/tree-sitter-norg",
			files = { "src/parser.c", "src/scanner.cc" },
			branch = "main",
		},
	}

	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"bash",
			"c",
			"c_sharp",
			"cpp",
			"comment",
			"css",
			"dockerfile",
			"gdscript",
			"html",
			"hjson",
			"javascript",
			"json",
			"json5",
			"lua",
			"query",
			"regex",
			"rust",
			"scss",
			"svelte",
			"toml",
			"tsx",
			"typescript",
			"yaml",
			"norg",
			"godotResource",
			"python",
		},
		highlight = {
			enable = true, -- false will disable the whole extension
			custom_captures = {
				["primitive.type"] = "Keyword",
				["escape.sequence"] = "Function",
			},
		},
		playground = {
			enable = true,
			disable = {},
			updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
			persist_queries = false, -- Whether the query persists across vim sessions
		},
		autotag = { enable = true },
	})
end
