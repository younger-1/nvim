return {
  settings = {
    pylsp = {
      plugins = {
        -- pylint = { enabled = true, executable = "pylint" },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        jedi_completion = { fuzzy = true },
        pyls_isort = { enabled = true },
        pylsp_mypy = { enabled = true },
        rope_completion = {
          enabled = true,
          eager = true,
        },
      },
    },
  },
}
