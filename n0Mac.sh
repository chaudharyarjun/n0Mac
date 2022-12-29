#!/bin/bash

NC='\033[0m' 			  # No Color
Red='\033[1;31m'    # Red
Green='\033[1;32m'  # Green
echo -e $Red "
                                                                                                         
                                                                                                         
                       000000000     MMMMMMMM               MMMMMMMM                                     
                     00:::::::::00   M:::::::M             M:::::::M                                     
                   00:::::::::::::00 M::::::::M           M::::::::M                                     
                  0:::::::000:::::::0M:::::::::M         M:::::::::M                                     
nnnn  nnnnnnnn    0::::::0   0::::::0M::::::::::M       M::::::::::M  aaaaaaaaaaaaa      cccccccccccccccc
n:::nn::::::::nn  0:::::0     0:::::0M:::::::::::M     M:::::::::::M  a::::::::::::a   cc:::::::::::::::c
n::::::::::::::nn 0:::::0     0:::::0M:::::::M::::M   M::::M:::::::M  aaaaaaaaa:::::a c:::::::::::::::::c
nn:::::::::::::::n0:::::0 000 0:::::0M::::::M M::::M M::::M M::::::M           a::::ac:::::::cccccc:::::c
  n:::::nnnn:::::n0:::::0 000 0:::::0M::::::M  M::::M::::M  M::::::M    aaaaaaa:::::ac::::::c     ccccccc
  n::::n    n::::n0:::::0     0:::::0M::::::M   M:::::::M   M::::::M  aa::::::::::::ac:::::c             
  n::::n    n::::n0:::::0     0:::::0M::::::M    M:::::M    M::::::M a::::aaaa::::::ac:::::c             
  n::::n    n::::n0::::::0   0::::::0M::::::M     MMMMM     M::::::Ma::::a    a:::::ac::::::c     ccccccc
  n::::n    n::::n0:::::::000:::::::0M::::::M               M::::::Ma::::a    a:::::ac:::::::cccccc:::::c
  n::::n    n::::n 00:::::::::::::00 M::::::M               M::::::Ma:::::aaaa::::::a c:::::::::::::::::c
  n::::n    n::::n   00:::::::::00   M::::::M               M::::::M a::::::::::aa:::a cc:::::::::::::::c
  nnnnnn    nnnnnn     000000000     MMMMMMMM               MMMMMMMM  aaaaaaaaaa  aaaa   cccccccccccccccc
                                                                                                         
                                                                                                         " $NC

echo -e $Green"=============================================================================================================[+]" $NC
if [[ $EUID -ne 0 ]]; then
    echo $Red "This script must be run as root"
    exit 1
fi

macchanger -l > vendor_list.txt
mac1=$(shuf -n 1 vendor_list.txt | awk '{ print $3}')
mac2=$(printf '%02x:%02x:%02x' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256])
macchanger -m "$mac1:$mac2" eth0  #Specify the interface you wanna change!
path=$(find / -name 'n0Mac.sh' -print -quit)

echo -e $Green"=============================================================================================================[+]" $NC

if [[ $(cat /etc/crontab | grep "n0Mac.sh") ]]; then
  exit 1
else 
  echo "@reboot root /bin/sh $path" >> /etc/crontab
fi  

