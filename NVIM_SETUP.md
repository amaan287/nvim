# Neovim Setup Overview

This configuration is designed to give Neovim a premium, production-grade experience with a "Charcoal" dark aesthetic and modular architecture. It bridges the gap between the intuitiveness of modern IDEs and the raw power of Neovim.

---

## 🏗️ Core Architecture (Clean Code)

The setup follows a modular design for maintainability and speed.

### Structure
- `init.lua` – System entry point.
- `lua/config/` – Core editor logic:
  - `settings.lua` – Vim options and UI behaviors.
  - `keymaps.lua` – All custom shortcuts.
  - `lazy.lua` – Plugin manager orchestrator.
  - `autocmds.lua` – Centralized automated behaviors.
- `lua/plugins/` – Modular plugin specifications (Auto-imported):
  - `ui.lua` – Theme, statusline, tabs, and dashboard.
  - `lsp.lua` – Intelligence, autocompletion, and formatting.
  - `editor.lua` – Navigation, explorer, terminal, and search.
  - `git.lua` – Worktrees, diffs, and staging.
  - `coding.lua` – Treesitter, folding (UFO), and syntax logic.

---

## 🎨 Aesthetic & UI (Premium Charcoal)

### Catppuccin Mocha (Custom Charcoal)
- Fixed background to `#151616` across all views (Explorer, Diffs, Code).
- High-contrast, soft syntax highlighting with italics for modern feel.

### Luxury Visuals
- **mini.animate**: Smooth, high-end motion for scrolling, resizing, and opening windows.
- **lualine.nvim**: Sleek statusline with breadcrumbs (`navic`) showing your code location.
- **bufferline.nvim**: Premium horizontal tabs with diagnostics and close-on-hover logic.
- **alpha-nvim**: Professional ASCII dashboard on startup.

---

## 🧠 Intelligence & Engineering

### LSP & Completion
- **LSP Config**: Pre-configured for Lua, Go, JS/TS, Python, and Tailwind.
- **Autocompletion**: `nvim-cmp` with modern icons and bordered windows.
- **none-ls**: Auto-formatting on save using Prettier, Black, and Stylua.

### Enhanced Navigation
- **Aerial**: Visual code outline (`<leader>o`) to see functions/classes at a glance.
- **UFO**: VSCode-grade code folding with "Peek" support (press `K` on a fold).
- **markview.nvim**: Real-time "Obsidian-style" rendering for Markdown files.
- **Spectre**: Global search and replace UI with live previews.

---

## 🐙 Git Power-User Workflow

- **Neogit**: Full-scale Git dashboard (`<leader>gg`).
- **Diffview**: Side-by-side global diffs and permanent file history timelines.
- **Worktree**: Manage multiple branch checkouts simultaneously via Telescope (`<leader>gw`).
- **Gitsigns**: Inline hunk indicators and change tracking.

---

## ⌨️ Essential Keybindings

| Category | Mapping | Action |
| :--- | :--- | :--- |
| **Explorer** | `Ctrl + b` | Toggle File Explorer |
| **Focus** | `-` | Open Oil (Edit filesystem as text) |
| **Outline** | `<leader>o` | Toggle Code Outline |
| **Search** | `Ctrl + Shift + f` | Global Search (Project) |
| **Command** | `Ctrl + Shift + p` | Command Palette |
| **Folds** | `zR` / `zM` | Open / Close All Folds |
| **Folds** | `K` | Peek into a folded block |
| **Git** | `<leader>gg` | Open Neogit Dashboard |
| **Git** | `<leader>gw` | Manage Git Worktrees |
| **Time** | `<leader>u` | UndoTree (Visual time-machine) |
| **Session** | `<leader>qs` | Restore Last Session |

---

## 🛠️ Automated Behaviors (`autocmds`)
- **Auto-Explorer**: File tree opens automatically on launch.
- **Yank Highlight**: Flashes the text you just copied for visual feedback.
- **Auto-Resize**: Splits automatically re-balance when you resize your terminal window.
- **Format on Save**: Clean code is enforced every time you save.
