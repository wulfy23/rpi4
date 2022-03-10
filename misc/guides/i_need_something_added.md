


## requests packages/features

1) required for firstboot net connectivity (or related functions)?
2) are they not too big?
3) can they easily be rendered dormant/intert?
5) are they common to other users?
6) if (complex) setup is required can you provide samples/automation?
7) do they cause any other conflicts with typical device operation or other build related logic?


*Uncommon requests are put to the 3 or 5 build user test ( 20% interest )

## providing these helps (for packages)
1) run `grep . /lib/upgrade/keep.d/* /etc/sysgrade.conf` and double check all the typical service data files outside of /etc/config are in the list if there are more please state the directory/file-paths
2) diff `ps wwww` and `ps wwww` before and after starting the service if any
3) `ls -lah /path/to/binfile` and `du -chs /path/to/any/major/additional/files`
5) your fully configured `/etc/config/service` file, and any additional setup you undertook to setup the service (i.e. write up a brief setup guide)
6) state any complications... i.e. 'httpd-dns-proxy leaves stale config in /etc/config/dnsmasq on upgrade'

## providing these helps (for features)
1) links to simple technical docs for your suggested feature (how it works technically)


[guide index](https://github.com/wulfy23/rpi4/blob/master/README.md#github-guides)





