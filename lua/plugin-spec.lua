local function lua_keymap(mod_name, func, args)
  local args_str = table.concat(args, ", ")
  local prefix = "lua require('" .. mod_name .. "')."
  local lua_cmd = func .. '(' .. args_str .. ')'
  local cmd = '<cmd>' .. prefix .. lua_cmd .. '<CR>'
  return cmd
end

local full_plugins = not vim.g.vscode

return {
  {
    'dracula/vim',
    enabled = full_plugins,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd 'colorscheme dracula'
      if vim.fn.has("termguicolors") == 1 then
        vim.opt.termguicolors = true
      end
    end,
  },
  {
    'karb94/neoscroll.nvim',
    enabled = full_plugins,
    keys = {
      { '<C-e>', lua_keymap('neoscroll', 'scroll', {'-vim.wo.scroll', 'true', '250'}), mode = {'n', 'x'} },
      { '<C-n>', lua_keymap('neoscroll', 'scroll', {'vim.wo.scroll', 'true', '250'}), mode = {'n', 'x'} },
      { 'zt', lua_keymap('neoscroll', 'zt', {'250'}), mode = {'n', 'x'} },
      { 'zz', lua_keymap('neoscroll', 'zz', {'250'}), mode = {'n', 'x'} },
      { 'zb', lua_keymap('neoscroll', 'zb', {'250'}), mode = {'n', 'x'} },
    },
    opts = { hide_cursor = false, easing_function = "sine", mappings = {} },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    enabled = full_plugins,
    build = ":TSUpdate",
    opts = {
      -- TODO: Add incremental search bindings
        ensure_installed = { "c", "lua", "rust", "bash", "cmake", "cpp", "go",
        "java", "json", "make", "python", "toml", "verilog", "yaml", "vim",
        "vimdoc", "query"},
        highlight = { enable = true },
        -- indent = { enable = true },
      }
  },
  -- { "junegunn/fzf", build = "./install --bin" },
  {
    'ibhagwan/fzf-lua',
    enabled = full_plugins,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { '<C-p>', "<cmd>lua require('fzf-lua').files()<CR>" },
      { '<Leader><Leader>', "<cmd>lua require('fzf-lua').lines()<CR>" },
      { '<Leader><Tab>', "<cmd>lua require('fzf-lua').tabs()<CR>" },
    }
  },
  {
    'lewis6991/gitsigns.nvim',
    enabled = full_plugins,
    config = function()
      local gs = require('gitsigns')
      gs.setup{}
      -- local gs = package.loaded.gitsigns

      vim.keymap.set('n', 'gs', gs.stage_hunk)
      vim.keymap.set('n', 'gr', gs.reset_hunk)
      vim.keymap.set('v', 'gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
      vim.keymap.set('v', 'gr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
      vim.keymap.set('n', 'gu', gs.undo_stage_hunk)
      vim.keymap.set('n', 'gS', gs.stage_buffer)
      vim.keymap.set('n', 'gR', gs.reset_buffer)
      vim.keymap.set('n', 'gp', gs.preview_hunk)
      vim.keymap.set('n', 'gb', function() gs.blame_line{full=true} end)
      -- vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame)
      vim.keymap.set('n', 'gd', gs.diffthis)
      vim.keymap.set('n', 'gD', function() gs.diffthis('~') end)
      -- vim.keymap.set('n', '<leader>gt', gs.toggle_deleted)
      vim.keymap.set({'o', 'v'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

      vim.keymap.set('n', 'gn', gs.next_hunk)
      vim.keymap.set('n', 'ge', gs.prev_hunk)
    end,
  },
  {
    'easymotion/vim-easymotion',
    init = function()
      vim.g.EasyMotion_do_mapping = 0
      vim.g.EasyMotion_do_smartcase = 1
    end,
    keys = {
      { '<Leader>f', '<Plug>(easymotion-bd-f)', mode = '' },
      { '<Leader>s', '<Plug>(easymotion-bd-f2)', mode = '' },
      { '<Leader>F', '<Plug>(easymotion-overwin-f)' },
      { '<Leader>s', '<Plug>(easymotion-overwin-f2)' },
    },
  },
  {
    'tpope/vim-vinegar',
    enabled = full_plugins,
  },
  {
    'nathom/filetype.nvim',
    enabled = full_plugins,
  },
  {
    'justinmk/vim-sneak',
    keys = {
      { '[', '<Plug>Sneak_S', mode = '' },
      { ']', '<Plug>Sneak_s', mode = '' },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    enabled = full_plugins,
    lazy = false,
    priority = 900,
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter" },
    opts = {
      theme = 'dracula',
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'filename' },
        lualine_c = { 'nvim_treesitter#statusline' },
        lualine_x = {},
        lualine_y = { 'filetype' },
        lualine_z = { 'location' },
      },
    },
  }
}

-- Future plugins
-- https://github.com/jeetsukumaran/vim-indentwise
--   Navigate by indent levels
-- https://github.com/SmiteshP/nvim-navic
--   LSP Location
-- https://github.com/SmiteshP/nvim-navbuddy
--   LSP Breadcrumb popup