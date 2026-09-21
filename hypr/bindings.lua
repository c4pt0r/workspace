-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Close window, in addition to the default SUPER + W.
o.bind("SUPER + SHIFT + Q", "Close window", hl.dsp.window.close())

-- Unbind existing SUPER + P (was: Pseudo window)
hl.unbind("SUPER + P")
-- Open the Omarchy menu/launcher, same as SUPER + SPACE
o.bind("SUPER + P", "Omarchy menu", "omarchy-menu toggle")

-- Unbind existing SUPER + SHIFT + P (was: Google Photos webapp)
hl.unbind("SUPER + SHIFT + P")
-- Move Pseudo window here, since SUPER + P now opens the Omarchy menu
o.bind("SUPER + SHIFT + P", "Pseudo window", hl.dsp.window.pseudo())

-- Voice input: hold Right Ctrl, speak Chinese, release to get English on screen.
-- Right Ctrl is a modifier, so Hyprland reports a different modmask for its
-- press and release (verified empirically):
--   press   -> modmask 0 (the CTRL bit is not set yet)
--   release -> modmask 4 (the CTRL bit is still set)
-- Hence: press binds plain, release binds the CTRL variant. The third bind is a
-- fallback in case a release ever arrives with modmask 0.
-- vinput-ptt guards on idle/recording state, so duplicate triggers are safe.
o.bind("Control_R",        "Voice zh->en (hold to talk)", "/home/dongxu/.local/bin/vinput-ptt start press")
o.bind("CTRL + Control_R", "Voice zh->en (release)",      "/home/dongxu/.local/bin/vinput-ptt stop release-ctrl", { release = true })
o.bind("Control_R",        "Voice zh->en (release alt)",  "/home/dongxu/.local/bin/vinput-ptt stop release-plain", { release = true })
