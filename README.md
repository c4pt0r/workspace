# workspace

some configurations

## neovim

The actual nvim config lives in its own repo (a kickstart.nvim fork), not here:

    git clone https://github.com/c4pt0r/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

External requirements:

- Basic utils: git, make, unzip, C compiler (gcc/clang)
- ripgrep
- `tree-sitter` CLI — required by nvim-treesitter's `main` branch to compile parsers
  - macOS: `brew install tree-sitter-cli` (note: the `tree-sitter` formula only ships the library, not the CLI)
  - Arch: `pacman -S tree-sitter-cli`
- Clipboard tool (xclip/xsel/win32yank or other depending on platform)
- A Nerd Font: optional, provides various icons; if you have it, set `vim.g.have_nerd_font` in init.lua to true
- Python LSP: `npm i -g pyright`
