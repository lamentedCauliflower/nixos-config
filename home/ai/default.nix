{
  pkgs,
  ...
}:
{
  imports = [
    ./opencode.nix
  ];

  home = {
    packages = with pkgs; [
      lmstudio
    ];
  };

  programs.mcp.servers = {
    context7 = {
      enable = true;
      url = "https://mcp.context7.com/mcp";
      headers = {
        CONTEXT7_API_KEY = "{env:CONTEXT7_API_KEY}";
      };
    };
  };
}
