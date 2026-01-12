{
  pkgs,
  username,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    nil
    nixd
    mesa
    vulkan-tools
    gh
    cargo
    sqlx-cli
    rust-analyzer
    wasm
    wasm-pack
    prettier
    qt6.qtdeclarative
    ffmpeg-full
  ];

  virtualisation.docker = {
    enable = true;
  };
  users.users.${username}.extraGroups = [ "docker" ];
}
