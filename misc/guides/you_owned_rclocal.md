

## so you have some custom stuff you want to run on bootup?

As this build uses rc.local the recommended way to add additional scripts is
to create /etc/custom/YOUR-MAC-CHARS.sh (then add this to sysupgrade.conf
so that it will be backed up over upgrades)

You should copy the sample to be aware of the several hooks available to
this script;

-firstboot
-startup (>everybootTBA)
-upgrade
-shutdown

```
cp -a /etc/custom/dca632563177.sh /etc/custom/YOURMAC.sh
echo /etc/custom/YOURMAC.sh >> /etc/sysupgrade.conf
```


This feature is not often used so report needs/experience
to improve things if needed... (firstboot and upgrade should
work ok)











<hr>



[guide index](https://github.com/wulfy23/rpi4/blob/master/README.md#github-guides)



