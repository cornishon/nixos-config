{ prefs, lib, pkgs, ... }@inputs:

{
  xdg.configFile."sway/lockscreen".source = ./lockscreen.png;
  xdg.configFile."sway/wallpaper".source = ./wallpapers/wallpaper-hax.jpg;

  home.packages = with pkgs; [
    # This is pretty much the same as /etc/sway/config.d/nixos.conf [1] but also restarts  
    # some user services [2] to make sure they have the correct environment variables [3]
    # [1] - https://github.com/NixOS/nixpkgs/blob/nixos-22.11/pkgs/applications/window-managers/sway/wrapper.nix#L20
    # [2] - https://wiki.archlinux.org/title/systemd/User#Environment_variables
    # [3] - https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
    (pkgs.writeScriptBin "sway-configure-dbus" ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user restart pipewire wireplumber xdg-desktop-portal xdg-desktop-portal-wlr
    '')

    swaybg
    swaylock
    waybar
    wofi # menu
    wf-recorder
    wl-clipboard
    grim # screenshot
    jq # to process json of current monitor
    slurp # select region for screenshot
    mako # notification daemon
    libnotify # required to use notify-send
    imv
    networkmanagerapplet # needs to be installed to have the systrey icon of nm-applet
    xorg.xrandr # to make games work on correct display
    glfw-wayland # to make native games work
  ];

  # NOTE: 
  # - For swaylock to work, security.pam is configured on the system config
  wayland.windowManager.sway = {
    enable = true;

    # NOTE: This is a "indirect" Systemd integration
    # usefull to make xdg.portal... work
    # https://github.com/swaywm/sway/issues/5160#issuecomment-641173221
    # https://nixos.wiki/wiki/Sway#Systemd_integration
    systemdIntegration = true;
    wrapperFeatures.gtk = true;
    xwayland = true;
    config = rec {

      ##########
      # INPUTS #
      ##########

      # You can get the names of your inputs by running: swaymsg -t get_inputs
      # Read `man 5 sway-input` for more information about this section.
      input = {
        "type:keyboard" = {
          xkb_layout = "pl";
          #repeat_rate = "50";
          #repeat_delay = "150";
          # xkb_options = "lv3:ralt_switch"; # to switch to the 3 level
        };
        "type:mouse" = {
          accel_profile = "flat";
          pointer_accel = "1";
        };
        "type:touchpad" = {
          tap = "enabled";
          pointer_accel = "1";
        };
      };

      ############
      # CRITERIA #
      ############

      #
      # To find about the apps ids:
      # swaymsg -t get_tree
      #

      floating.criteria = [
        { app_id = "pavucontrol"; }
        { app_id = ".telegram-desktop-wrapped"; } # telegram gtk file picker
      ];

      assigns = { };

      ##########
      # DESIGN #
      ##########

      fonts = {
        names = [ "JetBrainsMono NF" ];
        size = 9.0;
      };
      gaps = {
        smartGaps = false;
        inner = 4;
        outer = 0;
        top = 0;
      };
      # output = { "*" = { bg = "~/.background fill"; }; };
      window = {
        border = 1;
        hideEdgeBorders = "none";
      };
      colors =
        # Kanagawa Colorscheme
        # https://github.com/rebelot/kanagawa.nvim
        let bg = "#1F1F28";
        in {
          background = bg;
          focused = rec {
            border = "#957FB8";
            indicator = border;
            childBorder = border;
            background = bg;
            text = "#DCD7BA";
          };
          focusedInactive = rec {
            border = "#FFFFFF00";
            indicator = border;
            childBorder = border;
            background = bg;
            text = "#727169";
          };
          unfocused = rec {
            border = "#FFFFFF00";
            indicator = border;
            childBorder = border;
            background = bg;
            text = "#727169";
          };
          urgent = rec {
            border = "#FF5D62";
            indicator = border;
            childBorder = border;
            background = "#363646";
            text = "#E46876";
          };
        };

      ############
      # BINDINGS #
      ############

      modifier = "Mod4"; # Mod1 -> alt | Mod4 -> Super
      menu =
        "bash 'wofi --show drun,run --lines 12 --prompt \"\" --allow-images --hide-scroll --no-actions --insensitive | xargs swaymsg exec --'";
      terminal = "kitty";
      modes = {
        resize = {
          "${modifier}+Left" = "resize shrink width 10px";
          "${modifier}+Down" = "resize grow height 10px";
          "${modifier}+Up" = "resize shrink height 10px";
          "${modifier}+Right" = "resize grow width 10px";

          # return to default mode
          "${modifier}+Return" = "mode default";
          "${modifier}+Escape" = "mode default";
        };
      };
      keybindings = lib.mkOptionDefault {
        "${modifier}+g" = "floating toggle";
        "${modifier}+m" = "focus mode_toggle";
        "${modifier}+Shift+Escape" =
          "exec swaynag -t warning -m 'Power Menu Options' -b 'Logout' 'swaymsg exit' -b 'Restart' 'shutdown -r now' -b 'Shutdown'  'shutdown -h now' --background=#002b33DD --button-background=#0077b3DD --button-text=#FFFFFF --button-border-size=0 --text=#FFFFFF --border-bottom-size=0 --button-margin-right=10";
        "${modifier}+Shift+l" =
          "exec 'swaylock -f -i ~/.config/sway/lockscreen'";
        # Working with the focused windows
        #
        # You can "split" the current object of your focus with
        "${modifier}+b" = "splith";
        "${modifier}+v" = "splitv";
        # Move to scratchpad
        # Sway has a "scratchpad", which is a bag of holding for windows.
        # You can send windows there and get them back later.
        "${modifier}+y" = "move scratchpad";
        # Show the next scratchpad window or hide the focused scratchpad window.
        # If there are multiple scratchpad windows, this command cycles through them.
        "${modifier}+Shift+y" = "scratchpad show";
        # screenshot
        "${modifier}+p" = ''
          exec grim -t png -l 9 -o $(swaymsg -t get_outputs -r | jq -r '.[] | select(.focused == true) | .name') - > ~/downloads/screenshot.png && notify-send -t 1000 "screenshot saved on ~/downloads"
        '';

        # Brightness
        XF86MonBrightnessDown = "exec light -U 10";
        XF86MonBrightnessUp = "exec light -A 10";

        # Volume
        XF86AudioRaiseVolume =
          "exec 'pactl set-sink-volume @DEFAULT_AUDIO_SINK@ +5%'";
        XF86AudioLowerVolume =
          "exec 'pactl set-sink-volume @DEFAULT_AUDIO_SINK@ -5%'";
        XF86AudioMute =
          "exec 'pactl set-sink-mute @DEFAULT_AUDIO_SINK@ toggle'";

        ##############
        # WORKSPACES #
        ##############

        "${modifier}+1" = "workspace 1:";
        "${modifier}+2" = "workspace 2";
        "${modifier}+3" = "workspace 3";
        "${modifier}+4" = "workspace 4";
        "${modifier}+5" = "workspace 5";
        "${modifier}+6" = "workspace 6";
        "${modifier}+7" = "workspace 7";
        "${modifier}+8" = "workspace 8";
        "${modifier}+9" = "workspace 9";
        "${modifier}+0" = "workspace 10";
        "${modifier}+Shift+1" = "move container to workspace 1:";
        "${modifier}+Shift+2" = "move container to workspace 2";
        "${modifier}+Shift+3" = "move container to workspace 3";
        "${modifier}+Shift+4" = "move container to workspace 4";
        "${modifier}+Shift+5" = "move container to workspace 5";
        "${modifier}+Shift+6" = "move container to workspace 6";
        "${modifier}+Shift+7" = "move container to workspace 7";
        "${modifier}+Shift+8" = "move container to workspace 8";
        "${modifier}+Shift+9" = "move container to workspace 9";
        "${modifier}+Shift+0" = "move container to workspace 10";
      };
      workspaceAutoBackAndForth = true;

      ###########
      # STARTUP #
      ###########

      startup = [
        #
        # Environment
        #
        # Ensures that the environment variables are correctly set for the user 
        # systemd units started after the command (not those already running)
        #{ command = "exec systemctl --user import-environment"; }
        {
          command = "sway-configure-dbus";
        }
        # To ask for sudo via dbus
        #{ command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"; }
        #
        # Network
        #
        {
          command = "${pkgs.networkmanagerapplet}/bin/nm-applet --indicator";
        }
        #
        # Programs
        #
        { command = "${pkgs.mako}/bin/mako"; }
        {
          command =
            "${pkgs.swaybg}/bin/swaybg -i ~/.config/sway/wallpaper -m fill";
        }
        # swaymsg sets the mouse in the right place ;)
        {
          command = "swaymsg 'workspace 1:; exec firefox'";
        }
        #
        # RENDER TIME ADJUSTEMENTS
        # Change this if you get stutters
        # https://artemis.sh/2022/09/18/wayland-from-an-x-apologist.html
        # https://www.reddit.com/r/swaywm/comments/jfjsqy/comment/gh8xgjq/?context=3
        # https://www.reddit.com/r/swaywm/comments/rettyx/please_help_me_understand_how_to_use_max_render/
        #
        # set render time to 1ms for all windows
        { command = "swaymsg 'for_window [title=.*] max_render_time 1'"; }
        { command = "'output * max_render_time 7'"; }
        { command = "echo $WLR_RENDERER"; }
      ];
    };
  };
}

