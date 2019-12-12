#!/bin/bash
# IP address
echo "Settinng IP address"
sed -i "s/192.168.1.1/172.16.100.1/g" .config
sed -i "s/255.255.255.0/255.255.0.0/g" .config
sed -i "s/192.168.1.255/172.16.100.255/g" .config

# NTP
echo "Settinng NTP Server"
sed -i "s/0.openwrt.pool.ntp.org/ntp1.aliyun.com/g" ./package/base-files/files/bin/config_generate
sed -i "s/1.openwrt.pool.ntp.org/ntp2.aliyun.com/g" ./package/base-files/files/bin/config_generate
sed -i "s/2.openwrt.pool.ntp.org/ntp3.aliyun.com/g" ./package/base-files/files/bin/config_generate
sed -i "s/3.openwrt.pool.ntp.org/ntp4.aliyun.com/g" ./package/base-files/files/bin/config_generate

# Timezone
echo "Settinng Timezone"
sed -i "s/UTC/CST-8/g" ./package/base-files/files/bin/config_generate
sed -i "/CST-8/a set system.@system[-1].zonename='Asia/Shanghai'" ./package/base-files/files/bin/config_generate