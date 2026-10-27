{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty.overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [
        # Remove once nixpkgs includes the systemd 262 startup fix (Ghostty 1.4).
        # https://github.com/ghostty-org/ghostty/pull/14399
        (pkgs.fetchpatch2 {
          url = "https://github.com/ghostty-org/ghostty/commit/1a9edb0009a7e4fd87d2eca5d61386ce0c2b7e9d.patch";
          hash = "sha256-hl/95VfUNMEsqx8U3c2Aj+mN71+FOwqkPTPWCcIn0AQ=";
        })
      ];
    });
    # package = pkgs.ghostty;
    settings = {
      gtk-single-instance = true;
      window-decoration = "auto";
      shell-integration-features = "ssh-env,ssh-terminfo";
    };
  };
}
