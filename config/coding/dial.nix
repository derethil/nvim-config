{pkgs, ...}: {
  vim.lazy.plugins."dial.nvim" = {
    package = pkgs.vimPlugins.dial-nvim;
    lazy = true;
    keys = [
      {
        key = "<C-a>";
        mode = ["n" "v"];
        action = ''
          function()
            return require("dial.map").manipulate("increment", "normal")
          end
        '';
        lua = true;
        desc = "Increment";
      }
      {
        key = "<C-x>";
        mode = ["n" "v"];
        action = ''
          function()
            return require("dial.map").manipulate("decrement", "normal")
          end
        '';
        lua = true;
        desc = "Decrement";
      }
      {
        key = "g<C-a>";
        mode = ["n" "v"];
        action = ''
          function()
            return require("dial.map").manipulate("increment", "gnormal")
          end
        '';
        lua = true;
        desc = "Increment";
      }
      {
        key = "g<C-x>";
        mode = ["n" "v"];
        action = ''
          function()
            return require("dial.map").manipulate("decrement", "gnormal")
          end
        '';
        lua = true;
        desc = "Decrement";
      }
    ];
    after = ''
      local augend = require("dial.augend")

      local logical_alias = augend.constant.new({
        elements = { "&&", "||" },
        word = false,
        cyclic = true,
      })

      local ordinal_numbers = augend.constant.new({
        elements = {
          "first",
          "second",
          "third",
          "fourth",
          "fifth",
          "sixth",
          "seventh",
          "eighth",
          "ninth",
          "tenth",
        },
        word = false,
        cyclic = true,
      })

      local weekdays = augend.constant.new({
        elements = {
          "Monday",
          "Tuesday",
          "Wednesday",
          "Thursday",
          "Friday",
          "Saturday",
          "Sunday",
        },
        word = true,
        cyclic = true,
      })

      local months = augend.constant.new({
        elements = {
          "January",
          "February",
          "March",
          "April",
          "May",
          "June",
          "July",
          "August",
          "September",
          "October",
          "November",
          "December",
        },
        word = true,
        cyclic = true,
      })

      local capitalized_boolean = augend.constant.new({
        elements = {
          "True",
          "False",
        },
        word = true,
        cyclic = true,
      })

      local groups = {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.decimal_int,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          ordinal_numbers,
          weekdays,
          months,
          capitalized_boolean,
          augend.constant.alias.bool,
          logical_alias,
        },
        vue = {
          augend.constant.new({ elements = { "let", "const" } }),
          augend.hexcolor.new({ case = "lower" }),
          augend.hexcolor.new({ case = "upper" }),
        },
        typescript = {
          augend.constant.new({ elements = { "let", "const" } }),
        },
        css = {
          augend.hexcolor.new({
            case = "lower",
          }),
          augend.hexcolor.new({
            case = "upper",
          }),
        },
        markdown = {
          augend.constant.new({
            elements = { "[ ]", "[x]" },
            word = false,
            cyclic = true,
          }),
          augend.misc.alias.markdown_header,
        },
        json = {
          augend.semver.alias.semver,
        },
        lua = {
          augend.constant.new({
            elements = { "and", "or" },
            word = true,
            cyclic = true,
          }),
        },
        python = {
          augend.constant.new({
            elements = { "and", "or" },
          }),
        },
      }

      -- Copy defaults to each group
      for name, group in pairs(groups) do
        if name ~= "default" then
          vim.list_extend(group, groups.default)
        end
      end

      require("dial.config").augends:register_group(groups)

      vim.g.dials_by_ft = {
        css = "css",
        vue = "vue",
        javascript = "typescript",
        typescript = "typescript",
        typescriptreact = "typescript",
        javascriptreact = "typescript",
        json = "json",
        lua = "lua",
        markdown = "markdown",
        sass = "css",
        scss = "css",
        python = "python",
      }
    '';
  };
}
