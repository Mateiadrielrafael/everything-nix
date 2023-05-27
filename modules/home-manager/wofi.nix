# Temporary copy of [this](https://github.com/nix-community/home-manager/blob/master/modules/programs/wofi.nix)
# until the next home manager relase.
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.wofi;

  toConfig = attrs:
    ''
      # Generated by Home Manager.
    '' + generators.toKeyValue { }
    (filterAttrs (name: value: value != null) attrs);
in {
  meta.maintainers = [ maintainers.christoph-heiss ];

  options.programs.wofi = {
    enable = mkEnableOption
      "wofi: a launcher/menu program for wlroots based wayland compositors such as sway";

    package = mkPackageOption pkgs "wofi" { };

    settings = mkOption {
      default = { };
      type = types.attrs;
      description = ''
        Configuration options for wofi. See
        <citerefentry>
          <refentrytitle>wofi</refentrytitle>
          <manvolnum>5</manvolnum>
        </citerefentry>.
      '';
      example = literalExpression ''
        {
          location = "bottom-right";
          allow_markup = true;
          width = 250;
        }
      '';
    };

    style = mkOption {
      default = null;
      type = types.nullOr types.str;
      description = ''
        CSS style for wofi to use as a stylesheet. See
        <citerefentry>
          <refentrytitle>wofi</refentrytitle>
          <manvolnum>7</manvolnum>
        </citerefentry>.
      '';
      example = ''
        * {
            font-family: monospace;
        }

        window {
            background-color: #7c818c;
        }
      '';
    };
  };

  config = mkIf cfg.enable {
    assertions =
      [ (hm.assertions.assertPlatform "programs.wofi" pkgs platforms.linux) ];

    home.packages = [ cfg.package ];

    xdg.configFile = mkMerge [
      (mkIf (cfg.settings != { }) {
        "wofi/config".text = toConfig cfg.settings;
      })
      (mkIf (cfg.style != null) { "wofi/style.css".text = cfg.style; })
    ];
  };
}