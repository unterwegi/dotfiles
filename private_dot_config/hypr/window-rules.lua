---@module 'hl'

-- hide borders when only one window is visible

hl.workspace_rule({
    workspace = "w[tv1]",
    gaps_out = 0,
    gaps_in = 0,
})

hl.workspace_rule({
    workspace = "f[1]",
    gaps_out = 0,
    gaps_in = 0,
})

hl.window_rule({
    match       = {
        float = 0,
        workspace = "w[tv1]",
    },
    border_size = 0,
    rounding = 0,
})

hl.window_rule({
    match       = {
        float = 0,
        workspace = "f[1]",
    },
    border_size = 0,
    rounding = 0,
})

hl.window_rule({
    name      = "steam_on_ws_1",
    match     = {
        class = "(steam)(.*)$",
    },
    workspace = 1,
})
