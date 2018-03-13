#!/bin/bash
#This is the final script for bash
#        ************** Name: Reet Inder Singh Dhaliwal   ****************
#        **************     Student ID: 200359500         ****************
#        ************** Administrative Scripting COMP2101 ****************
#        **************    Professor Dennis Simpson       ****************


#This is a script which displays the system information summary

#This Script will provide following information
# 1. System name with domain name if it has one
# 2. IP addresses for this host by interface
# 3. OS version and name
# 4. CPU description
# 5. Memory installed
# 6. Available disk space on attached physical drives
# 7. Lists of Printers configured


#Assigning the default values and declaring the variables

default="yes"

#Using variables to make the task easy and decrease the length of the script

function helpcmds {
  echo "
  One or more outputs can be shown for the following:
  $0 [-hl | --help menu]
  $0 [-dh | --Displaying domain name and host name]
  $0 [-ip | --Shows IP address of system]
  $0 [-o | --Operating System name]
  $0 [-op | --Version of Operating System]
  $0 [-cp | --CPU details]
  $0 [-r | --RAM details]
  $0 [-ds | --Available Disk Space]
  $0 [-pi | --Installed Printers list]
  "
}

function replyerror {
  echo "$@" >&2
}
# using the variables to decrease the length of the script

while [ $# -gt 0 ]; do
  case "$1" in
    -hl)
    helpcmds
    default="no"
    ;;

    -dh)
    hostinfodetails="yes"
    default="no"
    ;;

    -ip)
    IPaddressdetails="yes"
    default="no"
    ;;

    -o)
    osinfodetails="yes"
    default="no"
    ;;

    -op)
    OSversiondetails="yes"
    default="no"
    ;;

    -cp)
    CPUinfodetails="yes"
    default="no"
    ;;

    -r)
    RAMdetails="yes"
    default="no"
    ;;

    -ds)
    diskspacedetails="yes"
    default="no"
    ;;

    -pi)
    printerdetails="yes"
    default="no"
    ;;
    *)
    replyerror "
    '$1' wrong entry"
    exit 1
    ;;
  esac
  shift
done

#Putting the data into variables using the commands for linux
systemname="$(hostname)"

domainname="$(hostname -d)"

osinfo="$(grep "NAME" /etc/os-release |sed -e 's/.*=//' -e 's/"//g')"

osversion="$(grep "VERSION" /etc/os-release |sed -e 's/*=//' -e 's/"//g')"

ipaddress="$(hostname -I)"

CPUinfo="$(cat /proc/cpuinfo | grep 'model name' | uniq)"

RAMinfo="$(cat /proc/meminfo | grep "Mem")"

discspace="$(df -h)"

printerinfo="$(lpstat -p)"

#Testing the outputs using command line

#Domain Name and Host Name details
hostnamedetailsinfo="
Hostname
--------
$systemname

Domain Name
-----------
$domainname
"

#IP address Details
ipaddressdetailsinfo="
IP Address Information
----------------------
IP Address: $ipaddress
"

#Operating system name
OSinfodetailsinfo="
Operating System Information
----------------------------
Operating System Installed
 $osinfo
"

#OSversion details
OSversiondetailsinfo="
Operating System Version Info
-----------------------------
$osversion
"

#CPU details
CPUinfodetailsinfo="
CPU Information
---------------
CPU Info
 $CPUinfo
"

#RAM details
RAMinfodetailsinfo="
RAM Info
--------
RAM Installed
 $RAMinfo
"

#Disk space Available
Diskspacedetailsinfo="
Disc Space Information
----------------------
Disc Space
$discspace
"
#Printer INFORMATION
Printerdetailsinfo="
Printer Information
-------------------
Printers connected: $printerinfo
"
# Getting the output using the script
if [ "$default" = "yes" -o "$hostinfodetails" = "yes" ]; then
  echo "$hostnamedetailsinfo"
fi

if [ "$default" = "yes" -o "$IPaddressdetails" = "yes" ]; then
  echo "$ipaddressdetailsinfo"
fi

if [ "$default" = "yes" -o "$osinfodetails" = "yes" ]; then
  echo "$OSinfodetailsinfo"
fi

if [ "$default" = "yes" -o "$OSversiondetails" = "yes" ]; then
  echo "$OSversiondetailsinfo"
fi

if [ "$default" = "yes" -o "$CPUinfodetails" = "yes" ]; then
  echo "$CPUinfodetailsinfo"
fi

if [ "$default" = "yes" -o "$RAMdetails" = "yes" ]; then
  echo "$RAMinfodetailsinfo"
fi

if [ "$default" = "yes" -o "$diskspacedetails" = "yes" ]; then
  echo "$Diskspacedetailsinfo"
fi

if [ "$default" = "yes" -o "$printerdetails" = "yes" ]; then
  echo "$Printerdetailsinfo"
fi

echo All the information requested is displayed above
echo Thank You
