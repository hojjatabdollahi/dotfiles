return {
  plugins = {
    "AstroNvim/astrocommunity",
    -- { import = "astrocommunity.colorscheme.catppuccin" }
	  { import = "astrocommunity.motion.leap-nvim" },
	  { import = "astrocommunity.utility.telescope-live-grep-args-nvim" },
    -- ... import any community contributed plugins here
    -- {
    --   "nvim-treesitter/nvim-treesitter-context",
    --   name = "treesitter-context",
    --   event = "BufRead",
    --   config = function()
    --     require("treesitter-context").setup {}
    --   end,
    -- },
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
  },
}
