return {
  'olexsmir/gopher.nvim',
  ft = 'go',
  config = function(_, opts)
    require('gopher').setup(opts)

    vim.keymap.set('n', '<leader>gsj', '<cmd> GoTagAdd json <CR>', { desc = '[G]go [S]truct add [J]son tag' })
    vim.keymap.set('n', '<leader>gsy', '<cmd> GoTagAdd yaml <CR>', { desc = '[G]go [S]truct add [Y]aml tag' })
  end,
  build = function()
    vim.cmd [[silent! GoInstallDeps]]
  end,
}
