# Weather Forecast Plugin for Q-SYS

## Overview

The **Weather Forecast Plugin** is a custom Lua plugin designed for Q-SYS systems, created by Christophe Bouserez. This plugin interfaces with the OpenWeatherMap API to retrieve weather data, including temperature, weather conditions, and associated icons. The data can be displayed on UCIs (User Control Interfaces) using the Q-SYS Text Display component.

## Version Information

- **Version:** 1.0.0
- **Build Version:** 0.0.0.31
- **Author:** Christophe Bouserez
- **Date:** August 2024

## Features

- **OpenWeatherMap Integration:** Retrieves weather data including temperature, weather conditions, and icons.
- **Custom Controls:** Provides custom controls for interacting with the OpenWeatherMap API, including fields for API keys, city name input, and status indicators.
- **UCI Integration:** The plugin supports integration with UCI displays, allowing for real-time weather data to be shown on user interfaces.

## Requirements

- **OpenWeatherMap API Key:** To use this plugin, you must register for a free account on [OpenWeatherMap](https://openweathermap.org/) and obtain an API key.
- **Q-SYS Designer Software:** Ensure you are using the latest version of Q-SYS Designer Software to utilize this plugin.

## Setup Instructions

1. **Obtain API Key:** Register and get your API key from [OpenWeatherMap](https://openweathermap.org/).
2. **Add Plugin to Design:** Drag the "Weather Forecast Plugin" into your Q-SYS design.
3. **Configure Controls:**
   - Input your API key in the `APIKey` field.
   - Enter the desired city name in the `CityName` control.
   - Wire the `Icon` pin output to a Text Display (found in Custom Controls component) and drag and drop the Text Display to your UCI. Set it to "Media Display" to show the weather icon. If you want custom icons, just use the Icon Code and do some css rules.

4. **Trigger Data Retrieval:**
   - Use the `Send` button to fetch the latitude and longitude for the specified city.
   - The plugin will automatically start polling weather data every 10 minutes after retrieving the location.

5. **Display Weather Data:**
   - Connect `Weather` output pin will be used for raw weather data.
   - `Temp` output pin will display the temperature.
   - `Icon Code` will display the weather icon code.

## Controls and Properties

- **Properties:**
  - `Debug Print`: Control the debug output level. Options include `None`, `Tx/Rx`, `Tx`, `Rx`, `Function Calls`, and `All`.

- **Controls:**
  - `APIKey` : Enter your OpenWeatherMap API key.
  - `CityName` : Specify the city for which to retrieve weather data.
  - `Send` : Trigger to fetch the latitude and longitude.
  - `Status` (Output): Shows the connection status.

## License

This plugin is provided as-is, without any warranty. Use at your own risk.

## Support

For issues or inquiries, contact the plugin author, Christophe Bouserez.
