#!/bin/sh


#logread | sed -n -e "/- preinit -/,/- init -/p"

#lsusb -v | grep -e 'MaxPower' -e 'Bus [0-9]'
######### lspci -kvnn | sed -n '/Network/,/^$/ p'




#dmesg |grep "brcmfmac.*Firmware"


#vcgencmd get_config int
#strings /boot/start.elf | grep VC_BUILD

#head -n1 <(vcgencmd bootloader_version)
#head -n1 <(vcgencmd version)


##############################################
#ethtool -i eth1 #driver info
###################################################
#https://forum.manjaro.org/t/sabrent-usb-2-5g-ethernet-adapter-realtek-8152-chipset-drivers-from-aur/55483/14




#cat /sys/firmware/devicetree/base/model | sed -e "s/[\x0]//g"










#!/bin/bash
# mod by Jim Hurley
# Aug 28, 2019

# Some of the regex's used in sed
# Catch basic IP6 address   "s/\([0-9a-fA-F]\{1,4\}:\)\{7,7\}[0-9a-fA-F]\{1,4\}/y.y.y.y.y.y.y.y/g"
# Catch y::y.y.y.y          "s/[0-9a-fA-F]\{1,4\}:\(:[0-9a-fA-F]\{1,4\}\)\{1,4\}/y::y.y.y.y/g"
# IP4 d.d.d.d decimal	    "s/\([0-9]\{1,3\}\.\)\{3,3\}[0-9]\{1,3\}/x.x.x.x/g"
# mac address	            "s/\([0-9a-fA-F]\{2,2\}\:\)\{5,5\}[0-9a-fA-F]\{2,2\}/m.m.m.m/g"
# strip NUL characters      "s/[\x0]//g"

#OUT=raspinfo.txt

#rm -f $OUT

#exec > >(tee -ia $OUT)

#echo System Information 
#echo ------------------
#echo
#
# there is a NUL here
#cat /sys/firmware/devicetree/base/model | sed -e "s/[\x0]//g"
#echo
#echo

#cat /etc/os-release | head -4
#echo

#cat /etc/rpi-issue
#echo
#uname -a

#cat /proc/cpuinfo | tail -3

#echo "Throttled flag  : "`vcgencmd get_throttled`
#echo "Camera          : "`vcgencmd get_camera`

#echo
#echo "Videocore information"
#echo "---------------------"
#echo
#
#vcgencmd version
#echo
#vcgencmd mem_reloc_stats
#
#echo
#echo "Filesystem information"
#echo "----------------------"

#df
#echo
#cat /proc/swaps

#echo
#echo "Package version information"
#echo "---------------------------"

#apt-cache policy raspberrypi-ui-mods | head -2
#apt-cache policy raspberrypi-sys-mods | head -2
#apt-cache policy openbox | head -2
#apt-cache policy lxpanel | head -2
#apt-cache policy pcmanfm | head -2
#apt-cache policy rpd-plym-splash | head -2

#echo
#echo "Networking Information"
#echo "----------------------"
#echo

#ifconfig | sed -e "s/\([0-9a-fA-F]\{1,4\}:\)\{7,7\}[0-9a-fA-F]\{1,4\}/y.y.y.y.y.y.y.y/g" | sed -e "s/[0-9a-fA-F]\{1,4\}:\(:[0-9a-fA-F]\{1,4\}\)\{1,4\}/y::y.y.y.y/g" | sed -e "s/\([0-9]\{1,3\}\.\)\{3,3\}[0-9]\{1,3\}/x.x.x.x/g" | sed -e "s/\([0-9a-fA-F]\{2,2\}\:\)\{5,5\}[0-9a-fA-F]\{2,2\}/m.m.m.m/g"

#echo
#echo "USB Information"
#echo "---------------"
#echo

#lsusb -t

#echo
#echo "config.txt"
#echo "----------"
#echo

#cat /boot/config.txt | egrep -v "^\s*(#|^$)"
#vcgencmd get_config int
#vcgencmd get_config str


#echo
#echo "cmdline.txt"
#echo "-----------"

#cat /proc/cmdline

#echo
#echo "raspi-gpio settings"
#echo "-------------------"
#echo

#raspi-gpio get

#echo
#echo "vcdbg log messages"
#echo "------------------"
#echo

#sudo vcdbg log msg 2>&1

#echo
#echo "dmesg log"
#echo "---------"
#echo

#dmesg | sed -e "s/\([0-9a-fA-F]\{1,4\}:\)\{7,7\}[0-9a-fA-F]\{1,4\}/y.y.y.y.y.y.y.y/g" | sed -e "s/[0-9a-fA-F]\{1,4\}:\(:[0-9a-fA-F]\{1,4\}\)\{1,4\}/y::y.y.y.y/g" | sed -e "s/\([0-9a-fA-F]\{2,2\}\:\)\{5,5\}[0-9a-fA-F]\{2,2\}/m.m.m.m/g"

















#for dns in $(pidof dnsmasq); do prlimit -p $dns; done

#packet_steering="$(uci get "network.@globals[0].packet_steering")"

#strings /boot/start_db.elf  | grep -i version | grep BUILD_ID
#fgrep BUILD_ID_VERSION /boot/*.elf




########## official 20210211@707
#vert@zr:/fs/sdd1/openwrt/RTNGext/ibminiSINGLE/r707-officailextract$ strings B/*.elf | grep BUILD_ID
#VC_BUILD_ID_USER: dom
#VC_BUILD_ID_TIME: 11:41:45
#VC_BUILD_ID_TIME: Apr 15 2020
#VC_BUILD_ID_BRANCH: bcm2711_2
#VC_BUILD_ID_VARIANT: start_cd
#VC_BUILD_ID_HOSTNAME: buildbot
#VC_BUILD_ID_PLATFORM: raspberrypi_linux
#VC_BUILD_ID_VERSION: 1103ec16df2571274600b377411499bf5aed6d0d (clean)
#VC_BUILD_ID_USER: dom
#VC_BUILD_ID_TIME: 11:41:24
#VC_BUILD_ID_VARIANT: start
#VC_BUILD_ID_TIME: Apr 15 2020
#VC_BUILD_ID_BRANCH: bcm2711_2
#VC_BUILD_ID_HOSTNAME: buildbot
#VC_BUILD_ID_PLATFORM: raspberrypi_linux
#VC_BUILD_ID_VERSION: 1103ec16df2571274600b377411499bf5aed6d0d (clean)
#VC_BUILD_ID_USER: dom
#VC_BUILD_ID_TIME: 11:42:37
#VC_BUILD_ID_VARIANT: start_x
#VC_BUILD_ID_TIME: Apr 15 2020
#VC_BUILD_ID_BRANCH: bcm2711_2
#VC_BUILD_ID_HOSTNAME: buildbot
#VC_BUILD_ID_PLATFORM: raspberrypi_linux
#VC_BUILD_ID_VERSION: 1103ec16df2571274600b377411499bf5aed6d0d (clean)
#########################################################################################



#8 GiB model was introduced in May 2020
#########################################################################################@build
#VC_BUILD_ID_USER: dom
#VC_BUILD_ID_TIME: 21:13:42
#VC_BUILD_ID_TIME: May 22 2020
#VC_BUILD_ID_BRANCH: bcm2711_2
#VC_BUILD_ID_VARIANT: start_db
#VC_BUILD_ID_HOSTNAME: buildbot
#VC_BUILD_ID_PLATFORM: raspberrypi_linux
#VC_BUILD_ID_VERSION: 4da3e1264076308eda90652cb98b553ae0586390 (clean)
#########################################################################################


#strings B/*.elf | grep BUILD_ID | grep -E '(VARIANT|VERSION|TIME)' | sort | uniq


#https://github.com/raspberrypi/firmware/issues/1518
#Yes, it first appeared in the 5.4.81 release































. /etc/custom/buildinfo.txt 2>/dev/null
. /.filesinfo 2>/dev/null
. /etc/os-release 2>/dev/null

sepS="#################################"






usage() {

cat <<LLL

    $0
        -b|brief        (brief)
        -d|detail       (wip-usenoparams)
        -hw         	(hwstats)

	-c		#slow dump cumulative package restore info
	upgradelog

        eeprom-update

        nowwwmods

	safebackup      http://router/backup.tar.gz #for 10mins

LLL


	
if [ -f /z/.datapart ]; then


cat <<LLL
	snapshot
	revertos
LLL


else
cat <<LLL
	#no datapart present
LLL

fi




}









if [ "$1" = "safebackup" ]; then




tar -cvzf /www/backup.tar.gz $(sysupgrade -l -q | grep -Ev '(/etc/passwd|/etc/shadow|/etc/group|/etc/config/rpcd|/etc/config/uhttpd|/root/tasks|/root/backup|/restorefiles|/etc/custom|/etc/tvheadend|/etc/php8|/etc/firewall.user|/boot/cmdline.txt|/etc/profile.d|/etc/sysupgrade.conf|/etc/rc.local|/etc/simple-adblock.servers.gz|/etc/profile|/etc/shells|/etc/shinit)') 1>/dev/null 2>/dev/null

echo "Download backup from http://router/backup.tar.gz / https://router/backup.tar.gz #10mins only"

(sleep 300; rm /www/backup.tar.gz 1>/dev/null 2>/dev/null)&

exit 0





fi


























show_maininfo() {


vlver=$(lspci -d 1106:3483 -xxx 2>/dev/null | awk '/^50:/ { print "VL805 FW version: " $5 $4 $3 $2 }')
if [ -n "${vlver}" ]; then
	vlver="${vlver#*: }"
fi
if [ -z "${vlver}" ]; then
	vlver=$(vcgencmd otp_dump 2>/dev/null | grep '30:' | sed 's/.*://')
fi





fwV=$(vcgencmd bootloader_version 2>/dev/null | head -n 1 2>/dev/null | cut -d' ' -f1,2,3 2>/dev/null | sed 's/ //g' 2>/dev/null)

fwWIFIdmesg=$(dmesg | grep brcmfmac | grep ' Firmware' | cut -d' ' -f7-)

################### vcgencmd bootloader_version
#Sep  3 2020 13:11:43
#version c305221a6d7e532693cc7ff57fddfc8649def167 (release)
#timestamp 1599135103


	if [ -x /bin/rpi4-getrevision.sh ]; then
		extraBD="$(/bin/rpi4-getrevision.sh)"
	fi





cat<<EOF
################################## $extraBD
############ buildid:${BUILD_ID:-buildidunknown} localversion:${localversion:-unknown} files:${FILESHASH:-hashunknown} variant:${variant:-unknown}
############ fwV:${fwV:-unknown} vlV:${vlver:-unknown}
############ fwWIFI: $fwWIFIdmesg
EOF
############ buildid:${BUILD_ID:-buildidunknown} localversion:${localversion:-unknown} files:${FILESHASH:-hashunknown} variant:${variant:-unknown} fwV:${fwV:-unknown} vlV:${vlver:-unknown}

###################################################################noideawhatthisis-userland||mbox blob?
fwMd=$(dmesg | grep 'raspberrypi-firmware soc:firmware' | grep 'Attached' | cut -d' ' -f12)

#strings /boot/start4.elf  | grep 'VC_BUILD_ID_TIME' | awk '{print $2 " " $3 " " $4}'  | grep -v :




fwMh=$(dmesg | grep 'raspberrypi-firmware soc:firmware' | grep 'are hash' | cut -d' ' -f11)
#echo "raspberrypi-firmware: $fwMd $fwMh"
echo "############ fwGPU: $fwMd $fwMh"





echo "$sepS wrt.ini brief"



cat /root/wrt.ini 2>/dev/null | grep -v '^#' | grep -v '^$' | grep -E '(NO.*|LUCI.*|WIFI.*|OVERCLOCK.*|PERFTW.*|RPI.*|RC.*|POWER.*|ENABLE.*|PROMP*|BASH.*|ASH.*|FW.*|COLOR.*|EXP.*)' | grep -v 'CONSOLEMACS' | while read LINE; do
	if echo $LINE | grep -q RPI4QOS_GAMING_MACS; then
		LINE=$(echo $LINE | cut -c1-23)
	fi
	echo $LINE
done

echo "$sepS"






DISKS=$(df -h | grep -Ev '(/dev$|^overlay|^shm)' | grep -vE '(^Filesystem|/opt/docker)' | tr -s '\t' ' ' | cut -d' ' -f5,6 | sed 's! !:!g' | tr -s '\n' ' ')
UPTIME=$(uptime 2>/dev/null | sed 's!load average: !!g' | sed 's! up !!g' | sed 's!^ !!g')
cat <<EOF
  UPTIME: $UPTIME
   DISKS: $DISKS
EOF












#NOTE:last8chars(9forLF) IS THE NETWORKBOOT string
#RPISERIALnum=$(cat /proc/cpuinfo | grep Serial | awk -F ': ' '{print $2}' | tail -c 9)

echo "$sepS hardware info"
cat /proc/cpuinfo  | grep -A3 Revision


#echo "$sepS dmesg-notable" #dmesg | grep 'raspberrypi-firmware soc:firmware'





#UPGhistCNT="$(cat /restorefiles/systeminfo.* 2>/dev/null | grep '^localversion' | cut -d'"' -f2 | tr -s '\n' ' ' | wc -w)"
#UPGhistLST="$(cat /restorefiles/systeminfo.* 2>/dev/null | grep '^localversion' | cut -d'"' -f2 | tr -s '\n' ' ')"
#echo "$sepS upghist: ${UPGhistCNT} ${UPGhistLST}"





}

















show_packagerestoreactions() {
if [ -f /root/.packagesrestored ]; then RESTORED=applied; fi
if [ -f /root/.packagesrestore.actions ] && [ "$(cat /root/.packagesrestore.actions | wc -l)" -gt 0 ]; then
    echo "$sepS AUTORESTORE ${RESTORED:-unapplied}"
    cat /root/.packagesrestore.actions 2>/dev/null
fi
}








if [ "${1}" = "snapshot" ] || [ "${1}" = "revertos" ]; then

	if [ -z "$(command -v reboot_recovery)" ]; then ISSUES="${ISSUES} reboot_recovery-unavailable"; fi
	if [ ! -f /z/.datapart ]; then ISSUES="${ISSUES} no-z-drive"; fi
	if [ "${1}" = "revertos" ]; then
		if [ "$(find /z/recovery -maxdepth 1 -type f 2>/dev/null | grep "tar.gz$" | wc -l)" -eq 0 ]; then
			ISSUES="${ISSUES} no-snapshots-have-been-made"
		fi
	fi

	if [ ! -z "${ISSUES}" ]; then
		case "${1}" in
			snapshot)
				reboot_recovery snapshot now
			;;

			revertos)
				reboot_recovery revertos now
			;;
		esac
	else
		echo "issues: ${ISSUES}"
	fi

	exit 0

fi






if [ "${1}" = "nowwwmods" ]; then

	rm -rf /usr/bin/ttyd 2>/dev/null
	rm -rf /www/dl 2>/dev/null
	rm -rf /www/editor 2>/dev/null
	rm /www/index.sh 2>/dev/null
	#/etc/init.d/uhttpd restart 2>/dev/null 1>/dev/null
	echo "www mods removed"

	exit 0
fi








if [ "${1}" = "upgradelog" ] && [ -f /boot/.upgrade.rpt ]; then
	cat /boot/.upgrade.rpt | grep -v '^Reading' | grep -v '^Copying'
	exit 0
elif [ "${1}" = "upgradelog" ] && [ ! -f /boot/.upgrade.rpt ]; then
	echo "no upgrade log available"
	exit 0
fi





if [ "${1}" = "eeprom-update" ]; then


	if [ -x /bin/rpi4_eeprom.sh ]; then

		if [ ! -z "${2}" ]; then
			#needtomakesureitssetupfirst
			#if [ "${2}" = "cancel" ]; then
			#	rpi-eeprom-update -r
			#else
				/bin/rpi4_eeprom.sh fetch ${2} -LUCI
			#fi
		fi

		#NOTE: stderr likely hook output
		echo "#########################################i> /bin/rpi4_eeprom.sh update"
		rpi4_eeprom.sh update -LUCI 1>/tmp/.eeprom-update.stdout 2>/tmp/.eeprom-update.stderr #@@@TEST-RETVAL
		########################################################################################
		cat /tmp/.eeprom-update.stdout 2>/dev/null
		########################################################################################
		echo "#########################################i> /bin/rpi4_eeprom.sh info"
		/bin/rpi4_eeprom.sh info
		########################################################################################
		

		########################################################################################
		#OFFMESSY-and-INFO-PRINTSdiffJUSTnotWHEREcamefrom
		#echo "#########################################i> config-hook-info"
		#cat /tmp/.eeprom-update.stderr 2>/dev/null
		########################################################################################
		rm /tmp/.eeprom-update.stderr /tmp/.eeprom-update.stdout 2>/dev/null

	else
		echo "/bin/rpi4_eeprom.sh [nope]"
	fi

	exit 0
fi









########################################################################################################
#if [ ! -z "${2}" ]; then
	###needtomakesureitssetupfirst
	###if [ "${2}" = "cancel" ]; then
	###	rpi-eeprom-update -r
	###else
#		/bin/rpi4_eeprom.sh fetch ${2} -LUCI
	###fi
#fi
########################################################################################################

########################################################################################################
###### ORIGINALMANUALCOMMANDS ######RETIRED /bin/rpi4_eeprom.sh updaterecommended -LUCI
########################################################################################################


############################################################# MOVE(stderrAKAhookoutTOAFTER info
#echo "#########################################i> stdout"; cat /tmp/.eeprom-update.stdout 2>/dev/null
#echo "#########################################i> stderr"; cat /tmp/.eeprom-update.stderr 2>/dev/null
########################################################################################################

########################################################################################################
###### ORIGINALMANUALCOMMANDS ######RETIRED /bin/rpi4_eeprom.sh updaterecommended -LUCI
########################################################################################################
################### stderr aka HOOK prints RED /bin/rpi4_eeprom.sh update -LUCI
########################################################################################################
##### NEVERUSEDokBUTshuntsOTHERstdERR /bin/rpi4_eeprom.sh update -LUCI 2>/tmp/.rpieepromupdatehook
########################################################################################################
### WONTWORKNEEDINVERTED rpi4_eeprom.sh update -LUCI 2>&1 | grep '\.sh\.hook' >/tmp/.rpieepromupdatehook
########################################################################################################
###REDIRECTISSUES rpi4_eeprom.sh update -LUCI 2>&1 >/tmp/.rpieepromupdateoutput
########################################################################################################
###STILLCONFUSING
#rpi4_eeprom.sh update -LUCI 2>/tmp/.rpieepromupdateoutput 1>/tmp/.rpieepromupdateoutput
#cat /tmp/.rpieepromupdateoutput 2>/dev/null | grep -v '\.sh\.hook'
#cat /tmp/.rpieepromupdateoutput 2>/dev/null | grep '\.sh\.hook'
########################################################################################################
		






while [ "$#" -gt 0 ]; do
case "${1}" in
    help|-h|--help) usage; exit 0; ;;
    -b|brief) BRIEF=1; sACTION="brief"; shift 1; ;;
    -d|detail) BRIEF=1; sACTION="detail"; shift 1; ;;
    -c) SHOWCUMULATIVE="1"; shift 1; ;;
    ########## -hw) sACTION="hw"; shift 1; ;;
    -hw) SHOWHW="hw"; shift 1; ;;
    #-hw) sACTION="${sACTION} hw"; shift 1; ;; #????????????????????
    "-v") VERBOSE="-v"; shift 1; ;;
    *)
        #DOCHECK="check"
        echo "unknown-parameter: $1"; usage; shift 1; sleep 1; exit 0; ;;
esac #if [ -f
done # current|stable|testing) FLAVOUR="${1}"; shift 1; ;; #@ifzFLAV





if [ -z "$sACTION" ]; then #echo "DEBUG sACTION: $sACTION"; sleep 2
	sACTION="default" #!!!sACTION="full"@wififirmwareinfoetc
	#SHOWHW
	#SHOWCUMULATIVE???
fi












if [ ! -z "$(command -v findmnt)" ]; then
	ROOTDEV=$(findmnt -n / 2>/dev/null | tr -s '\t' ' ' | cut -d' ' -f2)
	ROOTDEVptuuid=$(partx -g -o UUID $ROOTDEV)
	BOOTDEV=$(findmnt -n /boot 2>/dev/null | tr -s '\t' ' ' | cut -d' ' -f2)
	echo "$sepS root-dev: $ROOTDEV:$ROOTDEVptuuid boot-dev: $BOOTDEV"
else
	echo "$sepS findmnt-unavailable"
fi
#partx -g -o UUID $(findmnt -n / | tr -s '\t' ' ' | cut -d' ' -f2)
#partx -g -o type /dev/mmcblk0p1




if [ -f /boot/cmdline.txt ]; then
#r RAW
ROOTonPROC_r=$(sed -e 's/ /\n/g' /proc/cmdline | grep '^root=' | head -1 2>/dev/null | sed -e 's/^root=//' -e 's/,.*//')
ROOTonCMDL_r=$(sed -e 's/ /\n/g' /boot/cmdline.txt | grep '^root=' | head -1 2>/dev/null | sed -e 's/^root=//' -e 's/,.*//')
fi




ROOTPARTINFO="root@boot: $ROOTonPROC_r"
#echo "root@boot: $ROOTonPROC_r"
if [ ! -z "$ROOTonCMDL_r" ]; then
ROOTPARTINFO="${ROOTPARTINFO} root@cmdline: $ROOTonCMDL_r"
#echo "root@cmdline: $ROOTonCMDL_r"
fi

echo "$sepS root-partinfo: ${ROOTPARTINFO}"





show_maininfo





if [ "$(grep 'Writing' /boot/.upgrade.rpt 2>/dev/null | wc -l)" -gt 0 ]; then


	if [ -f /boot/.upgrade.time ] && grep -q "^UPGRADEt_TOTAL" /boot/.upgrade.time 2>/dev/null; then
		eval $(grep '^UPGRADEt_TOTAL=' /boot/.upgrade.time 2>/dev/null)
		echo "$sepS upgradespeed totaltimesecs:$UPGRADEt_TOTAL"
	else
		echo "$sepS upgradespeed"
	fi

	grep 'Writing' /boot/.upgrade.rpt 2>/dev/null

fi







case "$sACTION" in
	*) echo "$sepS cmdline.txt"; cat /boot/cmdline.txt; ;;
esac



case "$sACTION" in
	*)
        echo "$sepS config.txt"
		cat /boot/config.txt | grep -v '^#' | grep -v '^$' | grep -vE '(\[all\]|distroconfig)'
        echo "$sepS"
	;;
esac

















bcharappendstr() {

case "$1" in
	2) BOOT_ORD="${BOOT_ORD} tftp"; ;;
	1) BOOT_ORD="${BOOT_ORD} usb"; ;;
	4) BOOT_ORD="${BOOT_ORD} mmc"; ;;
esac

}
#2) BOOT_ORD="${BOOT_ORD:-} tftp"; ;;



eval $(vcgencmd bootloader_config | grep "^BOOT_ORDER")
BOOTCASE=$(echo $BOOT_ORDER | sed 's!0xf!!g')
#echo "BOOTCASE: $BOOTCASE"

while read B_CHAR; do
	[ -z "${B_CHAR}" ] && continue
	#echo "B_CHAR: $B_CHAR"
	bcharappendstr "$B_CHAR"
done <<LLL
$(echo $BOOTCASE | sed -e 's/\(.\)/\1\n/g')
LLL


echo "BOOTORDER: ${BOOT_ORD:-"unknown${BOOT_ORDER}"}"



#[root@dca632 /usbstick 48°]# vcgencmd bootloader_config
#[all]
#BOOT_ORDER=0xf14
#BOOT_UART=1
#WAKE_ON_GPIO=0
#POWER_OFF_ON_HALT=1
#DHCP_TIMEOUT=45000
#DHCP_REQ_TIMEOUT=4000
#TFTP_FILE_TIMEOUT=30000
#ENABLE_SELF_UPDATE=0
#DISABLE_HDMI=0
###################################
#echo "$sepS eeprom-config"
#vcgencmd bootloader_config
###################################
#  DISABLE_HDMI=0
#  SD_BOOT_MAX_RETRIES=1
#  USB_MSD_BOOT_MAX_RETRIES=1
#  TFTP_IP=192.168.0.130
#  BOOT_ORDER=0xf421
###################################
#Value	Mode	Description
#0x1	SD CARD	SD card (or eMMC on Compute Module 4)
#0x2	NETWORK	Network boot
#0x3	RPIBOOT	RPIBOOT - See usbboot (since 2020-09-03)
#0x4	USB-MSD	USB mass storage boot (since 2020-09-03)
#0x5	BCM-USB-MSD	USB 2.0 boot from USB Type-C socket or USB Type-A socket on CM4 IO board. (since 2020-12-14)
#0xe	STOP	Stop and display error pattern (since 2020-09-03). A power cycle is required to exit this state.
#0xf	RESTART	Start again with the first boot order field. (since 2020-09-03)
#############################
#If the RESTART (0xf) boot mode is encountered more than MAX_RESTARTS times then a watchdog reset is triggered. This isn't recommended for general use but may be useful for test or remote systems where a full reset is needed to resolve issues with hardware or network interfaces.
#############################
#Default: -1 (infinite)
#############################
#https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2711_bootloader_config.md
#https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2711_bootloader_config.md
#https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2711_bootloader_config.md
#https://www.raspberrypi.org/documentation/hardware/raspberrypi/booteeprom.md




















#performance	Run the CPU at the maximum frequency.
#powersave	Run the CPU at the minimum frequency.
#userspace	Run the CPU at user specified frequencies.
#ondemand	Scales the frequency dynamically according to current load. Jumps to the highest frequency and then possibly back off as the idle time increases.
#conservative	Scales the frequency dynamically according to current load. Scales the frequency more gradually than ondemand.
#schedutil	Scheduler-driven CPU frequency selection [2], [3].





THEGOV=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor 2>/dev/null)
case "$THEGOV" in
	ondemand)
GOV_UPTHRESH=$(cat /sys/devices/system/cpu/cpufreq/ondemand/up_threshold)
GOV_FREQMIN=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq)
GOV_FREQMAX=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq)
GOV_FREQCUR=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq)


#20220131 if overclocked
#GOV_STATEl=$(cat /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state | grep -A7 "$GOV_FREQMIN" | sed 's! !:!g' | tr -s '\n' ' ')
GOV_STATEl=$(cat /sys/devices/system/cpu/cpufreq/policy0/stats/time_in_state | grep -A12 "$GOV_FREQMIN" | sed 's! !:!g' | tr -s '\n' ' ')





#echo "$sepS SCALING"
#echo "            SCALING:$THEGOV thresh:$GOV_UPTHRESH min:$GOV_FREQMIN max:$GOV_FREQMAX cur:$GOV_FREQCUR"
#echo "   SCALINGSTATETIME: $GOV_STATEl"
#echo "$sepS"
SCALINGINFO="SCALING:$THEGOV thresh:$GOV_UPTHRESH min:$GOV_FREQMIN max:$GOV_FREQMAX cur:$GOV_FREQCUR"
SCALINGINFO="${SCALINGINFO} TIME:$GOV_STATEl"

	;;
	*)
#echo "$sepS SCALING: $THEGOV"
#echo "/sys/devices/system/cpu/cpufreq/policy0/scaling_governor $(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor 2>/dev/null)"









##############WASON@20220117 bad kernel/gpu fw print scaling issue SCALINGINFO="SCALING:$THEGOV"
#[    0.348365] cpu cpu0: Cannot get clock for CPU0
#[    0.348386] raspberrypi-cpufreq: probe of raspberrypi-cpufreq failed with error -2
###NB: no dir /sys/devices/system/cpu/cpufreq/policy0/<<<




SCALINGINFO="SCALING:${THEGOV:-"no_govenor_set:/sys/devices/system/cpu/cpufreq/policy0/scaling_governor"} ISSUES"

	;;




esac

#/sys/devices/system/cpu/cpufreq/policy0/stats/trans_table
#[root@dca632 /usbstick 50°]# cat /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq #750000
#[root@dca632 /usbstick 48°]# cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq









dumphwstats() {

DisplayHeader="Time       Temp     CPU     Core         Health           Vcore    PMIC"
    echo -e "${DisplayHeader}"
  Health=$(perl -e "printf \"%19b\n\", $(vcgencmd get_throttled | cut -f2 -d=)")
  Temp=$(vcgencmd measure_temp | cut -f2 -d=)
  Pmic=$(vcgencmd measure_temp pmic | cut -f2 -d=)
  Clockspeed=$(vcgencmd measure_clock arm | awk -F"=" '{printf ("%0.0f",$2/1000000); }' )
  Corespeed=$(vcgencmd measure_clock core | awk -F"=" '{printf ("%0.0f",$2/1000000); }' )
  CoreVolt=$(vcgencmd measure_volts | cut -f2 -d= | sed 's/000//')
  echo -e "$(date '+%H:%M:%S')  ${Temp}  $(printf '%4s' ${Clockspeed})MHz $(printf '%4s' ${Corespeed})MHz  $(printf '%020u' ${Health})  ${CoreVolt}  ${Pmic}"


}






UPTIME=$(uptime)
nCT=$(conntrack -L 2>/dev/null | wc -l)
nLPt=$(lsof -i -nP | grep -v ESTAB | grep TCP | wc -l)
nLPu=$(lsof -i -nP | grep -v ESTAB | grep UDP | wc -l)




echo "### uptime: $UPTIME"
echo "### network conntrack:$nCT lportsT:$nLPt lportsU:$nLPu"










top -b -n 1 | head -n2 | while read THIS; do
    echo "### $THIS"
done


dumphwstats | while read THIS; do
    echo "### $THIS"
done




if [ ! -z "$SCALINGINFO" ]; then
	echo "$SCALINGINFO"
fi








if [ -f /restorefiles/.overclock.rebootpending ]; then
	############### echo "### SCALING: overclockrebootpending"
	OVERCLOCKmsg="${OVERCLOCKmsg} overclockrebootpending"
elif grep -q '^arm_freq' /boot/config.txt || grep -q '^over_voltage' /boot/config.txt; then
	#echo "### SCALING: overclock_config.txt"
	OVERCLOCKmsg="${OVERCLOCKmsg} overclock_config.txt"
elif grep -q '^arm_freq' /boot/distroconfig.txt || grep -q '^over_voltage' /boot/distroconfig.txt; then
	#echo "### SCALING: overclock_distroconfig.txt"
	OVERCLOCKmsg="${OVERCLOCKmsg} overclock_distroconfig.txt"
fi




wrtiniOCLKprint() {
	cat /root/wrt.ini 2>/dev/null | grep 'OVERCLOCK'
}




if [ ! -z "${OVERCLOCKmsg}" ]; then
	echo "### SCALING: ${OVERCLOCKmsg} ini:$(wrtiniOCLKprint)"
fi



















echo "################ vcgencmd get_config int | grep freq"
vcgencmd get_config int | grep freq | grep -v hdmi
















#case "$sACTION" in
#	*) echo "$sepS usbdevices"; lsusb -t | grep -Ev '(hub|xhci)'; ;;
#esac
######echo "$sepS usbdevicesLOTS"; dmesg  | grep usb | grep -v register
#######echo "$sepS usbdevices"; lsusb | grep -v -i hub




if [ ! -z "$SHOWHW" ]; then
	echo "$sepS usbdevices"; lsusb -t | grep -Ev '(hub|xhci)'
fi












case "$sACTION" in
	brief) :; ;;
	*)
		echo "$sepS opkg-repos"
		grep -vE '(^#|^$)' /etc/opkg/customfeeds.conf  /etc/opkg/distfeeds.conf 2>/dev/null
	;;
esac

















stringsblob() {
    strings /lib/firmware/brcm/brcmfmac43455-sdio.bin | grep -E '(Ucode|^FWID|^DVID)' | grep -v '\%'
} ############################### wififw


wififirmwareinfo() {
cat /lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.txt 2>/dev/null | grep -E '(boardrev|boardtype)'
stringsblob
strings /lib/firmware/brcm/brcmfmac43455-sdio.bin | grep -o 'Version:.*'
}

#modinfo brcmfmac

case "$sACTION" in
	brief|default) :; ;;
	*)
		echo "$sepS wifi-firmare-info"
		wififirmwareinfo
	;;
esac















if [ ! -z "$SHOWHW" ] || ! echo "$sACTION" | grep -q brief; then
	echo "########################################## GPIO"
	cat /sys/kernel/debug/gpio | grep \|
fi #find /sys/class/gpio -type l | grep 'gpiochip'













ethtoolcheck() {
    case "$1" in
        err)
ethtool -S $2 2>/dev/null | grep -E '(errors:|drops:|pause:|col:|jabber:|cnt:|frags:|outrange:|unknown:)' | grep -v 'mdf_err' | grep -v ': 0'
    ;;
    esac
}

interfacereport() {

ip link | tr -s '\t' ' ' | grep -v ' link' | grep -v DOWN | cut -d' ' -f2 | sed 's/ //g' | sed 's/://g' | sed 's/@.*$//g' | \
    while read FACE; do #echo "############### $FACE"; ethtoolcheck "err" "$FACE"
	    iERR=$(ethtoolcheck "err" "$FACE")
	    if [ ! -z "$iERR" ]; then
    		#echo "############### $FACE"; echo "$iERR"
    		iMSG="############### $FACE err:$iERR"
		else
    		#echo "############### $FACE [ok]"
    		iMSG="############### $FACE [ok]"
	    fi
        iMSG="${iMSG} $(ethtool -i $FACE 2>/dev/null | grep 'driver:' | cut -d' ' -f2)"
        iMSG="${iMSG} $(ethtool -I $FACE 2>/dev/null | grep 'Link detected:' | cut -d' ' -f3)"
        iMSG="${iMSG} $(ethtool -I $FACE 2>/dev/null | grep 'Speed:' | cut -d' ' -f2)"

        echo "$iMSG"

done

}









sALG="$(cat /proc/sys/net/ipv4/tcp_congestion_control)"
for cALG in $(cat /proc/sys/net/ipv4/tcp_available_congestion_control); do
	
	if [ "$cALG" = "$sALG" ]; then
		algs="$algs [$cALG]"
	else
		algs="$algs $cALG"
	fi
done
#echo "tcp-algo: $algs"





if [ ! -z "$SHOWHW" ] || ! echo "$sACTION" | grep -q brief; then
	echo "$sepS interface-report: $algs"
	interfacereport
fi














#ethtool -I eth0
#	Speed: 1000Mb/s
#	Duplex: Full
#	Link detected: yes
###	Auto-negotiation: on #Supports Wake-on: gs #	Wake-on: d #	Current message level: 0x00000007 (7) \n   drv probe link
#        SecureOn password: 00:00:00:00:00:00




















#########if [ -z "$SHOWHW" ] || ! echo "$sACTION" | grep -q brief; then #!!!!!!!!!!!!!!!!!! 2021hack->needs cumulative
###########fi

#case "$sACTION" in
#	brief) :; ;;
#	*)
#		echo "$sepS packages-restore-historical"
#		cat /etc/custom/cumulative.txt 2>/dev/null
#		##############grep -vE '(^#|^$)' /etc/custom/autorestore.sh 2>/dev/null
#	;;
#esac
if [ ! -z "$SHOWCUMULATIVE" ]; then
	
	#ORIGINAL
	#echo "$sepS packages-restore-historical"
	#cat /etc/custom/cumulative.txt 2>/dev/null

	echo "$sepS packages-restore-historical"
	cat /etc/custom/cumulative.txt 2>/dev/null | while read LINE; do
	if echo $LINE | grep -q RPI4QOS_GAMING_MACS; then
		LINE=$(echo $LINE | cut -c1-23)
	fi
		echo $LINE
	done

fi




UPGhistCNT="$(cat /restorefiles/systeminfo.* 2>/dev/null | grep '^localversion' | cut -d'"' -f2 | tr -s '\n' ' ' | wc -w)"
UPGhistLST="$(cat /restorefiles/systeminfo.* 2>/dev/null | grep '^localversion' | cut -d'"' -f2 | tr -s '\n' ' ')"
#echo "$sepS upghist: ${UPGhistCNT} ${UPGhistLST}"

echo "$sepS upghist_count: ${UPGhistCNT}"
echo "$sepS upghist_list: ${UPGhistLST}"










#RANDOMSAMPLE cat /root/wrt.ini 2>/dev/null | grep -v '^#' | grep -v '^$' | grep -E '(NO.*|LUCI.*|WIFI.*|RPI.*|RC.*|POWER.*|ENABLE.*|PROMP*|BASH.*|ASH.*|FW.*|COLOR.*|EXP.*)' | grep -v 'CONSOLEMACS'






case "$sACTION" in
    brief) :; ;; #dontshow@brief
    *)
		echo "$sepS packages-restore-actions"
		show_packagerestoreactions
	;;
esac
















#@root/.packagerestore.actions #whystopped?
############### TEMPORARILYADDINGTHISFORBREVVITY NOT PROPERFLOW!!!






case "$sACTION" in
    brief) :; ;; #dontshow@brief
    *)


	echo "$sepS packages-restored-RAWDIRECT"
	cat /root/.packagesrestored 2>/dev/null
	
	echo "$sepS autorestore-running-RAWDIRECT"
	cat /etc/custom/autorestore.sh 2>/dev/null

	;;
esac









exit 0









case "$sACTION" in
	brief)

    : #20201221 evalhere nothing eval $(grep '^BUILD_ID' /etc/os-release)



#@@@ -b
#    "brief")
#	    shift 1
#cat <<NNN
#         variant: $variant
#NNN
#	BUILD_ID: $BUILD_ID
#    localversion: $localversion
#exit 0
	    ;;
    *)
        #DOCHECK="check"

	;;
	*)
		show_packagerestoreactions
	;;
esac










#show_packagerestoreactions
#find /sys/firmware/ | grep brcm #DEVICETREE


#ubus call network.interface dump | jsonfilter -e "@.interface[*]"


#ip -d link #dbg-net-verbose
#ip -s link show dev eth0 ||drops?

#ip link xstats type bridge #bridge IGMP-MLD
#ip -s link afstats dev br-lan ???
#ip link xstats type bridge_slave
########non openwrt #netstat -s #netstat --statistics



################
#ethtool -S eth0 | grep -E '(errors:|drops:|pause:|col:|jabber:|cnt:|frags:|outrange:|unknown:)' | grep -v ': 0'
#~     rx_runt_inval_fcs_align: 0
###~- mdf_err_cnt: 5





#ip link | tr -s '\t' ' ' | grep -v ' link' | grep -v DOWN | cut -d' ' -f2 | sed 's/ //g' | sed 's/://g' | sed 's/@.*$//g'
#ip link | tr -s '\t' ' ' | grep -v ' link' | cut -d' ' -f2 | sed 's/ //g' | sed 's/://g' | sed 's/@.*$//g'
#ip link | tr -s '\t' ' ' | grep -v ' link' | grep -v 'DOWN' | cut -d' ' -f2 | sed 's/ //g'
#ip link | tr -s '\t' ' ' | grep -v ' link' | cut -d' ' -f2 | sed 's/ //g'









MPSTAT=$(command -v mpstat); if [ ! -z "$MPSTAT" ]; then $MPSTAT | tail -n2; fi





#case "$sACTION" in
#	brief) :; ;;
#	*)
#		echo "################################## cmdline.txt"
#		cat /boot/cmdline.txt
#	;;
#esac






#buildid:${BUILD_ID:-buildidunknown} localversion:${localversion:-unknown} files:${FILESHASH:-hashunknown} ${FILESDATE:-dateunknown} ${FILESREVISION:-revisionunknown}
#echo "localversion: ${localversion:-unknown}"
#cat /root/wrt.ini 2>/dev/null | grep -v '^#' | grep -v '^$' | head -n5




#grep localversion /etc/custom/buildinfo.txt 2>/dev/null







################################################# ORIGINALISH-KEEP@PACKAGERESTOREACTIONSvsCUMULATIVE-SUMMARY
. /etc/custom/buildinfo.txt 2>/dev/null
. /.filesinfo 2>/dev/null
. /etc/os-release 2>/dev/null




usage() {

cat <<LLL

    $0
        -b          (brief)

LLL
}




dumphwstats() {

DisplayHeader="Time       Temp     CPU     Core         Health           Vcore    PMIC"
    echo -e "${DisplayHeader}"
  Health=$(perl -e "printf \"%19b\n\", $(vcgencmd get_throttled | cut -f2 -d=)")
  Temp=$(vcgencmd measure_temp | cut -f2 -d=)
  Pmic=$(vcgencmd measure_temp pmic | cut -f2 -d=)
  Clockspeed=$(vcgencmd measure_clock arm | awk -F"=" '{printf ("%0.0f",$2/1000000); }' )
  Corespeed=$(vcgencmd measure_clock core | awk -F"=" '{printf ("%0.0f",$2/1000000); }' )
  CoreVolt=$(vcgencmd measure_volts | cut -f2 -d= | sed 's/000//')
  echo -e "$(date '+%H:%M:%S')  ${Temp}  $(printf '%4s' ${Clockspeed})MHz $(printf '%4s' ${Corespeed})MHz  $(printf '%020u' ${Health})  ${CoreVolt}  ${Pmic}"

}







show_maininfo() {


vlver=$(lspci -d 1106:3483 -xxx 2>/dev/null | awk '/^50:/ { print "VL805 FW version: " $5 $4 $3 $2 }')
if [ -n "${vlver}" ]; then
	vlver="${vlver#*: }"
fi
if [ -z "${vlver}" ]; then
	vlver=$(vcgencmd otp_dump 2>/dev/null | grep '30:' | sed 's/.*://')
fi

fwV=$(vcgencmd bootloader_version 2>/dev/null | head -n 1 2>/dev/null | cut -d' ' -f1,2,3 2>/dev/null | sed 's/ //g' 2>/dev/null)

cat<<EOF
############ buildid:${BUILD_ID:-buildidunknown} localversion:${localversion:-unknown} files:${FILESHASH:-hashunknown} variant:${variant:-unknown} fwV:${fwV:-unknown} vlV:${vlver:-unknown}
EOF




#strings /boot/start4.elf  | grep 'VC_BUILD_ID_TIME' | awk '{print $2 " " $3 " " $4}'  | grep -v :









UPTIME=$(uptime)
CTn=$(conntrack -L 2>/dev/null | wc -l)


echo "### uptime: $UPTIME CTn:$CTn"




top -b -n 1 | head -n2 | while read THIS; do
    echo "### $THIS"
done
#dmesg  | grep usb | grep -v register
echo "################################# wrt.ini brief"
cat /root/wrt.ini 2>/dev/null | grep -v '^#' | grep -v '^$' | grep -E '(NO.*|LUCI.*|WIFI.*|RPI.*|RC.*|POWER.*|ENABLE.*|PROMP*|BASH.*|ASH.*|FW.*|COLOR.*|EXP.*)' | grep -v 'CONSOLEMACS'
echo "#################################"




echo "################################# hardware info"
cat /proc/cpuinfo  | grep -A3 Revision

echo "#################################"
dmesg | grep 'raspberrypi-firmware soc:firmware'

}






show_packagerestoreactions() {
if [ -f /root/.packagesrestored ]; then RESTORED=applied; fi
if [ -f /root/.packagesrestore.actions ] && [ "$(cat /root/.packagesrestore.actions | wc -l)" -gt 0 ]; then
    echo "############################### AUTORESTORE ${RESTORED:-unapplied}"
    cat /root/.packagesrestore.actions 2>/dev/null
fi
}









while [ "$#" -gt 0 ]; do
case "${1}" in
    help|-h|--help) usage; exit 0; ;;
    -b) BRIEF=1; sACTION="brief"; shift 1; ;;
    "-v") VERBOSE="-v"; shift 1; ;;
    *)
        #DOCHECK="check"
        echo "unknown-parameter: $1"; usage; shift 1; sleep 1; exit 0; ;;
esac #if [ -f
done # current|stable|testing) FLAVOUR="${1}"; shift 1; ;; #@ifzFLAV











show_maininfo











#Fri Feb 11 01:44:36 UTC 2022 Writing image-partition:1 to /dev/mmcblk0p1... start:8192 size:786432
#Fri Feb 11 01:45:04 UTC 2022 Writing image-partition:2 to /dev/mmcblk0p2... start:802816 size:1966080
#Fri Feb 11 01:46:09 UTC 2022 Writing previous PARTUUID[02070430] to /dev/mmcblk0... IMG[02111238]

#grep 'Writing' /boot/.upgrade.rpt 2>/dev/null
#grep 'Writing' /boot/.upgrade.rpt





















case "$sACTION" in
	*) echo "################################# cmdline.txt"; cat /boot/cmdline.txt; ;;
esac

case "$sACTION" in
	*)
        echo "################################# config.txt"
		cat /boot/config.txt | grep -v '^#' | grep -v '^$' | grep -vE '(\[all\]|distroconfig)'
	;;
esac


case "$sACTION" in
	*) echo "######################### usbdevices"; lsusb | grep -v -i hub; ;;
esac






case "$sACTION" in
	brief) :; ;;
	*)
		echo "################################# opkg repos"
		grep -vE '(^#|^$)' /etc/opkg/customfeeds.conf  /etc/opkg/distfeeds.conf 2>/dev/null
	;;
esac



case "$sACTION" in
	brief) :; ;;
	*)
		echo "################################# packages restore historical"
		cat /etc/custom/cumulative.txt 2>/dev/null
		#grep -vE '(^#|^$)' /etc/custom/autorestore.sh 2>/dev/null
	;;
esac











dumphwstats | while read THIS; do
    echo "### $THIS"
done




case "$sACTION" in
    brief) :; ;; #dontshow@brief
    *)
		show_packagerestoreactions
	;;
esac
























exit 0





case "$sACTION" in
	brief)

    : #20201221 evalhere nothing eval $(grep '^BUILD_ID' /etc/os-release)



#@@@ -b
#    "brief")
#	    shift 1
#cat <<NNN
#         variant: $variant
#NNN
#	BUILD_ID: $BUILD_ID
#    localversion: $localversion
#exit 0
	    ;;
    *)
        #DOCHECK="check"

	;;
	*)
		show_packagerestoreactions
	;;
esac










#show_packagerestoreactions


MPSTAT=$(command -v mpstat); if [ ! -z "$MPSTAT" ]; then $MPSTAT | tail -n2; fi





#case "$sACTION" in
#	brief) :; ;;
#	*)
#		echo "################################## cmdline.txt"
#		cat /boot/cmdline.txt
#	;;
#esac






#buildid:${BUILD_ID:-buildidunknown} localversion:${localversion:-unknown} files:${FILESHASH:-hashunknown} ${FILESDATE:-dateunknown} ${FILESREVISION:-revisionunknown}
#echo "localversion: ${localversion:-unknown}"
#cat /root/wrt.ini 2>/dev/null | grep -v '^#' | grep -v '^$' | head -n5




#grep localversion /etc/custom/buildinfo.txt 2>/dev/null














CASEEGGSALL() {
case "$BOOT_ORDER" in
	0xf41)
		echo "boot-order: mmc -> usb"
	;;
	0xf14)
		echo "boot-order: usb -> mmc"
	;;
	*)
		echo "boot-order: $BOOT_ORDER"
	;;
esac
}



















#########################################################3 clm_blob



for P in $(ls -1 /lib/firmware/brcm/brcmfmac4345*-sdio.clm_blob); do

	BLOBdate=$(strings $P | grep '^20')
	ALLBLOBinfo=$(strings $P | grep -A3 '^CLM DATA' | grep -v '^CLM DATA' | tr -s '\n' ' ')

	echo "### $P $BLOBdate $ALLBLOBinfo"
	#sleep 1

done
####################### #echo "### $P"; #strings $P | grep '^20'
#strings $P | grep -A3 '^CLM DATA' | grep -v '^CLM DATA' | tr -s '\n' ' '
#####################NOPE grep -vE '(\&|\\*|\>)' #strings $P | grep -i 'fw' #strings $P | grep -i 'id'



exit 0
#dmesg | grep brcmfmac | grep ' Firmware' | cut -d' ' -f7-
















#strings /boot/start4.elf  | grep 'VC_BUILD_ID_TIME' | awk '{print $2 " " $3 " " $4}'  | grep -v :








