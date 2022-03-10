

## so you have lots of data?

-docker?
-lxc?
-samba4 with photos?





NOTE: As of 20220216 in addition to the advice below changing ROOTFSEXPAND=1 to
      ROOTFSEXPAND_DATAPART=1 will get you a persistent 'z' folder/drive

      This unlocks a few persistence features the primary one being
      `reboot_recovery` os snapshotting and quick restoration tool...







OpenWrt is based on traditionally small amounts of flash memory ( 8M to 128M )... where only tiny backup files are/can-be stored...

In this build... i've made several 'enhancements' to support

larger amounts of packages
expansion of the rootfs
but the underlying backup method is still traditional ( although with a stock image /boot is maybe 50M not 300M )



## You need an additional drive (usb3 stick or powered dock/ssd)

Using the traditional block-mount (/etc/config/fstab) to mount an additional drive partition containing all your large data free's up the built in sysupgrade(.conf) process from having to copy(tar) all this additional data during upgrade...

- it's faster
- you don't need somewhere to put it while you flash the new image/OS

## how do I set it up?

### Create an ext4 partition on your new external hard drive
- this can be done in a PC or on the rpi4 itself
- other FS may work ok (f2fs, ext2/3, etc.) not ntfs... but safer to stay with ext4

### Plug it in and verify it's there

```
[root@dca632 /usbstick 52°] block info | grep -v '^/dev/mmc'
/dev/sda1: UUID="aa8fca3f-7077-4f41-a289-ca04fc22470d" LABEL="storage" VERSION="1.0" MOUNT="/usbstick" TYPE="ext4"
```

### Add an entry into /etc/config/fstab

- Find your partition from `block detect`
- Set enabled to 1 and add to /etc/config/fstab

```
### block detect | grep -A5 mount

config 'mount'
	option	target	'/usbstick'
	option	uuid	'aa8fca3f-7077-4f41-a289-ca04fc22470d'
	option	enabled	'0' #<change this to '1' and add to /etc/config/fstab

```

### Use block mount to mount(re) it...

```
block mount

#verify
block info; mount
```

## All done

- note: do NOT add this path or large directories to /etc/sysupgrade.conf
- this drive is NOT backup up... you must unmount/power-down and backup yourself from time to time
- point all services you use to store their data files under this mount-path
	-docker
	-lxc
	-samba

## Are there any ini setting for this?

Currently there are one or two mostly based on what I use ( init.d/(ntop etc. aka chrootdir)

```
### used my init.d/ntop or others
CHROOT_BASEDIR="/usbmountpoint/chroots"

### used by updatecheck-bar>youtubedl
YOUTUBEDL="/usbmountpoint/youtubedownloads"
```

As above chrootbasepath... if anyone is using these with something like docker and feels a custom init.d script or firstboot logic can be of use or any other similar setup, path or automation please post on the forum what you think would work well... preferrably PMing me your config file changes or other setup commands to be automated...

### random example idea1:

```
DOCKERSYNCDIR="/usbmountpoint/dockersync
```
- on startup(or similar, upgrade?), sync /rootfs/docker/... to the external drive path for persistent backups

### random example idea2:
- on firstboot if DATA_DISK="labelname" is set... automatically check and/or create /etc/config/fstab setup for it and mount using the drive LABEL as path...







<hr>

## forum post regarding this

https://forum.openwrt.org/t/rpi4-community-build/69998/1435?u=wulfy23






[guide index](https://github.com/wulfy23/rpi4/blob/master/README.md#github-guides)



