return {
  settings = {
    ['rust-analyzer'] = {
      cargo = { allFeatures = true },
      checkOnSave = { allFeatures = true, command = 'clippy' },
    },
  },
}
