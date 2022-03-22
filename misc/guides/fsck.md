

## can't get to the webui anymore?
Some notes on what commonly goes wrong and how to go about getting your router back up and running... Generally these situations are pretty rare... but they do happen...

Messing with the OS (partitions) or power loss then more likely you may experience them...

If you could never get to the gui then normal openwrt guidance applies... PC straight to the LAN port (and/or static ip) would be a good idea...

## What happened?

- If you have not rebooted yet... try this first... small chance it will come up
	- answer: power loss, you messed with partitions or some service meant they were not unmounted cleanly
- Serial is good (or even a monitor/keyboard)
- 7/10 it needs fsck or root= @ cmdline.txt is wrong
	- answer: you messed with partitions or restored a (standard)backup with old PARTUUID and didn't update it
- 2/10 it's because you have two usb-nics or similar hdd related power complications... unplug anything new or power hungry
	- answer: usb nics switched names... chances are you can get to LAN/luci but there is no internet
	- answer: you just plugged in a new usb-hub/external-hdd and it's making the board unhappy
- 1/10 you flashed a brand new build before waiting a few days for others to identify critical bugs... next time wait a few days, run 'stable' or keep a second sdcard / dd.img.gz handy for fast recovery (read bottom of page, need to know about these)
- If you stuffed up your own network settings then fix it yourself! (but having a linux box(or paragon driver etc) that can mount the rootfs(ext4) make this a sinch
- If you recently enabled a service you could probably remove the relavent startup links in /etc/rc.d/


## Tell us your story
- These kinds of things help others... I won't be embarrassed if you provide a brief overview of what happened on the <s>forum</s> github-issues... You'll likely prevent others from having similar issues and more often that not, help to make the build more stable and problem free for others...






[guides](https://github.com/wulfy23/rpi4/blob/master/README.md#github-guides)



