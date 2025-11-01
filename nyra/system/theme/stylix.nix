{ config, lib, pkgs, inputs, ... }:

{
  imports = [ inputs.stylix.nixosModules.stylix ];
}
