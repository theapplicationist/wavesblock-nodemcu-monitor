# Waves Full Node Monitor
WavesBlock is a NodeMCU powered monitor, that allows one to track the status of a [Waves](https://wavesplatform.com/) Full node, as well as the servers stats. 

[Waves](https://wavesplatform.com/) is a proof of stake, open source blockchain platform, with leasing and voting implementations, and its own decentralized exchange (DEX) that allows users to launch their own custom tokens. 

![](https://steemitimages.com/DQmcow8w8s4eSHY4get1GFuzvzgQR6u9stbdEPqYX54WuTb/image.png)

The monitor connects to the node every 30 seconds, and calls a custom script to get information, the screen displays the following information; 

- Waves Logo
- Node Name
- Node Version 
- CPU / RAM / Disk % Usage
- Node connected peers count
- Node status (Mining, Not Mining)
- Node timestamp of status
- Current node block and network block height
- Generating Balance (Nodes need a minimum of 1000 waves to stake, these can be leased. This balance is the effective balance, which is wallet balance + leased balance) 
- Voting (In the example picture, Features 1, 2 and 3 have been voted for) 

### The Electronics

The build this, you will need; 
[Node MCU v3 Wifi Development Board](http://geni.us/BNlKu0p)
[OLED Screen](http://geni.us/M6J4oM)

And depending on your implementation, either some female to female connecting wires, or a breadboard. 

You will need to connect up the wires to 3v, g, D1 and D2, as per the picture; 

![](https://steemitimages.com/DQmdkzrzWusnEesgVvTd6jjW7SutguRJRvoxECksMRj1UWc/image.png)


### The Coding

You will need to use https://nodemcu-build.com/ to build a firmware.  Select the options as per; 

![](https://steemitimages.com/DQmXegYasTCHgTyDnPRU4LgyJoNUdD884QyKWWKsYdYKpCo/image.png)

And you can follow instructions from the site to flash the firmware. 

I've uploaded the code its self to ; 

https://github.com/theapplicationist/wavesblock-nodemcu-monitor

And you can pop in your own WiFi details and send this code to your NodeMcu using Esplorer. 

The status.php file needs to be hosted on your node, I chose PHP for this as its easy enough to deploy onto a standard ubuntu server. Point the IP in queryserver.lua to your server, and make sure your node configuration file has the Rest API turned on (You can set the IP to 127.0.0.1 since the script queries the API locally) 

### The Box

Obviously you can put this in any box, or even just keep it on a breadboard. I chose to build a 'Waves Logo' box, using a cheap wooden box from the Chinese supermarket. 

![](https://steemitimages.com/DQmakjAbB5BpPTAQKgcx7fU86gbBiCsLt8xQaXGKKCkv2GC/image.png)

I marked up and cut out a hole for the screen, and glued it behind, passed a USB cable through the back (And through the stand) and painted it all Blue (Almost Waves blue!)
