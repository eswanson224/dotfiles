{ lib, niriEnabled, ... }:

{
  imports = lib.optionals niriEnabled [ ../../niri ];
}
