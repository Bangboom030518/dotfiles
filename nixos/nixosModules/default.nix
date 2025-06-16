{ config, pkgs, lib, home-manager, ... }:
{
  imports = [
    ./nixosSupport.nix
  ];

  networking.networkmanager.enable = true;
  time.timeZone = "Europe/London";
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
  environment.pathsToLink = [ "/share/zsh" ];

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
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-mono
    noto-fonts-color-emoji
  ];

  users.users.charlie = {
    isNormalUser = true;
    description = "General Minaj";
    extraGroups = [ "networkmanager" "wheel" ];
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
    libfprint
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
    anki
    nnn
    turso-cli
    cargo-shuttle
    gimp3
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
    decibels
    tor-browser
    eyedropper
    typst
  ];
  users.defaultUserShell = pkgs.zsh;
  powerManagement.powertop.enable = true;
  programs.starship.enable = true;
  programs.zsh.enable = true;
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      zlib
      openssl.dev
    ];
  };
  environment.gnome.excludePackages = [
    pkgs.gnome-tour
  ];
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

  services.tor = {
    enable = true;
    torsocks.enable = true;
    client.enable = true;
    settings = {
      ControlPort = 9051;
    };
  };

}
