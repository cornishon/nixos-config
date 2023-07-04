{ pkgs, inputs, ... }: {
  programs.helix = {
    enable = true;
    defaultEditor = true;

    package = inputs.helix.packages.${pkgs.hostPlatform.system}.default;

    settings = {
      theme = "amberwood";

      # Supertab
      keys.supertab = "move_parent_node_end";
      keys.select.tab = "move_parent_node_end";
      keys.normal.tab = "move_parent_node_end";
      keys.insert.S-tab = "move_parent_node_start";
      keys.select.S-tab = "move_parent_node_start";
      keys.normal.S-tab = "move_parent_node_start";

      keys.normal = {
        space.q = ":bc";
        A-w = [ ":format" ":write" ];
        esc = [ "collapse_selection" "keep_primary_selection" ];
        C-r = ":config-reload";
        X = "extend_line_above";
      };
      keys.insert = { A-w = [ "normal_mode" ":format" ":write" ]; };

      editor = {
        explorer.column-width = 32;
        sticky-context.enable = true;
        indent-guides.render = true;
        bufferline = "always";
        color-modes = true;
        scrolloff = 99;
        true-color = true;
        idle-timeout = 100;
        line-number = "relative";
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "block";
        };
      };
    };

    languages = {
      language = [
        {
          name = "nix";
          indent = {
            tab-width = 2;
            unit = " ";
          };
        }
        {
          name = "typescript";
          indent = {
            tab-width = 4;
            unit = " ";
          };
        }
        {
          name = "javascript";
          indent = {
            tab-width = 4;
            unit = " ";
          };
        }
        {
          name = "nix";
          auto-format = true;
          language-servers = [ "nil" ];
          formatter = {
            command = "nixfmt";
            args = [ ];
          };
        }
      ];

      language-server.rust-analyzer.config = { check.command = "clippy"; };
    };
  };

  home.packages = with pkgs; [
    # some other lsp related packages / dev tools
    typst
    shellcheck
    nodePackages.bash-language-server
    gawk
    # python
    black
    # javascript/typescript
    nodejs
    nodePackages.jsonlint
    nodePackages.yarn
    nodePackages.typescript-language-server
    vscode-langservers-extracted
    # rust/c/c++
    rustup
    mold
    lldb
    clang-tools
    gcc
    # nix lsp
    nil
  ];
}
