local M = {}
M.enabled = true
function M.toggle()
  local bufnr = vim.api.nvim_get_current_buf()
  if M.enabled then
    vim.treesitter.stop(bufnr)
    vim.cmd("syntax on")
    M.enabled = false
    print("Treesitter OFF")
  else
    vim.treesitter.start(bufnr)
    M.enabled = true
    print("Treesitter ON")
  end
end
return M
