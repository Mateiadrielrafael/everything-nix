let
  user = "adrielus";
  group = "syncthing";
  dataDir = "/persist/data/syncthing";
in
{
  services.syncthing = {
    inherit user group dataDir;
    enable = true;

    openDefaultPorts = true;
    configDir = "/persist/state/home/adrielus/syncthing/.config/syncthing";

    overrideDevices = true;
    overrideFolders = true;

    settings = {
      # {{{ Device ids 
      devices = {
        enceladus.id = "QWOAERM-V2FNXPI-TB7NFUS-LKW7JTB-IZY4OEZ-FYDPJNP-6IKPW4Y-YREXDQM";
        lapetus.id = "VVHM7RC-ZSDOZJI-EGBIJR4-2DOGAXG-OEJZWSH-OYUK5XT-7CDMWSL-3AVM2AZ";
        tethys.id = "NGHX5G4-IY3ZXL2-NQMMRQV-2GDQLC6-LIDWSNG-DAJUAQH-KBAP64V-55K2LQ6";
      };
      # }}}

      extraOptions.options.crashReportingEnabled = false;
    };
  };

  # I'm not sure this is needed anymore, I just know I got some ownership errors at some point.
  systemd.tmpfiles.rules = [ "d ${dataDir} - ${user} ${group} -" ];
}
