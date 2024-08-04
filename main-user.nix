{ lib, config, pkgs, ... }:
let
  cfg = config.main-user;
in
{
  options.main-user = {
    enable = lib.mkEnableOption "enable usr module";

    username = lib.mkOption {
      default = "mainuser";
      descripton = ''
      username
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      initialPassword = "1234";
      description = "main user";
      shell = pkgs.zsh;
    };
  };
}
