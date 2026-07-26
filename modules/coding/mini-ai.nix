{
  flake.modules.nvf.coding-mini-ai = {lib, ...}: {
    vim.mini.ai = {
      enable = true;

      setupOpts = {
        custom_textobjects = {
          # Without dot in function names
          U = lib.generators.mkLuaInline ''
            require("mini.ai").gen_spec.function_call({ name_pattern = "[%w_]" })
          '';

          # Classes
          c = lib.generators.mkLuaInline ''
            require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" })
          '';

          # Digits
          d = ["%f[%d]%d+"];

          # Word with case
          e = [
            ["%u[%l%d]+%f[^%l%d]" "%f[%S][%l%d]+%f[^%l%d]" "%f[%P][%l%d]+%f[^%l%d]" "^[%l%d]+%f[^%l%d]"]
            "^().*()$"
          ];

          # Functions
          f = lib.generators.mkLuaInline ''
            require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" })
          '';

          # Code blocks
          o = lib.generators.mkLuaInline ''
            require("mini.ai").gen_spec.treesitter({
              a = { "@block.outer", "@conditional.outer", "@loop.outer" },
              i = { "@block.inner", "@conditional.inner", "@loop.inner" },
            })
          '';

          # Nix double single-quoted strings
          q = ["''().-()''"];
          # Tags
          t = ["<([%p%w]-)%f[^<%w][^<>]->.-</%1>" "^<.->().*()</[^/]->$"];

          # Usage
          u = lib.generators.mkLuaInline ''
            require("mini.ai").gen_spec.function_call()
          '';
        };

        n_lines = 500;
      };
    };
  };
}
