{...}: {
  flake.modules.nvf.languages-golang-keymaps = {lib, ...}: let
    inherit (lib.nvim.binds) mkKeymap;
  in {
    vim.binds.whichKey.register."<leader>cg" = "+Golang";

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
  };
}
