#!/bin/bash
set -e
DATE=`date --rfc-3339 sec`
echo "$DATE: Getting data updates..."
curl -o "/var/tmp/default.upstream" "https://raw.githubusercontent.com/BigUIFU/AGH_SELF/main/DNS/default-dns.conf"
curl -s https://gitlab.com/fernvenue/chn-domains-list/-/raw/master/CHN.ALL.agh | sed "/#/d" > "/var/tmp/chinalist.upstream"
echo "$DATE: Processing data format..."
cat "/var/tmp/default.upstream" "/var/tmp/chinalist.upstream" > /usr/share/adguardhome.upstream
sed -i "s|114.114.114.114|tls://dns.alidns.com|g" /usr/share/adguardhome.upstream
echo "$DATE: Cleaning..."
rm /var/tmp/*.upstream
systemctl restart AdGuardHome
echo "$DATE: All finished!"
