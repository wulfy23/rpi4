

# How is this firmware made?







## use of imagebuilder

This firmware is created using OpenWrt's imagebuilder bundle. It 'bundles' pre-compiled
packages into the firmware image/s.

In top of this, userspace scripts are added to various levels of the OS function to
tweak, optimise, fix, extensify what some elements of the OS perform.

Notably;

	-sysupgrade
         This area of the OS is the one with the most adaptions and alterations.
            -imagebuilder generation
                  -larger partition sizes
                  -use of PARTUUID rather than /dev/x for partition idenitication
                   to support usb boot
            -FILES:
                  -upgrade logic uses PARTUUID if in operation to support USB boot
                  -some .dot flagfiles to know OS/upgrade state, package selections pre/post etc.

            -firstboot:
                  -if an upgrade and enabled, try to restore users last extra packages





















## Build related advice recommended
1) Update regularly at least once a month
2) Make use of /etc/packagesremove.txt to remove most kmods that you don't need
3) Don't enable or start any services you won't use...

## Build related advice optional
1) Blank ini WWW_MODS="" and/or run rpi-support.sh nowwwmods after install
2) (optional) Don't use rpi-sysupgrade-online.sh (use your browser to download and scp the update file) or just use it with dlonly then flash yourself after verification

[guides](https://github.com/wulfy23/rpi4/blob/master/README.md#github-guides)















