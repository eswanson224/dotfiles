{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "eswanson224";
        email = "erik@swanso.nz";
      };
      extraConfig = {
        init = {
          defaultBranch = "master";
        };
        push = {
          autoSetupRemote = true;
        };
      };
    };
  };
}
