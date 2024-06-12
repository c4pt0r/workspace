# workspace

some configurations

## neovim

Install External Dependencies

External Requirements:

    Basic utils: git, make, unzip, C Compiler (gcc)
    ripgrep
    Clipboard tool (xclip/xsel/win32yank or other depending on platform)
    A Nerd Font: optional, provides various icons
        if you have it set vim.g.have_nerd_font in init.lua to true
    Language Setup:
        If want to write Typescript, you need npm
        If want to write Golang, you will need go
        etc.

    NOTE See Install Recipes for additional Windows and Linux specific notes and quick install snippets


// lsp python
npm i -g pyright

// ripgrep 

git clone https://github.com/c4pt0r/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
