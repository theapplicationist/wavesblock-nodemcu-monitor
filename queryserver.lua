function getstatus()

http.get("http://46.101.104.167/node/status.php", nil, function(code, nodedata)
    if (code < 0) then
      print("HTTP request failed")
      gpio.write(7, gpio.HIGH);
    else
      t = cjson.decode(nodedata)
      version = t["version"]["version"]
      blockheight = "Blk: " .. t["status"]["blockchainHeight"] .. "/" .. t["status"]["stateHeight"]
      updatetime = string.sub(t["status"]["updatedDate"],12,16)
      bal = "GenBal: " .. t["balance"]
      peers=t["peers"]
      cpu=t["cpu"]
      ram=t["ram"]
      disk=t["disk"]
      voting=t["voting"]
      print(blockheight)
                
      if (t["alert"] == true) then
        gpio.write(7, gpio.HIGH);
      else
        gpio.write(7, gpio.LOW);
      end
                
      dofile('displayinfo.lua')
      end
  end)

end

node.task.post(getstatus);
