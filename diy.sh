#!/bin/bash
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

# set root password(default: root)
echo "Set root password(default: root)"
sed -i 's|root.*|root:$1$n3vjdweX$vyZqcZyUC5Q2uq4bxnfbQ0:18242:0:99999:7:::|g' ./package/base-files/files/etc/shadow