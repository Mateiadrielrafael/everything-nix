{ lib, ... }:
let
  port = 8401;
  websiteBlocklist = [
    "www.saashub.com/"
    "slant.co"
    "nix-united.com"
    "libhunt.com"
  ];
in
{
  imports = [ ../../common/optional/podman.nix ];

  networking.firewall.allowedTCPPorts = [ port ];
  virtualisation.oci-containers.containers.whoogle-search = {
    image = "benbusby/whoogle-search";
    autoStart = true;
    ports = [ "${toString port}:5000" ]; # server:docker
    environment = {
      WHOOGLE_UPDATE_CHECK = "0";
      WHOOGLE_CONFIG_DISABLE = "0";
      WHOOGLE_CONFIG_BLOCK = lib.concatStringsSep "," websiteBlocklist;
      WHOOGLE_CONFIG_THEME = "system";
    };
  };
}
