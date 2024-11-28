return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- For icon support
    'lewis6991/gitsigns.nvim', -- For git diff information
  },
  config = function()
    -- Local references for better performance
    local lualine = require 'lualine'
    local api = vim.api
    local fn = vim.fn
    local tbl_contains = vim.tbl_contains

    -- Mode mapping for concise display
    local mode_map = {
      NORMAL = 'N',
      ['O-PENDING'] = 'N?',
      INSERT = 'I',
      VISUAL = 'V',
      ['V-BLOCK'] = 'VB',
      ['V-LINE'] = 'VL',
      ['V-REPLACE'] = 'VR',
      REPLACE = 'R',
      COMMAND = '!',
      SHELL = 'SH',
      TERMINAL = 'T',
      EX = 'X',
      ['S-BLOCK'] = 'SB',
      ['S-LINE'] = 'SL',
      SELECT = 'S',
      CONFIRM = 'Y?',
      MORE = 'M',
    }

    -- Function to get word count for specific filetypes
    local function get_word_count()
      local filetypes = { 'markdown', 'md', 'txt' }
      if not tbl_contains(filetypes, vim.bo.filetype) then
        return ''
      end

      local word_count = fn.wordcount()
      local words = word_count.visual_words or word_count.words

      if words == nil then
        return ''
      end

      return words == 1 and '1 word' or words .. ' words'
    end

    -- Function to get cursor position
    local function get_position()
      local col = fn.col '.'
      local line = fn.line '.'
      local total = fn.line '$'
      return string.format('C:%d L:%d/%d', col, line, total)
    end

    -- Function to retrieve git diff information
    local function diff_source()
      local gitsigns = vim.b.gitsigns_status_dict or {}
      return {
        added = gitsigns.added or 0,
        modified = gitsigns.changed or 0,
        removed = gitsigns.removed or 0,
      }
    end

    -- Function to display current macro recording
    local function macro_recording()
      local reg = fn.reg_recording()
      return reg ~= '' and ' ' .. reg or ''
    end

    -- Define color palette (can be customized or integrated with theme)
    local colors = {
      green = '#a7c080',
      yellow = '#ffdf1b',
      red = '#ff6666',
      gray = '#858585',
      light_gray = '#eeeeee',
      blue = '#61afef',
      purple = '#c678dd',
      cyan = '#56b6c2',
      white = '#ffffff',
    }

    -- Setup lualine
    lualine.setup {
      options = {
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        icons_enabled = true,
        globalstatus = true, -- Requires Neovim 0.7+
        disabled_filetypes = { 'NvimTree', 'toggleterm' },
      },
      sections = {
        lualine_a = {
          {
            'mode',
            fmt = function(mode)
              return mode_map[mode] or mode
            end,
            color = { fg = colors.white, bg = colors.blue, gui = 'bold' },
          },
        },
        lualine_b = {
          { 'branch', icon = '', color = { fg = colors.green, gui = 'bold' } },
          {
            'diff',
            source = diff_source,
            symbols = { added = ' ', modified = '柳', removed = ' ' },
            diff_color = {
              added = { fg = colors.green },
              modified = { fg = colors.yellow },
              removed = { fg = colors.red },
            },
          },
        },
        lualine_c = {
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            diagnostics_color = {
              color_error = { fg = colors.red },
              color_warn = { fg = colors.yellow },
              color_info = { fg = colors.cyan },
              color_hint = { fg = colors.gray },
            },
          },
          {
            'filename',
            file_status = true,
            path = 1, -- Relative path
            shorting_target = 40,
            symbols = {
              modified = '●',
              readonly = '',
              unnamed = '[No Name]',
              newfile = '[New]',
            },
            color = { fg = colors.white, gui = 'bold' },
          },
          {
            get_word_count,
            cond = function()
              return get_word_count() ~= ''
            end,
            color = { fg = colors.gray },
          },
          {
            'searchcount',
            symbols = { count = '🔍 %d', icon = '' },
            color = { fg = colors.purple },
          },
          {
            'selectioncount',
            symbols = { count = '🔢 %d', icon = '' },
            color = { fg = colors.purple },
          },
          {
            macro_recording,
            color = { fg = colors.white, bg = colors.red, gui = 'bold' },
          },
        },
        lualine_x = {
          {
            'fileformat',
            symbols = {
              unix = 'LF',
              dos = 'CRLF',
              mac = 'CR',
            },
            color = { fg = colors.cyan },
          },
          {
            'filetype',
            icon_only = true,
            colored = true,
            color = { fg = colors.blue },
          },
        },
        lualine_y = {
          {
            'encoding',
            color = { fg = colors.gray },
          },
          {
            'filetype',
            color = { fg = colors.gray },
          },
        },
        lualine_z = {
          {
            get_position,
            padding = { left = 1, right = 1 },
            color = { fg = colors.white, bg = colors.blue },
          },
        },
      },
      inactive_sections = {
        lualine_a = {
          {
            function()
              return ' ' .. api.nvim_win_get_number(0)
            end,
            color = { fg = colors.green, bg = colors.gray, gui = 'bold' },
          },
        },
        lualine_b = {},
        lualine_c = {
          {
            'filename',
            path = 1,
            shorting_target = 40,
            symbols = {
              modified = '●',
              readonly = '',
              unnamed = '[No Name]',
              newfile = '[New]',
            },
            color = { fg = colors.white },
          },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          {
            get_position,
            padding = { left = 1, right = 1 },
            color = { fg = colors.white, bg = colors.gray },
          },
        },
      },
      extensions = { 'quickfix', 'toggleterm', 'fzf', 'nvim-tree' },
    }

    -- Autocommands to refresh lualine on macro recording events
    api.nvim_create_autocmd({ 'RecordingEnter', 'RecordingLeave' }, {
      callback = function()
        vim.schedule(function()
          lualine.refresh()
        end)
      end,
    })
  end,
}
