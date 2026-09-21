# fcitx5-vinput

Voice input for Fcitx5 on Wayland/Hyprland. Offline ASR via sherpa-onnx, with
optional LLM post-processing through an OpenAI-compatible endpoint.

Upstream: https://github.com/xifan2333/fcitx5-vinput

## Layout

| File | Installs to |
| --- | --- |
| `config.json` | `~/.config/vinput/config.json` |
| `fcitx5-vinput.conf` | `~/.config/fcitx5/conf/vinput.conf` |
| `vinput-ptt` | `~/.local/bin/vinput-ptt` |

The Hyprland key bindings live in `../hypr/bindings.lua`.

## Install

```bash
yay -S fcitx5-vinput-bin

vinput init
vinput model add onnx-xasr-zh-en-punct-int8-off   # 130 MB, zh+en, punctuation, hotwords
vinput model use onnx-xasr-zh-en-punct-int8-off

install -m700 -d ~/.config/vinput
install -m600 config.json ~/.config/vinput/config.json
install -m644 fcitx5-vinput.conf ~/.config/fcitx5/conf/vinput.conf
install -m755 vinput-ptt ~/.local/bin/vinput-ptt

systemctl --user enable --now vinput-daemon.service
```

`config.json` ships with `"api_key": "REPLACE_ME"`. Put the real key in with:

```bash
vinput llm edit openai -k sk-...
vinput llm test openai
systemctl --user restart vinput-daemon
```

Never commit the key back: this repo is public, and the file is chmod 600 for a
reason.

## Keys

| Key | Action |
| --- | --- |
| Right Alt | Dictate, post-processed by the active scene |
| Right Ctrl | Hold to talk in Chinese, release to type English |
| Right Shift | Command palette (`/m` model, `/a` ASR, `/s` scene, `/p` adapters) |

Scenes:

| Scene | Behaviour |
| --- | --- |
| `__raw__` | Raw ASR, no network, no LLM |
| `polish` | Fix homophones and punctuation, drop filler words |
| `translate` | Translate to idiomatic English, single result, auto-commit |
| `__command__` | Rewrite selected text by voice (its key is disabled, see below) |

Switch the active scene with `vinput scene use <id>` or Right Shift then `/s`.

## Things that bit me

**Right Ctrl's built-in function is disabled on purpose.** `CommandKeys=` is
empty in `fcitx5-vinput.conf`. The addon's own "rewrite the selection by voice"
feature asks the input method for the active selection and, when that comes back
empty, silently falls back to the PRIMARY selection. Under Wayland applications
do not report a selection range over text-input-v3, so it always took whatever
was last selected with the mouse and fed that stale text to the LLM. There is no
config switch for the fallback, so the key had to go. That freed it for the
Hyprland binding above.

**Editing Fcitx5 config needs the service stopped first.** Fcitx5 writes its
in-memory config on exit, which clobbers a file edited while it runs, and
`pkill fcitx5` just gets it restarted by `omarchy-fcitx5.service`:

```bash
systemctl --user stop omarchy-fcitx5.service
# edit ~/.config/fcitx5/conf/vinput.conf
systemctl --user start omarchy-fcitx5.service
```

An empty key list is written as a flat `CommandKeys=`, not as an empty
`[CommandKeys]` section. Values that differ from the default are written
uncommented, so a round trip through a stop is a cheap way to confirm a setting
was actually loaded.

**Binding a bare modifier key in Hyprland needs two binds.** Press and release
of `Control_R` do not carry the same modmask: press arrives as modmask 0 because
the CTRL bit is not set yet, release arrives as modmask 4 because it still is.
Binding only one variant records forever and never stops. `wtype` is no help for
testing this -- it builds its own keymap where `Control_R` carries no modifier
semantics, so both variants appear to match. Bind a logging wrapper instead and
press the real key once; `vinput-ptt` writes to `~/.local/state/vinput-ptt.log`.

**`vinput scene edit` activates the scene it edits.** Check `vinput scene list`
for the `[*]` marker after every edit.

**`vinput rec stop --scene <id>` is a single-shot override** and leaves the
global active scene alone. That is the whole reason one key can translate while
another polishes -- the addon itself has no key-to-scene mapping.

**Reasoning models reject `temperature`.** vinput hardcodes `temperature=0.2`,
which newer models refuse with `HTTP 400 unsupported_value`. A provider's
`extra_body` can carry `{"temperature": 1}`, though the daemon does keep a list
of protected keys it refuses to override, so this is not guaranteed to work.
The `openai-luna` provider in `config.json` is set up that way but is not in use.

## Debugging

```bash
journalctl --user -u vinput-daemon -f    # ASR, VAD and LLM errors
cat ~/.local/state/vinput-ptt.log        # which bind variant fired
vinput daemon status
vinput model list
vinput device list
```
