{ ... }:

let
  quant = 128;
in
{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig = {
      pipewire-pulse."92-low-latency" = {
        "context.properties" = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = { };
          }
        ];
        "pulse.properties" = {
          "pulse.min.req" = "${toString quant}/48000";
          "pulse.default.req" = "${toString quant}/48000";
          "pulse.max.req" = "${toString quant}/48000";
          "pulse.min.quantum" = "${toString quant}/48000";
          "pulse.max.quantum" = "${toString quant}/48000";
        };
        "stream.properties" = {
          "node.latency" = "${toString quant}/48000";
          "resample.quality" = 1;
        };
      };
      pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = quant;
          "default.clock.min-quantum" = quant;
          "default.clock.max-quantum" = quant;
        };
      };
    };
  };
}
