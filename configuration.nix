# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  programs.java.enable = true;
  # Enable flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pyrotek45 = {
    isNormalUser = true;
    description = "pyrotek45";
    extraGroups = [ "dialout" "networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      firefox
    ];
  };

  environment.pathsToLink = [ "/libexec" ];

  environment.gnome.excludePackages = [
    pkgs.gnome-software
    pkgs.epiphany
    pkgs.gnome-characters
    pkgs.gnome-tour
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    # internet
    discord
    google-chrome
    firefox
    orca-slicer
    openscad
    freecad
    
    # utilities
    gnome-tweaks
    calibre
    neovim
    tilix
    protontricks
    ncdu
    killall
    jq
    wget
    tmux
    appimage-run
    steam-run
    neofetch
    gnumake
    htop
    zip
    wine64

    # music production
    ardour
    cardinal
    calf
    zynaddsubfx
    odin2
    helm
    vcv-rack
    distrho-ports
    lsp-plugins
    surge-XT
    carla
    x42-plugins
    ninjas2
    samplv1
    synthv1
    padthv1
    drumkv1

    # art
    krita
    gimp
    aseprite
    pixelorama
    blender

    # video
    vlc
    kdenlive
    shotcut

    # audio
    audacity
    qjackctl

    # programming
    vscode
    godot_4
    lmms
   
    # rust
    rustup
    gcc
    llvm

    # office
    libreoffice

    # gaming
    heroic
    vulkan-tools
  ];

  programs.git = {
    enable = true;
    config = {
      user.email="pyrotek45_gaming@yahoo.com";
      user.name="pyrotek45";
    };
  };

  programs.tmux.enable = true;
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;

  environment.interactiveShellInit = ''
	
    alias nix-switch='sudo nixos-rebuild switch'
    alias nix-edit='sudo nvim /etc/nixos/configuration.nix'
    alias nix-setup='
        gsettings set org.gnome.desktop.interface clock-format '12h'
        # adds minimize and maximize to the title bar
        gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

        # disables hot corners and enables the application menu
        gnome-extensions enable apps-menu@gnome-shell-extensions.gcampax.github.com 
        gsettings set org.gnome.desktop.interface enable-hot-corners false
        # enables luanch new instance everytime an app is launched
        gnome-extensions enable launch-new-instance@gnome-shell-extensions.gcampax.github.com

        # sets dark theme and installs papirus icons
        gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
        wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.icons" sh
        gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
        gsettings set org.gnome.desktop.interface color-scheme prefer-dark
      '
  '';


  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
    };
  };

  environment.variables = {
    DSSI_PATH   = "$HOME/.dssi:$HOME/.nix-profile/lib/dssi:/run/current-system/sw/lib/dssi";
    LADSPA_PATH = "$HOME/.ladspa:$HOME/.nix-profile/lib/ladspa:/run/current-system/sw/lib/ladspa";
    LV2_PATH    = "$HOME/.lv2:/run/current-system/sw/lib/lv2:$HOME/.nix-profile/lib/lv2";
    LXVST_PATH  = "$HOME/.lxvst:$HOME/.nix-profile/lib/lxvst:/run/current-system/sw/lib/lxvst";
    VST_PATH    = "$HOME/.vst:$HOME/.nix-profile/lib/vst:/run/current-system/sw/lib/vst";
    VST3_PATH   = "$HOME/.vst3:$HOME/.nix-profile/lib/vst3:/run/current-system/sw/lib/vst3";
  };

  nix.settings.auto-optimise-store = true;
  hardware.graphics.enable = true;

  
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.flatpak.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}