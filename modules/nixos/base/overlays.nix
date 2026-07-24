{ ... }:

{
  # Temporary package pins live here. Each overlay should say why it exists and
  # when it can be dropped, so cleanup is obvious once nixos-unstable catches up.
  nixpkgs.overlays = [
    (final: prev: {
      # Pinned to nixpkgs PR #545319 (claude-code 2.1.219) until it lands in
      # nixos-unstable. The upstream package is manifest-driven; we only need to
      # bump version + the x86_64-linux binary checksum for this single host.
      # Drop this override once `nix eval nixpkgs#claude-code.version` >= 2.1.219.
      claude-code = prev.claude-code.overrideAttrs (_: rec {
        version = "2.1.219";
        src = prev.fetchurl {
          url = "https://downloads.claude.ai/claude-code-releases/${version}/linux-x64/claude";
          sha256 = "22cfd6f5b3061c0391ba84e9cf8c9deaa37783aac18b004d42ec061e98f00691";
        };
      });
    })
  ];
}
