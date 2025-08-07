{ ... }:

{
  programs.git = {
    enable = true;
    userName = "eswanson224";
    userEmail = "eswanson224@proton.me";
    extraConfig = {
      init = { defaultBranch = "main"; };
      push = { autoSetupRemote = true; };
    };
  };
}
