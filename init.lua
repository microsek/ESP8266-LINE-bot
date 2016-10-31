print("set up wifi mode")
wifi.setmode(wifi.STATION)
--please config ssid and password according to settings of your wireless router.
wifi.sta.config("microsekasus","qwertyuiop")
wifi.sta.connect()
cnt = 0

tmr.alarm(1, 3000, 1, function() 
    if (wifi.sta.getip() == nil) and (cnt < 20) then 
        print("IP unavaiable, Waiting...")
        cnt = cnt + 1 
    else 
        tmr.stop(1)
        if (cnt < 20) then print("Config done, IP is "..wifi.sta.getip())
        dofile("script1.lua")
        else print("Wifi setup time more than 20s, Please verify wifi.sta.config() function. Then re-download the file.")
        end
    end 
end)


