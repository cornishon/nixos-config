{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    # desktop ui
    swayidle
    swayosd
    swaynotificationcenter
    gtklock
    adw-gtk3
    gnome.adwaita-icon-theme
    xfce.thunar
    xfce.xfconf
    hyprpicker
    wl-clipboard
    wofi
    # hardware control
    brightnessctl
    bluez-tools
    #qt wayland support
    qt6.qtwayland
    libsForQt5.qt5.qtwayland
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      $MOD = SUPER
      $terminal = kitty
      $browser = brave

      exec-once = swaync & gammastep-indicator -l 53:18
      #exec-once = nwg-panel
      exec-once = waybar
      exec-once = swayidle -w timeout 240 'gtklock -g adw-gtk3-dark' timeout 360 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'
      exec-once = [workspace special silent] $terminal

      env = XCURSOR_SIZE,32

      monitor=eDP-1,preferred,auto,1
      monitor=,prefferred,auto,auto

      input {
          kb_layout = pl
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1

          touchpad {
              natural_scroll = true
          }

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }
      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 2
          gaps_out = 4
          border_size = 1
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)

          layout = master

          cursor_inactive_timeout = 1
      }
      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 0
          blur = false
          blur_size = 3
          blur_passes = 1
          blur_new_optimizations = true

          drop_shadow = true
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }

      animations {
          enabled = true

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 2, myBezier
          animation = windowsOut, 1, 2, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 2, default
          animation = fade, 1, 2, default
          animation = workspaces, 1, 2, default
      }

      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = true # master switch for pseudotiling. Enabling is bound to Mod + P in the keybinds section below
          preserve_split = true # you probably want this
      }

      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true
          no_gaps_when_only = true
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = true
      }

      misc {
        mouse_move_enables_dpms = true
        key_press_enables_dpms = true
      }

      # Example windowrule v1
      # windowrule = float, ^(PictureInPicture)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $MOD, Return, exec, $terminal
      bind = $MOD SHIFT, Q, killactive,
      bind = $MOD CTRL, Q, exit,
      bind = $MOD, E, exec, thunar
      bind = $MOD, W, exec, $browser 
      bind = $MOD, C, togglefloating,
      bind = $MOD, C, centerwindow,
      bind = $MOD, S, movetoworkspace, special
      bind = $MOD, Semicolon, togglespecialworkspace
      bind = $MOD, F, fullscreen, 0
      bind = $MOD SHIFT, F, fullscreen, 1
      bind = $MOD, R, exec, wofi --show drun
      bind = $MOD SHIFT, P, pseudo, # dwindle
      bind = $MOD, V, togglesplit, # dwindle
      bind = $MOD, V, layoutmsg, orientationnext # master
      bind = $MOD SHIFT, Return, layoutmsg, swapwithmaster # master
      bind = $MOD, N, exec, swaync-client -t

      # Move focus with MOD + hjkl
      bind = $MOD, H, movefocus, l
      bind = $MOD, J, movefocus, d
      bind = $MOD, K, movefocus, u
      bind = $MOD, L, movefocus, r
      bind = $MOD SHIFT, H, movewindow, l
      bind = $MOD SHIFT, J, movewindow, d
      bind = $MOD SHIFT, K, movewindow, u
      bind = $MOD SHIFT, L, movewindow, r
      bind = $MOD CTRL, H, resizeactive, -20 0
      bind = $MOD CTRL, J, resizeactive, 0 20
      bind = $MOD CTRL, K, resizeactive, 0 -20
      bind = $MOD CTRL, L, resizeactive, 20 0

      # Switch workspaces with MOD + [0-9]
      #bind = $MOD Tab, workspace, previous
      bind = $MOD, 1, workspace, 1
      bind = $MOD, 2, workspace, 2
      bind = $MOD, 3, workspace, 3
      bind = $MOD, 4, workspace, 4
      bind = $MOD, 5, workspace, 5
      bind = $MOD, 6, workspace, 6
      bind = $MOD, 7, workspace, 7
      bind = $MOD, 8, workspace, 8
      bind = $MOD, 9, workspace, 9
      bind = $MOD, 0, workspace, 10

      # Move active window to a workspace with MOD + SHIFT + [0-9]
      bind = $MOD SHIFT, 1, movetoworkspace, 1
      bind = $MOD SHIFT, 2, movetoworkspace, 2
      bind = $MOD SHIFT, 3, movetoworkspace, 3
      bind = $MOD SHIFT, 4, movetoworkspace, 4
      bind = $MOD SHIFT, 5, movetoworkspace, 5
      bind = $MOD SHIFT, 6, movetoworkspace, 6
      bind = $MOD SHIFT, 7, movetoworkspace, 7
      bind = $MOD SHIFT, 8, movetoworkspace, 8
      bind = $MOD SHIFT, 9, movetoworkspace, 9
      bind = $MOD SHIFT, 0, movetoworkspace, 10

      # Scroll through existing workspaces with MOD + scroll
      bind = $MOD, mouse_down, workspace, e+1
      bind = $MOD, mouse_up, workspace, e-1

      # Move/resize windows with MOD + LMB/RMB and dragging
      bindm = $MOD, mouse:272, movewindow
      bindm = $MOD, mouse:273, resizewindow

      bind = $MOD, Escape, exec, gtklock --gtk-theme 'adw-gtk3-dark' & systemctl suspend
      # Brightness control
      #bind = , XF86MonBrightnessDown, exec, brightnessctl set 10%-
      #bind = , XF86MonBrightnessUp, exec, brightnessctl set 10%+
      bind = , XF86MonBrightnessDown, exec, swayosd --brightness lower
      bind = , XF86MonBrightnessUp, exec, swayosd --brightness raise

      # Volume control
      #bind = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
      #bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      #bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      #bind = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      bind = , XF86AudioRaiseVolume, exec, swayosd --output-volume raise
      bind = , XF86AudioLowerVolume, exec, swayosd --output-volume lower
      bind = , XF86AudioMute, exec, swayosd --output-volume mute-toggle
      bind = , XF86AudioMicMute, exec, swayosd --input-volume mute-toggle
    '';
  };
}
