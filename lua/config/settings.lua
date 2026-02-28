local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

opt.wrap = false
opt.cursorline = true

opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.signcolumn = "yes"

opt.splitright = true
opt.splitbelow = true

opt.clipboard = "unnamedplus"
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

-- Hover ONLY on mouse hover (not keyboard cursor move)
local hover_timer = nil

vim.api.nvim_create_autocmd("CursorMoved", {
  callback = function()
    local mouse = vim.fn.getmousepos()
    if mouse.winid ~= vim.api.nvim_get_current_win() then
      return
    end

    local mouse_line = mouse.line
    local cursor_line = vim.fn.line(".")

    -- Trigger hover only if cursor moved via mouse
    if mouse_line == cursor_line then
      if hover_timer then
        vim.fn.timer_stop(hover_timer)
      end

      hover_timer = vim.fn.timer_start(120, function()
        vim.schedule(function()
          vim.lsp.buf.hover()
        end)
      end)
    end
  end,
})

-- Signature help while typing
vim.api.nvim_create_autocmd("InsertCharPre", {
  callback = function()
    vim.lsp.buf.signature_help()
  end,
})
