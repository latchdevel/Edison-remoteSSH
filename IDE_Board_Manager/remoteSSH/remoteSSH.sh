#!/bin/sh
#
# Upload sketch script by SSH
# https://github.com/latchdevel/Edison-remoteSSH
# 
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
# 
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
#
# ARG 1: ELF file to download
#
echo -ne "Starting remoteSSH download script: \n"
file_name="$1"
#
# Checking for readelf command to read .comment section from elf file
#
echo -ne "Checking for readelf command... \n"
readelf_cmd="`which greadelf || which readelf`"
if [ -n "$readelf_cmd" ]; then

        echo -ne "OK $readelf_cmd "
else
        echo -ne "ERROR! readelf command from GNU Binutils not found\n"
        echo -ne "\t You must be install binutils package \n"
        exit 1
fi
readelf_ver="`$readelf_cmd -v 2>/dev/null|head -1`"
if [ -n "$readelf_ver" ]; then
	
	echo -ne "$readelf_ver \n"
else
	echo -ne "ERROR! readelf maybe not working fine. \n"
	exit 1
fi
#
# Get dst info from .comment section of elf file object
#
echo -ne "Getting destination host... "
dst=`$readelf_cmd -p .comment $file_name|grep \]|cut -c 13-`
dst_host="`echo "$dst" |sed s/\ //g | grep -ie '^host:' |cut -c 6-`"
if [ -n "$dst_host" ]; then
	echo -ne "OK Destination host: $dst_host \n"
else
	echo -ne "ERROR! No destination host defined. \n\t Try to insert #ident \"HOST:your_ip_or_name_of_host\" in your code.\n"
	exit 1
fi
#
# Get user from .comment section of elf file object
#
echo -ne "Getting remote user... "
dst_user="`echo "$dst" |sed s/\ //g | grep -ie '^user:' |cut -c 6-`"
if [ -n "$dst_user" ]; then
	echo -ne "OK User: $dst_user \n"	
else
	dst_user="root"
	echo -ne "Setting default user to root \n"
fi
#
# Cheking for remote host
#
echo -ne "Checking for remote host ... "
remote_stat="`ssh -q -l $dst_user $dst_host "uname -a"`"
result=$?
if [ -n "$remote_stat" ]; then
	echo -ne "OK $remote_stat \n"
else
	echo -ne "ERROR! ($result) Unable to connect. \n\t Check host, user, and SSH public key authentication. \n"
	exit 1
fi
#
# Backup old sketch
#
echo -ne "Doing backup of current sketch... "
ssh -q -l $dst_user $dst_host "cp /sketch/sketch.elf /sketch/sketch.elf.remotessh.backup"
result=$?
if [ $result -eq 0 ]; then
	echo -ne "OK Backup current sketch done. \n"
else
	echo -ne "ERROR! ($result) Trying to continue... \n"
fi

#
# Stop current sketch
#
echo -ne "Stopping current sketch... "
pids="`ssh -q -l $dst_user $dst_host "ps|grep /sketch/sketch.elf |grep -v grep |cut -c -6"`"
if [ -z "$pids" ]; then
	echo -en "Maybe not running... \n"
else
	#echo -ne "PID: `echo $pids` \n"
	for p in $pids; do 
		echo -ne "Kill PID $p " 
		ssh -q -l $dst_user $dst_host "kill -9 $p" 
		result=$?
		if [ $result -eq 0 ]; then
        		echo -ne "stop OK \n"
		else
			echo -ne "ERROR! ($result) Unable to continue. \n" 
			exit 1
		fi
	done
fi
#
# Copy new sketch
#
echo -ne "Downloading new sketch... "
scp -qB $file_name $dst_user@$dst_host:/sketch/sketch.elf
result=$?
if [ $result -eq 0 ]; then
	echo -ne "copy OK \n"
else
	echo -ne "ERROR! ($result) Unable to continue. \n"
	exit 1
fi
#
# Launch new sktch
echo -ne "Launching new sketch... "
ssh -q -l $dst_user $dst_host "/sketch/sketch.elf /dev/ttyGS0 &"
result=$?
if [ $result -eq 0 ]; then
        echo -ne "OK New sketch running. \n"
else
        echo -ne "ERROR! ($result) Unable to continue. \n"
	exit 1
fi
#
echo -ne "Congratulations!!! All done OK! \n"
exit 0
