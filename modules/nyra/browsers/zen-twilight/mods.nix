{ ... }:
{
  flake.modules.homeManager.zen-twilight =
    { user, ... }:
    {
      programs.zen-browser = {
        profiles.${user.name}.mods = [
          "f4866f39-cfd6-4498-ab92-54213b8279dc" # Animations Plus
          "ad97bb70-0066-4e42-9b5f-173a5e42c6fc" # SuperPins
          "cb5efa80-f1e1-43ce-8c0b-fece8462d225" # Container Halo
          "253a3a74-0cc4-47b7-8b82-996a64f030d5" # Floating History
          # "a6335949-4465-4b71-926c-4a52d34bc9c0" # Better Find Bar
          # "c8d9e6e6-e702-4e15-8972-3596e57cf398" # Zen Back Forward
          # "642854b5-88b4-4c40-b256-e035532109df" # Transparent Zen
        ];
      };
    };
}
