{ config, pkgs, ... }:

{
  imports = [
    ./lib-home/tmux.nix
    ./lib-home/nvim/nvim.nix
    ./lib-home/alacritty.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "iver";
  home.homeDirectory = "/home/iver";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    (import ./lib-home/vm-script.nix { inherit pkgs; })
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/iver/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      sl = "ls";
      myhint = "echo sudo nixos-rebuild switch --flake ./.#iver";
      grep = "grep --color=auto";
      octave = "octave --silent";
      ntnu = "cd /home/iver/Documents/NTNU";
      rust = "cd /home/iver/Documents/Programering/Rust";
      nivm = "nvim";
      ls = "lsd";
    };
    bashrcExtra = ''
      eval "$(direnv hook bash)"

      # function for switching git branches using fzf
      gitb() {
        local branches branch
        branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
        branch=$(echo "$branches" |
                 fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
        git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
      }
    '';
  };
  programs.git = {
    enable = true;
    userName = "iver";
    userEmail = "iverrog@gmail.com";
    # difftastic = {
    #   enable = true;
    # };
    diff-so-fancy = {
      enable = true;
    };
    extraConfig.credential.helper = "manager";
    extraConfig.credential."https://github.com".username = "Iver-rog";
    extraConfig.credential.credentialStore = "cache";
  };
  home.file = {
    ".octaverc".text = ''
    PS1 ('\033[34m\033[039;044m octave:\#\033[049;034m\033[032;001m\w> \033[039;000m')
    '';
  };
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
  dconf.settings = { # vm-setting
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
  home.file = {
    ".config/solaar/rules.yaml".text = ''
    %YAML 1.3
    ---
    - MouseGesture: Mouse Left
    - KeyPress:
      - [Super_L, Control_L, Left]
      - click
    ...
    ---
    - MouseGesture: Mouse Right
    - KeyPress:
      - [Super_L, Control_L, Right]
      - click
    ...
    ---
    - MouseGesture: Mouse Down
    - KeyPress:
      - [Super_L, w]
      - click
    ...
    '';
  };
}
