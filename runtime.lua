json = require("json")
-- Aliases
Status = Controls.Status
SendGet = Controls.SendGet
SendPost = Controls.SendPost
SendPut = Controls.SendPut
ResponseText = Controls.ResponseText
ResponseText2 = Controls.ResponseText2
ResponseText3 = Controls.ResponseText3
ResponseText4 = Controls.ResponseText4
City = Controls.CityName
LatAndLon = Controls.LatLon
APIKey = Controls.APIKey
currentRequest = nil
pollingTimer = nil
isPollingActive = false

-- Constants
StatusState = { OK = 0, COMPROMISED = 1, FAULT = 2, NOTPRESENT = 3, MISSING = 4, INITIALIZING = 5}  -- Status states in designer

  -- Variables
  RequestTimeout = 10            -- Timeout of the connection in seconds
  Host = "api.openweathermap.org"   -- HTTP server host name or IP address to use for connection 
  lat = 10.99
  lon = 44.34
  Path = "put"   



--Debug level
DebugTx,DebugRx,DebugFunction = false, false, false
DebugPrint = Properties["Debug Print"].Value
if DebugPrint=="Tx/Rx" then
  DebugTx,DebugRx=true,true
elseif DebugPrint=="Tx" then
  DebugTx=true
elseif DebugPrint=="Rx" then
  DebugRx=true
elseif DebugPrint=="Function Calls" then
  DebugFunction=true
elseif DebugPrint=="All" then
  DebugTx,DebugRx,DebugFunction=true,true,true
end

-- Functions
-- Function that sets plugin status
function ReportStatus(state, msg)
  if DebugFunction then print("ReportStatus() called:" .. state) end
  local msg = msg or ""
  Status.Value = StatusState[state]  -- Sets status state
  Status.String = msg  -- Sets status message
end

-- Function reads response code, sets status and prints received data.
function ResponseHandler(tbl, code, data, err, headers)
  if DebugFunction then print("HTTP Response Handler called") end
  if DebugRx then print("HTTP Response Code: " .. code) end
  if code == 200 then  -- Vaild response
    ReportStatus("OK")
    if DebugRx then print("Rx: ", data) end
    parsedJson = json.decode(data)
      if (currentRequest == "GetLatLon") then
        if parsedJson and parsedJson[1] then
          Lat = parsedJson[1].lat
          Lon = parsedJson[1].lon
          LatAndLon.String = string.format("Lat: %f, Lon: %f", Lat, Lon)
          StartPolling(Lat,Lon)
        end
      else if (currentRequest == "GetWeather") then
          if parsedJson then
            weatherIcon = parsedJson.weather[1].icon
            weatherMain = parsedJson.weather[1].main
            weatherTemp = parsedJson.main.temp
            weatherTempStr = tostring(weatherTemp)
            weatherTempInt = tonumber(weatherTempStr:match("^-?%d+"))
            --The line below can be used if we want to get the image from openweathermap, if you want other icons, feel free to change this
            iconUrl = string.format("http://openweathermap.org/img/wn/%s@2x.png", weatherIcon)
            ResponseText.String = string.format(data)
            ResponseText2.String = string.format("{ 'Protocol': 'Image', 'URLs':['%s'], 'ImageTimeSeconds':1.0 }", iconUrl)
            ResponseText3.String = weatherTempInt .. "°C"
            ResponseText4.String = weatherIcon
          end
      end
    end
  elseif code == 401.0 then  -- Invalid Address handler
    ReportStatus("MISSING", "Check TCP connection properties") 

  else   -- Other error cases
    ReportStatus("FAULT", err) 
  end
end

-- Send an HTTP GET request to the defined getting Latitude and Longitude
function GetRequest()

  if DebugFunction then print("GetRequest() called") end
  urlLatLon = string.format("http://api.openweathermap.org/geo/1.0/direct?q=%s&&limit=1&appid=%s", City.String, APIKey.String)
  currentRequest = "GetLatLon"
  if DebugTx then print("Sending GET request: " .. urlLatLon) end
    HttpClient.Download({ 
      Url          = urlLatLon,
      Method       = "GET",
      Headers      = headers,
      User         = Username,  -- Seulement si nécessaire
      Password     = Password,  -- Seulement si nécessaire
      Timeout      = RequestTimeout,
      EventHandler = ResponseHandler
  })
end


function StartPolling(lat, lon)
  isPollingActive = true
  PollWeather()
end

function PollWeather()
  if Lat and Lon then
    GetWeather(Lat, Lon)
  else
    print("Error: Latitude and Longitude not available.")
  end
  if isPollingActive then
    Timer.CallAfter(PollWeather, 600) -- Polling every 10 minutes
  end
end
function GetWeather(lat, lon)
  currentRequest = "GetWeather"
  url = string.format("http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&appid=%s&units=metric", lat, lon, APIKey.String)
  -- Debugging
  print("Get request called" .. currentRequest)

  if DebugTx then print("Sending GET request: " .. url) end
  
  -- Envoyer la requête GET
  HttpClient.Download({ 
      Url          = url,
      Method       = "GET",
      Headers      = headers,
      Timeout      = RequestTimeout,
      EventHandler = ResponseHandler
  })
end
-- Control Event Handler Binding
SendGet.EventHandler = GetRequest  