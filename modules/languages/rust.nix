{
  flake.modules.nvf.languages-rust = {lib, ...}: {
    vim = {
      languages.rust = {
        enable = true;
        dap.enable = true;
        extensions.crates-nvim.enable = true;
        format.enable = true;
        lsp.enable = true;
        treesitter.enable = true;
      };

      autocmds = [
        {
          event = ["LspAttach"];

          callback = lib.generators.mkLuaInline ''
            function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if client and client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
              end
            end
          '';

          pattern = ["*.rs"];
          desc = "Enable inlay hints for Rust";
        }
      ];

      lsp.servers.rust_analyzer.init_options = ''
        ['rust-analyzer'] = {
          inlayHints = {
            lifetimeElisionHints = { enable = "always" },
            bindingModeHints = { enable = true },
          },
        },
      '';
    };
  };
}
