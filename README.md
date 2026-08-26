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
`hypr/` 下的文件是覆盖层，拷过去即可：

    cp hypr/*.lua "${XDG_CONFIG_HOME:-$HOME/.config}"/hypr/
    hyprctl reload && hyprctl configerrors

只收了相对 Omarchy 默认模板（`/usr/share/omarchy/config/hypr/`）有改动的文件；
`looknfeel.lua`、`hyprsunset.conf`、`xdph.conf` 与默认一致，没必要备份。

| 文件 | 内容 |
| --- | --- |
| `input.lua` | Ctrl / Caps Lock 对调（替换默认的 `compose:caps`），HHKB 因硬件已调过而单独排除；外接鼠标降速 |
| `bindings.lua` | `SUPER+SHIFT+Q` 关窗口；`SUPER+P` 改成开 Omarchy 菜单，原本的 Pseudo window 挪到 `SUPER+SHIFT+P` |
| `hyprland.lua` | DOSBox 窗口浮动并锁 4:3（1536x1152），否则平铺成竖条画面只剩中间一小块 |
| `autostart.lua` | 开机起 `caffeine-tray`（托盘防休眠开关） |
| `monitors.lua` | **本机专用**：缩放写死 `2`（默认是 `auto`）。换机器前先改回 `auto` 再 apply |

几个坑：

- `hl.device` 里的设备名是本机 `hyprctl devices -j` 的输出，换机器/换外设后要重新
  对一遍，名字对不上是静默不生效，不会报错
- 调指针速度必须同时设 `accel_profile = "flat"`，否则默认的 adaptive 加速曲线会在
  快速移动时把位移放大回去，光调 `sensitivity` 几乎没有手感变化
- 改键位前先看现有绑定 `omarchy menu keybindings --print`，占用的键要先 `hl.unbind`
