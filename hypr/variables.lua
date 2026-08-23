hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 5,
    border_size = 2,

    col = {
      active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
      inactive_border = "rgba(595959aa)",
    },

    resize_on_border = true,
    allow_tearing = false,
    layout = "dwindle",
  },

  decoration = {
    rounding = 10,
    active_opacity = 1.0,
    inactive_opacity = 1.0,
  },

  input = {
    kb_layout = "se",
    follow_mouse = 1,
    sensitivity = 0,
  },

  misc = {
    force_default_wallpaper = 1,
    disable_splash_rendering = true,
    middle_click_paste = false,
  },
})
