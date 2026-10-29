{ pkgs, inputs, ... }:

let
  herdr = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.herdr;
  herdrSkill = pkgs.runCommand "herdr-skill" { } ''
    ${herdr}/bin/herdr --skill > $out
  '';
in
{
  programs = {
    herdr = {
      enable = true;
      package = herdr;
    };
    codex = {
      enable = true;
      package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.codex;
    };
    pi-coding-agent = {
      enable = true;
      package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.pi;
      extraPackages = with pkgs; [
        nodejs
        bubblewrap
        socat
        ripgrep
      ];
      settings = {
        defaultTools = [ "+codemode" ];
        packages = [ "npm:pi-sandbox@0.7.3" "npm:@ff-labs/pi-fff@0.11.0" ];
      };
    };
    claude-code = {
      enable = true;
      package = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-code;
      skills.herdr = herdrSkill;
    };
  };
}
