{ config, pkgs, ... }:

{
  imports = [
    ./lib-home/tmux.nix
    ./lib-home/nvim/nvim.nix
    ./lib-home/alacritty.nix
    ./lib-home/starship.nix
  ];

  home.packages = [
    (import ./lib-home/vm-script.nix { inherit pkgs; })
  ] ++ (import ./lib/development.nix { inherit pkgs; }).packages;

  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      sl = "ls";
      myhint = "echo 'sudo nixos-rebuild switch --flake ./.#iver \ncloc'";
      grep = "grep --color=auto";
      octave = "octave --silent";
      ntnu = "cd /home/iver/Documents/NTNU";
      rust = "cd /home/iver/Documents/Programering/Rust";
      nivm = "nvim";
      ls = "lsd";
      y = "yazi";
    };
    bashrcExtra = ''
      set -o vi
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

  home.file.".inputrc".text = ''
    set show-mode-in-prompt on
    set vi-cmd-mode-string "\1\e[2 q\2"
    set vi-ins-mode-string "\1\e[6 q\2"
  '';

  programs.git = {
    enable = true;
    userName = "iver";
    userEmail = "iverrog@gmail.com";
    diff-so-fancy = {
      enable = true;
    };
    extraConfig.credential.helper = "manager";
    extraConfig.credential."https://github.com".username = "Iver-rog";
    extraConfig.credential.credentialStore = "cache";
  };

  home.file.".octaverc".text = ''
    PS1 ('\033[34m\033[039;044m octave:\#\033[049;034m\033[032;001m\w> \033[039;000m')
  '';

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  home.file.".config/solaar/rules.yaml".text = ''
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
}

