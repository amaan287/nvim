local function augroup(name)
  return vim.api.nvim_create_augroup("amaan_" .. name, { clear = true })
end

-- Open NvimTree on startup
vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup("nvim_tree"),
  callback = function()
    require("nvim-tree.api").tree.open()
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.api.nvim_get_current_tabpage()
    vim.cmd("tabdo wincmd =")
    vim.api.nvim_set_current_tabpage(current_tab)
  end,
})
