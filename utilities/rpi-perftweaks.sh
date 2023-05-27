#!/bin/sh

ecmd="echo "; i=$(basename $0)
if [ -x /etc/custom/custfunc.sh ]; then . /etc/custom/custfunc.sh; ecmd="echm ${i} "; fi


###################################################################################################
#NOTE: this is a cut down simplified version so its deliberately clunky
#special thanks to @SubZero @rhester72 @mint and others TBA for input
#@dlakelan


###################################################################################################
#the Gbs option is tested without SQM further tweaks to steering or
#service removal / affinity et. al. may be required depending on
#goal is latency VS max throughput

#specifically eth0-affinity off of core0 decreases latency no Gbs keeps them all on core0 best for under 550Mbs


######################## IF YOU ARE NOT A COMMUNITY BUILD USER A TYPICAL SETUP in /root/wrt.ini WILL BE
#PERFTWEAKS="default"
### PERFTWEAKS_Gbs=1			#OPTIONAL over 650Mb/s
### PERFTWEAKS_FREQ_MIN="900000"	#OPTIONAL set a lower lowest frequency


if [ "$1" = "boot" ]; then
	(sleep 35; $0)&
	exit 0
fi #this is needed to make sure services are started before renice

eval `grep '^PERFTWEAKS_DEBUG=' /root/wrt.ini 2>/dev/null`
eval `grep '^PERFTWEAKS=' /root/wrt.ini 2>/dev/null`
eval `grep '^POWERPROFILE=' /root/wrt.ini 2>/dev/null`
eval `grep '^EEE_DISABLE=' /root/wrt.ini 2>/dev/null`

eval `grep '^PERFTWEAKS_Gbs=' /root/wrt.ini 2>/dev/null`			#20211226_@SubZero
eval `grep '^PERFTWEAKS_FREQ_MIN' /root/wrt.ini 2>/dev/null`			#PERFTWEAKS_FREQ_MIN="900000"


############################################################################################### 20220107
if [ ! -z "$PERFTWEAKS" ]; then #HACKYTEST THIS IS FOR 20-smp HOTPLUG NEEDS to GO LATER && contain OPTS
	touch /tmp/.perftweaks
fi


uciSQMdlVAL=$(uci -q show sqm | grep download= | head -n1 | cut -d"'" -f2)
if [ -z "$PERFTWEAKS_Gbs" ] && [ "${uciSQMdlVAL:-0}" -gt 523551 ]; then
	$ecmd "fast wan detected set PERFTWEAKS_Gbs=1 in /root/wrt.ini (OVERCLOCK=medium optional)"
fi




boardmaxfreq() {
	
	local MfreqWORDno=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies | wc -w)
	local MfreqVAL=
	if [ -z "$MfreqWORDno" ]; then
		MfreqVAL="1500000"			#issues
	else
		MfreqVAL=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies | cut -d' ' -f${MfreqWORDno})
	fi

	echo "$MfreqVAL"

}




boardmidfreq() {

	local MfreqVAL=
	
	local totalfreqs="$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies | wc -w)"
	if [ -z "$totalfreqs" ]; then echo "1000000"; return 0; fi

	freqsAVAIL="/sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies"
	if [ ! -z "$PERFTWEAKS_FREQ_MIN" ] && grep -wq "${PERFTWEAKS_FREQ_MIN}" "${freqsAVAIL}"; then
		echo "$PERFTWEAKS_FREQ_MIN"; return 0
	fi


	local MfreqWORDno=$(($totalfreqs / 2))
	if [ "$totalfreqs" -le 12 ]; then
		MfreqWORDno=$((MfreqWORDno + 1))
	elif [ "$totalfreqs" -ge 13 ] && [ "$totalfreqs" -le 15 ]; then
		MfreqWORDno=$((MfreqWORDno + 2))
	else
		MfreqWORDno=$((MfreqWORDno + 3))
	fi

	if [ -z "$MfreqWORDno" ]; then
		MfreqVAL="1000000"					#issues
	else
		MfreqVAL=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies | cut -d' ' -f${MfreqWORDno})
	fi

	echo "$MfreqVAL"

}







case "$POWERPROFILE" in
   	"quickest")
		#theMINfreq="1500000"
		theMINfreq="$(boardmaxfreq)"
	;;
   	"quicker")
		#theMINfreq="1000000"
		theMINfreq="1300000"
	;;
	*) #quick nothing
		POWERPROFILE="quick"
		#theMINfreq="1100000"
		theMINfreq="$(boardmidfreq)"
		#@> boardmidfreq
		################################## #theMINfreq="900000"
	;;
esac



#if [ "${PERFTWEAKS}" = "default" ] || [ "${POWERPROFILE}" = "quick" ]; then
if [ "${PERFTWEAKS}" = "default" ] || [ ! -z "${POWERPROFILE}" ]; then

	governor=$(cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor)
	#$ecmd "GOVERNOR[$governor]: $POWERPROFILE" #600000 750000 1000000 1500000 #echq
	
	if [ "$governor" = "ondemand" ]; then

		GOVmsg="${GOVmsg} upthresh:21"
		echo -n 21 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold && sleep 2

		GOVmsg="${GOVmsg} downfac:6" #10>6>5
		echo -n 5 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor #sleep 2

		GOVmsg="${GOVmsg} minfreq:$theMINfreq"
		echo -n "${theMINfreq}" > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq


		GOVmsg="${GOVmsg} maxfreq:$(boardmaxfreq)"
		echo -n "$(boardmaxfreq)" > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq

		###GOVmsg="${GOVmsg} maxfreq:1500000"
		####echo -n '1500000' > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq

	fi


	if [ ! -z "$GOVmsg" ]; then
		$ecmd "GOVERNOR[$governor]: $POWERPROFILE $GOVmsg"
	else
		$ecmd "GOVERNOR[$governor]: $POWERPROFILE $GOVmsg [nochange-or-altgov]"
	fi

fi


#################$ecmd "GOVERNOR[$governor]: $POWERPROFILE" #600000 750000 
#################202107 600000 700000 800000 900000 1000000 1100000 1200000 1300000 1400000 1500000
#################$ecmd "GOVERNOR[$governor]: $POWERPROFILE" #600000 750000 1000000 1500000 #echq







reniceprocess() {

	local P_NAME="${1}"
	local P_VAL="${2}"

	RENICEmsg="${RENICEmsg} ${P_NAME}:${P_VAL}"
	for dP in $(pidof ${P_NAME} 2>/dev/null ); do $RENICE ${P_VAL} $dP 2>/dev/null; done

	#for dP in $(pidof ${P_NAME} 2>/dev/null ); do
	#	$ecmd "$RENICE ${P_VAL} $dP"
	#	$RENICE ${P_VAL} $dP
	#done

}




RENICE=$(command -v renice)
#if [ ! -z "${PERFTWEAKS}" ] && [ ! -z "${RENICE}" ]; then
if [ "${PERFTWEAKS}" = "default" ]; then

	reniceprocess "dnsmasq" -5 #reniceprocess "dnsmasq" -7
	reniceprocess "uhttpd" 2
	reniceprocess "dropbear" 1
	#reniceprocess "wpad" 10 #slowsallnet?

	$ecmd "RENICE $RENICEmsg"
fi










tasksetpids() {
	local thispid=
	for thispid in $(pidof ${1}); do #oneonlybutmeh
		$TASKSET -apc ${2} $thispid 2>&1 >/dev/null
		TASKSETmsg="${TASKSETmsg} ${1}:${thispid}>${2}"
	done
}





servicecpuadjust() {
	
	#if [ -z "$gottaskset" ]; then echq "taskset:$TASKSET not available" && return 0; fi
	tasksetpids "nlbwmon" 3
	tasksetpids "collectd" 3
	tasksetpids "uhttpd" 2 ### spikes@io
	tasksetpids "odhcpd" 3 ### tasksetpids "odhcpd" 0-0
	tasksetpids "dropbear" 3 #maxes on file transfer
	#tasksetpids "wpad" 3
	#tasksetpids "hostapd" 3
	#tasksetpids "wpa-supplicant" 3

thispid=
for thispid in $(pidof dnsmasq); do
	$TASKSET -apc 3 $thispid 2>&1 >/dev/null
	TASKSETmsg="${TASKSETmsg} dnsmasq:${thispid}>3"
done

}





    TASKSET="$(command -v taskset-aarch64)"
	if [ ! -z "$TASKSET" ]; then
		servicecpuadjust
		$ecmd "TASKSET: $TASKSETmsg" #echo "taskset: $TASKSETmsg" >/dev/kmsg
	else	
		$ecmd "TASKSET:$TASKSET not available" #echo "taskset:$TASKSET not available" >/dev/kmsg
	fi







findRUPT() {
	fgrep ${1} /proc/interrupts  | sed 's|^ ||g' | cut -d':' -f1 | \
		tr -s '\n' ' '
}





################################# NOT TOO SURE ABOUT THIS ONE - NEEDS some CHANGING TESTING afaik WAS for WIFI
################################# but not everyone has it || effects disk too?

mmcINTs="$(findRUPT mmc)"
mmcNEWVAL="c"

tRU=
if [ ! -z "$mmcINTs" ]; then
	for tRU in $mmcINTs; do
		intPREV=
		intPREV=$(grep . /proc/irq/$tRU/smp_affinity 2>/dev/null)
		echo -n ${mmcNEWVAL} > /proc/irq/$tRU/smp_affinity
		mmcINTmsg="${mmcINTmsg} ${mmcNEWVAL}:$intPREV>$tRU"
	done
else
	mmcINTmsg="noMMCintFOUND" #echo "$0 nommcirqfound" >/dev/console
fi

if [ ! -z "$mmcINTmsg" ]; then
	$ecmd "MMCINTs: ${mmcINTmsg}"
fi






eth0INTs="$(findRUPT eth0)"


tRU=
if [ ! -z "$eth0INTs" ]; then
	for tRU in $eth0INTs; do

		coreSET=${coreSET:-1}		
		
		intPREV=
		intPREV=$(grep . /proc/irq/$tRU/smp_affinity 2>/dev/null)

		if [ "$coreSET" != "$intPREV" ]; then
			##############! fNE2 if [ "$coreSET" -ne "$intPREV" ]; then
			echo -n $coreSET > /proc/irq/$tRU/smp_affinity #echo -n 1 > /proc/irq/$tRU/smp_affinity
			eth0INTmsg="$eth0INTmsg $tRU:${intPREV}>${coreSET}"		
		else
			eth0INTmsg="$eth0INTmsg $tRU:${intPREV}=${coreSET}"
		fi #eth0INTmsg="$eth0INTmsg $tRU:${intPREV}>${coreSET}"

		if [ ! -z "$PERFTWEAKS_Gbs" ]; then #FOR Gbs 2nd interrupt to core 2 may effect latency
			coreSET=$((coreSET + 1))
		fi
	done
else
	eth0INTmsg="$0 eth0_no-irqfound" >/dev/console #echo "$0 eth0_no-irqfound" >/dev/console
fi

if [ ! -z "$eth0INTmsg" ]; then
	$ecmd "ETH0INT: $eth0INTmsg"
fi






WANIFACE=$(ubus call network.interface.wan status | jsonfilter -e '@.device')
#$ecmd "WANIFACE: $WANIFACE"
LANIFACE=$(ubus call network.interface.lan status | jsonfilter -e '@.device')
case "$LANIFACE" in
	"br-"*)
		LANIFACE="$(brctl show br-lan | grep -v '^bridge name' | head -n1 | tr -s '\t' ' ' | cut -d' ' -f4)"
	;;
esac
#$ecmd "LANIFACE: $LANIFACE"
$ecmd "LANIFACE:$LANIFACE WANIFACE:$WANIFACE"




setAsysval() {

	local sysVAL="${1}"
	local sysPATH="${2}"
	local sysVALprev=


	if [ ! -e "${sysPATH}" ]; then
		$ecmd "sysPATHinvalid: $sysPATH"
		return 1
	fi


	sysVALprev=$(grep . $sysPATH 2>/dev/null)

	if [ "$sysVALprev" = "$sysVAL" ]; then
		$ecmd "sysval: $(echo $sysPATH | sed 's|/sys/class/net/||g')[${sysVALprev}=${sysVAL}]"
	else
		echo -n $sysVAL > ${sysPATH}
		$ecmd "sysval: $(echo $sysPATH | sed 's|/sys/class/net/||g')[${sysVALprev}>${sysVAL}]"
	fi


}
#echo -n $sysVAL > /sys/class/net/eth0/queues/tx-0/xps_cpus





#if [ "${PERFTWEAKS}" = "default" ]; then


################## TEMPORARY LOGIC! 20211227 ##########################
if [ "${PERFTWEAKS}" = "default" ] || [ ! -z "$PERFTWEAKS_Gbs" ]; then
################## TEMPORARY LOGIC! 20211227 ##########################
setAsysval "1" "/sys/class/net/eth0/queues/tx-0/xps_cpus"
#echo -n 1 > /sys/class/net/eth0/queues/tx-0/xps_cpus #0

setAsysval "2" "/sys/class/net/eth0/queues/tx-1/xps_cpus"
#echo -n 2 > /sys/class/net/eth0/queues/tx-1/xps_cpus #1

setAsysval "4" "/sys/class/net/eth0/queues/tx-2/xps_cpus"
#echo -n 4 > /sys/class/net/eth0/queues/tx-2/xps_cpus #2

setAsysval "4" "/sys/class/net/eth0/queues/tx-3/xps_cpus"
#echo -n 4 > /sys/class/net/eth0/queues/tx-3/xps_cpus #0 ###echo -n 1 > /sys/class/net/eth0/queues/tx-3/xps_cpus #0

setAsysval "2" "/sys/class/net/eth0/queues/tx-4/xps_cpus"
#echo -n 2 > /sys/class/net/eth0/queues/tx-4/xps_cpus #1

setAsysval "7" "/sys/class/net/eth0/queues/rx-0/rps_cpus"
#echo -n 7 > /sys/class/net/eth0/queues/rx-0/rps_cpus #0 #ORIGINAL echo -n 1 > /sys/class/net/eth0/queues/rx-0/rps_cpus #0

setAsysval "7" "/sys/class/net/${WANIFACE}/queues/rx-0/rps_cpus"
#echo -n 7 > /sys/class/net/${WANIFACE}/queues/rx-0/rps_cpus #012 #echo -n 7 > /sys/class/net/eth1/queues/rx-0/rps_cpus #012



############################################## 20211207 NEEDS TO GET REAL IFACES
############################################## is old/tmpoff code for this
############################################## or move back to hotplug
#/bin/rpi-perftweaks.sh: line 179: can't create /sys/class/net/eth1/queues/rx-0/rps_cpus: nonexistent directory
#NOTE 1 2 4 8
######################## OVERRIDEBACKtoALLonONE echo -n $coreSET > /proc/irq/$tRU/smp_affinity


############################################################ kongy CHECK THIS probably not needed here or current
sysctl -w vm.min_free_kbytes=65536 2>/dev/null 1>/dev/null 
sysctl -w net.netfilter.nf_conntrack_max=32768 2>/dev/null 1>/dev/null


fi







######if [ ! -z "$PERFTWEAKS_Gbs" ]; then
######	echo "PERFTWEAKS_Gbs [for sqm use please test alternate steering vals]" > /dev/kmsg

#####	###########################################################TEMPORARY UNTIL RE-ADD CUSTOM hotplug
#####	#########################SET steering all f's for now for hotplug AKA if device is replugged after boot



#NOTE: added touch /tmp/.perftweaks and custom 20-smp below no longer needed-ish FEW MORE WEEKS THEN REMOVE and FIXUP



### 202305 users reporting its unticked based on comment above just turn off and TBA apply our settings on top of stock
#	if [ ! -z "$(uci -q show network | grep "network.globals.packet_steering='1'")" ]; then
#		#$ecmd "disable packet steering [tmp-wip-ini-toggle-restore-etc]"
#		uci set network.globals.packet_steering='0'
#		uci commit network
#	fi






########### NOPEfonipv6etc
#    if [ -z "$(uci -q show network | grep "network.globals.packet_steering='1'")" ]; then
#		$ecmd "enabling packet steering [tmp-wip-ini-toggle-restore-etc]"
#		uci set network.globals.packet_steering='1'
#		uci commit network
#	fi

######fi



#NOTE: needs old not Gbs but still want steering > MEH lets just enable for everyone? TEMPORARILY


















fixtailroom() {


	if [ -f /tmp/.perftweaks ] && grep -q "^tailroomfix$" /tmp/.perftweaks 2>/dev/null ; then return 0; fi
	[ -f /tmp/.perftweaks ] && echo 'tailroomfix' >> /tmp/.perftweaks #nofile_means_summof_(perf)'enable'varswasoff

	#if [ ! -z "$NOTAILROOMFIX" ]; then
	#	echo "tailroom_fix: skip [NOTAILROOMFIX]" >/dev/kmsg
	#	return 0
	#fi

	echo "tailroom_fix: ethtool -K eth0 rx off [$1]" >/dev/kmsg
	ethtool -K eth0 rx off

}





eval `grep '^NOTAILROOMFIX=' /root/wrt.ini 2>/dev/null`
eval `grep '^TAILROOMFIX_FORCE=' /root/wrt.ini 2>/dev/null`






#################################################################TAILROOM-5.10_UNCOMMONBUG
### if grep -q '^Version: 5.10' /usr/lib/opkg/info/kernel.control; then
if grep -q '^Version: 5.1' /usr/lib/opkg/info/kernel.control; then


	if [ ! -z "$NOTAILROOMFIX" ]; then
		echo "tailroom_fix: skip [NOTAILROOMFIX]" >/dev/kmsg

	elif [ "$(dmesg | grep tailroom | grep -v 'tailroom_fix' | wc -l)" -gt 5 ]; then
		fixtailroom "dmesg-detected"

		#echo "tailroom_fix: ethtool -K eth0 rx off [apply-dmesg]" >/dev/kmsg
		#ethtool -K eth0 rx off

	elif grep -q 'DC:A6:32:56:31:77' /proc/cmdline 2>/dev/null; then
		fixtailroom "maintainer"

		#echo "tailroom_fix: ethtool -K eth0 rx off [apply_maintainer]" >/dev/kmsg
		#ethtool -K eth0 rx off
	elif [ ! -z "$TAILROOMFIX_FORCE" ]; then
		fixtailroom "force-on TAILROOMFIX_FORCE=1"
	else
		echo "tailroom_fix: ethtool -K eth0 rx off [skip_notailroomindmesg]" >/dev/kmsg
	fi

else
	echo "tailroom_fix: ethtool -K eth0 rx off [skip_not_5.x]" >/dev/kmsg
	### echo "tailroom_fix: ethtool -K eth0 rx off [skip_not_5.10]" >/dev/kmsg
fi















edbg() {


	if [ ! -z "$PERFTWEAKS_DEBUG" ]; then
		echo "$(basename $0)_edbg: ${1}" >/dev/kmsg
	fi


}




eee_set_adapter() {

	local eee_FACE="${1}"
	local eee_SETTO="${2}"



	local eee_GREPstr="eee ${eee_FACE} ${eee_SETTO}"


	case "${eee_SETTO}" in
		off)
			local eee_GREPstrNOT="eee ${eee_FACE} on"
		;;
		on)
			local eee_GREPstrNOT="eee ${eee_FACE} off"
		;;
	esac


	if ! ethtool --show-eee ${eee_FACE} 1>/dev/null 2>/dev/null; then



eee_SETTO="notsupported"
eee_GREPstr="eee ${eee_FACE} notsupported"
eee_GREPstrNOT="eee ${eee_FACE} thisisnotneededweshouldntrecheckflagfileifexistsforthis"



		if [ -f /tmp/.perftweaks ]; then
			if grep -q "^${eee_GREPstr}$" /tmp/.perftweaks 2>/dev/null ; then
				:	
			else
				echo "${eee_GREPstr}" >> /tmp/.perftweaks
			fi
		fi

		return 3

	fi #ENDUNSUPPORTCHECKS













	if [ -f /tmp/.perftweaks ]; then
		if grep -q "^${eee_GREPstr}$" /tmp/.perftweaks 2>/dev/null ; then
	return 0

		#elif grep -q "^${eee_FACE}$" /tmp/.perftweaks 2>/dev/null ; then
		elif grep -q "^${eee_GREPstrNOT}$" /tmp/.perftweaks 2>/dev/null ; then
			sed -i "s|^${eee_GREPstrNOT}$|${eee_GREPstr}|g" /tmp/.perftweaks
			echo "${eee_GREPstr}" >> /tmp/.perftweaks


		else
			echo "${eee_GREPstr}" >> /tmp/.perftweaks

		fi

	#else we are not enabled for general perftweaks aka INI vars dont combine

	fi





	case "${eee_SETTO}" in
		off)
		echo "EEE_DISABLE: ${eee_FACE}:${eee_SETTO} $(ethtool --set-eee $eee_FACE eee $eee_SETTO 2>&1)" 1>/dev/kmsg
		;;

		on)
			echo "EEE_DISABLE: ${eee_FACE}:${eee_SETTO} ONNOTSUPPORTEDYET" 1>/dev/kmsg
		;;
		

		*)
			echo "EEE_DISABLE: ${eee_FACE}:${eee_SETTO} WHOOPS" 1>/dev/kmsg
		;;

	esac

}







###TAILROOM-5.10_UNCOMMONBUG INI OPTIONAL(i dont use) interface_list i.e. EEE_DISABLE="eth0 eth1"
if [ ! -z "$EEE_DISABLE" ]; then
	for eNET in $EEE_DISABLE; do

		eee_set_adapter "$eNET" off

		#echo "EEE_DISABLE: $eNET $(ethtool --set-eee $eNET eee off 2>&1)" 1>/dev/kmsg
	done
else
	if [ ! -z "$PERFTWEAKS_DEBUG" ]; then
		echo "EEE_DISABLE [off]" >/dev/kmsg #echo "EEE_DISABLE [off]" >/dev/console
	fi
fi ### ethtool --show-eee eth1










exit 0


