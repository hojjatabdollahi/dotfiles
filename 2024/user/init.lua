return {
  plugins = {
    "AstroNvim/astrocommunity",
    -- { import = "astrocommunity.colorscheme.catppuccin" }
	  { import = "astrocommunity.motion.leap-nvim" },
	  { import = "astrocommunity.utility.telescope-live-grep-args-nvim" },
    -- ... import any community contributed plugins here
    {
      "nvim-treesitter/nvim-treesitter-context",
      name = "treesitter-context",
      event = "BufRead",
      config = function()
        require("treesitter-context").setup {}
      end,
    },
    -- {
    --   "sourcegraph/sg.nvim",
    --   dependencies = { "nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]] },
    --   event = "BufRead",
    -- },
    -- {
    --   "L3MON4D3/LuaSnip",
    --   name = "treesitter-context",
    --   event = "BufRead",
    --   config = function(plugin, opts)
    --     -- include the default astronvim config that calls the setup call
    --     require "plugins.configs.luasnip"(plugin, opts)
    --     -- load snippets paths
    --     require("luasnip.loaders.from_vscode").lazy_load {
    --       -- this can be used if your configuration lives in ~/.config/nvim
    --       -- if your configuration lives in ~/.config/astronvim, the full path
    --       -- must be specified in the next line
    --       paths = { "/Users/hojjatabdollahi/.config/nvim/lua/user/snippets" }
    --     }
    --   end,
    -- },
    {
      "stevearc/conform.nvim",
      event = { "BufRead" },
      opts = {
			  formatters_by_ft = {
				  sql = { "sql_formatter" },
				  go = { "gci", "injected" },
				  ["*"] = { "injected" },
			  },
			   format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true,
        },
        formatters = {
          sleek = {
            command = 'sleek'
          },
          gci = {
            command = 'gci'
          },
          injected = { options = { ignore_errors = true } },
        },
        notify_on_error = true,
		  },
		  config = function(_, opts)
			  require("conform").setup(opts)
			  require("conform").formatters.sql_formatter = {
			    prepend_args = {"-c", vim.fn.expand("~/.config/sql-formatter.json")},
			  }
		  end,
    },
    {
      "hexdigest/go-enhanced-treesitter.nvim",
      event = "BufRead",
      ft = "go",
    },
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({
          panel = {
              enabled = true,
              auto_refresh = false,
              keymap = {
                jump_prev = "[[",
                jump_next = "]]",
                accept = "<CR>",
                refresh = "gr",
                open = "<M-CR>"
              },
              layout = {
                position = "bottom", -- | top | left | right
                ratio = 0.4
              },
            },
            suggestion = {
              enabled = true,
              auto_trigger = false,
              debounce = 75,
              keymap = {
                accept = "<M-l>",
                accept_word = false,
                accept_line = false,
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-]>",
              },
            },
            filetypes = {
              yaml = false,
              markdown = false,
              help = false,
              gitcommit = false,
              gitrebase = false,
              hgcommit = false,
              svn = false,
              cvs = false,
              ["."] = false,
            },
            copilot_node_command = 'node', -- Node.js version must be > 18.x
            server_opts_overrides = {},
        })
      end,
    },
  },
}
