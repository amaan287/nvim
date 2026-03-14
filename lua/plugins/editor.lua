return {
  { "nvim-lua/plenary.nvim" },

  {
    "forkyoudev/forkyou.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("forkyou").setup({
        api_token = vim.env.FORKYOU_API_KEY,
      })
    end,
  },

  -- Navigation
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },

  -- File Explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      sort_by = "case_sensitive",
      view = { width = 35, side = "left", relativenumber = true },
      renderer = {
        highlight_git = true,
        highlight_opened_files = "all",
        root_folder_label = "  " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
        indent_markers = { enable = true, icons = { corner = "└", edge = "│", item = "│", bottom = "─", none = " " } },
        icons = {
            glyphs = {
                folder = { arrow_closed = "󰅂", arrow_open = "󰅀", default = "", open = "", empty = "", empty_open = "" },
                git = { unstaged = "󰄱", staged = "󰱒", unmerged = "", renamed = "➜", untracked = "󰇘", deleted = "󰆴", ignored = "◌" },
            },
        },
      },
      filters = { custom = { "^.git$" } },
      actions = { open_file = { quit_on_open = false, window_picker = { enable = false } } },
      update_focused_file = { enable = true, update_root = true },
    },
  },

  -- Search & Telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { horizontal = { prompt_position = "top", preview_width = 0.55, results_width = 0.8 }, width = 0.8, height = 0.8 },
        sorting_strategy = "ascending",
        winblend = 10,
        prompt_prefix = "   ",
        selection_caret = "  ",
      },
    },
  },

  -- Better UI for Lists
  { "folke/trouble.nvim", opts = {} },
  { "folke/todo-comments.nvim", opts = {} },
  { "kevinhwang91/nvim-bqf", ft = "qf" },

  -- Utils
  { "folke/which-key.nvim", event = "VeryLazy", init = function() vim.o.timeout = true vim.o.timeoutlen = 300 end, opts = {} },
  { "kylechui/nvim-surround", version = "*", event = "VeryLazy", opts = {} },
  { "akinsho/toggleterm.nvim", version = "*", opts = { size = 15, direction = "horizontal", float_opts = { border = "rounded" } } },
  { "folke/persistence.nvim", event = "BufReadPre", opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } } },
  { "mbbill/undotree", cmd = "UndotreeToggle" },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { default_file_explorer = true, columns = { "icon" }, view_options = { show_hidden = true } },
  },
  { "numToStr/Comment.nvim", opts = {} },
  { "RRethy/vim-illuminate", event = "VeryLazy" },
  { "mg979/vim-visual-multi", branch = "master" },
}
