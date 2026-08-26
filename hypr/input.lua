-- Keep only your personal input overrides here. Uncommented settings below
-- replace Omarchy's defaults.

-- Keyboard layout and options.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
-- hl.config({
--   input = {
--     -- Use multiple keyboard layouts and switch between them with Left Alt + Right Alt.
--     kb_layout = "us,dk,eu",
--     kb_options = "compose:caps,shift:both_capslock_cancel,grp:alts_toggle",
--
--     -- Use a specific keyboard variant if needed (e.g. intl for international keyboards).
--     kb_variant = "intl",
--
--     -- Change speed of keyboard repeat.
--     repeat_rate = 40,
--     repeat_delay = 250,
--
--     -- Start with numlock on by default.
--     numlock_by_default = true,
--
--     -- Increase sensitivity for mouse/trackpad (default: 0).
--     sensitivity = 0.35,
--
--     -- Turn off mouse acceleration (default: adaptive).
--     accel_profile = "flat",
--
--     touchpad = {
--       -- Use natural (inverse) scrolling.
--       natural_scroll = true,
--
--       -- Use two-finger clicks for right-click instead of lower-right corner.
--       clickfinger_behavior = true,
--
--       -- Control the speed of your scrolling.
--       scroll_factor = 0.4,
--
--       -- Enable the touchpad while typing.
--       disable_while_typing = false,
--
--       -- Left-click-and-drag with three fingers.
--       drag_3fg = 1,
--     },
--   },
-- })

-- App-specific touchpad scroll speeds.
-- o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.5 })
-- o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })

-- Enable touchpad gestures for changing workspaces.
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
-- hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Enable touchpad gestures for moving focus (helpful on scrolling layout).
-- hl.gesture({ fingers = 3, direction = "left", action = function() hl.dispatch(hl.dsp.focus({ direction = "l" })) end })
-- hl.gesture({ fingers = 3, direction = "right", action = function() hl.dispatch(hl.dsp.focus({ direction = "r" })) end })

-- Swap Ctrl and Caps Lock.
-- Note: this replaces Omarchy's default "compose:caps" (Caps Lock as Compose key).
hl.config({
  input = {
    kb_options = "ctrl:swapcaps,shift:both_capslock_cancel",
  },
})

-- HHKB (external USB) already swaps Ctrl/Caps Lock in hardware, so skip the
-- software swap for it. Keep the rest of the global options.
-- Device name from: hyprctl devices -j
hl.device({
  name = "topre-corporation-hhkb-professional",
  kb_options = "shift:both_capslock_cancel",
})

-- 外接鼠标：调低灵敏度。
-- accel_profile = "flat" 关掉自适应加速，sensitivity 变成统一的速度缩放
-- （范围 -1.0 ~ 1.0，0 为原始 1:1，负值更慢）。
-- 两个 USB 接收器都设上，笔记本触摸板和小红点不受影响。
-- 设备名来自：hyprctl devices -j
for _, mouse in ipairs({
  "telink-wireless-device-mouse",
  "mosart-semi.-2.4g-keyboard-mouse-1",
}) do
  hl.device({
    name = mouse,
    accel_profile = "flat",
    sensitivity = -0.6,
  })
end
