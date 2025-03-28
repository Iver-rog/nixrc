{ pkgs, fetchFromGitHub,  ... }:
let
  resurrectDirPath = "~/.config/tmux/resurrect";

  mkTmuxPlugin = pkgs.tmuxPlugins.mkTmuxPlugin;
in
{
  programs.tmux = {
    enable = true;
    prefix = "C-Space";
    mouse = true;
    terminal = "tmux-256color";
    historyLimit = 100000;
    keyMode = "vi";
    baseIndex = 1;
    clock24 = true;
    sensibleOnTop = true;
    
    plugins = with pkgs;[
      tmuxPlugins.better-mouse-mode
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor 'frappe'
          set -g @catppuccin_window_tabs_enabled on
          set -g @catppuccin_date_time "%H:%M"
        '';
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
          
          # This three lines are specific to NixOS and they are intended
          # to edit the tmux_resurrect_* files that are created when tmux
          # session is saved using the tmux-resurrect plugin. Without going
          # into too much details the strings that are saved for some applications
          # such as nvim, vim, man... when using NixOS, appimage, asdf-vm into the
          # tmux_resurrect_* files can't be parsed and restored. This addition
          # makes sure to fix the tmux_resurrect_* files so they can be parsed by
          # the tmux-resurrect plugin and successfully restored.
          set -g @resurrect-dir ${resurrectDirPath}
          set -g @resurrect-hook-post-save-all 'sed -i -E "s|(pane.*nvim\s*:)[^;]+;.*\s([^ ]+)$|\1nvim \2|" ${resurrectDirPath}/last'
          '';
      }
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10'
        '';
      }
    ];
    extraConfig = ''
      bind O display-popup -B -E -h 75% -w 75% /home/iver/Documents/Programering/Rust/sessionx-clone/target/release/sessionx-clone 
      '';
  };
}
