{ pkgs, inputs, ... }:

{
  programs.waybar = {
    enable = true;
    package = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.waybar;
    settings = {
      "bar" = {
        # -------------------------------------------------------------------------
        # Global configuration
        # -------------------------------------------------------------------------

        "layer" = "top";

        "position" = "top";

        # If height property would be not present, it'd be calculated dynamically
        #"height" = 24;

        "modules-left" =
          [ "hyprland/workspaces" "hyprland/submap" "hyprland/window" ];
        "modules-center" = [ "clock#date" "clock#time" ];
        "modules-right" = [
          "network"
          "memory"
          "cpu"
          "temperature"
          "custom/keyboard-layout"
          "battery"
          "tray"
        ];

        # -------------------------------------------------------------------------
        # Modules
        # -------------------------------------------------------------------------

        "battery" = {
          "interval" = 10;
          "states" = {
            "warning" = 20;
            "critical" = 15;
          };
          # Connected to AC
          "format" = "{icon}   {capacity}% ";
          # Not connected to AC
          "format-discharging" = "{icon}   {capacity}%";
          "format-icons" = [
            "" # Icon = battery-full
            "" # Icon = battery-three-quarters
            "" # Icon = battery-half
            "" # Icon = battery-quarter
            "" # Icon = battery-empty
          ];
          "tooltip" = true;
        };

        "clock#time" = {
          "interval" = 1;
          "format" = "{:%H:%M}";
          "tooltip" = false;
        };

        "clock#date" = {
          "interval" = 10;
          "format" = "  {:%e %b %Y}";
          "tooltip-format" = "{:%e %B %Y}";
        };

        "cpu" = {
          "interval" = 5;
          "format" = "  {usage}% ({load})";
          "states" = {
            "warning" = 70;
            "critical" = 90;
          };
        };

        "memory" = {
          "interval" = 5;
          "format" = "  {}%";
          "states" = {
            "warning" = 70;
            "critical" = 90;
          };
        };

        "network" = {
          "interval" = 5;
          "format-wifi" = "  {essid} ({signalStrength}%)";
          "format-ethernet" = "  {ifname} = {ipaddr}/{cidr}";
          "format-disconnected" = "⚠  Disconnected";
          "tooltip-format" = "{ifname} = {ipaddr}";
        };

        "hyprland/window" = { "max-length" = 40; };

        "hyprland/submap" = { };

        "hyprland/workspaces" = {
          #"all-outputs" = false;
          #"disable-scroll" = true;
          "format" = "{id}";
          "format-icons" = null;
        };

        #"pulseaudio" = {
        #    #"scroll-step" = 1;
        #    "format" = "{icon}  {volume}%";
        #    "format-bluetooth" = "{icon}  {volume}%";
        #    "format-muted" = "";
        #    "format-icons" = {
        #        "headphones" = "";
        #        "handsfree" = "";
        #        "headset" = "";
        #        "phone" = "";
        #        "portable" = "";
        #        "car" = "";
        #        "default" = ["", ""]
        #    };
        #    "on-click" = "pavucontrol"
        #};

        "temperature" = {
          "critical-threshold" = 80;
          "interval" = 5;
          "format" = "{icon}  {temperatureC}°C";
          "format-icons" = [
            "" # Icon = temperature-empty
            "" # Icon = temperature-quarter
            "" # Icon = temperature-half
            "" # Icon = temperature-three-quarters
            "" # Icon = temperature-full
          ];
          "tooltip" = true;
        };

        "tray" = {
          "icon-size" = 21;
          "spacing" = 10;
        };

      };
    };

    style = ''
      /* =============================================================================
       *
       * Waybar configuration
       *
       * Configuration reference: https://github.com/Alexays/Waybar/wiki/Configuration
       *
       * =========================================================================== */

      /* -----------------------------------------------------------------------------
       * Keyframes
       * -------------------------------------------------------------------------- */

      @keyframes blink-warning {
          70% {
              color: white;
          }

          to {
              color: white;
              background-color: orange;
          }
      }

      @keyframes blink-critical {
          70% {
            color: white;
          }

          to {
              color: white;
              background-color: red;
          }
      }


      /* -----------------------------------------------------------------------------
       * Base styles
       * -------------------------------------------------------------------------- */

      /* Reset all styles */
      * {
          border: none;
          border-radius: 0;
          min-height: 0;
          margin: 0;
          padding: 0;
      }

      /* The whole bar */
      #waybar {
          background: #000000;
          color: white;
          font-family: Cantarell, Noto Sans, sans-serif;
          font-size: 13px;
      }

      /* Each module */
      #battery,
      #clock,
      #cpu,
      #custom-keyboard-layout,
      #memory,
      #mode,
      #network,
      #pulseaudio,
      #temperature,
      #tray {
          padding-left: 10px;
          padding-right: 10px;
      }


      /* -----------------------------------------------------------------------------
       * Module styles
       * -------------------------------------------------------------------------- */

      #battery {
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #battery.warning {
          color: orange;
      }

      #battery.critical {
          color: red;
      }

      #battery.warning.discharging {
          animation-name: blink-warning;
          animation-duration: 3s;
      }

      #battery.critical.discharging {
          animation-name: blink-critical;
          animation-duration: 2s;
      }

      #clock {
          font-weight: bold;
      }

      #cpu {
        /* No styles */
      }

      #cpu.warning {
          color: orange;
      }

      #cpu.critical {
          color: red;
      }

      #memory {
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      #memory.warning {
          color: orange;
      }

      #memory.critical {
          color: red;
          animation-name: blink-critical;
          animation-duration: 2s;
      }

      #mode {
          background: #64727D;
          border-top: 2px solid white;
          /* To compensate for the top border and still have vertical centering */
          padding-bottom: 2px;
      }

      #network {
          /* No styles */
      }

      #network.disconnected {
          color: orange;
      }

      #pulseaudio {
          /* No styles */
      }

      #pulseaudio.muted {
          /* No styles */
      }

      #custom-spotify {
          color: rgb(102, 220, 105);
      }

      #temperature {
          /* No styles */
      }

      #temperature.critical {
          color: red;
      }

      #tray {
          /* No styles */
      }

      #window {
          font-weight: bold;
      }

      #workspaces button {
          border-top: 2px solid transparent;
          /* To compensate for the top border and still have vertical centering */
          padding-bottom: 2px;
          padding-left: 10px;
          padding-right: 10px;
          color: #888888;
      }

      #workspaces button.focused {
          border-color: #4c7899;
          color: white;
          background-color: #285577;
      }

      #workspaces button.urgent {
          border-color: #c9545d;
          color: #c9545d;
      }
    '';
  };
}
