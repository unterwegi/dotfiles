---@module 'hl'
hl.bind("SUPER" .. " + " .. "Q", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER" .. " + " .. "R", hl.dsp.exec_cmd("hyprlauncher"))
hl.bind("SUPER" .. " + " .. "C", hl.dsp.window.close())
hl.bind("SUPER" .. " + " .. "M", hl.dsp.exit())
hl.bind("SUPER" .. " + " .. "E", hl.dsp.exec_cmd("thunar"))
hl.bind("SUPER" .. " + " .. "O", hl.dsp.window.float())
hl.bind("SUPER" .. " + " .. "F", hl.dsp.window.fullscreen())
hl.bind("CTRL + ALT" .. " + " .. "L", hl.dsp.exec_cmd("hyprlock"))

-- focus movement
hl.bind("SUPER" .. " + " .. "H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER" .. " + " .. "L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER" .. " + " .. "K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER" .. " + " .. "J", hl.dsp.focus({ direction = "down" }))

for i = 1, 9 do
    -- Switch workspaces with SUPER + [0-9]
    hl.bind("SUPER" .. " + " .. i, hl.dsp.focus({ workspace = i, on_current_monitor = true }))
    -- Move active window to a workspace with SUPER + SHIFT + [0-9]
    hl.bind("SUPER" .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Screenshots
hl.bind("SUPER" .. " + " .. "S", hl.dsp.exec_cmd("grim -g \"$(slurp -d)\"-| wl-copy"))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind("SUPER" .. " + " .. "mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER" .. " + " .. "mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 5"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 5"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
