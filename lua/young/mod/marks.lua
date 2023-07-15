require('marks').setup {
  -- whether to map keybinds or not. default true
  default_mappings = true,
  -- which builtin marks to show. default {}
  builtin_marks = { '^', '.', '<', '>', '[', ']' },
  -- whether movements cycle back to the beginning/end of buffer. default true
  cyclic = true,
  -- whether the shada file is updated after modifying uppercase marks. default false
  force_write_shada = false,
  -- how often (in ms) to redraw signs/recompute mark positions.
  -- higher values will have better performance but may cause visual lag,
  -- while lower values may cause performance penalties. default 150.
  refresh_interval = 250,
  -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
  -- marks, and bookmarks.
  -- can be either a table with all/none of the keys, or a single number, in which case
  -- the priority applies to all marks.
  -- default 10.
  sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
  -- disables mark tracking for specific filetypes. default {}
  excluded_filetypes = {},
  -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
  -- sign/virttext. Bookmarks can be used to group together positions and quickly move
  -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
  -- default virt_text is "".
  bookmark_0 = {
    sign = '⚑',
    virt_text = 'hello world',
    -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
    -- defaults to false.
    annotate = false,
  },
  bookmark_1 = {
    sign = '',
    virt_text = '<bookmark-1>',
    annotate = true,
  },
  -- Default mappings
  -- mx              Set mark x
  -- m,              Set the next available alphabetical (lowercase) mark
  -- m;              Toggle the next available mark at the current line
  -- dmx             Delete mark x
  -- dm-             Delete all marks on the current line
  -- dm<space>       Delete all marks in the current buffer
  -- m]              Move to next mark
  -- m[              Move to previous mark
  -- m:              Preview mark. This will prompt you for a specific mark to preview; press <cr> to preview the next mark.
  --
  -- m[0-9]          Add a bookmark from bookmark group[0-9].
  -- dm[0-9]         Delete all bookmarks from bookmark group[0-9].
  -- m}              Move to the next bookmark having the same type as the bookmark under the cursor. Works across buffers.
  -- m{              Move to the previous bookmark having the same type as the bookmark under the cursor. Works across buffers.
  -- dm=             Delete the bookmark under the cursor.
  mappings = {
    toggle = 'm<tab>',
    preview = "m'",
    annotate = "m`",
  },
  -- set_next               Set next available lowercase mark at cursor.
  -- toggle                 Toggle next available mark at cursor.
  -- delete_line            Deletes all marks on current line.
  -- delete_buf             Deletes all marks in current buffer.
  -- next                   Goes to next mark in buffer.
  -- prev                   Goes to previous mark in buffer.
  -- preview                Previews mark (will wait for user input). press <cr> to just preview the next mark.
  -- set                    Sets a letter mark (will wait for input).
  -- delete                 Delete a letter mark (will wait for input).
  --
  -- set_bookmark[0-9]      Sets a bookmark from group[0-9].
  -- delete_bookmark[0-9]   Deletes all bookmarks from group[0-9].
  -- delete_bookmark        Deletes the bookmark under the cursor.
  -- next_bookmark          Moves to the next bookmark having the same type as the bookmark under the cursor.
  -- prev_bookmark          Moves to the previous bookmark having the same type as the bookmark under the cursor.
  -- next_bookmark[0-9]     Moves to the next bookmark of the same group type. Works by first going according to line number, and then according to buffer number.
  -- prev_bookmark[0-9]     Moves to the previous bookmark of the same group type. Works by first going according to line number, and then according to buffer number.
  -- annotate               Prompts the user for a virtual line annotation that is then placed above the bookmark. Requires neovim 0.6+ and is not mapped by default.
}
