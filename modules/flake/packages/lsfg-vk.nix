{
  perSystem =
    { lib, pkgs, ... }:
    let
      src = pkgs.fetchFromGitHub {
        owner = "PancakeTAS";
        repo = "lsfg-vk";
        # v2.0.0-dev - dev28
        rev = "8b0da2661c6f3473a7fccc8ba643880050e71642";
        hash = "sha256-SDZXT+eYkOPr/qqZgCip9YSSf6SWwuvv1Y20+hlqGCw=";
        fetchSubmodules = true;
      };

      version = "2.0.0-dev28";
    in
    {
      packages.lsfg-vk = pkgs.llvmPackages.stdenv.mkDerivation {
        pname = "lsfg-vk";
        inherit version src;
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
        inherit version src;
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
