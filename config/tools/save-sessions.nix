{pkgs, ...}: {
  vim.lazy.plugins."persistence.nvim" = {
    package = pkgs.vimPlugins.persistence-nvim;
    event = "VimEnter";
    setupModule = "persistence";
    setupOpts = {};
    after = ''
      local argv = vim.fn.argv()
      if type(argv) == "string" then
        argv = { argv }
      end

      if next(argv) == nil then
        require("persistence").load()

        -- Force refresh buffers after session load to ensure everything is loaded correctly
        vim.defer_fn(function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, 'buflisted') then
              vim.api.nvim_exec_autocmds('BufReadPost', { buffer = buf })
              vim.api.nvim_exec_autocmds('FileType', { buffer = buf })
            end
          end
        end, 100)

        vim.notify("Session loaded", vim.log.levels.INFO, { title = "Persistence" })
      end
    '';
  };
}
