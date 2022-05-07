-- local status_ok, jdtls = pcall(require, "jdtls")
-- if not status_ok then
--   return
-- end

local ok, jdtls_server = require('nvim-lsp-installer.servers').get_server 'jdtls'
if not ok or not jdtls_server:is_installed() then
  vim.notify '[Young]: not install jdtls'
  return
end

local common_opts = require 'young.lsp.common'
local config

local M = {}

-- UI
local finders = require 'telescope.finders'
local sorters = require 'telescope.sorters'
local actions = require 'telescope.actions'
local pickers = require 'telescope.pickers'
require('jdtls.ui').pick_one_async = function(items, prompt, label_fn, cb)
  local opts = {}
  pickers.new(opts, {
    prompt_title = prompt,
    finder = finders.new_table {
      results = items,
      entry_maker = function(entry)
        return {
          value = entry,
          display = label_fn(entry),
          ordinal = label_fn(entry),
        }
      end,
    },
    sorter = sorters.get_generic_fuzzy_sorter(),
    attach_mappings = function(prompt_bufnr)
      actions.goto_file_selection_edit:replace(function()
        local selection = actions.get_selected_entry(prompt_bufnr)
        actions.close(prompt_bufnr)

        cb(selection.value)
      end)

      return true
    end,
  }):find()
end

local on_attach_jdtls = function(client, bufnr)
  common_opts.on_attach(client, bufnr)

  -- JdtBytecode command to show bytecode of current file
  -- JdtJol command to show memory usage of current file (jol_path must be set)
  -- JdtJshell command to open up jshell with classpath from project set
  require('jdtls.setup').add_commands()

  -- require('jdtls').setup_dap()
  -- require('lsp-status').register_progress()
  -- require('lspsaga').init_lsp_saga()

  -- require('formatter').setup {
  --   filetype = {
  --     java = {
  --       function()
  --         return {
  --           exe = 'java',
  --           args = {
  --             '-jar',
  --             os.getenv 'HOME' .. '/.local/jars/google-java-format.jar',
  --             vim.api.nvim_buf_get_name(0),
  --           },
  --           stdin = true,
  --         }
  --       end,
  --     },
  --   },
  -- }

  -- Java specific
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ji', "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jt', "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jn', "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    'v',
    '<leader>jv',
    "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>jv', "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>jm', "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
end

M.setup = function()
  -- Find root of project
  local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
  local root_dir = require('jdtls.setup').find_root(root_markers)
  local home = os.getenv 'HOME'
  -- local workspace_folder = home .. '/.workspace' .. vim.fn.fnamemodify(root_dir, ':p:h:t')

  local extendedClientCapabilities = require('jdtls').extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

  -- local lspconfig_jdtls = require('lspconfig').jdtls.document_config.default_config
  -- lspconfig_jdtls.handlers = nil
  -- lspconfig_jdtls.init_options = nil
  -- lspconfig_jdtls.root_dir = nil
  -- config = vim.tbl_deep_extend('force', lspconfig_jdtls, common_opts)

  config = vim.tbl_deep_extend('force', common_opts, require 'young.lsp.providers.jdtls')
  config = vim.tbl_deep_extend('force', config, {
    cmd = jdtls_server._default_options.cmd,
    root_dir = root_dir,
    on_attach = on_attach_jdtls,
    flags = {
      allow_incremental_sync = true,
      server_side_fuzzy_completion = true,
    },
    capabilities = {
      workspace = {
        configuration = true,
      },
    },
    init_options = {
      -- bundles = bundles;
      extendedClientCapabilities = extendedClientCapabilities,
    },
  })

  config.settings = {
    -- ['java.format.settings.url'] = home .. '/.config/nvim/.java-google-style.xml',
    -- ['java.format.settings.profile'] = 'GoogleStyle',
    java = {
      format = {
        -- insertSpaces = true,
        -- tabSize = 4, -- FIXME: Not working
        comments = { enabled = false },
        settings = {
          profile = 'GoogleStyle',
          url = home .. '/.config/nvim/.java-google-style.xml',
        },
      },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      completion = {
        favoriteStaticMembers = {
          'org.hamcrest.MatcherAssert.assertThat',
          'org.hamcrest.Matchers.*',
          'org.hamcrest.CoreMatchers.*',
          'org.junit.jupiter.api.Assertions.*',
          'java.util.Objects.requireNonNull',
          'java.util.Objects.requireNonNullElse',
          'org.mockito.Mockito.*',
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
        },
      },
      -- configuration = {
      --   runtimes = {
      --     {
      --       name = 'JavaSE-11',
      --       path = home .. '/.sdkman/candidates/java/11.0.10-open/',
      --     },
      --     {
      --       name = 'JavaSE-14',
      --       path = home .. '/.sdkman/candidates/java/14.0.2-open/',
      --     },
      --     {
      --       name = 'JavaSE-15',
      --       path = home .. '/.sdkman/candidates/java/15.0.1-open/',
      --     },
      --   },
      -- },
    },
  }

  config.on_init = function(client, _)
    client.notify('workspace/didChangeConfiguration', { settings = config.settings })
  end

  -- local jar_patterns = {
  --     '/dev/microsoft/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
  --     '/dev/dgileadi/vscode-java-decompiler/server/*.jar',
  --     '/dev/microsoft/vscode-java-test/server/*.jar',
  -- }

  -- local bundles = {}
  -- for _, jar_pattern in ipairs(jar_patterns) do
  --   for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), '\n')) do
  --     if not vim.endswith(bundle, 'com.microsoft.java.test.runner.jar') then
  --       table.insert(bundles, bundle)
  --     end
  --   end
  -- end

  -- NOTE: for debug
  M.config = config

  require('jdtls').start_or_attach(config)
end

return M
