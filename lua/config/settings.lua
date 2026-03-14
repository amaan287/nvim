local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

opt.wrap = false
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8

opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.signcolumn = "yes"

opt.splitright = true
opt.splitbelow = true

opt.clipboard = "unnamedplus"

-- Allow arrow keys to wrap between lines
opt.whichwrap:append("<,>,h,l")

-- Code Folding (UFO)
opt.foldcolumn = "1" -- Fixed width to prevent UI jumping
opt.fillchars = [[eob: ,fold: ,foldopen:,foldclose:]] -- VSCode-like icons
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
-- Smooth LSP hover & bordered windows (VSCode style)
vim.o.updatetime = 250

local border = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = border }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = border }
)


