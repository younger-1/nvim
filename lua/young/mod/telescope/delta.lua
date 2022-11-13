local previewers = require 'telescope.previewers'
local builtin = require 'telescope.builtin'

local delta = previewers.new_termopen_previewer {
  get_command = function(entry)
    return {
      'git',
      '-c',
      'core.pager=delta',
      '-c',
      'delta.side-by-side=false',
      'diff',
      entry.value .. '^!',
      '--',
      entry.current_file,
    }
  end,
}

local E = {}

E.commits = function(opts)
  opts = opts or {}
  opts.previewer = { delta, previewers.git_commit_message.new(opts), previewers.git_commit_diff_as_was.new(opts) }

  builtin.git_commits(opts)
end

E.bcommits = function(opts)
  opts = opts or {}
  opts.previewer = { delta, previewers.git_commit_message.new(opts), previewers.git_commit_diff_as_was.new(opts) }

  builtin.git_bcommits(opts)
end

E.status = function(opts)
  opts = opts or {}
  opts.previewer = delta

  builtin.git_status(opts)
end

return E
