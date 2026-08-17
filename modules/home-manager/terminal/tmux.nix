{ ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    mouse = true;
    historyLimit = 100000;
    escapeTime = 20;
    baseIndex = 1;
    keyMode = "vi";
    focusEvents = true;
    extraConfig = ''
      set -as terminal-features ",xterm-ghostty:RGB"
      set -g renumber-windows on

      bind c new-window -c "#{pane_current_path}"
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      bind PageUp copy-mode -u

      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      set -g set-clipboard on

      bind r source-file ~/.config/tmux/tmux.conf \; \
        display-message "tmux config reloaded"
    '';
  };
}
