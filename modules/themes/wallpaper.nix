# Tutorial regarding this:
# https://www.codyhiar.com/blog/how-to-set-desktop-wallpaper-on-nixos/
{ pkgs, config, ... }: {
  home-manager.users.adrielus = {
    home.packages = with pkgs; [ xwallpaper ];
    xdg.configFile."wallpaper".source = pkgs.myThemes.current.wallpaper;
    xsession = {
      enable = true;
      initExtra = ''
        xwallpaper --zoom ~/.config/wallpaper
      '';
    };
  };

}
