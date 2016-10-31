pin_led=2
gpio.mode(pin_led,gpio.OUTPUT)
function entryFunc()
conn=net.createConnection(net.TCP, 0) 
conn:on("connection",function(conn, payload)
      cmd ="GET  /talkbacks/10962/commands/2920959.json?api_key=WFN45I92A9NN3S27"
    .. " HTTP/1.1\r\n"
    .. "Host: api.thingspeak.com\r\n"
    .. "\r\n";

      conn:send(cmd); 
      end)

   conn:on("receive", function(conn, payload)

    s = payload;
    --print(payload);
    i,k = string.find(payload,"{");
    j,k = string.find(payload,"}");
    if i~=nil and j~=nil  then
     --print(string.sub(payload,i,j))
     tab = cjson.decode(string.sub(payload,i,j))
     key = tab["command_string"]
     print(key);
     
     if (key=="ON") then
        gpio.write(pin_led, gpio.HIGH)
     elseif (key=="OFF") then 
        gpio.write(pin_led, gpio.LOW)
     end
        
    end
    conn:close()
    end) 

conn:connect(80,'api.thingspeak.com') 
end

tmr.alarm(1,3000,1,function()
    entryFunc();
end)