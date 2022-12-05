{ lib, pkgs, ... }:
let
  shellAliases = import ./aliases.nix;
  common = import ./common.nix;

  globalTheme = pkgs.myThemes.current;
  theme = "dangerous";
  themePackage = builtins.getAttr theme pkgs.myFishPlugins.themes; # Dynamically pick the theme path

  defaultDangerousColors = "000000 333333 666666 ff4ff0 0088ff ff6600 ff0000 ff0033 3300ff 0000ff 00ffff 00ff00";
  dangerousColors = globalTheme.fish.dangerousColors or defaultDangerousColors;
in
{
  users.defaultUserShell = pkgs.fish;
  home-manager.users.adrielus = {
    programs.command-not-found.enable = false;
    programs.nix-index.enable = true;

    # Source every file in the theme 
    xdg.configFile."fish/conf.d/plugin-${theme}.fish".text = lib.mkAfter ''
      for f in $plugin_dir/*.fish
        source $f
      end
    '';

    programs.fish = {
      inherit shellAliases;

      enable = true;
      plugins = with pkgs; [
        myFishPlugins.z # jump around the file system with ease (might replace with autojump)
        themePackage # theme 
      ];

      shellInit = ''
        source ${../../../dotfiles/fish/config.fish}

        # Source the entire oh-my-fish lib
        for f in ${pkgs.myFishPlugins.oh-my-fish}/lib/git/**/*.fish 
          source $f
        end


        ${if theme == "dangerous" 
           then "set dangerous_colors ${dangerousColors}" 
           else ""}

        ${common.shellInit}
      '';
    };
  };
}
