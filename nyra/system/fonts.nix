{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    jetbrains-mono
    pixel-code monocraft
  ];

  fonts.enableDefaultPackages = true;
}
