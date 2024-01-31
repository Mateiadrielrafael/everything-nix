{ lib, ... }: {
  options.satellite.proxy = {
    type = lib.types.functionTo lib.types.anything;
    description = "Helper function for generating a quick proxy config";
  };

  config.satellite.proxy = port: {
    enableACME = true;
    acmeRoot = null;
    forceSSL = true;
    locations."/".proxyPass = "http://127.0.0.1:${toString port}";
  };
}
