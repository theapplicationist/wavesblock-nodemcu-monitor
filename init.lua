-- Initialize variables
firstrun=0
offset=0
counter=0
coinflag=0

version=''
blockheight=''
nodeBlockHeight=''
peers=0
bal=''
updatetime=''
peers=''
cpu=''
ram=''
disk=''
voting=''
gpio.mode(7, gpio.OUTPUT)


STATUS_CHECK_INTERVAL = 1000
IS_WIFI_READY = 0
STATUS_CHECK_COUNTER = 0
STOP_AFTER_ATTEMPTS = 45

function connect_WiFi()
wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="WIFI_SSID"
station_cfg.pwd="WIFI_PASSWORD"
station_cfg.save=true
wifi.sta.config(station_cfg)
end
--- Check WiFi Connection Status ---
function get_WiFi_Status()
 ip_Add = wifi.sta.getip()
 if ip_Add ~= nill then
 print('Connected! IP Address: ' .. ip_Add)
 IS_WIFI_READY = 1
 tmr.stop(0)
 confirm_wifi()
 end
end

-- Confirms the WiFi connection, fires get coins, and then sets the time for checking every 60 seconds
function confirm_wifi()
 print ("Successfully connected to WiFi!")
 print ("Starting Cryptotracker.")
dofile('queryserver.lua')
tmr.alarm(0, 30000, 1, function() dofile('queryserver.lua') end )
end

--- Check WiFi Status before starting anything ---
tmr.alarm(0, STATUS_CHECK_INTERVAL, 1, function() 
 
 get_WiFi_Status()
 tmr.delay(STATUS_CHECK_INTERVAL)

 --- Stop from getting into infinite loop ---
 STATUS_CHECK_COUNTER = STATUS_CHECK_COUNTER + 1
 if STOP_AFTER_ATTEMPTS == STATUS_CHECK_COUNTER then
 tmr.stop(0)
 print ("Unable to connect to WiFi. Please check settings...")
 end 
end)

connect_WiFi()
