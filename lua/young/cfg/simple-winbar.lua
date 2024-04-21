xy.winbar = { '%f', vim.fn.winnr }
xy.set_winbar = function()
  -- return table.concat({ '%5.12f', '  ', require('nvim-navic').get_location(), '  ', vim.fn.winnr() }, '%=')
  -- local res = {}
  -- for _, elem in pairs(xy.winbar) do
  --   table.insert(res, elem())
  -- end
  return table.concat(
    vim.tbl_map(function(elem)
      if type(elem) == 'function' then
        return elem()
      else
        return elem
      end
    end, xy.winbar),
    '%='
  )
end

vim.o.winbar = '%{%v:lua.xy.set_winbar()%}'
