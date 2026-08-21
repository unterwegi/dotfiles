---@module 'hl'

hl.config({
    input = {
        kb_layout = "de",
        kb_variant = "nodeadkeys",
        follow_mouse = 1,
        sensitivity = 0,
    },
    general = {
        gaps_in = 5,
        gaps_out = 5,
    },
    misc = {
        disable_hyprland_logo = true,
        vrr = 2,
    },
    ecosystem = {
        no_update_news = true,
    },
})

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("wayle panel start")
    hl.exec_cmd("hyprlauncher -d")
    hl.exec_cmd("uwsm app -- ~/.local/libexec/polkit-agent")
    hl.exec_cmd("uwsm app -- swaybg -o \\* -i ~/.config/wallpaper.png -m fill")
    hl.exec_cmd("uwsm app -- ~/.cargo/bin/clipboard-sync")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)

require("keybindings")
require("window-rules")

-- Added by hyprmoncfg: its generated monitor rules load last, so nothing before this can override the applied layout.
dofile((os.getenv("XDG_CONFIG_HOME") or os.getenv("HOME") .. "/.config") .. "/hypr/hyprmoncfg-monitors.lua")
