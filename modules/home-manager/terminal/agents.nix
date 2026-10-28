{ pkgs, inputs, ... }:

{
  programs = {
    herdr = {
      enable = true;
      package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.herdr;
    };
    codex = {
      enable = true;
      package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.codex;
    };
    pi-coding-agent = {
      enable = true;
      package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.pi;
      # pi-sandbox uses bubblewrap and a network proxy on Linux. Node supplies
      # npm for Pi's package manager; packages must be installed with pi update.
      extraPackages = with pkgs; [
        nodejs
        bubblewrap
        socat
        ripgrep
      ];
      settings = {
        # Built-in codemode can batch tool calls and filter results before they
        # enter the model context; ordinary tools remain available too.
        defaultTools = [ "+codemode" ];
        packages = [ "npm:pi-sandbox@0.7.2" ];
      };
    };
    claude-code = {
      enable = true;
      package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code;
    };
  };
}
