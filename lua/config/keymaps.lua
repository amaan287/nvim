vim.g.mapleader = " "

-- Session Management (Persistence)
vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end, { desc = "Restore Session" })
vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "Restore Last Session" })
vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end, { desc = "Don't Save Session" })

local keymap = vim.keymap

-- Save
keymap.set("n", "<C-s>", ":w<CR>", { silent = true })
keymap.set("i", "<C-s>", "<Esc>:w<CR>", { silent = true })

-- Quit
keymap.set("n", "<C-q>", ":q<CR>", { silent = true })

-- Select all
keymap.set("n", "<C-a>", "ggVG")

-- Better indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- UFO Folding
keymap.set("n", "zR", function() require("ufo").openAllFolds() end, { desc = "Open all folds" })
keymap.set("n", "zM", function() require("ufo").closeAllFolds() end, { desc = "Close all folds" })
keymap.set("n", "zr", function() require("ufo").openFoldsExceptKinds() end, { desc = "Open folds except kinds" })
keymap.set("n", "zm", function() require("ufo").closeFoldsWith() end, { desc = "Close folds with" })
keymap.set("n", "K", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, { desc = "Peek Fold / Hover" })

-- Window navigation (VSCode-like feel)
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-l>", "<C-w>l")
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-k>", "<C-w>k")

-- Window splits (VSCode-style: focus new split)
keymap.set("n", "<C-\\>", function()
  vim.cmd("vsplit")
  vim.cmd("wincmd l")
end, { silent = true, desc = "Vertical Split" })

keymap.set("n", "<C-->", function()
  vim.cmd("split")
  vim.cmd("wincmd j")
end, { silent = true, desc = "Horizontal Split" })

-- VSCode-like Explorer Toggle
keymap.set({ "n", "i", "v" }, "<C-b>", "<cmd>NvimTreeToggle<CR>", { silent = true, desc = "Toggle Explorer" })

-- Code Outline (Aerial)
keymap.set("n", "<leader>o", "<cmd>AerialToggle! right<CR>", { silent = true, desc = "Toggle Outline" })

-- Premium Git Management (VSCode-like UI)
keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", { silent = true, desc = "Neogit Status" })
keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { silent = true, desc = "Global Diff" })
keymap.set("n", "<leader>gf", "<cmd>DiffviewFileHistory %<CR>", { silent = true, desc = "File History" })
keymap.set("n", "<leader>gx", "<cmd>DiffviewClose<CR>", { silent = true, desc = "Close Diff" })

-- Git Worktree Management
keymap.set("n", "<leader>gw", function()
  require("telescope").extensions.git_worktree.git_worktrees()
end, { silent = true, desc = "Switch Worktree" })

keymap.set("n", "<leader>gn", function()
  require("telescope").extensions.git_worktree.create_git_worktree()
end, { silent = true, desc = "New Worktree" })


-- VSCode-like Search (Current File)
keymap.set("n", "<C-f>", function()
  require("telescope.builtin").current_buffer_fuzzy_find({
    previewer = false,
  })
end, { silent = true, desc = "Search in File" })

-- VSCode-like Global Search (Workspace)
keymap.set("n", "<C-S-f>", function()
  require("telescope.builtin").live_grep({
    additional_args = function()
      return { "--hidden" }
    end,
  })
end, { silent = true, desc = "Search in Workspace" })

-- VSCode Command Palette
keymap.set("n", "<C-S-p>", function()
  require("telescope.builtin").commands()
end, { silent = true, desc = "Command Palette" })

-- Buffer Navigation (VSCode-like tabs)
keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", { silent = true })
keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", { silent = true })

-- Alt + Arrow Tab Navigation (VSCode style)
keymap.set("n", "<A-Right>", ":BufferLineCycleNext<CR>", { silent = true })
keymap.set("n", "<A-Left>", ":BufferLineCyclePrev<CR>", { silent = true })

-- Integrated Terminal Toggle (VSCode-like)
keymap.set("n", "<C-j>", ":ToggleTerm<CR>", { silent = true, desc = "Toggle Terminal" })
keymap.set("t", "<C-j>", [[<C-\><C-n>:ToggleTerm<CR>]], { silent = true })

-- Duplicate Line (VSCode style)
keymap.set("n", "<C-S-Down>", ":t.<CR>", { silent = true })
keymap.set("n", "<C-S-Up>", ":t-1<CR>", { silent = true })
keymap.set("v", "<C-S-Down>", ":t'><CR>gv", { silent = true })
keymap.set("v", "<C-S-Up>", ":t'<-1<CR>gv", { silent = true })

-- Move Line (VSCode style)
keymap.set("n", "<A-Down>", ":m .+1<CR>==", { silent = true })
keymap.set("n", "<A-Up>", ":m .-2<CR>==", { silent = true })
keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { silent = true })
keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { silent = true })

-- Ctrl + Click -> Go to Definition (VSCode style)
keymap.set("n", "<C-LeftMouse>", function()
  vim.lsp.buf.definition()
end, { silent = true })

-- Also support in insert mode
keymap.set("i", "<C-LeftMouse>", function()
  vim.lsp.buf.definition()
end, { silent = true })

-- Close Current Tab (VSCode style Ctrl+w)
keymap.set("n", "<C-w>", function()
  local current_buf = vim.api.nvim_get_current_buf()

  -- Get listed buffers (real file buffers)
  local buffers = vim.tbl_filter(function(buf)
    return vim.bo[buf].buflisted
  end, vim.api.nvim_list_bufs())

  -- Close current buffer
  vim.cmd("bdelete " .. current_buf)

  -- Refresh buffer list after delete
  local remaining = vim.tbl_filter(function(buf)
    return vim.bo[buf].buflisted
  end, vim.api.nvim_list_bufs())

  if #remaining > 0 then
    -- Go to last buffer (most recently used)
    vim.cmd("buffer #")
  else
    -- If no buffers left, focus file explorer
    vim.cmd("NvimTreeFocus")
  end
end, { silent = true, desc = "Close Tab" })

-- Learning Session Shortcuts
keymap.set("n", "<leader>ls", function()
  require("config.learn").start()
end, { silent = true, desc = "Start Learning Session" })

keymap.set("n", "<leader>le", function()
  require("config.learn").stop()
end, { silent = true, desc = "End Learning Session" })

-- Alt + Space -> Quick File Open (VSCode Ctrl+P style)
keymap.set("n", "<A-Space>", function()
  require("telescope.builtin").find_files({
    hidden = true,
    previewer = false,
  })
end, { silent = true, desc = "Quick Open File" })

-- Undotree
keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" })

-- Oil (File Manager)
keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })

-- Quickfix List Toggle
keymap.set("n", "<leader>xl", function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists then
    vim.cmd("cclose")
  else
    vim.cmd("copen")
  end
end, { desc = "Toggle Quickfix List" })

-- Real Peek Definition (VSCode-style floating window with navigation)
keymap.set("n", "<A-F12>", function()
  local params = vim.lsp.util.make_position_params()
  vim.lsp.buf_request(0, "textDocument/definition", params, function(_, result)
    if not result or vim.tbl_isempty(result) then
      return
    end

    local def = result[1]
    local uri = def.uri or def.targetUri
    local range = def.range or def.targetSelectionRange

    local bufnr = vim.uri_to_bufnr(uri)
    vim.fn.bufload(bufnr)

    local start_line = range.start.line
    local end_line = range["end"].line

    local context_before = math.max(start_line - 5, 0)
    local context_after = end_line + 5

    local lines = vim.api.nvim_buf_get_lines(
      bufnr,
      context_before,
      context_after + 1,
      false
    )

    local ft = vim.bo[bufnr].filetype

    local preview_buf, preview_win = vim.lsp.util.open_floating_preview(
      lines,
      ft,
      {
        border = "rounded",
        focusable = true,
      }
    )

    -- Move cursor inside floating window to actual definition line
    local target_line = (start_line - context_before) + 1
    vim.api.nvim_win_set_cursor(preview_win, { target_line, 0 })
  end)
end, { silent = true, desc = "Peek Definition" })
