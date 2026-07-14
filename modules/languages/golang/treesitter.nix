# Embedded SQL highlighting inside Go strings (GORM / database queries).
#
# HOW IT WORKS — four layers cooperate, ordered by treesitter highlight priority:
#
#   1. ./injections/go.scm         Matches GORM-ish calls like db.Raw("SELECT ...")
#                                  and tags the string content as `sql`, so the SQL
#                                  parser highlights keywords/etc.
#
#   2. Go string priority = 90     By default nvim-treesitter highlights every Go
#                                  string as @string at priority 100, which fights
#                                  the injected SQL. We lower it to 90 via a nixpkgs
#                                  patch (see below) so SQL always wins.
#
#   3. ./highlights/sql.scm        Applies @markup.normal at priority 95 to all SQL
#                                  nodes, so tokens the SQL grammar DOESN'T colour
#                                  (table/column names) fall back to Normal instead
#                                  of the green Go-string colour. 95 > 90 (beats the
#                                  string) but < 100 (real SQL keywords still win).
#
#   4. lsp.nix highlight overrides Make gopls' `@lsp.type.string.go` transparent so
#                                  semantic tokens don't repaint the string green,
#                                  and link `@markup.normal` -> Normal.
_: {
  flake.modules.nvf.languages-golang-treesitter = {
    vim.treesitter.queries = [
      {
        type = "injections";
        filetypes = ["go"];
        query = builtins.readFile ./injections/go.scm;
      }
      {
        type = "highlights";
        filetypes = ["sql"];
        query = builtins.readFile ./highlights/sql.scm;
      }
    ];
  };
}
