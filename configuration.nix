# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
 ];
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.defaultSession ="none+awesome";
  services.xserver.windowManager.awesome.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
   services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";
services.openssh = {
  enable = true;
#  passwordAuthentication = false; # default true
#  permitRootLogin = "yes";
#  challengeResponseAuthentication = false;
    };
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;
    virtualisation.docker.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
   services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.hikari = {
     isNormalUser = true;
     extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
       };
nix.package = pkgs.nixFlakes;   
nix.trustedUsers = [ "root" "hikari" ];
nix.extraOptions = ''experimental-features = nix-command flakes'';
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nixpkgs.config.allowUnfree = true;
   environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    zsh
    zsh-powerlevel10k
    vscode-with-extensions
    wget
    firefox-beta-bin
    wget
    git
    mob
    cargo
    rustc
    gnome.gnome-tweaks
    gnomeExtensions.animation-tweaks
    gparted
    docker
   ntfs3g 
    jmtpfs
    usbutils
teams   
 mtpfs
solc    
solc-select
slither-analyzer
gdrive
    gmtp
    gvfs
    libmtp
    direnv
	ntfsprogs
    home-manager
    nix
    alacritty
      openvpn
   opera
   # mouse
   logiops


   # yubikey
   yubikey-agent
   yubioath-desktop
   yubico-piv-tool
   yubikey-personalization-gui
   age-plugin-yubikey
   yubikey-personalization
   yubikey-touch-detector
   yubikey-manager-qt
   yubikey-manager
	];
programs.zsh.enable = true;
users.defaultUserShell = pkgs.zsh;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

  # VPN
    services.openvpn.servers = {
    # officeVPN  = { config = '' config /home/hikari/.config/openvpn/officeVPN.conf ''; };
  };


  # Nvidia settings
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.opengl.enable = true;
    hardware.nvidia.powerManagement.enable = true; 
    hardware.nvidia.nvidiaSettings = true;
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    hardware.nvidia.nvidiaPersistenced = true;
    hardware.nvidia.modesetting.enable = true;
    hardware.nvidiaOptimus.disable = false;
    #hardware.nvidia.prime.sync.enable = true;
    hardware.nvidia.prime = {
offload.enable = true;
intelBusId = "PCI:0:2:0";
nvidiaBusId = "PCI:1:0:0";
};
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
   networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "unstable"; # Did you read the comment?

}

