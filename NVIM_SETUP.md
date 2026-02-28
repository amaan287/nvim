# Neovim Setup Overview

This configuration is designed to give Neovim a VSCode-like experience while keeping the speed, flexibility, and composability of native Neovim.

The setup focuses on:
- Modern UI with statusline, tabs, icons, and file explorer
- Full LSP support with hover, signature help, inlay hints
- Fast fuzzy finding and workspace search
- Integrated formatting and linting
- Practical keybindings that mirror common VSCode shortcuts

---

## Core Structure

Entry point:
- `init.lua` – Loads settings, keymaps, plugin manager, and learning module.

Config modules:
- `lua/config/settings.lua` – Editor options and LSP UI behavior.
- `lua/config/keymaps.lua` – All custom keybindings.
- `lua/config/lazy.lua` – Plugin manager and plugin configuration.
- `lua/config/learn.lua` – Custom learning session logic.

---

## Plugin Manager

### lazy.nvim
Used for plugin management.

Why:
- Fast startup with lazy loading
- Clean plugin specification
- Easy updates and dependency handling

---

## UI and Visual Layer

### vscode.nvim (Colorscheme)
Why:
- Familiar VSCode look
- Clean contrast
- Works well with LSP diagnostics

### lualine.nvim
Statusline at the bottom.

Why:
- Lightweight
- Clear mode, branch, diagnostics
- Themed to match VSCode

### bufferline.nvim
Tabs across the top (VSCode-style).

Why:
- Visual buffer switching
- LSP diagnostics per buffer
- Integrated with file explorer

### nvim-tree
File explorer on the left.

Why:
- Fast file navigation
- Git integration
- Opens automatically on startup

### gitsigns.nvim
Git change indicators in the sign column.

Why:
- See added/modified/deleted lines instantly

---

## Search and Navigation

### telescope.nvim
Fuzzy finder and search engine.

Used for:
- File search
- Live grep across project
- Command palette
- In-buffer fuzzy search

Why:
- Extremely fast
- Flexible layouts
- VSCode-like workflows

---

## Syntax and Parsing

### nvim-treesitter
Advanced syntax highlighting and indentation.

Languages installed:
- Lua
- JavaScript
- TypeScript
- Python
- HTML
- CSS
- JSON
- Bash

Why:
- Accurate highlighting
- Better indentation
- Incremental selection support

Incremental selection keymaps:
- `gnn` – Start selection
- `grn` – Expand node
- `grc` – Expand scope
- `grm` – Shrink selection

---

## LSP (Language Server Protocol)

### nvim-lspconfig
Configures language servers.

Enabled servers:
- lua_ls
- gopls
- tsserver
- tailwindcss
- pyright

Features enabled:
- Hover with rounded borders
- Signature help while typing
- Inlay hints (if supported)
- Ctrl+Click go to definition
- Peek definition in floating window

### mason.nvim + mason-lspconfig
Manages installation of LSP servers.

Why:
- Automatic installation
- Consistent dev environment

### none-ls.nvim (null-ls)
Formatting and diagnostics bridge.

Formatters:
- prettier
- gofmt
- black

Diagnostics / Code actions:
- eslint

Why:
- Keeps formatting unified through LSP

---

## Autocompletion

### nvim-cmp
Completion engine.

Sources:
- LSP
- LuaSnip
- Buffer
- Path

Why:
- Fast
- Minimal UI
- Keyboard-driven workflow

Completion keys:
- `Enter` – Confirm selection
- `Tab` – Next item
- `Shift+Tab` – Previous item
- `Ctrl+k` – Show docs (when menu open)

---

## Terminal Integration

### toggleterm.nvim
Integrated terminal inside Neovim.

Why:
- Run builds/tests without leaving editor
- Horizontal split like VSCode terminal

---

## Multi-Cursor

### vim-visual-multi
VSCode-like multi-cursor editing.

Keybindings:
- `Ctrl+d` – Select next occurrence
- `Ctrl+Up/Down` – Add cursor above/below

---

## Editor Settings

Key defaults:
- Relative line numbers
- 4-space indentation
- expandtab enabled
- Smart case search
- System clipboard enabled
- Split right and below
- Signcolumn always visible
- Cursorline enabled
- No line wrap

LSP behavior:
- Hover only triggers on mouse hover
- Signature help while typing
- Rounded floating window borders

---

## Keybindings

Leader key:
- `Space`

File Operations:
- `Ctrl+s` – Save
- `Ctrl+q` – Quit
- `Ctrl+w` – Close current tab
- `Ctrl+a` – Select all

Explorer:
- `Ctrl+b` – Toggle file explorer

Search:
- `Ctrl+f` – Search in current file
- `Ctrl+Shift+f` – Search in workspace
- `Alt+Space` – Quick file open
- `Ctrl+Shift+p` – Command palette

Buffer Navigation:
- `Shift+l` – Next tab
- `Shift+h` – Previous tab
- `Alt+Left/Right` – Navigate tabs

Terminal:
- `Ctrl+j` – Toggle terminal

Code Navigation:
- `Ctrl+Click` – Go to definition
- `Alt+F12` – Peek definition

Editing:
- `Ctrl+Shift+Up/Down` – Duplicate line
- `Alt+Up/Down` – Move line
- `<` / `>` in visual mode – Stay-indented shifting

Learning Mode:
- `<leader>ls` – Start session
- `<leader>le` – End session

---

## Startup Behavior

On launch:
- File explorer opens automatically
- Colorscheme loads
- LSP ready if server available

---

## Philosophy

This setup aims to:
- Feel familiar to VSCode users
- Preserve Vim modal power
- Keep performance high
- Minimize unnecessary UI noise
- Stay keyboard-centric

It balances modern IDE features with Neovim's minimal core.
