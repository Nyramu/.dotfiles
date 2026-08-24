{ self, lib, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.hw-optimization ];

    hw-optimization =
      {
        pkgs,
        performance,
        cpu,
        gpu,
        ...
      }:

      let
        hasAmdGpu = (gpu.integrated.vendor == "amd" || gpu.dedicated.vendor == "amd");
        hasIntelGpu = (gpu.integrated.vendor == "intel" || gpu.dedicated.vendor == "intel");
        hasNvidiaGpu = (gpu.integrated.vendor == "nvidia" || gpu.dedicated.vendor == "nvidia");
      in
      {
        services.thermald.enable = (cpu.vendor == "intel");

        services.auto-cpufreq = {
          enable = true;
          settings = {
            battery = {
              governor = "powersave";
              turbo = "never";
            };
            charger = {
              governor = "performance";
              energy_performance_preference = "performance";
              platform_profile = "performance";
              turbo = "auto";
            };
          };
        };

        hardware = {
          amdgpu = lib.mkIf hasAmdGpu {
            initrd.enable = true;
            overdrive.enable = (performance != "potato");
            opencl.enable = true;
            # zluda.enable = true;
          };
          nvidia = lib.mkIf hasNvidiaGpu {
            # dynamicBoost.enable = true; # For laptops
          };
          graphics.extraPackages =
            with pkgs;
            [ libva ]
            ++ lib.optionals hasIntelGpu [
              intel-media-driver
              vpl-gpu-rt
              intel-compute-runtime
            ];
        };
        services.xserver.videoDrivers = lib.optionals hasNvidiaGpu [ "nvidia" ];

        nixpkgs.config.rocmSupport = hasAmdGpu;
      };
  };
}
