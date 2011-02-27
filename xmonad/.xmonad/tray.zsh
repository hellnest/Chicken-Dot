#!/bin/zsh
# ~/.xmonad/traybarscript.zsh
## Variables ##
# Battery
BAT_CHARGE="charging"
BAT_CHARGED="charged"
BAT_LOW=25
BAT_INFO='/proc/acpi/battery/BAT0/info'
BAT_STATE='/proc/acpi/battery/BAT0/state'

# Network
INTERFACE=eth1

# Date & Time
DATE_FORMAT='%a, %d/%m/%Y'
TIME_FORMAT='%R'

# Icons
#BAT_ICON='^i(/home/lilith/.dzen/dzen_bitmaps/battery.xbm)'
#PAC_ICON='^i(/home/lee/.xmonad/xbm/xbm8x8/pacman.xbm)'

# Intervals
BATIVAL=15
INTERVAL=1
IVAL=1
PACIVAL=180
#NETVAL=1

# Counters
BATCOUNTER=$BATIVAL
DATECOUNTER=$IVAL
PACCOUNTER=$PACIVAL
TIMECOUNTER=$IVAL

# Text
SEP="|"
PACTXT="Updates: "

## Functions ##
fbat()
{
    BAT_FULL=`cat $BAT_INFO|grep last|line|cut -d " " -f 9`;
    BAT_CAP=`cat $BAT_STATE|grep remaining|cut -d " " -f 8`;
    BAT_CUR=`expr $BAT_CAP \* 100`;
    BAT_PERC=`expr $BAT_CUR / $BAT_FULL`;
    print "$BAT_PERC"
}
fdate() { date +$DATE_FORMAT }
fpacman() { pacman -Qu | wc -l }
ftime() { date +$TIME_FORMAT }

while true; do
    if [ $BATCOUNTER -ge $BATIVAL  ]; then
    BAT_AC=`cat $BAT_STATE |grep "charging state"|cut -d " " -f 12`
    if [ "$BAT_AC" = "$BAT_CHARGE" -o "$BAT_AC" = "$BAT_CHARGED" ]; then
    BAT_ICON='^i(/home/lee/.xmonad/xbm/xbm8x8/ac_01.xbm)'
    else
    BAT_ICON='^i(/home/lee/.xmonad/xbm/xbm8x8/bat_full_02.xbm)'
    fi
    TBBAT=$(fbat)
    BATCOUNTER=0
    fi

    if [ $DATECOUNTER -ge $IVAL ]; then
        TBDATE=$(fdate)
        DATECOUNTER=0
    fi

    if [ $PACCOUNTER -ge $PACIVAL ]; then
        TBPAC=$(fpacman)
    PACCOUNTER=0
    fi

    if [ $TIMECOUNTER -ge $IVAL ]; then
    TBTIME=$(ftime)
    TIMECOUNTER=0
    fi
    
    
    RXB=`cat /sys/class/net/${INTERFACE}/statistics/rx_bytes`
    TXB=`cat /sys/class/net/${INTERFACE}/statistics/tx_bytes`
    
    RXBN=`cat /sys/class/net/${INTERFACE}/statistics/rx_bytes`
    TXBN=`cat /sys/class/net/${INTERFACE}/statistics/tx_bytes`
    RXR=$(printf "%4d\n" $(echo "($RXBN - $RXB) / 1024/${SLEEP}" | bc))
    TXR=$(printf "%4d\n" $(echo "($TXBN - $TXB) / 1024/${SLEEP}" | bc))

    print " $SEP $RXR kB/s $SEP $TXR kB/s $SEP $PACTXT $TBPAC $SEP $BAT_ICON $TBBAT% $SEP $TBDATE $SEP $TBTIME "

    RXB=$RXBN; TXB=$TXBN
    DATECOUNTER=$((DATECOUNTER+1))
    BATCOUNTER=$((BATCOUNTER+1))
    PACCOUNTER=$((PACCOUNTER+1))
    TIMECOUNTER=$((TIMECOUNTER+1))

    sleep $INTERVAL
done