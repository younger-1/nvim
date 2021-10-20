return function()
  require('yabs'):setup {
    languages = { -- List of languages in vim `filetype` format
      lua = {
        tasks = {
          run = {
            command = 'luafile %', -- The cammand to run (% and other
            -- wildcards will be automatically
            -- expanded)
            type = 'vim', -- The type of command (can be `vim`, `lua`, or
            -- `shell`, default `shell`)
          },
        },
      },
      c = {
        default_task = 'build_and_run',
        tasks = {
          build = {
            command = 'clang main.c -o main',
            output = 'buffer', -- Where to show output of the
            -- command can be `buffer`,
            -- `consolation`, `echo`,
            -- `quickfix`, `terminal`, or `none`
            opts = { -- Options for output (currently, the only one
              -- is `open_on_run`, which defines the behavior
              -- for the quickfix list opening) (can be
              -- `never`, `always`, or `auto`, the default)
              open_on_run = 'always',
            },
          },
          run = { -- You can specify as many tasks as you want per
            -- filetype
            command = './main',
            output = 'buffer',
          },
          build_and_run = { -- Setting the type to lua means the command
            -- is a lua function
            command = function()
              -- The following api can be used to run a task when a
              -- previous one finishes
              -- WARNING: this api is experimental and subject to
              -- changes
              require('yabs'):run_task('build', {
                on_exit = function()
                  require('yabs').languages.c:run_task 'run'
                end,
              })
            end,
            type = 'lua',
          },
        },
      },
    },
    tasks = { -- Same values as `language.tasks`, but global
      build = {
        command = 'echo building project...',
        output = 'consolation',
      },
      run = {
        command = 'echo running project..',
        output = 'echo',
      },
    },
    opts = { -- Same values as `language.opts`
      output_types = {
        quickfix = {
          open_on_run = 'always',
        },
      },
    },
  }
end
