return {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas {
        replace = {
          ['Scoop manifest'] = {
            description = 'Scoop bucket app manifest',
            fileMatch = { 'bucket/**.json' },
            name = 'Scoop manifest',
            url = 'https://cdn.jsdelivr.net/gh/lukesampson/scoop@master/schema.json',
            -- url = "https://raw.githubusercontent.com/lukesampson/scoop/master/schema.json",
          },
        },
      },
    },
  },
}
