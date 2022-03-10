

# So you want to lock it downus maximus eh?

## Non-build-related Advice
1) Run luci on loopback and ssh-tunnel using key only authentication https://openwrt.org/docs/guide-user/luci/luci.secure OR if you have multiple VLANs etc... create a few VLSM firewall rules allowing luci access for only a few ip addresses from preferrably a management subnet or allowed mac-address, note: THIS WOULD BE JUST FOR LUCI... you will want another way to get in (ssh/console) in case you change your subnetting assignments or router ip or whatever... static rules don't really like mass network changes... OR even better just dont run luci at ALL and use ssh for all management
2) Use a long complex password and change it bi-monthly minimum (monthly is better)


## Build related advice recommended
1) Update regularly at least once a month
2) Make use of /etc/packagesremove.txt to remove most kmods that you don't need
3) Don't enable or start any services you won't use...

## Build related advice optional
1) Blank ini WWW_MODS="" and/or run rpi-support.sh nowwwmods after install
2) (optional) Don't use rpi-sysupgrade-online.sh (use your browser to download and scp the update file) or just use it with dlonly then flash yourself after verification

[guides](https://github.com/wulfy23/rpi4/blob/master/README.md#github-guides)















