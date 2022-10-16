

# OpenWrt builds for the rpi-4

NOTE: Hetzner (wulfy23.info) hosting expired on the 9/Aug/2022 therefore the account was closed on the 8/Aug/2022



see: <s>https://forum.openwrt.org/t/rpi4-community-build/69998 to request packages, provide feedback etc.</s> 
i'm no longer active on the forums... and builds are <s>discontinued</s> on life support

a few build users have reached out regarding continuation of builds...

given github issues is available to us

- https://github.com/wulfy23/rpi4/issues

it's probably the least I can do to attempt to build images which
contain critical fixes for CVE's or key bumps


anticipate degradation in master based builds and potential discontinuation of them, leaving only release builds available
- factory images if present are primarily for use by existing users of the build



## Credits

### Credit and source courtesy of the OpenWrt team, contributors and the great folks on the forum.

<sup>the two kind $10(AUD) donators who helped facilitate image storage and distribution over the last year</sup><br>
<sup>github https://github.com for a solid and open platform</sup><br><br>


<sup>[@damianperera github_action_sidebuilds](https://github.com/damianperera/openwrt-rpi)</sup><br>
<sup>[@jerrykuku luci-theme-argon](https://github.com/jerrykuku/luci-theme-argon)</sup><br>
<sup>login-sysinfo.sh: Cezary Jackiewicz</sup><br>
<sup>[@NateLol](https://github.com/NateLol/luci-app-oled) and Vinay Divakar</sup><br>
<sup>pi-foundation for a mostly open platform - committers do good things</sup><br>
<sup>Special thanks: vgaetera jeff jow slh trendy and lleachii for guru skillsharing and support... </sup><br>
<sup>@neil1, @PaulFertser, @dibdot, @trendy, @moodyblue, @jayanta525, @poodad, @syntaxterror, @bigfat, @gpuyy, @krazeh, @LionHeartP, @jcejohnson, @cesarvog, @malikshi, @stargeizer, @mint, @johnd2, @BenjaminBeichler, @cricalix, @aporetic, @toasterdev, @masaq, @synapse, @Phase1, @zakeru46, @SubZero, @swanson, @Hagbertumple, @rspierz, @peexl and @geerlingguy for contributions to the build</sup><br>
<sup>@dangowrt, @noltari, @oskari.rauta, @nbd, @bkpepe, @mj22226, @chunkeey, @mhei mainline code</sup><br>
<sup>@hnyman build system insight and official repo fixing</sup><br>
<sup>@bobafetthotmail nicmove/macmatch</sup><br>
<sup>@stangri vpn-pbr and other apps</sup><br>
<sup>@bkpepe, @neheb github mentoring</sup><br>
<sup>[Van Tech Corner](https://www.youtube.com/channel/UCczXrZ5r1nCMACiaipGqbtw)</sup><br>
<sup>[MaroonMed](https://www.maroonmed.com/berry-on-a-bush-router-on-a-stick-raspberry-pi-4-inter-vlan-openwrt-router/)</sup><br>
<sup>sqm-dscp-logic: hisham2630(ultimate-sqm-settings-layer-cake-dscp-marks) (and others) @ldir @dlakelan</sup><br>
<sup>@lynx, @moeller0, @dlakelan + others sqm-autorate (lte/3g/variable-bw-links) (no longer active - use upstream direct)</sup><br>
<sup>argonone code: @DarkElvenAngel</sup><br>
<sup>@dairyman and the rooter peoples</sup><br>
<sup>plenty-of-others: if i have learnt or borrowed something from you thankyou...</sup><br>


## img-specs:
- ext4 300M-boot 900M-rootfs (no squashfs) (NOTE: ROOTFSEXPAND=1 on first upgrade)
                            20220205 alternate ROOTFSEXPAND_DATAPART="psave" option 
- opkg-alt-repo (base|core|luci) 100% non-modified
- over 223 additional drivers and packages


## github-guides
- guides [wulfy23/rpi4/misc/README.md](https://github.com/wulfy23/rpi4/blob/master/misc/README.md)

	- [i am new, hardware, flashing, initial setup](https://github.com/wulfy23/rpi4/blob/master/misc/guides/abc123.md)
	- [updatecheck bar or flavour](https://github.com/wulfy23/rpi4/blob/master/misc/guides/updatecheck.md)
	- [ini-editing](https://github.com/wulfy23/rpi4/blob/master/misc/guides/updatecheck.md#ini-editing)
	- [i have large data](https://github.com/wulfy23/rpi4/blob/master/misc/guides/i_have_large_data.md)
	- [i need something added](https://github.com/wulfy23/rpi4/blob/master/misc/guides/i_need_something_added.md)
	- [o' shit](https://github.com/wulfy23/rpi4/blob/master/misc/guides/fsck.md)
	- [i'm paranoid](https://github.com/wulfy23/rpi4/blob/master/misc/guides/im_paranoid.md)
	- [using vlans](https://github.com/wulfy23/rpi4/blob/master/HARDWARE.md#using-vlans)
	- [dd-backups](https://github.com/wulfy23/rpi4/blob/master/misc/guides/dd-backups.md)
	- [factory-tricks](https://github.com/wulfy23/rpi4/blob/master/misc/guides/factory-tricks.md)


# extra-overview

## features
- automatic re-install of packages post-upgrade (or not)
- luci updatecheck notice with one-click flash
- optimised / patched rpi-eeprom-update
- login sysinfo and sh/bash profile blingification
- usbboot-support/auto-fsck (wip->multiboot/partresize/live-mode)
- usb persisent nic naming (optional)
- pre/post upgrade OS snapshotting or restore assumming bootability and extrapart is enabled
- easy user setup variables via wrt.ini (lanip, ntp-server, etc.) with luci editing
- expansion of partition to whole sdcard on sysupgrade
- webui full-ish text editor (conditional/semi-stale)
- webui browser ssh terminal (wip conditional/to finish test further)
- smb/sshfs mount helper
- nano colors, fake 'man' command
- OLD youtube-download webui (wip requires external storage) (removed/disabled 2022-09)

## scripts
- rpi-sysup-online.sh automated upgrade
- package restore (sysupgrade -R)
- rpi-throttlewatch.sh ( test thermal/scaling )
- some 'locate' command setup+tweaks
- OLD? (may have broken around 2022-03) rpi4-official-opkg.sh for security and bugfixes from master (this may not work post around 2022/03)


## opt-in/out
- persistent logs / statistics / nlbwmon / upgrade-data
- sqmdscp console/other priority @> rpi4.qos
- lucisshon, wifiadminboot
- fwcustom geoip-db(git dl)

## utilities
- speedtest-ookla(git-dl'd)
- qemu(git-manual-dl wip needs a tester)
- base64, tac, stat, blkid, etc. etc.


## packages
- bash (w-temperature@ps1)
- wget curl unzip htop lsof losetup strace vim-fuller
- openvpn + kmod-tun + wireguard + mwan3 + vpn-pbr
- banip + adblock
- many many more... if you call in the next 15mins, you will recieve a free toaster!





