{
  pkgs,
  lib,
  ...
}: {
  # Basic configuration

  vim.languages.python = {
    enable = true;
    dap.enable = false;
    lsp.enable = false;
    treesitter.enable = true;
    format = {
      enable = true;
      type = "ruff";
    };
  };

  vim.extraPackages = [
    pkgs.basedpyright
    pkgs.ruff
    pkgs.prettier
  ];

  # Configure LSPs

  vim.lsp.servers = {
    "basedpyright" = {
      cmd = ["basedpyright-langserver" "--stdio"];
      root_markers = [
        ".git"
        "Pipfile"
        "pyproject.toml"
        "pyrightconfig.json"
        "requirements.txt"
        "setup.cfg"
        "setup.py"
      ];
      filetypes = ["python"];
      single_file_support = true;
      settings = {
        basedpyright = {
          analysis = {
            autoSearchPaths = true;
            disableOrganizeImports = true; # Use Ruff's import organiser
            diagnosticMode = "openFilesOnly";
            useLibraryCodeForTypes = false; # disable library type analysis
          };
        };
        python = {
          analysis = {
            ignore = ["*"]; # Ignore all files for analysis to exclusively use Ruff for linting
          };
        };
      };
    };
    "ruff" = {
      cmd = ["ruff" "server"];
      filetypes = ["python"];
      root_markers = [
        ".git"
        "pyproject.toml"
        "ruff.toml"
        "setup.py"
        "setup.cfg"
        "requirements.txt"
      ];
      single_file_support = true;
      init_options = {
        settings = {
          logLevel = "info";
        };
      };
    };
  };

  # Fix conflict between BasedPyright and Ruff LSP servers for hover information

  vim.autocmds = [
    (lib.util.mkLspAttachCallback [
      {
        clientName = "ruff";
        desc = "Disable Ruff hoverProvider";
        code = lib.generators.mkLuaInline ''
          client.server_capabilities.hoverProvider = false
        '';
      }
    ])
  ];

  # Textual CSS (TCSS) support

  vim.lazy.plugins.nvim-tcss = {
    package = pkgs.internal.nvim-tcss;
    setupModule = "tcss";
    lazy = true;
    event = ["BufReadPre *.tcss" "BufNewFile *.tcss"];
  };

  vim.formatter.conform-nvim = {
    setupOpts = {
      formatters_by_ft.tcss = ["prettier_tcss"];
      formatters.prettier_tcss = {
        command = "prettier";
        args = ["--stdin-filepath" "$FILENAME" "--parser" "css"];
        stdin = true;
      };
    };
  };
}
