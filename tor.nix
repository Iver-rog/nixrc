{ config, pkgs }:{
  users.users.iver = {
    packages = with pkgs; [
      tor-browser
    ];
  };
}
