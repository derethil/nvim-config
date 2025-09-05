{lib, ...}: {
  vim.usercmds = [
    {
      name = "CopyCodeBlock";
      callback = lib.generators.mkLuaInline ''
        function(opts)
          local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, true)
          local content = table.concat(lines, "\n")
          local result = string.format("```%s\n%s\n```", vim.bo.filetype, content)
          vim.fn.setreg("+", result)
        end
      '';
      desc = "Copy selected lines as a code block with syntax highlighting";
      range = true;
    }
  ];
}
