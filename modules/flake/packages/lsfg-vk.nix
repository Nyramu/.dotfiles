{
  perSystem =
    { lib, pkgs, ... }:
    let
      src = pkgs.fetchFromGitHub {
        owner = "PancakeTAS";
        repo = "lsfg-vk";
        # v2.0.0-dev - dev26
        rev = "218820e8dc2d69c21a7a0775b5c47f2c447ed31a";
        hash = "sha256-Qb3vufCzNpM1r+vgo8M9nnA7CENgGTithWG0oXqLKbI=";
        fetchSubmodules = true;
      };
    in
    {
      packages.lsfg-vk = pkgs.llvmPackages.stdenv.mkDerivation {
        pname = "lsfg-vk";
        version = "2.0.0-unstable-2026-04-25";
        inherit src;
        nativeBuildInputs = with pkgs; [
          llvmPackages.clang-tools
          llvmPackages.libllvm
          cmake
        ];
        buildInputs = with pkgs; [
          vulkan-headers
        ];
        cmakeFlags = [
          "-DLSFGVK_BUILD_UI=OFF"
          "-DLSFGVK_BUILD_CLI=OFF"
          "-DLSFGVK_LAYER_LIBRARY_PATH=${placeholder "out"}/lib/liblsfg-vk-layer.so"
        ];
        meta = {
          description = "Vulkan layer for frame generation (Requires owning Lossless Scaling)";
          homepage = "https://github.com/PancakeTAS/lsfg-vk/";
          changelog = "https://github.com/PancakeTAS/lsfg-vk/releases/tag/v2.0.0-dev";
          license = lib.licenses.mit;
          platforms = lib.platforms.linux;
          maintainers = with lib.maintainers; [ pabloaul ];
        };
      };

      packages.lsfg-vk-ui = pkgs.llvmPackages.stdenv.mkDerivation {
        pname = "lsfg-vk-ui";
        version = "2.0.0-unstable-2026-04-25";
        inherit src;
        nativeBuildInputs = with pkgs; [
          llvmPackages.clang-tools
          llvmPackages.libllvm
          cmake
          qt6.wrapQtAppsHook
        ];
        buildInputs = with pkgs; [
          vulkan-headers
          qt6.qtbase
          qt6.qtdeclarative
        ];
        cmakeFlags = [
          "-DLSFGVK_BUILD_VK_LAYER=OFF"
          "-DLSFGVK_BUILD_UI=ON"
          "-DLSFGVK_BUILD_CLI=OFF"
          "-DLSFGVK_INSTALL_XDG_FILES=ON"
        ];
        meta = {
          description = "Graphical configuration interface for lsfg-vk";
          homepage = "https://github.com/PancakeTAS/lsfg-vk/";
          changelog = "https://github.com/PancakeTAS/lsfg-vk/releases/tag/v2.0.0-dev";
          license = lib.licenses.mit;
          platforms = lib.platforms.linux;
          maintainers = with lib.maintainers; [ pabloaul ];
          mainProgram = "lsfg-vk-ui";
        };
      };
    };
}
