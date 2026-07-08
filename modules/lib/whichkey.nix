{lib, ...}: {
  flake.lib.whichkey = {
    mkEntry = {
      key,
      desc,
      icon ? null,
      color ? null,
      group ? false,
    }: let
      iconAttr =
        if icon != null
        then
          ", icon = { icon = '${icon}'"
          + (lib.optionalString (color != null) ", color = '${color}'")
          + " }"
        else "";
      groupAttr = lib.optionalString group ", group = true";
    in "require('which-key').add({ { '${key}', desc = '${desc}'${groupAttr}${iconAttr} } })";
  };
}
