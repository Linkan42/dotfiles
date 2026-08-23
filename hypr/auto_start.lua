hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")

    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("~/.config/hypr/scripts/auto_change_wallpaper.sh ~/Documents/wallpapers/3440x1440 DP-1 900 5400")
    hl.exec_cmd("~/.config/hypr/scripts/auto_change_wallpaper.sh ~/Documents/wallpapers/2160x3840 DP-2 900 5400")
    hl.exec_cmd("~/.config/hypr/scripts/auto_change_wallpaper.sh ~/Documents/wallpapers/2160x3840 HDMI-A-1 900 5400")
end)
