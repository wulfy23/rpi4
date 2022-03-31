

## so you have lots of data?

## ROOTFSEXPAND=1 > ROOTFSEXPAND_DATAPART='psave'

I use the persistent z drive for log preservation, some chroots, reboot_recovery snapshots (infrequently)

ToDo options that rely-ish / use the above...




## RCSHBASH + RCSHDIR

```
RCSHBASH=1
RCSHDIR="/usbstick"
```
When I login run bash... and change to /usbstick directory which is a block mounted usb drive
containing everything 'not common' to the build... i.e. files i'm testing, development stuff
backups, everything that's also on 'z' drive just in case






## main
### second
- this
- other

### 
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

As above chrootbasepath... if anyone is using these with something like docker and feels a custom init.d script or firstboot logic can be of use or any other similar setup, path or automation please post on the <s>forum</s> github-issues what you think would work well... preferrably PMing me your config file changes or other setup commands to be automated...

### random example idea1:

```
DOCKERSYNCDIR="/usbmountpoint/dockersync
```
- on startup(or similar, upgrade?), sync /rootfs/docker/... to the external drive path for persistent backups

### random example idea2:
- on firstboot if DATA_DISK="labelname" is set... automatically check and/or create /etc/config/fstab setup for it and mount using the drive LABEL as path...







<hr>

## post regarding this

https://forum.openwrt.org/t/rpi4-community-build/69998/1435?u=wulfy23






[guide index](https://github.com/wulfy23/rpi4/blob/master/README.md#github-guides)



