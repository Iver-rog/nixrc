{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.8;
        blur = true;
      };
      font = {
        normal = { family = "JetBrainsMono Nerd Font"; style = "Regular"; };
      };
    };
  };
}
