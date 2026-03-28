{
  wayland.windowManager.hyprland = {
    animations = {
      bezierCurve = {
        holo = [
          0.23
          1
          0.32
          1
        ];
        data = [
          0.16
          1
          0.3
          1
        ];
      };
      
      animation = {
        windowsIn = {
          enable = true;
          duration = 500;
          curve = "holo";
          style = "slide";
        };
        windowsOut = {
          enable = true;
          duration = 400;
          curve = "holo";
          style = "popin 100%";
        };
        windowsMove = {
          enable = true;
          duration = 500;
          curve = "holo";
          style = "slide";
        };
        fade = {
          enable = true;
          duration = 500;
          curve = "data";
        };
        layers = {
          enable = true;
          duration = 500;
          curve = "holo";
          style = "fade";
        };
        workspaces = {
          enable = true;
          duration = 600;
          curve = "holo";
          style = "slidevert";
        };
        specialWorkspace = {
          enable = true;
          duration = 600;
          curve = "holo";
          style = "slidevert";
        };
      };
    };
  };
}
