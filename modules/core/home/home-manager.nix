{ self, ... }:
{
  flake.modules.homeManager = {
    core.imports = [ self.modules.homeManager.home-manager ];

    home-manager =
      { config, user, ... }:
      {
        home = {
          username = user.name;
          homeDirectory = "/home/${user.name}";
          file."Trash".source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.dataHome}/Trash/files";
        };
        news.display = "silent";

        programs.home-manager.enable = true;
      };
  };
}
