#!/bin/sh
 
### short script that downloads a list of ad servers for use with
### squid to block ads.
###
### details on configuring squid itself can be found here:
###
###    http://pgl.yoyo.org/adservers/#withsquid
###
### - originally by Stephen Patterson <steve@lexx.uklinux.net>
### - butchered by Peter Lowe <pgl@yoyo.org>
###
 
## set things
##
 
# URL of the ad server list to download
listurl='http://pgl.yoyo.org/as/serverlist.php?hostformat=squid-dstdom-regex;showintro=0'
 
# location of the list of ad servers used by Squid
targetfile='/etc/squid/squid.adservers'
 
# location of a file where hostnames not listed can be added
extrasfile='/etc/squid-extra.adservers'
 
# command to reload squid - change according to your system
reloadcmd='/etc/rc.d/squid restart'
 
# temp file to use
tmpfile="/tmp/.adlist.$$"
 
# command to fetch the list (alternatives commented out)
fetchcmd="wget -q $listurl -O $tmpfile"
 
# get a fresh list of ad server addresses for squid to refuse
$fetchcmd
 
# add the extras
[ -f "$extrasfile" ] && cat $extrasfile >> $tmpfile
 
# check the temp file exists OK before overwriting the existing list
if [ ! -s $tmpfile ]
then
    echo "temp file '$tmpfile' either doesn't exist or is empty; quitting"
    exit
fi
 
# sort and filter out duplicates
sort $tmpfile > $targetfile
 
# clean up
rm $tmpfile
 
# restart Squid
$reloadcmd