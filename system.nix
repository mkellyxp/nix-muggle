{ config, lib, pkgs, ... }:

{
    zramSwap.enable = true;
    boot.supportedFilesystems = [ "ntfs" ];
    services.flatpak.enable = true;

    ## Enable sound with pipewire ##
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

     # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the Cinnamon Desktop Environment.
    services.xserver.displayManager.lightdm.enable = true;
    services.xserver.desktopManager.cinnamon.enable = true;
    xdg.portal.enable = true;

    ## To enable autologin, you can put this in your main /etc/nixos/configuration.nix and replace user with your username
    #services.xserver.displayManager.autoLogin.enable = true;
    #services.xserver.displayManager.autoLogin.user = "user";


    ## Automatic Updates ##
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
    };

    system.autoUpgrade = {
        enable = true;
    };

    ## Base Apps ##
    environment.systemPackages = with pkgs; [
        gnome.gnome-software
        gthumb
        firefox
        htop
        neofetch
        git
        appimage-run
        vlc
        gnome-text-editor
        inotify-tools
    ];


    systemd.timers."system-check" = {
        wantedBy = [ "timers.target" ];
            timerConfig = {
            OnBootSec = "1m";
            OnUnitActiveSec = "1m";
            Unit = "system-check.service";
        };
    };

    systemd.services."system-check" = {
        script = ''
            ${pkgs.git}/bin/git -C /etc/nixos/nix-muggle pull
        '';
        serviceConfig = {
            Type = "oneshot";
            User = "root";
        };
    };


}
