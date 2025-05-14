{ config, pkgs, lib, ... }:
let
  home-manager = builtins.fetchTarball {
    url = https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz;
    sha256 = "sha256:1vf41h2362jk6qxih57wx779i1sqmd98j49cw5z6mhxs429apzhg";
  };
in
{
  imports = [
    (import "${home-manager}/nixos")
    ./nixosSupport.nix
  ];
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraMono" ]; })
    noto-fonts-color-emoji
  ];

  users.users.charlie = {
    isNormalUser = true;
    description = "General Minaj";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.users.charlie = { pkgs, ... }: {
    xdg = {
      enable = true;
      configFile."nvim".source = ../../nvim;
        };
      # The state version is required and should stay at the version you
      # originally installed.
      home.stateVersion = "24.11";
    };

    environment.systemPackages = with pkgs; [
      neovim
      lshw
      github-cli
      git
      rustup
      neofetch
      zsh
      fprintd
      clang
      nodejs
      wl-clipboard
      ripgrep
      tmux
      vscode
      tailwindcss
      pkg-config
      python3
      google-chrome
      powertop
      # nvtopPackages.intel
      anki
      nnn
      turso-cli
      cargo-shuttle
      gimp
      btop
      yt-dlp
      ffmpeg
      pavucontrol
      libreoffice-qt
      hunspell
      hunspellDicts.uk_UA
      hunspellDicts.th_TH
      mpv
      gnumake
      mcpelauncher-ui-qt
      steam
      slack
      spotify
      audacity
      mysql-workbench
      decibels
    ];
    users.defaultUserShell = pkgs.zsh;
    powerManagement.powertop.enable = true;
    programs = {
      starship.enable = true;
      zsh.enable = true;
      nix-ld = {
        enable = true;
        libraries = with pkgs; [
          zlib
          openssl.dev
        ];
      };
    };
    environment.gnome.excludePackages = [ pkgs.gnome-tour ];
    services.xserver.excludePackages = [ pkgs.xterm ];
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    nixpkgs.config.allowUnfree = true;

    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
    };

  }
