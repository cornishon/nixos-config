{
  enable = true;
  defaultEditor = true;

  settings = {
    theme = "autumn_night";
    editor = {
      color-modes = true;
      scrolloff = 5;
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
        name = "typescript";
        auto-format = true;
        indent = {
          tab-width = 4;
          unit = " ";
        };
      }
      {
        name = "javascript";
        auto-format = true;
        indent = {
          tab-width = 4;
          unit = " ";
        };
      }
      {
        name = "rust";
        auto-format = true;
        indent = {
          tab-width = 4;
          unit = " ";
        };
      }
      {
        name = "nix";
        auto-format = true;
        formatter = {
          command = "nixfmt";
          args = [ ];
        };
      }
    ];
  };
}
