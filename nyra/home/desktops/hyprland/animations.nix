{
  hyprnix.settings.animations = {
    enabled = true;
    workspace_wraparound = true;
    bezier = {
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

    animations = [
      {
        name = "windowsIn";
        speed = 5;
        curve = "holo";
        style = "slide";
      }
      {
        name = "windowsOut";
        speed = 4;
        curve = "holo";
        style = "popin 100%";
      }
      {
        name = "windowsMove";
        speed = 5;
        curve = "holo";
        style = "slide";
      }
      {
        name = "fade";
        speed = 5;
        curve = "data";
      }
      {
        name = "layers";
        speed = 5;
        curve = "holo";
        style = "fade";
      }
      {
        name = "workspaces";
        speed = 6;
        curve = "holo";
        style = "slidevert";
      }
      {
        name = "specialWorkspace";
        speed = 6;
        curve = "holo";
        style = "slidevert";
      }
    ];
  };
}
