{ config, lib, pkgs, inputs,  ... }:

{
  imports =
    [ # no se
      ./hardware-configuration.nix
    ];

  #idk como x23
  boot.initrd.kernelModules = [ "i915" ];
  powerManagement.cpuFreqGovernor = "performance";
  services.thermald.enable = true;
  programs.nix-ld.enable = true;
 

  
  #aliases
  programs.bash.shellAliases.vi = "busybox vi";
  programs.fish.shellAliases.vi = "busybox vi";
  programs.fish.shellAliases.ll = "ls -la";
  programs.fish.shellAliases.adios = "cowsay Te extrañare hermano!, adios.";
  programs.fish.shellAliases.son = "poweroff";
  programs.fish.shellAliases.sonion = "reboot";
   
  #setarangenereitor
  zramSwap = {
  enable = true;
  algorithm = "zstd";
  memoryPercent = 100; 
 }; #esto NO es el cierre de # no se # ok?

  # el butloader
   boot.loader = {
   systemd-boot.enable = false;
   efi.canTouchEfiVariables = true;
   grub = {
     enable = true;
     efiSupport = true;
     device = "nodev";
    };
  };
  
  boot.loader.grub.minegrub-world-sel = {
  enable = true;
   customIcons = [{
     name = "nixos";
     lineTop = "NixOS (12/10/2026, 20:00)";
     lineBottom = "Creative Mode, Cheats, Version: 26.11";
     imgName = "nixos";
    }];
  };


  networking.hostName = "sausy-system";

  # neswork
  networking.networkmanager.enable = true;

  # timesone
  time.timeZone = "America/Mexico_City";

  #tu usuario JAJAJAJAJJAJAJAJAJA
   users.users.wasabi = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "audio" "video" ]; # Enable ‘doas’ for the user
     shell = pkgs.fish;
     packages = with pkgs; [
       tree
     ];
   };

   users.users.sonion = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
     packages = with pkgs; [
       tree
     ];
   };


  #cosas super experimentales asi bien ajuas ajuas XD
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
   
  #Programas tuyos papoi
  programs.gpu-screen-recorder.enable = true;
  programs.zsh.enable = true;
  programs.fish.enable = true;
  programs.hyprland.enable = true;
  programs.niri.enable = true;
  programs.steam.enable = true;
  programs.tmux.enable = true;
  programs.serpantinum.enable = true;
  programs.obs-studio = {
  enable = true;
  enableVirtualCamera = true; 
  plugins = with pkgs.obs-studio-plugins; [
    wlrobs                  
    obs-pipewire-audio-capture
    ];
  };

  #equidege
  xdg.portal = {
  enable = true;
  extraPortals = [
     pkgs.xdg-desktop-portal-gnome    
     pkgs.xdg-desktop-portal-hyprland   
    ];
  };
  
  #Servicios
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;
  };
  services.libinput.enable = true;   
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.flatpak.enable = true; 
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  services.gnome.gnome-keyring.enable = true;
    
 
  #Seguridad parapapa
  security.rtkit.enable = true;
  security.polkit.enable = true;
  security.sudo.enable = false;
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

  #nipu, nipu? si, niputa idea
  qt.enable = true;
  programs.dconf.enable = true;
  
  #variables de sesion de alch no se que
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "Bibata-Modern-Classic";
    HYPRCURSOR_SIZE = "24";
       XDG_DATA_DIRS = [ "${pkgs.catppuccin-gtk}/share" "${pkgs.papirus-icon-theme}/share" ];
  };
  environment.etc = {
  "X11/cursors/Bibata-Modern-Classic.theme".text = ''
    [Icon Theme]
    Inherits=Bibata-Modern-Classic
  '';
};


  #fuentes pipirisnais
  fonts.packages = with pkgs; [
    nerd-fonts.hurmit
    noto-fonts
    noto-fonts-color-emoji
    liberation_ttf
    material-symbols
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
   inputs.serpantinum.packages.${stdenv.hostPlatform.system}.default
   onlyoffice-desktopeditors
   tor-browser
   quickshell
   grim
   slurp
   swappy
   wl-clipboard
   gpu-screen-recorder
   fuzzel
   cliphist
   libnotify
   dart-sass
   app2unit
   glib
   dconf
   gimp
   busybox
   vim
   peaclock
   wayvnc
   jq
   git 
   wget
   fetch
   brightnessctl
   firefox
   screenfetch
   hyprcursor
   bibata-cursors
   cava
   pipes
   helix
   cmatrix
   cowsay
   lolcat
   fetch
   playerctl
   btop
   spotify
   discord
   waybar
   jq
   xwayland-satellite
   libxcb-cursor
   xsettingsd
   gamescope
   prismlauncher
   ninvaders
   bastet
   catppuccin-gtk
   papirus-icon-theme
   cargo
   gcc
   rustc
   pkg-config
   openssl
   curl
   glib
   gtk3
   libsoup_3
   pango
   atk
   gdk-pixbuf
   libX11
   libXcursor
   libXrandr
   libXi
   libglvnd
   alsa-lib                
    fontconfig
    freetype
    libayatana-appindicator   
    wayland
    libxkbcommon
    appimage-run
    desktop-file-utils
    slstatus
    picom
    matugen
    awww
    adw-gtk3
    gpu-screen-recorder
    slurp
    ];

  #ya van muchos idk, ahora en espanish niputaidea
  networking.firewall.allowedTCPPorts = [ 5900  ];
  
  
  programs.nix-ld.libraries = with pkgs; [
   glib gtk3 pango atk gdk-pixbuf cairo harfbuzz
   fontconfig freetype libayatana-appindicator
   wayland libxkbcommon openssl xdotool
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
   services.openssh.enable = true;

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
  system.stateVersion = "26.11"; # Did you read the comment?


}
