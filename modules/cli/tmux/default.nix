{ pkgs,...}:
{
  programs = {
    tmux = {
      enable = true;
      historyLimit = 20000;
      terminal = "tmux-256color";
    };
  };
}
