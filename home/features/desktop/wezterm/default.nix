{ pkgs, config, ... }: {
  home.packages = [ pkgs.wezterm ];

  # Create link to config
  xdg.configFile."wezterm/colorscheme.lua".text = config.satellite.colorscheme.lua;
  xdg.configFile."wezterm/wezterm.lua".source =
    config.satellite.dev.path "home/features/desktop/wezterm/wezterm.lua";
}