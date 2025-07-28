{lib, ...}: {
  vim.autocmds = [
    {
      event = ["TextYankPost"];
      desc = "Highlight when yanking (copying) text";
      callback = lib.generators.mkLuaInline ''
        function()
          vim.hl.on_yank()
        end
      '';
    }
    # NOTE: this seems like a bug somewhere, try removing eventually to see if it's fixed
    {
      event = ["BufLeave" "WinLeave"];
      desc = "Close Floating Windows on Buffer Switch";
      callback = lib.generators.mkLuaInline ''
        function()
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_is_valid(win) then
              if vim.api.nvim_win_get_config(win).relative == "win" then
                vim.api.nvim_win_close(win, false)
              end
            end
          end
        end
      '';
    }
  ];
}
