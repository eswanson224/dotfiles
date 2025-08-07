{ pkgs, ... }:

{
  btop = {
    enable = true;
    package = pkgs.btop-cuda;
  };
}
