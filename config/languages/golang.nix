{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.nvim.binds) mkKeymap;
in {
  vim.languages.go = {
    dap.enable = false;
    enable = true;
    lsp.enable = true;
    treesitter.enable = true;
    format = {
      enable = true;
    };
  };

  vim.lsp.servers = {
    golangci_lint_ls = {
      filetypes = ["go"];
      rootPatterns = [".golangci.yml" ".golangci.toml"];
    };
  };

  vim.extraPackages = with pkgs; [
    golangci-lint
    golangci-lint-langserver

    # packages for gopher-nvim
    gomodifytags
    impl
    gotests
    iferr
    internal.json2go
  ];

  # Filetype icons
  vim.mini.icons.setupOpts = {
    file = {
      ".go-version" = {
        glyph = "";
        hl = "MiniIconsBlue";
      };
    };
    filetype = {
      gotmpl = {
        glyph = "󰟓";
        hl = "MiniIconsGrey";
      };
    };
  };

  # gopher.nvim

  vim.lazy.plugins.gopher-nvim = {
    package = pkgs.internal.gopher-nvim;
    setupModule = "gopher";
    setupOpts = {};
    ft = ["go" "gomod" "gotmpl"];
  };

  vim.binds.whichKey.register = {
    "<leader>cg" = "+Golang";
  };
  vim.keymaps = [
    (mkKeymap "n" "<leader>cgt" "<CMD>GoTagAdd json<CR>" {
      desc = "Add JSON tags to struct fields";
      silent = true;
    })
    (mkKeymap "n" "<leader>cgr" "<CMD>GoTagRemove json<CR>" {
      desc = "Remove JSON tags from struct fields";
      silent = true;
    })
    (mkKeymap "n" "<leader>cge" "<CMD>GoIfErr<CR>" {
      desc = "Add if err != nil block for the previous statement";
      silent = true;
    })
    (mkKeymap "n" "<leader>cgw" ''<CMD>GoIfErr fmt.Errorf("failed to : %w", err)<CR><CMD>lua vim.defer_fn(function() local pos = vim.fn.searchpos("failed to : %w", "bn") vim.fn.cursor(pos[1], pos[2] + 10) vim.cmd("startinsert") end, 10)<CR>'' {
      desc = "Add if err != nil block with fmt.Errorf for the previous statement";
      silent = true;
    })
  ];
}
