# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
{

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [
    ./hardware-configuration.nix
    # Neovim 
    ./neovim.nix
  ];

  boot = {
    loader = {
      grub.enable = true;
      grub.device = "/dev/sda";
      grub.useOSProber = true;
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

 # Enable networking
 networking = {
   networkmanager.enable = true;
   # hosts = { "127.0.0.1" = [ "nixos" ]; };
 };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";
  
  environment.pathsToLink = [ "/libexec" ]; 

  # Enable x11 and gnome
  services.xserver = {
    enable = true;

    displayManager = {
      gdm.enable = true;
    };

    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = [
    pkgs.gnome.gnome-software
    pkgs.gnome.geary
    pkgs.gnome.cheese
    pkgs.epiphany
    pkgs.gnome.gnome-characters
    pkgs.gnome-tour
    pkgs.gnome.gnome-music
  ];

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users.pyrotek45 = {
    isNormalUser = true;
    description = "pyrotek45";
    extraGroups = [ "networkmanager" "wheel" "docker"];
  };

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [
    "libtiff-4.0.3-opentoonz"
  ];


  environment.systemPackages = with pkgs; [
    (discord.override { nss = pkgs.nss_latest;})
    soundconverter
    vlc
    libreoffice
    krita
    gimp-with-plugins
    shotcut
    notejot
    ardour
    surge-XT
    cardinal
    helm
    audio-recorder
    audacity
    obs-studio
    wget
    pipewire_0_2
    firefox
    vscode
    bitwig-studio
    lutris
    blender
    godot
    rust-analyzer
    appimage-run
    neofetch
    element-desktop
    gnome.gnome-tweaks
    heroic
    gnumake
    htop
    lollypop
    bottles
    kdenlive
    aseprite
    pixelorama
    inkscape
    xdelta
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

  environment.interactiveShellInit = ''
    alias ec='sudo nvim /etc/nixos/configuration.nix'
  '';

  services.flatpak.enable = true;

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
    };
  };

  console = {
    font = "ter-132n";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
    colors = [
      "282828"
      "cc241d"
      "98971a"
      "d79921"
      "458588"
      "b16286"
      "689d6a"
      "a89984"
      "928374"
      "fb4934"
      "b8bb26"
      "fabd2f"
      "83a598"
      "d3869b"
      "8ec07c"
      "ebdbb2"
    ];
  };

  environment.variables = {
    DSSI_PATH   = "$HOME/.dssi:$HOME/.nix-profile/lib/dssi:/run/current-system/sw/lib/dssi";
    LADSPA_PATH = "$HOME/.ladspa:$HOME/.nix-profile/lib/ladspa:/run/current-system/sw/lib/ladspa";
    LV2_PATH    = "$HOME/.lv2:$HOME/.nix-profile/lib/lv2:/run/current-system/sw/lib/lv2";
    LXVST_PATH  = "$HOME/.lxvst:$HOME/.nix-profile/lib/lxvst:/run/current-system/sw/lib/lxvst";
    VST_PATH    = "$HOME/.vst:$HOME/.nix-profile/lib/vst:/run/current-system/sw/lib/vst";
    VST3_PATH   = "$HOME/.vst3:$HOME/.nix-profile/lib/vst3:/run/current-system/sw/lib/vst3";
  };

  system.autoUpgrade.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leavecatenate(variables, "bootdev", bootdev)
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
