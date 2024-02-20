{...}: {
  # Manage dconf via Home-manager
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/wm/preferences" = {
        button-layout = "";
      };
      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "list-view";
        search-view = "list-view";
      };
      "org/gnome/Weather" = {
        locations = "[<(uint32 2, <('Warsaw', 'EPWA', true, [(0.91048009894147275, 0.36593737231924195)], [(0.91193453416703718, 0.36651914291880922)])>)>]";
      };
      "org/gnome/calculator" = {
        button-mode = "financial";
      };
    };
  };
}