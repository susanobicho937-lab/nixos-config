{ config, lib, pkgs, inputs,  ... }:

{
  imports =
    [ # no se
      ./hardware-configuration.nix
    ];

 
  
  #aliases
  programs.fish.shellAliases.ll = "ls -la";
  programs.fish.shellAliases.adios = "cowsay Te extrañare hermano!, adios.";
   
  #setarangenereitor
  zramSwap = {
  enable = true;
  algorithm = "zstd";
  memoryPercent = 100; 
 }; #esto NO es el cierre de # no se # ok?

  # el butloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "salsa-y-picante";

  # neswork
  networking.networkmanager.enable = true;

  # timesone
  time.timeZone = "America/Mexico_City";

  #tu usuario wasabi JAJAJA
   users.users.wasabi = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "audio" "video" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
   };

  #cosas super experimentales asi bien ajuas ajuas XD
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
   
  #Programas tuyos papoi
  programs.fish.enable = true;
  programs.niri.enable = true;
  programs.steam.enable = true;

  #Servicios
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;
  };
  services.libinput.enable = true;   
  services.displayManager.sddm.enable = false;
  services.displayManager.sddm.wayland.enable = false;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.flatpak.enable = true; 
  services.upower.enable = true;
 
  #Seguridad parapapa
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.doas.enable = true;
  security.doas.extraRules = [
   {
     users = [ "wasabi" ];
     keepEnv = true;
     persist = true;
   }
  ];

  #Tus drivers de video hermano, o si no no juegas beamng
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "Bibata-Modern-Classic";
    HYPRCURSOR_SIZE = "24";
  };

  #fuentes pipirisnais
  fonts.packages = with pkgs; [
    nerd-fonts.hurmit
    noto-fonts
    noto-fonts-color-emoji
    liberation_ttf
  ];
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
      monospace = [ "Hurmit Nerd Font" ];
    };
  };
  fonts.fontDir.enable = true;
  #la nt nsss
  nixpkgs.config.allowUnfree = true;

  #pacman
  environment.systemPackages = with pkgs; [
   fastfetch
   git 
   wget
   brightnessctl
   hyprpaper
   firefox
   screenfetch
   ghostty
   asciiquarium
   hyprcursor
   bibata-cursors
   cava
   pipes
   helix
   cmatrix
   cowsay
   lolcat
   playerctl
   btop
   spotify
   discord
   rofi
   waybar
   jq
   xwayland-satellite
   libxcb-cursor
   xsettingsd
   gamescope
   thunar
   iwd
   prismlauncher
   docker
   ninvaders
   bastet
   foot
   hyprland
   ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org .
  system.stateVersion = "26.05"; # Did you read the comment?


}

