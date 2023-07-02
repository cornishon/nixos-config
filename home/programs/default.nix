{ pkgs, ... }:

{
  programs = {
    bat.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        set -q ZELLIJ || zellij attach --create
        command -q any-nix-shell && any-nix-shell fish --info-right | source
        command -q zoxide && zoxide init fish | source
      '';
      plugins = [ ];
    };

    fzf = {
      enable = true;
      enableFishIntegration = true;
      defaultCommand = "fd --type file --follow"; # FZF_DEFAULT_COMMAND
      defaultOptions = [ "--height 20%" ]; # FZF_DEFAULT_OPTS
      fileWidgetCommand = "fd --type file --follow"; # FZF_CTRL_T_COMMAND
    };

    helix = import ./helix.nix;

    htop = {
      enable = true;
      settings = {
        sort_direction = true;
        sort_key = "PERCENT_CPU";
      };
    };

    jq.enable = true;

    lazygit.enable = true;

    starship = {
      enable = true;
      enableTransience = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = [ ];
    };

  };
}
