{ self, ... }:
{
  flake.modules.nixos = {
    gaming.imports = [ self.modules.nixos.steam ];

    steam = {
      programs.steam.config.apps = {
        "230410" = {
          name = "Warframe";
          compatTool = "Proton-GE";
          args = [ "--expose-wayland" ];
          env = {
            LD_PRELOAD = "";
          };
          allowDownloadsWhileRunning = "never";
          updateBehavior = "always";
          language = "italian";
        };

        "3357650" = {
          name = "Pragmata";
          compatTool = "Proton-GE";
          env = {
            LD_PRELOAD = "";
            PROTON_FSR4_RDNA3_UPGRADE = 1;
          };
          allowDownloadsWhileRunning = "never";
          updateBehavior = "always";
          language = "italian";
        };

        "3812600" = {
          name = "ReStory: Chill Electronics Repairs";
          compatTool = "Proton-GE";
          args = [ "--expose-wayland" ];
          env = {
            LD_PRELOAD = "";
          };
          allowDownloadsWhileRunning = "never";
          updateBehavior = "always";
        };

        "1593500" = {
          name = "God of War";
          compatTool = "Proton-GE";
          env = {
            LD_PRELOAD = "";
            LSFGVK_PROFILE = "2x";
          };
          allowDownloadsWhileRunning = "never";
          updateBehavior = "always";
          language = "italian";
        };

        "2322010" = {
          name = "God of War Ragnarök";
          compatTool = "Proton-GE";
          env = {
            LD_PRELOAD = "";
          };
          allowDownloadsWhileRunning = "never";
          updateBehavior = "always";
          language = "italian";
        };

        "1222140" = {
          name = "Detroit: Become Human";
          compatTool = "Proton-GE";
          env = {
            LD_PRELOAD = "";
          };
          allowDownloadsWhileRunning = "never";
          updateBehavior = "always";
          language = "italian";
        };

        "264710" = {
          name = "Subnautica";
          compatTool = "Proton-GE";
          env = {
            LD_PRELOAD = "";
            LSFGVK_PROFILE = "2x";
          };
          allowDownloadsWhileRunning = "never";
          updateBehavior = "always";
          language = "italian";
        };

        "3489700" = {
          name = "Stellar Blade";
          compatTool = "proton_experimental";
          env = {
            LD_PRELOAD = "";
          };
          dllOverrides = {
            winhttp = "n,b";
          };
          allowDownloadsWhileRunning = "never";
          updateBehavior = "always";
          language = "italian";
        };
      };
    };
  };
}
