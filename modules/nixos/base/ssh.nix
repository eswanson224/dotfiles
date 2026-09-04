{ ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      AcceptEnv = [
        "COLORTERM"
        "TERM_PROGRAM"
        "TERM_PROGRAM_VERSION"
      ];
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}
