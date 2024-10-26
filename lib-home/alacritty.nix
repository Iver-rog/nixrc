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
      # colors = {
      #   primary ={
      #     foreground = "#000000";
      #     background = "#ffe8cf";
      #   };
      # };
    };
  };
}
