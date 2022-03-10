

## updatecheck bar in luci

the updatecheck bar in luci(bootstrap/argon) provides a few build
specific features that usually in one way or another are
required


## What?
- Inform about available builds...
- A flash button for you selected flavour...(one-click-flash)
- A backup function to exclude problematic and bulky files
- Links to a few build specific webapps
- Refresh button to clear/cancel/recheck



## Minor Updates are not usually important

note: minor updates are typically very minor bugfixes or feature
additions and usually are not beneficial to most people...

if it's been more than a month, then read the RELEASE_NOTES to
check for release blockers and critical package backports...

these can typically be fixed by `opkg upgrade` anyway...


## Major Updates especially on 'stable' are more worthy of attention


## flavour

The updatecheck makes use of the updatecheck.sh script and
a variable configured in /root/wrt.ini (or luci > system > startup > custom startup)

```
UPGRADEsFLAVOUR="stable"       #what I advise usually master after a while of testing
#UPGRADEsFLAVOUR="release"     #currently 21.02.0
#UPGRADEsFLAVOUR="current"     #master head/latest, small chances of bugs
                               #or no major changes/improvements to warrant
                               #telling everyone to update
                               #NOTE: at the moment testing = current
#UPGRADEsFLAVOUR="testing"     #master head/latest + stability is of known questionality
```

The default at the current time is 'stable'... If you start with 21.02.0 factory...
you will probably want to change the above variable to 'release'


Now that 21.02.0 is available most 70% people should really be changing stable to release


if you choose to run current see bottom of page for specifics re: bug/availability etc.














## Click refresh
-Before you upgrade(one-click-flash) it's usually helpful to click refresh
for your sanity. Sometimes I may shift out an old build and your info
may be stale... so clicking refresh before you flash will make sure you
have the latest metadata...


## I accidentally clicked one click flash
- If you are fast enough... the refresh button will also cancel an accidentally clicked flash
- You may set the variable `NO_ONECLICKFLASH=1` to remove flash entirely


## Backups
1. The backups you create are available in /www/backup
after you download these please also click [refresh]
for optimal security(mostly from guest/unknown lan hosts)




## Additional webapps
These are semi-secured(as above) although they are still under test
- youtube-dl
- editor (pheditor)
- tty(d) (dynamically launch web based terminal)

For the uber security concious there are two ways to remove these
note: these need more testing(wip) if they do not work for you
please PM me on the forum

1. Comment out the line below or adjust it to your liking...
```
WWW_EXTRAS="ytdl editor ttyd"
```

2. Run rpi-support.sh nowwwmods (also in luci > system > custom commands


## Improvements...
-If you are a skilled coder and would like to offer criticism / suggestions
/ patches for the above... the optimal way to do this would be to PM me...









Editing ini settings <sup>[5](#ini-editing)</sup>



## ini-editing
In `/root/wrt.ini` ( luci > system > startup > local-startup );
(note: you can also use the `[editor]` in the updatecheck bar...)

1. Enable by uncommenting an option by removing the `#`
2. Disable by adding a `#`


### remove-updatecheck-bar
For example, to remove the updatecheck bar (note: this option is applied during upgrade);
```
NOUPDATECHECK=1
```
To enable it again but keep the line disabled

```
#NOUPDATECHECK=1
```



### ENABLEDSERVICES
Another common setting ENABLEDSERVICES which is used on upgrade to re-enable services you wish to run to keep the build light for everyone.

Example setting it up for a few and modemmanger(which needs dbus)
```
ENABLEDSERVICES="adblock dbus modemmanager"
```


Note:

1. some options are required... and if not set will(should) be re-inserted on next upgrade-firstboot
2. there are two more ways these options are applied (i.e. inherited, after upgrade only, runtime by hotplug or services, one-way EEE_DISABLE="eth1" runs from rpi-perftweaks.sh so you need to reboot to turn it off)

- Negating parameters: Adding these will override built-in or other parameters
- Firstboot parameters: These options (most) are only read/applied at firstboot
- Fallback parameters: Probably few... but exist just in case




### UNDER ANY CIRCUMSTANCES DO NOT DO THESE THINGS

```
######################## NOTICE THE MISSING SINGLE QUOTE ON THIS LINE
PARAMETER='something

######################## NOTICE THE MISSING DOUBLE QUOTE ON THIS LINE
FISH=slimey"

######################## DUPLICATE OPTIONS > not so bad last one should be used
UPGRADEsFLAVOUR="release"
UPGRADEsFLAVOUR="testing"
```

DO NOT DO THIS
```
ENABLEDSERVICES="sqm irqbalance https-dns-proxy" [fboot/upgrade] enable+start
#                                                ^ missing #
```

but you can do this
```
ENABLEDSERVICES="sqm irqbalance https-dns-proxy"
#or
ENABLEDSERVICES="sqm irqbalance https-dns-proxy" #[fboot/upgrade] enable+start
```




## unknown or new options

There is a sample file which can be placed on the first partition of a factory install (needs testing)

wrt.ini sample [wulfy23/rpi4/utilities/wrt.ini](https://github.com/wulfy23/rpi4/tree/master/utilities/wrt.ini)

You can checkout the file `/etc/custom/wrt.ini.undocumented` for some extra options that are
either wip or not really 'mainstream'...

If you'd like an option for something... just ask on the forum... fair chance others may want it too!
Can't guarentee anything, but i'll do what is feasable pending the need / complexities...




## About Variants

When I created the build, the goal was to keep it minimal... (yet 'fullish')

Over time more packages were added so 'variants' were made possible

These are NOT RELATED to FLAVOUR at the moment... but are variations on how many packages are bundled with each build...

```
current: 'extra(full)' has more packages than std (semi-discontinued due to low demand)

intermittent: 'std(halffull)' includes general-kmods[device-support], packages that are used for core function [disk,internet,scripting], and packages i'd guess more than 3-5 people use...
```

As most people have been comfortable/happy with the fullest='extra' variant... Other variants are not generated at this time... but there is scope for a 'minimal' or perhaps a 'mega' pending demand... (3-5 regular build users needing such commonalities)

## ib-statix

there is also an alternate solution, via a downloaded (custom) imagebuilder, which offers more flexibility although is less appealing to all users... availability of this is also dependant on 3-5 people regularly needing it... and clearly explaining why... (just because i'd like to know)






## i-chose-to-run-current

Anyone with basic openwrt or command line knowledge is welcome to run current/testing
but be prepared to report bugs, downgrade or toggle on issues and report / laise
would be great... without a few users testing and reporting on a variety conditions
the build inherently grows unstable over time... testing is one of the most 
useful things those who are unable to code/otherwise contribute and can spare the risks can do
to assist on the build.

Current is kind of good for new luci features breaking updates/fixes... but does come with more risks of instability...

Depending on storage space... opkg repo's for current may not be available for more than a week or so...

unlike 'stable' which are intended to be available at minimum for the next 2 subsequent 'stable' versions (i.e. 3 at a time minimum)




## if you are running an old release deliberately or staying on current (does not apply to 'release')

It is possible to use opkg from hetzner hosting rather that github. Repos are retained for a longer
duration there.

If you are testing old builds (non 'release') then you probably want this setting.

If you run 'current' and don't upgrade every month or so, then you probably want this setting.

This setting is applied during firstboot but you can manually switch the opkg feed urls to this path also...
or change the ini variable and re-run; /etc/custom/firstboot/51-opkgdumpconfs


```
OPKGFEEDS_COMMUNITY_DOMAIN="rpi4.wulfy23.info/opkg"
#OPKGFEEDS_COMMUNITY_DOMAIN="github.com/wulfy23/rpi4-opkg/raw/master"
```





# im-running-current-or-testing-and-having-or-reporting-and-issue

- THANKYOU! please check the RELEASE_NOTES first to make sure that it's not something already known
- unless I need some debugging information, i'll probably just say thankyou (and possibly add something to the release notes)...
- it's assumed that if you are running 'current' or 'testing' that you are are;
	- comfortable downgrading or reverting to your own backup/s or sdcard-image/spare if needed OR just putting up with minor quirks for a few days/weeks until the next testing version comes along
	- able to clearly state your version, and any other minimal relevant additional info or run a few commands as requested to further gather this information



# end-of-document

[guides](https://github.com/wulfy23/rpi4/blob/master/README.md#github-guides)


