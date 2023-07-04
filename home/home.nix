{ pkgs, ... }:
let
  username = "adamz";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";
  packages = with pkgs; [
    any-nix-shell # fish support for nix shell
    exa # ls replacement
    fd # find replacement
    gnomeExtensions.appindicator
    gnomeExtensions.just-perfection
    gnomeExtensions.scroll-panel
    gnomeExtensions.tophat
    gnomeExtensions.night-theme-switcher
    blackbox-terminal # for gnome
    iosevka-comfy.comfy # comfy font for the terminal
    killall # kill all processes matching a name
    libnotify # notify-send command
    nixfmt # formatting for nix code
    playerctl # music player controlle
    ripgrep # fast grep
    rustup # for rust development
    tldr # summary of a man page
    tree # display files in a tree view
    zellij # terminal workspace
  ];
in {
  programs.home-manager.enable = true;

  imports = [ ./programs ];

  home = {
    inherit username homeDirectory packages;

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
