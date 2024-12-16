return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('fzf-lua').setup {
      -- fzf_opts = { ['--wrap'] = true },
      grep = {
        rg_glob = true,
        -- first returned string is the new search query
        -- second returned string are (optional) additional rg flags
        -- @return string, string?
        rg_glob_fn = function(query, opts)
          local regex, flags = query:match '^(.-)%s%-%-(.*)$'
          -- If no separator is detected will return the original query
          return (regex or query), flags
        end,
      },
      winopts = {
        preview = {
          -- wrap = 'wrap',
        },
      },
      defaults = {
        git_icons = true,
        file_icons = false,
        color_icons = true,
        formatter = 'path.filename_first',
      },
    }

    vim.keymap.set('n', '<leader>p', require('fzf-lua').files, { desc = 'FZF Files' })
  end,
}
