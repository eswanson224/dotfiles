{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    languages = {
      language = [{
        name = "latex";
        soft-wrap.enable = true;
        language-servers = ["texlab"];
      }];
      language-server.texlab.config.texlab.chktex = {
        onOpenAndSave = true;
        onEdit = true;
      };
      language-server.texlab.config.texlab.forwardSearch = {
        executable = "zathura";
        args = [ "--synctex-forward" "%l:1:%f" "%p" ];
      };
      language-server.texlab.config.texlab.build = {
        forwardSearchAfter = true;
        onSave = true;
        auxDirectory = "build";
        logDirectory = "build";
        pdfDirectory = "build";
        executable = "helix-tectonic";
        args = [ "%f" ];
      };
    };
  };
  home.packages = [
    (pkgs.writeShellScriptBin "helix-tectonic" ''
      #!/bin/sh

      mkdir -p build
      tectonic -X compile --synctex --keep-logs --keep-intermediates --outdir=build --only-cached $1
    '')
    pkgs.texlab
  ];
}
