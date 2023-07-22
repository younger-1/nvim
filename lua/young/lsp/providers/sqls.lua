return {
  settings = {
    sqls = {
      connections = {
        -- {
        --   driver = 'mysql',
        --   dataSourceName = 'root:root@tcp(127.0.0.1:3306)/world',
        -- },
        -- {
        --   driver = 'postgresql',
        --   dataSourceName = 'host=127.0.0.1 port=5432 user=postgres password=mysecretpassword1234 dbname=dvdrental sslmode=disable',
        -- },
        {
          driver = 'mysql',
          -- @see https://github.com/go-sql-driver/mysql#dsn-data-source-name
          -- [username[:password]@][protocol[(address)]]/dbname[?param1=value1&...&paramN=valueN]
          -- dataSourceName = 'root@tcp(127.0.0.1:3306)/mysql',
          dataSourceName = 'root@/mysql',
        },
        {
          driver = 'postgresql',
          dataSourceName = 'dbname=postgres sslmode=disable',
        },
      },
    },
  },
  on_attach = function(client, bufnr)
    require('young.lsp.common').on_attach(client, bufnr)

    if rr 'sqls' then
      require('sqls').on_attach(client, bufnr)
    end
  end,
}
