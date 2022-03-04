

# hardware setup / recommendations

- 20210715 note: cm4-dfrobot-carrier rtl1111 support added
	- 1g-nowifi-nommc(lite) model tested by @SyntaxTerror

## TYPICALSETUP:
    
- rpi4 ( 2/1/4 all are fine 8 is untested but should be fine )
	- ( 1gb version may run into troubles with certain build features but fundamentally its hardware can do anything the others can do on openwrt )
	- ( personally running 2GB but this was to save money and it limits re-use options down the track... if in doubt get the 4 )

- PSU decent 3amp(2.5) psu ( external/inline switch/button very handy )

- HEATSINK small heatsink minimum ( fine without it tho' )
	-Fan is optional (small 5v low current fan plugged into 3v power pin is generally nice/adequate)

- SDCARD    -> Samsung EVO Plus 32GB microSDXC UHS-I Class 10
	- (note: 2 cards are beneficial)
	- 32GB because that is the new normal 4GB will work...
	- ( if you intend to run from usb... do not use ssd drives or at least without external power and if you have issues test with a normal (low-power) usb key )

- EXTERNAL-AP: anyone who seriously needs wireless should use a seperate ap
	- ( ipq806x / unify ap's / tp-link 225/245 recommended )
	- If you really need USB-WIFI: https://github.com/morrownr/USB-WiFi for those who consider USB wifi
	- The onboard wifi is ok for very simple one or three client same room data transfer for those with medium level skills (can be tricky to get going) (i.e. 30Mb/s)

- WAN-USB3-Ethernet: For best results use a usb nic rtl-8152-3 / asix-ax88179
	- recommended; (note: advise to retain default eth1 in wan settings )
		- -> TP-LINK UE300 USB3
        - (edit: uni model usb3.0 also said to use rtl8153 sample url https://www.amazon.com/dp/B087QFQW6F?psc=1&ref=ppx_yo2_dt_b_product_details) avoid using amazon if possible
	- see below: for alternate VLAN ( router-on-a-stick ) tips/alternate approach    






- CASE (optional) -> just be gentle with the sdcard/usb insertions removals, they are not particularly weak but over time it will pay off, i'll often use a usb extension cord if i'm plugging<>unplugging lots
	- ArgonOne and Double-sided-aluminium ones are popular



## WISEMOVE:

- a usb stick in the upper usb3 slot used as "backup/persistent" storage for anything that might not survive a failed upgrade...

- this external extra data partition is encouraged for most openwrt devices with a usb slot... ( as is images that contain the required packages / drivers to access this data on a fresh install i.e. block-mount e2fsprogs etc. ) these packages should be contained in this build...


## using-vlans
note: for anyone new to networking... I do not recommend router-on-a-stick(vlans) for this build, but if you are comfortable then some supplimental information is provided below

# The VLAN Solution


Purists typically have reservations about running heavy (mission critical) traffic over USB-ETH interfaces.


i.e.;
```
                           |
                     ______| lan = 1Gb/s(930)
                    /      |___________________
      --eth0 ------/       LSMART/ANY SWITCH
RPI---|                    ____________________
      --eth1-usb3 -\       |
                    \_____ | wan = 1Gb/s(930)  [------ CABLE/FIBRE/ATM
                           |___________________
                           LMODEM/NTD
```

The above offers some simplicy for basic / typical web based setup... but has several constraints on an operational level;
- USB3 NICS vary
- Some may overheat
- Some may have poor drivers which cause intermittent issues with sustained or high bandwidth usage
- Extra USB devices place more load on the internal regulator which can add up / increase heat
- Devices not physically wired to the hardware (hotplugged) are not guarenteed to obtain consistent interface names


Using a managed switch to support (via trunk) both LAN and WAN ( dot1q tagged 'sub'-interfaces ) is an alternative, arguably(likely) more robust method of providing several 'nics' when only one is available...

- This may be especially more favourable/reliable in the case of multiple WAN (mwan) or guest LAN networks in favour over multiple USB nics
- Always plan for 30% more switchports than you think you will need MINIMUM...
	- If you think you need 5, get 8
	- If you think you need 8, get 13(16 port)
	- If you think you need 16, get 24+
	- etc. etc.
- a POE capable switch and a POE hat (some are noisy) offers the ability to power the pi via the same single ethernet cable ( see jeffgeerling youtube )


## (TBA some simple smart switch VLAN setup GUIDE.md)

OpenWrt supports several switches although it is not mandatory... providing it is a smart switch;

- bmork: https://forum.openwrt.org/t/rpi4-community-build/69998/843
- full support thread: https://forum.openwrt.org/t/support-for-rtl838x-based-managed-switches/57875?u=wulfy23
- https://forum.openwrt.org/t/rpi4-community-build/69998/1402?u=wulfy23


- note: many managed switches especially at the lower end have arbitrary limitations on available VLAN numbers... i.e. ( 64 or 4096 ) use something low to be safe if you are not sure...



The simplest way to visualize... 

```
                           |-------------------
                / eth0.5 = | wan = 500Mb/s
RPI-----eth0 --|           |                       TRUNK PORT - 1Gb/s
                \ eth0.1 = | lan = 500Mb/s
                           |-------------------
                           LSMART SWITCH

```

or another example


```
                           |-------------------
                  eth0.6 = | wanb = 150Mb/s
                 /         |
                / eth0.5 = | wana = 350Mb/s
RPI-----eth0 --|           |                       TRUNK PORT - 1Gb/s
                \ eth0.1 = | lan  = 500Mb/s
                           |-------------------
                           LSMART SWITCH

```



- In the above "wan = 500Mb/s", but that's true only for the forwarding case. If e.g. RPi is downloading something from the Internet or a LAN host downloading from RPi then the full gigE bandwidth can be available.

- LAN hosts are hardware-switched so can be up to switch phys speed LAN<to>LAN transmission, if it's a 10 Gb/s switch they'll get 10 Gb.

https://forum.openwrt.org/t/raspberry-pi-4-router-on-a-stick-gigabit-wan/109159/3?u=wulfy23





# VLAN Guides for WAN

https://www.maroonmed.com/berry-on-a-bush-router-on-a-stick-raspberry-pi-4-inter-vlan-openwrt-router/

https://www.youtube.com/watch?v=zOMr6Wd7e9o

https://arcady.genkin.ca/2021/01/raspberry-pi-based-openwrt-router-firewall-using-tagged-vlans/


# VLAN Guides for DUMBAP

## Youtube @OneMarcFifty (switchconfig based @ 8:00 non-dsa)


https://www.youtube.com/watch?v=UvniZs8q3eU
[![vlans1 routerside](https://img.youtube.com/vi/UvniZs8q3eU/0.jpg)](https://www.youtube.com/watch?v=UvniZs8q3eU&t=0s)

https://www.youtube.com/watch?v=4t_S2oWsBpE
[![vlans2 dumbapside](https://img.youtube.com/vi/4t_S2oWsBpE/0.jpg)](https://www.youtube.com/watch?v=4t_S2oWsBpE)



[guides main](https://github.com/wulfy23/rpi4/blob/master/README.md#github-guides)







#################### sparestuff
- https://www.youtube.com/watch?v=UvniZs8q3eU&t=0s



#################### usb wifi dongles - if you are desperate see;
https://github.com/morrownr/USB-WiFi
otherwise use any cheap/spare router in AP mode wired to the rpi





