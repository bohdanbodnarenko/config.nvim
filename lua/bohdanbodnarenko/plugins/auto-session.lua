return {
  'rmagatti/auto-session',
  config = function()
    local auto_session = require 'auto-session'

    auto_session.setup {
      auto_restore_enabled = true,
      auto_session_suppress_dirs = { '~/', '~/Downloads/' },
      auto_save = true,
      cwd_change_handling = true,
      auto_create = true,
    }

    vim.keymap.set('n', '<leader>wr', '<cmd>SessionRestore<CR>', { desc = '[W]orkspace [R]estore session for cwd' }) -- restore last workspace session for current directory
    vim.keymap.set('n', '<leader>ws', '<cmd>SessionSave<CR>', { desc = '[W]orkspace [S]ave session for auto session root dir' }) -- save workspace session for current working directory}
  end,
}
