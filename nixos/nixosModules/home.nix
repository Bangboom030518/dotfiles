{ config, pkgs, lib, ... }:
{
  xdg = {
    enable = true;
    configFile."nvim".source = ../../nvim;
    configFile."mimeapps.list".source = ../../mimeapps.list;
  };

  home.sessionVariables = {
    PATH = "$PATH:$HOME/.fzf/bin:$HOME/bin:$HOME/.zvm/bin:$HOME/.zvm/self:$HOME/.npm-global/bin:$HOME/.cargo/bin";
    EDITOR = "nvim";
    TERMINAL = "console";
    BROWSER = "web";
  };
  /*
      zinit ice as"command" from"gh-r" \
         atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
         atpull"%atclone" src"init.zsh"

      zinit light chisui/zsh-nix-shell
      zinit snippet OMZP::git

      zinit ice depth=1
      zinit light jeffreytse/zsh-vi-mode

      zinit cdreplay -q

      zinit snippet OMZP::git

      zinit cdreplay -q

      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu no

      [ -f $HOME/.cargo/env ] && . "$HOME/.cargo/env"

      command -v fzf &> /dev/null && eval "$(fzf --zsh)"
    */
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      append = true;
      findNoDups = true;
      ignoreAllDups = true;
      saveNoDups = true;
    };
    shellAliases = {
      vim = "nvim";
    };
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      format = lib.concatStrings [ "$nix_shell" "$username" "[](bg:#51576d fg:#a6d189)" "$directory" "[](fg:#51576d) " ];
      add_newline = false;
      username = {
        show_always = true;
        disabled = false;
        style_user = "bg:#a6d189 fg:#51576d";
        style_root = "bg:#a6d189 fg:#51576d";
        format = "[ $user ]($style)";
      };
      right_format = "$git_branch $time";
      nix_shell = {
        style = "fg:black bg:blue";
        format = "[ $name ]($style)[](fg:blue bg:#a6d189)";
      };
      git_branch = {
        style = "fg:#a5adce";
        format = "[$symbol$branch]($style)";
      };
      time = {
        disabled = false;
        style = "fg:#a5adce";
        use_12hr = false;
        format = "[$time]($style)";
      };
      directory = {
        style = "fg:#c6d0f5 bg:#51576d";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };
    };
  };
  home.packages = with pkgs.gnomeExtensions; [
    dash-to-dock
    clipboard-history
    hibernate-status-button
    app-hider
  ];
  dconf = {
    enable = true;

    settings = {
      "org/gnome/desktop/interface" = {
        gtk-enable-primary-paste = false;
      };

      "org/gnome/shell" = {
        enabled-extensions = with pkgs.gnomeExtensions; [
          dash-to-dock.extensionUuid
          clipboard-history.extensionUuid
          hibernate-status-button.extensionUuid
          app-hider.extensionUuid
        ];
      };

      "org/gnome/shell/extensions/app-hider" = {
        hidden-apps = [ "btop.desktop" "mpv.desktop" "nvim.desktop" "nnn.desktop" ];
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        show-trash = false;
      };
    };
  };

  home.stateVersion = "24.11";
}
