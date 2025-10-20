{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "eswanson224";
        email = "eswanson224@proton.me";
      };
      extraConfig = {
        init = { defaultBranch = "master"; };
        push = { autoSetupRemote = true; };
      };
    };
  };
}
