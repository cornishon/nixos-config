{ ... }: {
  imports = [ ./helix ];

  programs = {
    bat.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # without bash home-manager can't source session variables
    bash.enable = true;

    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        # set -q ZELLIJ || zellij attach --create
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

    htop = {
      enable = true;
      settings = {
        sort_direction = true;
        sort_key = "PERCENT_CPU";
      };
    };

    jq.enable = true;

    kitty = {
      enable = true;
      environment.EDITOR = "hx";
      font = {
        name = "JetBrainsMono NF";
        size = 12;
      };
      theme = "Afterglow";
      settings = {
        allow_remote_control = true;
        # include = "current-theme.conf";
        scrollback_lines = 10000;
        enable_audio_bell = false;
        update_check_interval = 0;
        hide_window_decorations = true;
        confirm_os_window_close = 0;
      };
    };

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
