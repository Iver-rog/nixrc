{ config, pkgs, user, ... }:{
  users.users.${user} = {
    packages = with pkgs; [
      tor-browser
    ];
  };
}
