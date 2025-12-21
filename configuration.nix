{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Ho_Chi_Minh";
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "vi_VN";
    LC_IDENTIFICATION = "vi_VN";
    LC_MEASUREMENT = "vi_VN";
    LC_MONETARY = "vi_VN";
    LC_NAME = "vi_VN";
    LC_NUMERIC = "vi_VN";
    LC_PAPER = "vi_VN";
    LC_TELEPHONE = "vi_VN";
    LC_TIME = "vi_VN";
  };

  # X11 & Desktop Manager (Đã sửa lỗi cho bản 25.11)
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  # Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User Account (Đã thêm quyền Android/Docker)
  users.users.quocdai = {
    isNormalUser = true;
    description = "quocdai";
    extraGroups = [ "networkmanager" "wheel" "docker" "adbusers" "kvm" ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;
  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;
  virtualisation.docker.enable = true;

  # Bộ gõ Tiếng Việt
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5.addons =  [
      pkgs.fcitx5-bamboo
      pkgs.fcitx5-gtk
    ];
  };

  environment.variables = {
    GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };


  # Danh sách phần mềm
  environment.systemPackages = with pkgs; [
    # Version control
    git
    gh
    # Editor
    neovim
    vim
    # Terminal & Shell
    wezterm
    tmux
    zsh
    # Shell enhancement
    starship
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf
    # CLI UX
    bat
    lsd
    htop
    # Networking & utils
    curl
    wget
    unzip
    # Build tools
    gcc
    gnumake
    # Java / Android
    jdk21
    maven
    android-tools
  ];
  # Hỗ trợ chạy các file binary tải từ ngoài (như Android SDK)
  programs.nix-ld.enable = true;
  programs.adb.enable = true;

  system.stateVersion = "25.11";
}
