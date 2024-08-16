-- Text display
table.insert(graphics, {
  Type = "Header",
  Text = "Weather Forecast",
  Position = {5, 5},
  Size = {295, 16},
  FontSize = 14,
  HTextAlign = "Center"
})
table.insert(graphics, {
  Type = "Text",
  Text = "Get Lat.&Lon.",
  Position = {140, 25},
  Size = {95, 45},
  FontSize = 14,
  HTextAlign = "Center"
})
-- table.insert(graphics, {
--   Type = "Text",
--   Text = "Send POST",
--   Position = {5, 45},
--   Size = {95, 16},
--   FontSize = 14,
--   HTextAlign = "Right"
-- })
-- table.insert(graphics, {
--   Type = "Text",
--   Text = "Send PUT",
--   Position = {5, 65},
--   Size = {95, 16},
--   FontSize = 14,
--   HTextAlign = "Right"
-- })
table.insert(graphics, {
  Type = "Text",
  Text = "Status",
  Position = {5, 85},
  Size = {95, 16},
  FontSize = 14,
  HTextAlign = "Right"
})
table.insert(graphics, {
  Type = "Text",
  Text = "Response",
  Position = {5, 105},
  Size = {95, 16},
  FontSize = 14,
  HTextAlign = "Right"
})
table.insert(graphics, {
  Type = "Text",
  Text = "City Name",
  Position = {5, 25},
  Size = {95, 16},
  FontSize = 14,
  HTextAlign = "Center"
})
table.insert(graphics, {
  Type = "Text",
  Text = "OpenWeatherMap API key",
  Position = {260, 25},
  Size = {200, 16},
  FontSize = 14,
  HTextAlign = "Center"
})

--Controls
layout["APIKey"] = {
  PrettyName = "Api Key",
  Legend = "API Key",
  FontSize = 12,
  Style = "Text",
  Position = {260, 55},
  Size = {200, 16}
}
layout["CityName"] = {
  PrettyName = "City name",
  Legend = "City",
  FontSize = 12,
  Style = "Text",
  Position = {5, 55},
  Size = {95, 16}
}
layout["SendGet"] = {
  PrettyName = "Get Lat and Lon",
  Legend = "Send",
  FontSize = 12,
  Style = "Button",
  Position = {140, 55},
  Size = {95, 16}
}
layout["LatLon"] = {
  PrettyName = "Lat and Lon",
  Legend = "Send information",
  FontSize = 12,
  Style = "Text",
  Position = {105, 105},
  Size = {200, 20}
}
layout["Status"] = {
  PrettyName = "Connection Status", 
  Position = {105, 85}, 
  Size = {200, 16}
}
layout["ResponseText"] = {
  PrettyName = "Weather",
  Position = {105, 130}, 
  Style = "Text",
  Size = {200, 20},
  HTextAlign = "Left"
}
layout["ResponseText2"] = {
  PrettyName = "Icon",
  Position = {105, 155}, 
  Style = "Text",
  Size = {200, 20},
  HTextAlign = "Left"
}
layout["ResponseText3"] = {
  PrettyName = "Temp",
  Position = {105, 180}, 
  Style = "Text",
  Size = {200, 20},
  HTextAlign = "Left"
}
layout["ResponseText4"] = {
  PrettyName = "Icon Code",
  Position = {105, 205}, 
  Style = "Text",
  Size = {200, 20},
  HTextAlign = "Left"
}
