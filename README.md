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

## hyprland (Omarchy)

Omarchy 的 Hyprland 配置是 Lua，用户文件在 Omarchy 默认配置之后加载，所以
`hypr/` 下的文件是覆盖层，直接拷过去即可：

    cp hypr/input.lua "${XDG_CONFIG_HOME:-$HOME/.config}"/hypr/input.lua
    hyprctl reload && hyprctl configerrors

`input.lua` 里的内容：

- Ctrl / Caps Lock 对调（替换 Omarchy 默认的 `compose:caps`），HHKB 因为硬件
  已经调过所以单独排除
- 外接鼠标降速：`accel_profile = "flat"` + `sensitivity = -0.6`

注意两点：

- `hl.device` 里的设备名是本机 `hyprctl devices -j` 的输出，换机器/换外设后
  要重新对一遍，名字对不上就是静默不生效
- 调指针速度必须同时设 `accel_profile = "flat"`，否则默认的 adaptive 加速
  曲线会在快速移动时把位移放大回去，光调 `sensitivity` 几乎没有手感变化
