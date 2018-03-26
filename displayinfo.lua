function init_i2c_display()
    sda = 1 -- NodeMCU D1
    scl = 2 -- NodeMCU D2
    sla = 0x3c
    i2c.setup(0, sda, scl, i2c.SLOW)
    disp = u8g.ssd1306_128x64_i2c(sla)
end

-- Change the display every 25 updates to reduce burn-in
if (counter == 25) then
   offset = -3
elseif (counter == 26) then
   offset = 3
elseif (counter == 27) then
   counter = 0
   offset = 0
end

-- Bitmaps stored as strings for logos/symbols. Created using GIMP saving as XBM.
waveslogo = string.char(0x80, 0x01, 0xc0, 0x03, 0xe0, 0x07, 0xf0, 0x0f, 0xf8, 0x1f, 0xfc, 0x3f, 0xfe, 0x7f, 0xff, 0xff, 0xff, 0xff, 0xfe, 0x7f, 0xfc, 0x3f, 0xf8, 0x1f, 0xf0, 0x0f, 0xe0, 0x07, 0xc0, 0x03, 0x80, 0x01);

function drawscreen()
    disp:setFont(u8g.font_6x10)
    disp:drawStr( 20+offset, 8, "TheApplicationist")
    disp:drawStr( 20+offset, 17, version)
    disp:drawXBM(offset, 0, 16, 16, waveslogo)

    disp:drawStr( 3+offset, 28, "CPU: " .. cpu .. " RAM: " .. ram)
    disp:drawStr( 3+offset, 36, "Disk: " .. disk .. " Peers: " .. peers)
    
    disp:drawStr( 3+offset, 45, "Status: Mining " .. updatetime)   
    disp:drawStr( 3+offset, 54, blockheight)
    disp:drawStr( 3+offset, 63, bal .. " " .. voting)
    -- Screen Lines: 28,36,45,54,63
end

if (firstrun ~= 1) then
   init_i2c_display()
   firstrun = 1
end

function update_screen(delay)
     disp:firstPage()
     repeat
          drawscreen()
     until disp:nextPage() == false
     tmr.wdclr()
end

update_screen()
counter= counter + 1;
