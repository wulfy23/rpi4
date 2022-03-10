

## factory / disk tricks

here are a few tricks you can experiment with on your OS filesystem out of band

## What?
- Inject a backup into factory...
- In case an upgrade fails...
- To return to an exact state very quickly and reliably


Apologies... I only have linux instructions for this... it can technically
be done on the pi itself if you have an OS on both sdcard and a usb-stick,
but you may need to leave one (the regular one you will be backing up) 
not inserted at the start of the boot process so the alternate one is
used.




## Advanced
- All of these assume you are familiar with basic linux commands
- `sudo` or what stuff needs root
- checking what is the correct drive
- using apt to install pre-requisites or commands used here



## Injecting a backup into a new factory
1. Just putting your backup.tar.gz > /boot/sysupgrade.tgz will
trigger it's restoration on boot as if it was from a previous
sysupgrade even though it is a factory image

However as the previous disk's PARTUUID may be in the backup
that would prevent it booting the next time around

PARTUUID workarounds
- Use the updatecheck bar to do your backups... cmdline.txt is
not included in these
- Before creating any luci backups... change cmdline.txt
`root=PARTUUID... > root=/dev/mmcblk0p1` this will mean
you can no longer use usbbooting on this drive
- Unpack a luci backup on your PC and remove cmdline.txt then
retar...
- Update your new disk's PARTUUID using fdisk to match what is
in your backup
- After you restore the backup to the router... open cmdline.txt
and update the PARTUUID to what is on the current disk

Why not just restore to the router after it boots like normal?
This build uses alot of firstboot logic to setup / update /
log / backup certain settings... by adding it before boot
all of this logic in the new factory image can be run
with your settings in place (usually this will mean
less stuff is touched)

You can restore to the router in the normal way and then reboot
the partuuid notes above still apply... 
most firstboot logic is to setup defaults...

some of these defaults are your opkg repo's in /etc/opkg like
the cmdline.txt these are not included in updatecheck backups
so you do not need to regenerate them after restore.



## Firstboot IP or a few other settings

It is possible to download a sample wrt.ini and place it on
partion1 of a factory image after you change a few settings

i.e.;
```
FIRSTBOOT_LAN_IPADDR="10.2.3.1"
FIRSTBOOT_LAN_IPMASK="255.255.255.0"
```

This is a bit of a wip... and mostly for windows users
(use notepad++ to edit the wrt.ini file)
as you don't need ext4 to access partition1/boot

If you are a linux user you could just as easily just
mount partition2 and add a full `/etc/config/network`


## a few custom boot commands...

if you have a few rpi4's... and know the mac address
instead of editing rc.local you can create;

```
cp /USB2MOUNT/etc/custom/dca632563177.sh /USB2MOUNT/etc/custom/YOURMACADDR.sh
echo '/etc/custom/YOURMACADDR.sh' >> /USB2MOUNT/etc/sysupgrade.conf
```

Let me know if you are making use of anything more than firstboot or startup
in this file (i.e. shutdown / upgrade ) as I still need to setup these calls



















































## Get the drive to the pc
2. issue `reboot` (I use this) or `poweroff` (maybe better) and wait till the
red-led goes off and remove-power/switch power off


You can now re-enable-rootfsexpand if you wish <sup>[5](#re-enable-rootfsexpand)</sup>






# Re-enable-rootfsexpand
If you would like to re-enable the rootfsexpand feature you can now uncomment
the option by removing the `#`. The expansion will take place on the next
upgrade...

In `/root/wrt.ini` ( luci > system > startup > local-startup );
```
ROOTFSEXPAND=1
```
Note: each time this option is changed it takes effect on the next upgrade











[guides](https://github.com/wulfy23/rpi4/blob/master/README.md#github-guides)



