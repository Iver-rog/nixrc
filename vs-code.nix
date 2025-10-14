{ pkgs, user, ... }:
{
  users.users.${user}.packages = with pkgs; [
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        bbenoist.nix
        vadimcn.vscode-lldb
        mkhl.direnv
        ms-python.python
        vscodevim.vim
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        ms-vscode.hexeditor
        ms-python.debugpy
      ];
    })
  ];
}
