{
  pkgs,
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
  ];
}
