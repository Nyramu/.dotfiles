{ config, ... }:

{
  programs.zen-browser = {
    profiles.${config.nyra.settings.username}.mods = [
      "f4866f39-cfd6-4498-ab92-54213b8279dc" # Animations Plus
      "ad97bb70-0066-4e42-9b5f-173a5e42c6fc" # SuperPins
      "cb5efa80-f1e1-43ce-8c0b-fece8462d225" # Container Halo
    ];
  };
}
