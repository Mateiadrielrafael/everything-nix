{ pkgs, ... }: {
  home-manager.users.adrielus.home.packages = with pkgs; [
    elan # lean version manager
  ];
}
