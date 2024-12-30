{...}: {
  # Source aerospace config from the home-manager store
  home.file.".aerospace.toml".text = ''
    # Start AeroSpace at login
    start-at-login = true

    # Normalization settings
    enable-normalization-flatten-containers = true
    enable-normalization-opposite-orientation-for-nested-containers = true

    # Accordion layout settings
    accordion-padding = 30

    # Default root container settings
    default-root-container-layout = 'tiles'
    default-root-container-orientation = 'auto'

    # Mouse follows focus settings
    on-focused-monitor-changed = ['move-mouse monitor-lazy-center']
    on-focus-changed = ['move-mouse window-lazy-center']

    # Automatically unhide macOS hidden apps
    automatically-unhide-macos-hidden-apps = true

    # Key mapping preset
    [key-mapping]
    preset = 'qwerty'

    # Gaps settings
    [gaps]
    inner.horizontal = 6
    inner.vertical =   6
    outer.left =       6
    outer.bottom =     6
    outer.top =        6
    outer.right =      6

    # Main mode bindings
    [mode.main.binding]
    # Launch applications
    alt-shift-enter = 'exec-and-forget open -na alacritty'
    alt-shift-b = 'exec-and-forget open -a "Brave Browser"'
    # alt-shift-t = 'exec-and-forget open -a "Telegram"'
    alt-shift-f = 'exec-and-forget open -a Finder'
    alt-shift-o = 'exec-and-forget open -a Obsidian'

    # Window management
    alt-q = "close"
    alt-slash = 'layout tiles horizontal vertical'
    alt-comma = 'layout accordion horizontal vertical'
    alt-m = 'fullscreen'

    # Focus movement
    alt-h = 'focus left'
    alt-j = 'focus down'
    alt-k = 'focus up'
    alt-l = 'focus right'

    # Window movement
    alt-shift-h = 'move left'
    alt-shift-j = 'move down'
    alt-shift-k = 'move up'
    alt-shift-l = 'move right'

    # Resize windows
    alt-shift-minus = 'resize smart -50'
    alt-shift-equal = 'resize smart +50'

    # Workspace management
    ctrl-1 = 'workspace 1'
    ctrl-2 = 'workspace 2'
    ctrl-3 = 'workspace 3'
    ctrl-4 = 'workspace 4'
    ctrl-5 = 'workspace 5'
    ctrl-6 = 'workspace 6'
    ctrl-7 = 'workspace 7'
    ctrl-8 = 'workspace 8'
    ctrl-9 = 'workspace 9'

    # Move windows to workspaces
    ctrl-shift-1 = 'move-node-to-workspace 1'
    ctrl-shift-2 = 'move-node-to-workspace 2'
    ctrl-shift-3 = 'move-node-to-workspace 3'
    ctrl-shift-4 = 'move-node-to-workspace 4'
    ctrl-shift-5 = 'move-node-to-workspace 5'
    ctrl-shift-6 = 'move-node-to-workspace 6'
    ctrl-shift-7 = 'move-node-to-workspace 7'
    ctrl-shift-8 = 'move-node-to-workspace 8'
    ctrl-shift-9 = 'move-node-to-workspace 9'

    # Workspace navigation
    alt-tab = 'workspace-back-and-forth'
    alt-shift-tab = 'move-workspace-to-monitor --wrap-around next'

    # Enter service mode
    alt-shift-semicolon = 'mode service'

    # Service mode bindings
    [mode.service.binding]
    # Reload config and exit service mode
    esc = ['reload-config', 'mode main']

    # Reset layout
    r = ['flatten-workspace-tree', 'mode main']

    # Toggle floating/tiling layout
    f = ['layout floating tiling', 'mode main']

    # Close all windows but current
    backspace = ['close-all-windows-but-current', 'mode main']

    # Join with adjacent windows
    alt-shift-h = ['join-with left', 'mode main']
    alt-shift-j = ['join-with down', 'mode main']
    alt-shift-k = ['join-with up', 'mode main']
    alt-shift-l = ['join-with right', 'mode main']

    # Window detection rules
    [[on-window-detected]]
    if.app-id = 'com.brave.Browser'
    run = 'move-node-to-workspace 1'

    [[on-window-detected]]
    if.app-id = 'org.alacritty'
    run = 'move-node-to-workspace 2'

    [[on-window-detected]]
    if.app-id = 'com.tdesktop.Telegram'
    run = 'move-node-to-workspace 3'

    [[on-window-detected]]
    if.app-id = 'com.obsproject.obs-studio'
    run = 'move-node-to-workspace 4'

    [[on-window-detected]]
    if.app-id = 'us.zoom.xos'
    run = 'move-node-to-workspace 5'
  '';
}
