# Linux / WSL Neovim mirror

This is a deliberately stripped Linux/WSL mirror of the main Windows Neovim config in `AppData/Local/nvim`.

Goals:

- Boot quickly on a fresh Linux/WSL machine.
- Keep core editing, plugin manager, Telescope, Treesitter, LSP, completion, git, file tree, statusline, and general keymaps.
- Allow this mirror to lag behind the Windows config.
- Prefer disabling fragile optional features over making every workflow identical.

Notes:

- Apply on Linux via chezmoi so this lands at `~/.config/nvim`.
- The local Python provider is only used if `~/.config/nvim/nvim_venv/bin/python` exists.
- Optional tools such as Verible, Emacs VHDL formatting, toyforth, and Verilog runners should degrade gracefully if unavailable.
- Molten/notebook support is disabled here by default; re-enable it after creating a Linux Python provider environment if needed.
