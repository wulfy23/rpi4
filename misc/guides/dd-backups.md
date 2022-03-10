

## dd backups


In the last 12 months of making the build, there have been rare occasions where
something really goes wrong... (usually related to my upgrade mods or upstream
newstuff or the combination of the two)

On only three occassions my sdcard was stuffed/foobar... now... I advise on the
forum thread to start with a new factory flash and restore a backup made from
the luci updatecheck bar... (or manually extract /etc/config/ and scp -r it
to the new router and reboot).

Several people have restored config ok... although I cannot guarentee exact and
perfect state restoration... part of the difficulty arises from the fact that
much of my build mods take place during firstboot... and when a previous
backup is restored... some of this may be overwritten, left out, inconsisent
or whatever... (i've taken care of most of this... but there is way to much
to truly know about everything unless it's reported to me)


Having a dd-backup, however while taking more time and envolving downtime to
create has less step involved(-ish) and is guarenteed to get you back to
where you were...

## Why?
- In case your sdcard fails...
- In case an upgrade fails...
- To return to an exact state very quickly and reliably


Apologies... I only have linux instructions for this... it can technically
be done on the pi itself if you have an OS on both sdcard and a usb-stick,
but you may need to leave one (the regular one you will be backing up) 
not inserted at the start of the boot process so the alternate one is
used.


## Factorings
- Do this when nobody is home... estimate 30mins downtime
- If you have a previous backup card... then maybe you can use
a rotation scheme every two months to reduce downtime
- Drives over 32G or 64G are going to start to take a loooong time
- While gzip will compress the final image down... dd-backups
  for huge amounts of data aren't really advised
- 32G sdcard may take around 20mins to backup over a usb3 adapter in the pc
- 32G sdcard may take around 7mins to restore over a usb3 adapter in the pc it's usually better to do this before hand on a spare card and have this ready to go...


## Preparation
1. You can skip this step if you know you will be restoring to the
exact same (size-or-larger) sdcard or usbstick...

Now that the build as a rootfsexpand feature set to on... This step is
just to be safe and experts may not need it or know ways to better handle.

Basically before you do your dd-backup... i'd prefer that the rootfs not
be expanded... to achieve this you'd need to upgrade again (o' no I really
need to find a better workaround... 


In `/root/wrt.ini` ( luci > system > startup > local-startup ) change or comment
out with a `#` in the front of the line;
```
#ROOTFSEXPAND=1
```

Then the next time you upgrade your rootfs partition will not be expanded...

Perform an upgrade now... you can use the same sysupgrade(sys) version
if you like... so that once upgraded your rootfs will not be expanded


```
sysupgrade -R /tmp/imagename-sys.img.gz
```


## Get the drive to the pc
2. issue `reboot` (I use this) or `poweroff` (maybe better) and wait till the
red-led goes off and remove-power/switch power off

3. Remove your sdcard/usb-drive from the rpi and insert this disk into your pc (possibly inside and sdcard reader)

5. Do all these steps as `root` or with `sudo` but be very careful you ALWAYS know
the correct drive you are working with

6. Find the correct drive device (/dev/ABC) from the dmesg command;

```
dmesg | tail -n 30

[    2.829639] usb 4-4: New USB device found, idVendor=2537, idProduct=1068, bcdDevice= 1.00
[    2.829644] usb 4-4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.829646] usb 4-4: Product: X9
[    2.829649] usb 4-4: Manufacturer: XDISK
[    2.829651] usb 4-4: SerialNumber: 232173ABC
[    2.830992] usb-storage 4-4:1.0: USB Mass Storage device detected
[    2.831034] usb-storage 4-4:1.0: Quirks match for vid 2537 pid 1068: 800000
[    2.831048] scsi host7: usb-storage 4-4:1.0
[    2.885994]  sdx: sdx1 sdx2 sdx3
[    2.907942] sd 6:0:0:0: [sdx] Attached SCSI disk

```

In this case it is `/dev/sdx` !Pay carefull attention to the manufacturer/model/product!

MAKE SURE YOUR OS DID NOT AUTOMOUNT THE FILESYSTEMS/PARTITIONS
IF SO UNMOUNT THEM


## Check Filesystems
7. Double check the filesystems(partitions 1 and 2) are clean (i.e. that the pi was
properly shutdown before you removed power)

```
fsck -y /dev/sdx1 #notice the 1 for partition1/boot this is vfat
fsck -y /dev/sdx2 #notice the 2 for partition2/rootfs this is ext4
```

## Perform Backup
9. ok everything is good now to make the backup to somewhere there is space... in
this case I will use your home directory desktop

```
dd if=/dev/sdx | gzip > ${HOME}/Desktop/rpi4-3.5.7-9-samsungevo16G.img.dd
sync
```

Backup is complete... The disk can now be put back in the pi...

You can now re-enable-rootfsexpand if you wish <sup>[5](#re-enable-rootfsexpand)</sup>


## Restoring the backup (later to the same or similar drive)
#(carefull you can wreck your while pc if this is wrong letter use dmesg/lsblk to check)

```
zcat ${HOME}/Desktop/rpi4-3.5.7-9-samsungevo16G.img.dd > /dev/sdZ
sync
```


The disk can now be removed and booted...

You can now re-enable-rootfsexpand if you wish <sup>[5](#re-enable-rootfsexpand)</sup>






## Caveat

To support usbboot the (uniq-per-release)PARTUUID is kept from each factory first flash
across subsequent sysupgrades.

This means that if you say make this backup from your current sdcard, then restore it
to a usbstick (of the same or larger size) it will work IF that same sdcard is not
plugged in at the same time as they will share an identical PARTUUID

## To Do - Manually changing the PARTUUID

This has been written about in a few places... need to find the references...
basically on your pc;
- change /boot/cmdline.txt
- use fdisk advanced options to set the new 0xPARTUUID (carefull!)



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




