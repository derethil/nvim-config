{lib, ...}: {
  vim.usercmds = [
    {
      name = "CopyCodeBlock";
      callback =
        lib.generators.mkLuaInline
        /*
        lua
        */
        ''
          function(opts)
            -- Concatenate selected lines into a code block with syntax highlighting
            local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, true)

            -- Find minimum indentation to preserve relative indentation
            local min_indent = math.huge
            for _, line in ipairs(lines) do
              if line:match("%S") then -- ignore empty lines
                local indent = line:match("^%s*"):len()
                min_indent = math.min(min_indent, indent)
              end
            end

            -- Strip common indentation from all lines
            if min_indent < math.huge then
              for i, line in ipairs(lines) do
                if line:match("%S") then
                  lines[i] = line:sub(min_indent + 1)
                end
              end
            end

            local content = table.concat(lines, "\n")
            local result = string.format("```%s\n%s\n```", vim.bo.filetype, content)

            -- Copy to system clipboard
            vim.fn.setreg("+", result)

            -- Highlight the copied region
            local ns_id = vim.api.nvim_create_namespace("copy_code_block")
            vim.highlight.range(0, ns_id, "IncSearch", {opts.line1 - 1, 0}, {opts.line2 - 1, -1})
            vim.defer_fn(function()
              vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
            end, 150)
          end
        '';
      desc = "Copy selected lines as a code block with syntax highlighting";
      range = true;
    }
  ];
}
