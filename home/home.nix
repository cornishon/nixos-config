{ pkgs, lib, ... }:
let
  username = "adamz";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";

  gnomeExtensions = with pkgs.gnomeExtensions; [
    appindicator
    just-perfection
    night-theme-switcher
    power-profile-switcher
    switcher
    resource-monitor
    rounded-window-corners
    forge
  ];

  myPackages = with pkgs; [
    any-nix-shell # fish support for nix shell
    blackbox-terminal # terminal for gnome
    chafa # terminal sixel-powered image viewer
    gammastep # Screen color temperature manager
    gnome.dconf-editor # graphical frontend for dconf
    gvfs # virtual filesystem support library
    exa # ls replacement
    fd # find replacement
    killall # kill all processes matching a name
    libnotify # notify-send command
    nixfmt # formatting for nix code
    playerctl # music player controlle
    ripgrep # fast grep
    tldr # summary of a man page
    tree # display files in a tree view
    zellij # terminal workspace
  ];

in {
  programs.home-manager.enable = true;

  imports = [ ./programs ];

  home = {
    inherit username homeDirectory;

    packages = myPackages ++ gnomeExtensions;

    sessionVariables = { };

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.05";
  };

  xdg = {
    inherit configHome;
    enable = true;
  };
}
