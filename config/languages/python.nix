{
  pkgs,
  lib,
  ...
}: {
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
  ];

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

  vim.autocmds = [
    {
      event = ["LspAttach"];
      desc = "LSP: Disable hover capability from Ruff";
      callback = lib.generators.mkLuaInline ''
        function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client == nil then
            return
          end
          if client.name == 'ruff' then
            client.server_capabilities.hoverProvider = false
          end
        end
      '';
    }
  ];
}
