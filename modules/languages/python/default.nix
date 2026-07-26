{
  flake.modules.nvf.languages-python = {
    lib,
    pkgs,
    ...
  }: {
    vim = {
      # Basic configuration
      languages.python = {
        enable = true;
        dap.enable = false;

        format = {
          enable = true;
          type = ["ruff"];
        };

        lsp.enable = false;
        treesitter.enable = true;
      };

      # Textual CSS (TCSS) support
      lazy.plugins.nvim-tcss = {
        package = pkgs.internal.nvim-tcss;
        lazy = true;
        setupModule = "tcss";
        event = ["BufReadPre *.tcss" "BufNewFile *.tcss"];
      };

      # Fix conflict between BasedPyright and Ruff LSP servers for hover information
      autocmds = [
        (lib.util.mkLspAttachCallback [
          {
            clientName = "ruff";

            code = lib.generators.mkLuaInline ''
              client.server_capabilities.hoverProvider = false
            '';

            desc = "Disable Ruff hoverProvider";
          }
        ])
      ];

      extraPackages = [
        pkgs.basedpyright
        pkgs.ruff
        pkgs.prettier
      ];

      formatter.conform-nvim.setupOpts = {
        formatters.prettier_tcss = {
          args = ["--stdin-filepath" "$FILENAME" "--parser" "css"];
          command = "prettier";
          stdin = true;
        };

        formatters_by_ft.tcss = ["prettier_tcss"];
      };

      # Configure LSPs
      lsp.servers = {
        "basedpyright" = {
          cmd = ["basedpyright-langserver" "--stdio"];
          filetypes = ["python"];

          root_markers = [
            ".git"
            "Pipfile"
            "pyproject.toml"
            "pyrightconfig.json"
            "requirements.txt"
            "setup.cfg"
            "setup.py"
          ];

          settings = {
            basedpyright.analysis = {
              autoSearchPaths = true;
              diagnosticMode = "openFilesOnly";
              disableOrganizeImports = true; # Use Ruff's import organiser
              useLibraryCodeForTypes = false; # disable library type analysis
            };

            python.analysis = {
              ignore = ["*"]; # Ignore all files for analysis to exclusively use Ruff for linting
            };
          };

          single_file_support = true;
        };

        "ruff" = {
          cmd = ["ruff" "server"];
          filetypes = ["python"];
          init_options.settings.logLevel = "info";

          root_markers = [
            ".git"
            "pyproject.toml"
            "ruff.toml"
            "setup.py"
            "setup.cfg"
            "requirements.txt"
          ];

          single_file_support = true;
        };
      };
    };
  };
}
