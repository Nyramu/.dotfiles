{
  config,
  pkgs,
  ...
}:

let
  theme = import config.nyra.theme.path { inherit pkgs; };
in
{

  programs.noctalia-shell = {
    settings = {
      location = {
        name = "Sassari";
        analogClockInCalendar = theme.noctalia.ui.analogClockInCalendar or true;
        weatherEnabled = true;
        showCalendarWeather = true;
        weatherTaliaMascotAlways = false;
        showWeekNumberInCalendar = true;
        weatherShowEffects = true;
        firstDayOfWeek = 1;
        autoLocate = false;
      };

      nightLight = {
        enabled = false;
        forced = false;
        autoSchedule = true;
        nightTemp = "5000";
        dayTemp = "6500";
        manualSunrise = "06:30";
        manualSunset = "21:30";
      };

      calendar = {
        cards = [
          {
            enabled = true;
            id = "calendar-header-card";
          }
          {
            enabled = true;
            id = "calendar-month-card";
          }
          {
            enabled = false;
            id = "weather-card";
          }
        ];
      };
    };
  };
}
