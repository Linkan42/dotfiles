local mainMod = "SUPER"
local terminal = "kitty"

-- Basic stuff
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + ESCAPE", hl.dsp.exit())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + V", hl.dsp.window.float())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.kill())

-- Move focus
hl.bind(mainMod .. " + left", hl.dsp.focus({direction = "left"}))
hl.bind(mainMod .. " + right", hl.dsp.focus({direction = "right"}))
hl.bind(mainMod .. " + up", hl.dsp.focus({direction = "up"}))
hl.bind(mainMod .. " + down", hl.dsp.focus({direction = "down"}))

-- Workspace switching
hl.bind(mainMod .. " + 1", hl.dsp.focus({workspace = 1}))
hl.bind(mainMod .. " + 2", hl.dsp.focus({workspace = 2}))
hl.bind(mainMod .. " + 3", hl.dsp.focus({workspace = 3}))
hl.bind(mainMod .. " + 4", hl.dsp.focus({workspace = 4}))
hl.bind(mainMod .. " + 5", hl.dsp.focus({workspace = 5}))
hl.bind(mainMod .. " + 6", hl.dsp.focus({workspace = 6}))
hl.bind(mainMod .. " + 7", hl.dsp.focus({workspace = 7}))
hl.bind(mainMod .. " + 8", hl.dsp.focus({workspace = 8}))
hl.bind(mainMod .. " + 9", hl.dsp.focus({workspace = 9}))
hl.bind(mainMod .. " + 0", hl.dsp.focus({workspace = 10}))

-- Move window to workspace
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({workspace = 1, follow = 1}))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({workspace = 2, follow = 1}))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({workspace = 3, follow = 1}))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({workspace = 4, follow = 1}))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({workspace = 5, follow = 1}))
hl.bind(mainMod .. " + SHIFT + 6", hl.dsp.window.move({workspace = 6, follow = 1}))
hl.bind(mainMod .. " + SHIFT + 7", hl.dsp.window.move({workspace = 7, follow = 1}))
hl.bind(mainMod .. " + SHIFT + 8", hl.dsp.window.move({workspace = 8, follow = 1}))
hl.bind(mainMod .. " + SHIFT + 9", hl.dsp.window.move({workspace = 9, follow = 1}))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({workspace = 10, follow = 1}))

-- Resize active window
hl.bind(mainMod .. " + code:37 + left", hl.dsp.window.resize({ x = -50, y = 0 })) -- code:37 is LCTRL
hl.bind(mainMod .. " + code:37 + right", hl.dsp.window.resize({ x = 50, y = 0 }))
hl.bind(mainMod .. " + code:37 + up", hl.dsp.window.resize({ x = 0, y = -50 }))
hl.bind(mainMod .. " + code:37 + down", hl.dsp.window.resize({ x = 0, y = 50 }))

-- Move floating window
hl.bind(mainMod .. " + ALT + left", hl.dsp.window.move({ x = -50, y = 0 }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.move({ x = 50, y = 0 }))
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.move({ x = 0, y = -50 }))
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.move({ x = 0, y = 50 }))

-- Move window (tiling direction)
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({direction = "left"}))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({direction = "right"}))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({direction = "up"}))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({direction = "down"}))

-- Mouse drag move
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())

-- Audio controls
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))

-- Screenshot
hl.bind(mainMod .. " + CTRL + R", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))
hl.bind(mainMod .. " + CTRL + S", hl.dsp.exec_cmd("grim - | wl-copy"))
hl.bind(mainMod .. " + CTRL + 1", hl.dsp.exec_cmd("grim -o HDMI-A-1 - | wl-copy"))
hl.bind(mainMod .. " + CTRL + 2", hl.dsp.exec_cmd("grim -o DP-1 - | wl-copy"))
hl.bind(mainMod .. " + CTRL + 3", hl.dsp.exec_cmd("grim -o DP-2 - | wl-copy"))

-- Rofi
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("rofi -show run"))

-- Audio toggle script
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle_audio.sh"))
