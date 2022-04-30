# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, outputs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  nix = {
    package = inputs.nix.packages.x86_64-linux.nix; 
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
   };

  nixpkgs.overlays = [
    (builtins.getFlake "github:fortuneteller2k/nixpkgs-f2k").overlay
  ];


#nix.package = pkgs.nixUnstable; 

 
# Use the systemd-boot EFI boot loader. 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

   networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
   networking.networkmanager.enable = true; 
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
   i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
   };

  # Enable the X11 windowing system.
   services.xserver.enable = true;
   services.xserver.displayManager.lightdm.enable = true;
   services.xserver.displayManager.defaultSession = "none+awesome";
   services.xserver.windowManager.awesome = {
	enable = true;
        luaModules = with pkgs.luaPackages; [
        luarocks # is the package manager for Lua modules 
     	lgi
	vicious
	 ]; 
	}; 	
   services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource NVIDIA-G0 "Unknown AMD Radeon GPU @ pci:0000:05:00.0"
	'';

# Nvidia settings
    services.xserver.videoDrivers = [ "nvidia" ];
   # hardware.nvidia.powerManagement.enable = true; 
    hardware.nvidia.nvidiaSettings = true;
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    hardware.nvidia.nvidiaPersistenced = true;
    hardware.nvidia.modesetting.enable = true;
    hardware.nvidia.prime = {
offload.enable = true;
intelBusId = "PCI:0:2:0";
nvidiaBusId = "PCI:1:0:0";
};
# Configure keymap in X11

   services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
   services.printing.enable = true;

  # Enable sound.
   sound.enable = true;
   hardware.pulseaudio.enable = true;


  # Enable touchpad support (enabled default in most desktopManager).
   services.xserver.libinput.enable = true;
   services.xserver.libinput.touchpad.tapping = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.hikari = {
     isNormalUser = true;
     extraGroups = [ "wheel"  "docker"  ]; # Enable ‘sudo’ for the user.
     createHome = true;
     uid = 1000;
     shell = "/run/current-system/sw/bin/zsh";	 
     packages = [
	pkgs.ferdi
	pkgs.zellij
	pkgs.vscode
	pkgs.zenith-nvidia
	pkgs.eww
	];
};
programs.zsh.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     vim 
     neovim
     wget
     firefox-beta-bin
     alacritty
     awesome-git
     wpa_supplicant
     networkmanager
     git
     zsh
     pipewire
     pavucontrol
     networkmanagerapplet 
     emacs
     arandr 	
     nixFlakes
     gparted
     cinnamon.nemo
     linuxPackages.nvidia_x11
     libgnome-keyring 
    (writeShellScriptBin "nixFlakes" ''
      exec ${nixFlakes}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')
  ];


 
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

 
  # List services that you want to enable:
 # x.package = pkgs.nixUnstable; 
 # nixpkgs.config.allowUnfree = true;
  # Enable the OpenSSH daemon.
   services.openssh.enable = true;
  
  # Run garbage collection
   nix.gc.automatic = true;
   nix.gc.dates = "03:15";

  nixpkgs.config.allowUnfree = true; 
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
  system.stateVersion = "21.11";

}

