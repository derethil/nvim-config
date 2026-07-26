{inputs, ...}: {
  flake-file.inputs.pedantix.url = "github:Swarsel/pedantix";

  flake = {
    modules.nvf.languages-nix = {
      lib,
      pkgs,
      ...
    }: let
      inherit (lib) getExe generators util;
    in {
      vim = {
        languages.nix = {
          enable = true;
          extraDiagnostics.enable = true;
          format.enable = false;

          lsp = {
            enable = true;
            servers = ["nixd"];
          };

          treesitter.enable = true;
        };

        autocmds = [
          (util.mkLspAttachCallback [
            {
              clientName = "nixd";

              code = lib.generators.mkLuaInline ''
                client.server_capabilities.documentFormattingProvider = false
              '';

              desc = "Disable nixd formatting (conform handles it)";
            }
          ])
        ];

        extraPackages = [
          pkgs.alejandra
        ];

        formatter.conform-nvim.setupOpts = {
          formatters.pedantix = {
            args = ["--formatter" "alejandra" "--stdin-filepath" "$FILENAME"];
            command = getExe pkgs.pedantix;
            stdin = true;
          };

          formatters_by_ft.nix = generators.mkLuaInline ''{ "pedantix", "alejandra", stop_after_first = true }'';
        };

        lsp.presets.nixd.enable = true;
      };
    };

    overlays.pedantix = final: _prev: {
      pedantix = inputs.pedantix.packages.${final.stdenv.hostPlatform.system}.default;
    };
  };
}
