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
      { '<C-e>', lua_keymap('neoscroll', 'scroll', {'-vim.wo.scroll', 'true', '250'}), mode = {'n', 'x'} },
      { '<C-n>', lua_keymap('neoscroll', 'scroll', {'vim.wo.scroll', 'true', '250'}), mode = {'n', 'x'} },
      { 'zt', lua_keymap('neoscroll', 'zt', {'250'}), mode = {'n', 'x'} },
      { 'zz', lua_keymap('neoscroll', 'zz', {'250'}), mode = {'n', 'x'} },
      { 'zb', lua_keymap('neoscroll', 'zb', {'250'}), mode = {'n', 'x'} },
    },
    opts = { hide_cursor = false, easing_function = "sine", mappings = {} },
  },

  -- Tree Sitter (operations on AST)
  {
    'nvim-treesitter/nvim-treesitter',
    cond = neovide_or_term,
    build = ":TSUpdate",
	config = function()
	  require('nvim-treesitter').setup({
      -- TODO: Add incremental search bindings
        ensure_installed = { "c", "lua", "rust", "bash", "cmake", "cpp", "go",
        "java", "json", "make", "python", "toml", "verilog", "yaml", "vim",
        "vimdoc", "query"},
        highlight = { enable = true },
        -- indent = { enable = true },
      })
	  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.vhdl = {
        install_info = {
		  -- url = vim.fn.stdpath("config") .. "/tree-sitter-vhdl-main", -- local path or git repo
		  url = "https://github.com/alemuller/tree-sitter-vhdl",
          files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
          branch = "main", -- default branch in case of git repo if different from master
          -- optional entries:
          generate_requires_npm = false, -- if stand-alone parser without npm dependencies
          requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
		}
      }
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
      { '<Leader>s', '<Plug>(easymotion-overwin-f2)' },
    },
  },

  -- Netrw rework (don't need bc of yazi)
  {
    'tpope/vim-vinegar',
    -- cond = neovide_or_term,
    enabled = false,
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
        lualine_x = {},
        lualine_y = { 'filetype' },
        lualine_z = { 'location' },
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
  {
    "mikavilpas/yazi.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      {
        "--",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "-c",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory" ,
      },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,
      keymaps = {
        show_help = '<f1>',
      },
    },
  },

  -- LSP Easy Configuration
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    lazy = true,
    config = false,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
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
    cmd = 'LspInfo',
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
    },
    config = function()
      local lsp_zero = require('lsp-zero')

      -- lsp_attach is where you enable features that only work
      -- if there is a language server active in the file
      local lsp_attach = function(client, bufnr)
        local opts = {buffer = bufnr}

        vim.keymap.set('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', '<Leader>dt', '<cmd>tab split | lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', '<Leader>dv', '<cmd>vs | lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', '<Leader>ds', '<cmd>sp | lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
      end

      lsp_zero.extend_lspconfig({
        sign_text = true,
        lsp_attach = lsp_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      })

      -- These are just examples. Replace them with the language
      -- servers you have installed in your system
      require('lspconfig').vhdl_ls.setup({})
      require('lspconfig').rust_analyzer.setup({})
      require('lspconfig').jedi_language_server.setup({})
    end
  },
  {
    "zbirenbaum/copilot-cmp",
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
}

-- Future plugins
-- https://github.com/jeetsukumaran/vim-indentwise
--   Navigate by indent levels
-- https://github.com/SmiteshP/nvim-navic
--   LSP Location
-- https://github.com/SmiteshP/nvim-navbuddy
--   LSP Breadcrumb popup
