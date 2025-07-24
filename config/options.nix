{
  vim.globals = {
    mapleader = " ";
    maplocalleader = "\\";
  };

  vim.options = {
    ignorecase = true; # Ignore case in search patterns
    inccommand = "nosplit"; # Incremental command execution
    completeopt = "menu,popup,noinsert,noselect"; # Completion options
    conceallevel = 2; # Conceal level for hidden text
    confirm = true; # Confirm before overwriting files
    expandtab = true; # Use spaces instead of tabs
    mouse = "a"; # Enable mouse support
    mousemoveevent = true; # Enable mouse move events
    fillchars = "foldopen:,foldsep: ,foldclose:,fold: ,diff:╱,eob: "; # Customize fill characters
    foldlevel = 99; # Start with all folds open
    formatoptions = "jcroqlnt"; # Format options for text
    grepprg = "rg --vimgrep --no-heading --smart-case"; # Use ripgrep for searching
    jumpoptions = "view";
    laststatus = 3; # Always show the status line
    linebreak = true; # Break lines at word boundaries
    list = false; # Don't show whitespace characters
    number = true; # Show line numbers
    relativenumber = true; # Show relative line numbers
    pumblend = 10; # Popup menu transparency
    pumheight = 10; # Limit popup menu height
    ruler = false; # Disable the ruler
    sessionoptions = "buffers,curdir,tabpages,winsize,help,globals,skiprtp,folds"; # Save all session options
    shiftwidth = 2; # Indent size
    shiftround = true; # Round indent to shiftwidth
    shortmess = "ltToOCFWIc"; # Enable short messages
    signcolumn = "yes"; # Always show the sign column
    smartcase = true; # Enable smart case sensitivity
    smartindent = true; # Enable smart indentation
    spell = true; # Enable spell checking
    spelllang = "en"; # Set spell checking language
    splitbelow = true; # New horizontal splits go below
    splitkeep = "screen"; # Keep splits in the same screen
    splitright = true; # New vertical splits go to the right
    statuscolumn = "%{%v:lua.require'snacks.statuscolumn'.get()%}";
    tabstop = 2; # Tab stop size
    termguicolors = true; # Enable true color support
    timeoutlen = 300; # Quickly trigger which-key
    undofile = true; # Enable persistent undo
    undolevels = 10000; # Number of undo levels to keep
    updatetime = 200; # Save swap file after this many milliseconds
    virtualedit = "block"; # Allow virtual editing in all modes
    wildmode = "longest:full,full"; # Command-line completion mode
    winminwidth = 5; # Minimum width for windows
    wrap = false; # Line wrapping
    smoothscroll = true; # Smooth scrolling when line wrapped

    # Allow project-specific configurations
    exrc = true;
    secure = true;
  };
}
