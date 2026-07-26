{
  flake.modules.nvf.languages-golang-keymaps = {lib, ...}: let
    inherit (lib.nvim.binds) mkKeymap;
  in {
    vim = {
      binds.whichKey.register."<leader>cg" = "+Golang";

      keymaps = [
        (mkKeymap "n" "<leader>cgt" "<CMD>GoTagAdd json<CR>" {
          silent = true;
          desc = "Add JSON tags to struct fields";
        })
        (mkKeymap "n" "<leader>cgr" "<CMD>GoTagRemove json<CR>" {
          silent = true;
          desc = "Remove JSON tags from struct fields";
        })
        (mkKeymap "n" "<leader>cge" "<CMD>GoIfErr<CR>" {
          silent = true;
          desc = "Add if err != nil block for the previous statement";
        })
        (mkKeymap "n" "<leader>cgw" ''<CMD>GoIfErr fmt.Errorf("failed to : %w", err)<CR><CMD>lua vim.defer_fn(function() local pos = vim.fn.searchpos("failed to : %w", "bn") vim.fn.cursor(pos[1], pos[2] + 10) vim.cmd("startinsert") end, 10)<CR>'' {
          silent = true;
          desc = "Add if err != nil block with fmt.Errorf for the previous statement";
        })
      ];
    };
  };
}
