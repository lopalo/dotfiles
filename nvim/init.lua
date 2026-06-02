-- Neovim configuration (ported from .vimrc)

--------------------------------------------------------------------------------
-- Options
--------------------------------------------------------------------------------

vim.g.mapleader = "["

-- OSC 52 clipboard (copy to system clipboard over SSH/tmux)
vim.opt.clipboard = "unnamedplus"
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true
vim.opt.backspace = "indent,eol,start"

vim.opt.termguicolors = true
vim.opt.winborder = "rounded"
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.showcmd = true
vim.opt.colorcolumn = "82"

vim.opt.mouse = ""

vim.opt.history = 700

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"

vim.opt.autoread = true
vim.opt.ignorecase = true
vim.opt.wildignorecase = true
vim.opt.wildignore:append({ "*.pyc", "*.o", "*.hi", "*.jpg", "*.png", "node_modules" })
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.showmatch = true

vim.opt.laststatus = 2

vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

vim.opt.tags = ".ctags"

vim.opt.exrc = true
vim.opt.secure = true

vim.opt.signcolumn = "yes"
vim.opt.updatetime = 200

vim.diagnostic.config({
  severity_sort = true,
  float = {
    border = "rounded",
    source = "if_many",
  },
  jump = {
    on_jump = function()
      vim.diagnostic.open_float()
    end,
  },
  virtual_text = {
    show = "first"
  }
})

--------------------------------------------------------------------------------
-- Keymaps
--------------------------------------------------------------------------------

local keymap = vim.keymap.set

-- Search selected text in visual mode with //
keymap("v", "//", "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>", { silent = true })

-- K splits line (opposite of J)
keymap("n", "K", "i<CR><Esc>", { silent = true })

-- Diagnostic navigation (replacing ALE's C-j/C-k)
keymap("n", "<C-j>", vim.diagnostic.goto_next, { silent = true, desc = "Next diagnostic" })
keymap("n", "<C-k>", vim.diagnostic.goto_prev, { silent = true, desc = "Previous diagnostic" })

-- Command aliases for common typos
vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("Wqa", "wqa", {})
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})
vim.api.nvim_create_user_command("C", "nohlsearch", {})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    local function map(mode, lhs, rhs, desc)
      keymap(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
    end
    local tb = require("telescope.builtin")

    map("n", "<leader>d", tb.lsp_definitions, "LSP definitions")
    map("n", "<leader>t", tb.lsp_type_definitions, "LSP type definitions")
    map("n", "<leader>i", tb.lsp_implementations, "LSP implementations")
    map("n", "<leader>n", tb.lsp_references, "LSP references")
    map("n", "<leader>o", tb.lsp_document_symbols, "LSP document symbols")
    map("n", "<leader>w", tb.lsp_dynamic_workspace_symbols, "LSP workspace symbols")

    map("n", "<leader>l", vim.lsp.buf.declaration, "LSP declaration")
    map("n", "<leader>s", vim.lsp.buf.signature_help, "LSP signature help")
    map("n", "<leader>r", vim.lsp.buf.rename, "LSP rename")
    map("n", "<leader>h", function()
      vim.lsp.buf.hover({ border = "rounded" })
    end, "LSP hover")
    map({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, "LSP code action")
  end,
})

--------------------------------------------------------------------------------
-- lazy.nvim Bootstrap
--------------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------

require("lazy").setup({
  -- Colorscheme
  {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("nord")
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "nord",
      },
    },
  },

  -- File explorer (NERDTree replacement)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
    },
    opts = {
      view = { width = 30 },
    },
  },

  -- Fuzzy finder (ctrlp replacement)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    },
    opts = {
      defaults = {
        file_ignore_patterns = { "node_modules", "%.git/" },
      },
    },
  },

  -- Treesitter (Neovim 0.12+ rewrite on main; requires tree-sitter CLI on PATH)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local langs = {
        "rust",
        "python",
        "typescript",
        "javascript",
        "lua",
        "bash",
        "json",
        "yaml",
        "terraform",
        "vim",
        "vimdoc",
      }
      require("nvim-treesitter").install(langs)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = langs,
        callback = function()
          if vim.treesitter.start then
            vim.treesitter.start()
          end
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  -- Rainbow delimiters (rainbow parentheses)
  { "HiPhish/rainbow-delimiters.nvim" },

  -- Git gutter
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
      },
    },
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "rust_analyzer", "pyright", "ruff", "ts_ls", "eslint" },
      })
      require("mason-tool-installer").setup({
        ensure_installed = {
          "ruff",
          "prettier",
          "terraform",
        },
        auto_update = false,
        run_on_start = true,
      })
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "windwp/nvim-autopairs",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      require("nvim-autopairs").setup({ check_ts = true })
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      cmp.setup({
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- Formatter (neoformat replacement)
  {
    "stevearc/conform.nvim",
    keys = {
      {
        "==",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = { "n", "v" },
        desc = "Format buffer",
      },
    },
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        rust = { "rustfmt" },
        python = { "ruff_format" },
        typescript = { "prettier" },
        javascript = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        toml = { "taplo" },
        terraform = { "terraform_fmt" },
        tf = { "terraform_fmt" },
      },
    },
  },

  -- Surround (vim-surround replacement)
  { "kylechui/nvim-surround", event = "VeryLazy" },

  -- Comment (tcomment replacement)
  { "numToStr/Comment.nvim", event = "VeryLazy" },

  -- Session management (vim-obsession replacement)
  {
    "rmagatti/auto-session",
    opts = {
      log_level = "error",
      auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
    },
  },
})

--------------------------------------------------------------------------------
-- LSP
--------------------------------------------------------------------------------

vim.lsp.config("rust_analyzer", {
  cmd = { "rust-analyzer" },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        features = "all",
        allTargets = true,
        targetDir = "target",
      },
      checkOnSave = true,
      procMacro = {
        enable = true,
      },
    },
  },
})
-- LSP servers enabled via mason-lspconfig automatic_enable; rust uses ra-multiplex via vim.lsp.config above
