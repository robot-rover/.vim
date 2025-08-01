local function lua_keymap(mod_name, func, args)
  local args_str = table.concat(args, ", ")
  local prefix = "lua require('" .. mod_name .. "')."
  local lua_cmd = func .. '(' .. args_str .. ')'
  local cmd = '<cmd>' .. prefix .. lua_cmd .. '<CR>'
  return cmd
end

local neovide_or_term = not vim.g.vscode
local term_only = not vim.g.vscode and not vim.g.neovide

if vim.g.neovide then
  vim.opt.guifont = { "FiraCode Nerd Font", ":h8" }
end

local python3_override = os.getenv("NVIM_PYTHON_OVERRIDE")
if python3_override ~= nil and python3_override ~= "" then
  vim.g.python3_host_prog = python3_override
end

if vim.fn.has("win64") then
  -- vim.opt.shell = 'powershell.exe'
end

local copilot_lualine = {
  'copilot',
  symbols = {
    status = {
      icons = {
        enabled = "",
        sleep = "󰒲",   -- auto-trigger disabled
        disabled = "⭘",
        warning = "",
        unknown = " "
      },
      hl = {
        enabled = "#50FA7B",
        sleep = "#AEB7D0",
        disabled = "#6272A4",
        warning = "#FFB86C",
        unknown = "#FF5555"
      }
    },
    spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
    spinner_color = "#6272A4",
  },
  show_colors = false,
  show_loading = true,
}


return {
  -- Theme
  {
    'dracula/vim',
    cond = neovide_or_term,
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd 'colorscheme dracula'
      if vim.fn.has("termguicolors") == 1 then
        vim.opt.termguicolors = true
      end
    end,
  },

  -- Smooth scrolling in terminal
  {
    'karb94/neoscroll.nvim',
    cond = term_only,
    keys = {
      { '<C-e>', lua_keymap('neoscroll', 'scroll', {'-vim.wo.scroll', '{move_cursor=true, duration=250}'}), mode = {'n', 'x'} },
      { '<C-n>', lua_keymap('neoscroll', 'scroll', {'vim.wo.scroll', '{move_cursor=true, duration=250}'}), mode = {'n', 'x'} },
      { 'zt', lua_keymap('neoscroll', 'zt', {'{half_win_duration=250}'}), mode = {'n', 'x'} },
      { 'zz', lua_keymap('neoscroll', 'zz', {'{half_win_duration=250}'}), mode = {'n', 'x'} },
      { 'zb', lua_keymap('neoscroll', 'zb', {'{half_win_duration=250}'}), mode = {'n', 'x'} },
    },
    opts = { hide_cursor = false, easing_function = "sine", mappings = {} },
  },

  -- Tree Sitter (operations on AST)
  {
    'nvim-treesitter/nvim-treesitter',
    cond = neovide_or_term,
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = {
          "c", "lua", "rust", "bash", "cmake", "cpp", "go", "java", "json",
          "make", "python", "toml", "verilog", "yaml", "vim", "vimdoc",
          "query", "just", "nim", "git_rebase", "git_config", "gitcommit",
          "gitignore",
        },
        sync_install = false,
        auto_install = true,
        incremental_selection = {
          enable = true,
          keymaps = {
            -- set to `false` to disable one of the mappings
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- Fuzzy Finder
  -- { "junegunn/fzf", build = "./install --bin" },
  {
    'ibhagwan/fzf-lua',
    cond = neovide_or_term,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { '<C-p>', "<cmd>lua require('fzf-lua').files()<CR>" },
      { '<Leader><Leader>', "<cmd>lua require('fzf-lua').lines()<CR>" },
      { '<Leader><Tab>', "<cmd>lua require('fzf-lua').tabs()<CR>" },
    }
  },

  -- Git Integration
  {
    'lewis6991/gitsigns.nvim',
    cond = neovide_or_term,
    config = function()
      local gs = require('gitsigns')
      gs.setup{}
      -- local gs = package.loaded.gitsigns

      vim.keymap.set('n', 'Qs', gs.stage_hunk)
      vim.keymap.set('n', 'Qr', gs.reset_hunk)
      vim.keymap.set('v', 'Qs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
      vim.keymap.set('v', 'Qr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
      vim.keymap.set('n', 'Qu', gs.undo_stage_hunk)
      vim.keymap.set('n', 'QS', gs.stage_buffer)
      vim.keymap.set('n', 'QR', gs.reset_buffer)
      vim.keymap.set('n', 'Qp', gs.preview_hunk)
      vim.keymap.set('n', 'Qb', function() gs.blame_line{full=true} end)
      -- vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame)
      vim.keymap.set('n', 'Qd', gs.diffthis)
      vim.keymap.set('n', 'QD', function() gs.diffthis('~') end)
      -- vim.keymap.set('n', '<leader>gt', gs.toggle_deleted)
      vim.keymap.set('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')

      vim.keymap.set('n', 'Qn', gs.next_hunk)
      vim.keymap.set('n', 'Qe', gs.prev_hunk)
    end,
  },

  -- Eazy Motion (Search for character)
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
      { '<Leader>S', '<Plug>(easymotion-overwin-f2)' },
    },
  },

  -- Auto filetype detection
  {
    'nathom/filetype.nvim',
    cond = neovide_or_term,
  },

  -- Sneak (f w/ 2 characters)
  {
    'justinmk/vim-sneak',
    keys = {
      { '[', '<Plug>Sneak_S', mode = '' },
      { ']', '<Plug>Sneak_s', mode = '' },
    },
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    cond = neovide_or_term,
    lazy = false,
    priority = 900,
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter" },
    opts = {
      theme = 'dracula',
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'filename' },
        lualine_c = { 'nvim_treesitter#statusline' },
        lualine_x = { copilot_lualine },
        lualine_y = { 'filetype' },
        lualine_z = { 'progress', 'location' },
      },
    },
  },

  -- File Managers
  {
    "robot-rover/neo-broot",
    cond = neovide_or_term,
    keys = {
      { "--", "<cmd>Broot<cr>", desc = "Open broot in the cwd" },
      { "-f", "<cmd>BrootFile<cr>", desc = "Open broot at the current file" }
    },
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    cond = neovide_or_term,
    event = 'InsertEnter',
    dependencies = {
      {'L3MON4D3/LuaSnip'},
    },
    config = function(cmp)
      local cmp = require('cmp')
      cmp.setup({
        sources = {
          {name = 'nvim_lsp'},
          {name = 'copilot'},
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-e>'] = cmp.mapping.select_prev_item(),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-k>'] = cmp.mapping.scroll_docs(4),
          ['<Tab>'] = cmp.mapping.confirm({ select = false }),
        }),
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cond = neovide_or_term,
    cmd = 'LspInfo',
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
    },
    config = function()
      -- lsp_attach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf
          local cliend = args.data.client
          local opts = {buffer = bufnr}
          vim.lsp.inlay_hint.enable(true)

          vim.keymap.set('n', 'gh', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', '<Leader>dt', '<cmd>tab split | lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', '<Leader>dv', '<cmd>vs | lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', '<Leader>ds', '<cmd>sp | lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
          vim.keymap.set({'n', 'x'}, '<F3>', function() vim.lsp.buf.format({async = true}) end, opts)
          vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gp', function() vim.diagnostic.jump({count=1, float=true, severity=vim.diagnostic.severity.ERROR}) end, opts)
          vim.keymap.set('n', 'gP', function() vim.diagnostic.jump({count=-1, float=true, severity=vim.diagnostic.severity.ERROR}) end, opts)
          vim.keymap.set('n', 'gF', vim.diagnostic.open_float, opts)
        end
      })

      -- vim.lsp.enable('vhdl_ls')
      vim.lsp.enable('rust_analyzer')
      vim.lsp.enable('jedi_language_server')
    end
  },
  {
    "zbirenbaum/copilot-cmp",
    cond = neovide_or_term,
    event = "InsertEnter",
    config = function () require("copilot_cmp").setup() end,
    dependencies = {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      config = function()
        require("copilot").setup({
          suggestion = { enabled = false },
          panel = { enabled = false },
        })
      end,
    },
  },
  {
    "ntpeters/vim-better-whitespace",
    cond = neovide_or_term,
    cmd = "StripWhitespace",
    event = "BufWritePre",
    keys = {
      { '<Leader>s', '<cmd>StripWhitespace<cr>', mode = '' },
    },
    init = function()
      vim.api.nvim_create_autocmd("BufWritePre", {
        command = "StripWhitespace"
      })
    end,
  },
  {
    "AndreM222/copilot-lualine",
  },
}

-- Future plugins
-- https://github.com/jeetsukumaran/vim-indentwise
--   Navigate by indent levels
-- https://github.com/SmiteshP/nvim-navic
--   LSP Location
-- https://github.com/SmiteshP/nvim-navbuddy
--   LSP Breadcrumb popup
