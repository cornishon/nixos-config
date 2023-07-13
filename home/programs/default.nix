{ pkgs, config, inputs, ... }: {
  imports = [ ./neovim ./hyprland ./waybar ];

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
        fish_hybrid_key_bindings # vi bindings without sacrificing the useful emacs ones
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

    htop = with config.lib.htop.fields; {
      enable = true;
      settings = {
        sort_key = PERCENT_CPU;
        show_program_path = 0;
        fields = [
          PID
          USER
          PRIORITY
          NICE
          M_RESIDENT
          STATE
          PERCENT_CPU
          PERCENT_MEM
          TIME
          COMM
        ];
      };
    };

    jq.enable = true;

    kitty = {
      enable = true;
      environment.EDITOR = "nvim";
      font = {
        name = "JetBrainsMono NF";
        size = 12;
      };
      theme = "Gruvbox Dark Hard";
      settings = {
        allow_remote_control = true;
        include = "current-theme.conf";
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
      #enableTransience = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = [ ];
    };
  };
}
