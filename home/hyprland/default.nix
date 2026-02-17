{ config, device, ... }:
let
  wallpaperPath = "${config.home.homeDirectory}/.config/hypr/wallpaper.png";
in
{
  # Copy wallpaper to hypr config directory
  xdg.configFile."hypr/wallpaper.png".source = ../assets/wallpaper.png;

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ wallpaperPath ];
      wallpaper = [ ", ${wallpaperPath}" ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {

      cursor = {
        no_hardware_cursors = 1;
        enable_hyprcursor = true;
      };

      exec-once = [
        "waybar"
        "hyprpaper"
      ];

      # Set Monitors
      monitor =
        if device == "laptop" then
          [
            "eDP-1, 1920x1080@60, 0x0, 1, cm, auto"
            "DP-2, 1920x1080@60, 1920x0, 1, cm, auto"
            "DP-4, 1920x1080@60, 3840x0, 1, cm, auto"
          ]
        else
          [
            "HDMI-A-1, 1920x1080@60, 0x0, 1, cm, auto, bitdepth, 8"
            "DP-5, 1920x1080@60, 1920x0, 1, cm, auto, bitdepth, 8"
            "DP-3, 1920x1080@60, 3840x0, 1, cm, auto, bitdepth, 8"
          ];

      # Application Environment variables
      "$terminal" = "kitty";
      "$menu" = "rofi -show drun";

      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };

        # Color Settings Configured by stylix
      };

      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint, 0.23, 1, 0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear, 0, 0, 1, 1"
          "almostLinear, 0.5, 0.5, 0.75, 1"
          "quick, 0.15, 0, 0.1, 1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
          "zoomFactor, 1, 7, quick"
        ];
      };

      workspace =
        if device == "laptop" then
          [
            "w[tv1], gapsout:0, gapsin:0"
            "f[1], gapsout:0, gapsin:0"
            #  Set workspaces for each monitor
            "1, monitor:eDP-1, default:true, persistent:true"
            "2, monitor:eDP-1, persistent:true"
            "3, monitor:eDP-1, persistent:true"
            "4, monitor:DP-2, default:true, persistent:true"
            "5, monitor:DP-2, persistent:true"
            "6, monitor:DP-2, persistent:true"
            "7, monitor:DP-4, default:true, persistent:true"
            "8, monitor:DP-4, persistent:true"
            "9, monitor:DP-4, persistent:true"
          ]
        else
          [
            "w[tv1], gapsout:0, gapsin:0"
            "f[1], gapsout:0, gapsin:0"
            #  Set workspaces for each monitor
            "1, monitor:HDMI-A-1, default:true, persistent:true"
            "2, monitor:HDMI-A-1, persistent:true"
            "3, monitor:HDMI-A-1, persistent:true"
            "4, monitor:DP-5, default:true, persistent:true"
            "5, monitor:DP-5, persistent:true"
            "6, monitor:DP-5, persistent:true"
            "7, monitor:DP-3,default:true, persistent:true"
            "8, monitor:DP-3,persistent:true"
            "9, monitor:DP-3,persistent:true"
          ];

      windowrule = [
        "bordersize 0, floating:0, onworkspace:w[tv1]"
        "rounding 0, floating:0, onworkspace:w[tv1]"
        "bordersize 0, floating:0, onworkspace:f[1]"
        "rounding 0, floating:0, onworkspace:f[1]"
        "suppressevent maximize, class:.*"
        "nofocus, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0"
      ];

      windowrulev2 = [
        "monitor DP-2, class:(?i)zed"
        "monitor DP-4, class:(?i)librewolf"
        "tile, class:steam"
      ];

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        follow_mouse = 0;
        sensitivity = 0;
        force_no_accel = 0;
        touchpad = {
          natural_scroll = false;
        };
      };

      gesture = [
        "3, horizontal, workspace"
      ];

      device = [
        {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        }
      ];

      "$mainMod" = "SUPER";

      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod, C, killactive"
        "$mainMod, M, exit"
        "$mainMod, V, togglefloating"
        "$mainMod, R, exec, $menu"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"
        "$mainMod, F, fullscreen"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, workspace, r+1"
        "$mainMod, down, workspace, r-1"
        "$mainMod SHIFT, left, movewindow, l"
        "$mainMod SHIFT, right, movewindow, r"
        "$mainMod SHIFT, up, movetoworkspace, r+1"
        "$mainMod SHIFT, down, movetoworkspace, r-1"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

    };
  };

  xdg.portal.config.hyprland = {
    default = [
      "hyprland"
      "gtk"
    ];
  };

  programs.rofi.enable = true;

  programs.waybar = {
    enable = true;
    settings.main = {
      modules-right = [
        "mpd"
        "clock"
      ];
      modules-left = [ "hyprland/workspaces" ];
    };
  };

}
