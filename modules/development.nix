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
    clippy
    rustfmt
    cmake
    gcc
    openssl
    pkg-config
    rust-bindgen
    rustc
    trunk
    cargo-generate
    lld
    cursor-cli
    jq
    # opencode
  ];
  environment.variables."PKG_CONFIG_PATH" = "${pkgs.openssl.dev}/lib/pkgconfig";

  virtualisation.docker = {
    enable = true;
  };
  users.users.${username}.extraGroups = [ "docker" ];
}
