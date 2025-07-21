{lib, ...}: {
  vim.luaConfigRC.usercmds = lib.util.createUserCommand {
    command = "CopyCodeBlock";
    callback = ''
      function(opts)
        local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, true)
        local content = table.concat(lines, "\n")
        local result = string.format("```%s\n%s\n```", vim.bo.filetype, content)
        vim.fn.setreg("+", result)
      end
    '';
    opts = {range = true;};
  };
}

