{
  # TODO: figure out how to encrypt stuff with sops-nix and add TAVILY_API_KEY environment variable

  vim.binds.whichKey.register = {"<leader>a" = "+AI";};

  vim.assistant.avante-nvim = {
    enable = true;
    setupOpts = {
      provider = "copilot";
      web_search_engine = {
        provider = "tavily"; # won't work until TAVILY_API_KEY is set
      };
      providers = {
        copilot = {
        };
      };
      auto_suggestions_provider = "copilot";
      auto_suggestions = {
        enabled = false;
      };
    };
  };

  vim.utility.images.img-clip = {
    enable = true;
    setupOpts = {
      default = {
        embed_image_as_base64 = false;
        prompt_for_file_name = false;
        drag_and_drop.insert_mode = true;
        use_absolute_path = true;
      };
    };
  };
}
