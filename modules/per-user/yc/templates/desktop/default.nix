{ config, lib, pkgs, ... }:
let
  cfg = config.zfs-root.per-user.yc.templates.desktop;
  inherit (lib) mkDefault mkOption types mkIf;
in {
  options.zfs-root.per-user.yc.templates.desktop = {
    enable = mkOption {
      description = "Enable system config template by yc";
      type = types.bool;
      default = false;
    };
  };
  config = mkIf cfg.enable {
    zfs-root = {
      boot = {
        devNodes = "/dev/disk/by-id/";
        immutable = true;
      };
      networking = {
        timeZone = "Europe/Berlin";
        networkmanager.wirelessNetworks = {
          "TP-Link_48C2" = "77017543";
          "1203-5G" = "hallo stranger";
        };
      };

      per-user.yc.enable = true;
    };
    users = {
      yc = {
        # "!" means login disabled
        initialHashedPassword =
          "$6$UxT9KYGGV6ik$BhH3Q.2F8x1llZQLUS1Gm4AxU7bmgZUP7pNX6Qt3qrdXUy7ZYByl5RVyKKMp/DuHZgk.RiiEXK8YVH.b2nuOO/";
        description = "Yuchen Guo";
        # a default group must be set
        extraGroups = [
          # use doas
          "wheel"
          # manage VMs
          "libvirtd"
          # manage network
          "networkmanager"
          # connect to /dev/ttyUSB0
          "dialout"
        ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEeuanloGpRSuYbfJV3eGnfgyX1djaGC7UjUSgJeraKM openpgp:0x5862BCF8"
        ];
        packages = builtins.attrValues {
          inherit (pkgs)
            ffmpeg mg nixfmt qrencode minicom zathura jmtpfs gpxsee
            # pdf processor in Go
            pdfcpu
            # pdf manipulation suite in C++
            # https://qpdf.readthedocs.io/en/stable/
            qpdf;
        };
        isNormalUser = true;
      };
    };
    hardware = {
      opengl = {
        extraPackages =
          builtins.attrValues { inherit (pkgs) vaapiIntel intel-media-driver; };
        enable = true;
      };
      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
      pulseaudio.enable = false;
    };
    services = {
      blueman.enable = true;
      logind = {
        extraConfig = ''
          HandlePowerKey=suspend
        '';
        lidSwitch = "suspend";
        lidSwitchDocked = "ignore";
        lidSwitchExternalPower = "suspend";
      };
      pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
      };
    };
    sound.enable = true;
    programs.sway = {
      extraSessionCommands = ''
        export MOZ_ENABLE_WAYLAND=1
        export QT_QPA_PLATFORM=wayland-egl
        export XCURSOR_THEME=Adwaita
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';
      enable = true;
      extraPackages = builtins.attrValues {
        inherit (pkgs)
          swaylock swayidle foot gammastep brightnessctl fuzzel grim w3m
          gsettings-desktop-schemas pavucontrol waybar wl-clipboard;
      };
    };
    xdg.portal = {
      enable = true;
      wlr.enable = true;
    };
    fonts.fontconfig.defaultFonts = {
      monospace = [ "Source Code Pro" ];
      sansSerif = [ "Noto Sans Display" ];
      serif = [ "Noto Sans Display" ];
    };
    fonts.fonts = builtins.attrValues {
      inherit (pkgs) noto-fonts noto-fonts-cjk-sans source-code-pro;
    };
    environment.sessionVariables = {
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_WAYLAND_FORCE_DPI = "physical";
    };
  };
}
