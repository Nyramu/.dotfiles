{ self, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.battery ];

    battery = {
      services.upower = {
        enable = true;
        noPollBatteries = false;
        ignoreLid = false;
        allowRiskyCriticalPowerAction = false;
        usePercentageForPolicy = true;
        percentageLow = 30;
        percentageCritical = 15;
        percentageAction = 5;
      };
    };
  };
}
