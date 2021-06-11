# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Specify the encrypted disk
  boot.initrd.luks.devices.root = {
    device = "##device##2";
    preLVM = true;
  };

  # Enable latest kernel updates
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking setup
  networking.hostName = "##username##";

  # Enable NetworkManager
  networking.networkmanager.enable = true;

  # Enable wireless support via wpa_supplicant.
  # networking.wireless.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Root password
  users.users.root.initialHashedPassword = "##rootpasswd##";

  # Allow unfree proprietary packages such as spotify or vscode
  nixpkgs.config.allowUnfree = true;

  # System-wide packages
  environment.systemPackages = with pkgs; [
    # System utilities
    ark
    dmidecode
    gitAndTools.gitFull
    gnupg
    gparted
    htop
    ntfs3g
    usbutils
    unar
    unzip
    vim
    wget
    # Desktop utilities
    bitwarden
    chromium
    dropbox
    electrum
    evince
    filelight
    firefox
    gimp-with-plugins
    keepassxc
    killall
    libreoffice-fresh
    nextcloud-client
    notepadqq
    peek
    phototonic
    signal-desktop
    slack
    tdesktop
    vlc
    wine
    # Gnome specifics and utilities
    evolution
    gnome.gnome-tweaks
    networkmanagerapplet
    gnomeExtensions.dash-to-panel
    gnomeExtensions.dash-to-dock
    # KDE specifics and utilities
    # kcalc
    # krusader
    # spectacle
    # Python Trezor packages
    (python3.withPackages(ps: with ps; [ trezor trezor_agent ]))
    # Optional stuff
    # spotify
    # steam
    # vscode
  ];

  # Steam support
  # hardware.opengl.driSupport32Bit = true;
  # hardware.pulseaudio.support32Bit = true;

  # Enabling unfree packages, adding unstable channel to be able to install latest python-trezor
  environment.interactiveShellInit = ''
    if [ ! -f ~/.config/nixpkgs/config.nix ]
      then
        mkdir -p ~/.config/nixpkgs/
        echo  '{ allowUnfree = true; }' > ~/.config/nixpkgs/config.nix
    fi

    if [ ! -d /nix/var/nix/profiles/per-user/$USER/channels/unstable ]
      then
        nix-channel --add https://nixos.org/channels/nixos-unstable unstable && nix-channel --update
    fi
  '';

  # As GnuPG is now built without support for a graphical passphrase entry by default
  programs.gnupg.agent.enable = true;

  # List services that you want to enable:

  # Limit journal size
   services.journald = {
    extraConfig = "SystemMaxUse=500M";
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    clientConf = "ServerName cups.corp.sldev.cz";
  };

  # Enable Trezor Bridge
  services.trezord.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable sound.
  sound.enable = true;

  # Enable BT
  hardware.bluetooth.enable = true;

  # Enable pulseaudio with BT support
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # It is needed to explicitly disable libinput if we want to use synaptics. This will add support for all dell laptops
  services.xserver.libinput.enable = true;

  # Enable Lenovo/IBM touchpad support. Do not use, this is outdated option and should remain false for all company devices.
  services.xserver.synaptics.enable = false;

  # Default displayManager is LightDM
  # Enable SDDM displayManager
  # services.xserver.displayManager.sddm.enable = true;

  # Enable the KDE Desktop Environment
  # services.xserver.displayManager.slim.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Enable for Gnome Desktop Environment
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Prague";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.##username## = {
    isNormalUser = true;
    uid = 1000;
    createHome = true;
    home = "/home/##username##/";
    extraGroups = [ "wheel" "networkmanager" ]; # additional groups [ "vboxusers" "docker"];
  };

  # Enable Docker
  # virtualisation.docker.enable = true;

  # Enable VirtualBox
  # virtualisation.virtualbox.host = {
  #   enable = true;
  #   Enable VirtualBox ExtensionPack (necessary for USB drivers higher than 1.1)
  #   enableExtensionPack = true;
  #   Disable VirtualBox hardening
  #   enableHardening = false;
  # };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.03"; # Did you read the comment?

}
