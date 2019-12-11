# OpenWrt GL-MiFi

## Setting Global Porxy
```
export http_proxy=http://127.0.0.1:1087
export https_proxy=http://127.0.0.1:1087
export ftp_proxy=http://127.0.0.1:1087
export no_proxy=localhost,127.0.0.1,$(echo .{1..254} | sed 's/ /,/g')
```
## Download OpenWrt

```
sudo apt-get -y install build-essential asciidoc binutils \
bzip2 gawk gettext git libncurses5-dev libz-dev patch unzip \
zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs \
git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo \
libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf \
automake libtool autopoint device-tree-compiler libpam0g-dev \
libidn2-0-dev attr libpcre2-dev libexpat1-dev \
libssh2-1-dev libgnutls-dev libldap2-dev libcap-dev liblzma-dev \
libjansson-dev libpng-dev libupnp-dev \
libgd-dev bc lm-sensors libtirpc-dev \
libavahi-client-dev libarchive-dev -y

# Lede
git clone https://github.com/coolsnowwolf/lede.git
cd ./lede

wget https://raw.githubusercontent.com/openwrt/openwrt/master/include/target.mk -O ./include/target.mk
sed -i "s/dnsmasq/dnsmasq-full/g" ./include/target.mk
./scripts/feeds update -a
./scripts/feeds install -a


mkdir package/udpspeeder
wget https://raw.githubusercontent.com/atrandys/openwrt-udp2raw-speeder/master/udpspeeder/Makefile  -O package/udpspeeder/Makefile

package/udp2raw
wget https://raw.githubusercontent.com/WouldChar/openwrt-udp2raw-speeder/master/udp2raw/Makefile -O package/udp2raw/Makefile

git clone https://github.com/atrandys/luci-udptools.git ./package/luci-udptools

# Download GL-MiFi config
wget https://raw.githubusercontent.com/buxiaomo/OpenWrt-GL-MiFi/master/lede.config -O .config
```


## Download Package

```
make download -j8 V=s
```

## Build image

```
make -j8 V=s | tee /tmp/lede.build.log
```

<!-- ## Clean Data

```
make dirclean && make clean && make dirclean
``` -->

## Packages list

```
Target System (x86)  --->
  Atheros AR7xxx/AR9xxx

Subtarget (Generic)  --->
  Generic

Target Profile (Default Profile (all drivers))  --->
  GL.iNet GL-MiFi

Extra packages  --->
  automount

Kernel modules  --->
  Filesystems  --->
    kmod-fs-xfs
  Network Support  --->
    kmod-tcp-bbr
  USB Support  --->
    kmod-usb-net
    kmod-usb-net-rndis
    kmod-usb-serial
    kmod-usb-serial-option

LuCI  --->
  Collections  --->
    luci
  Modules  --->
    Translations  --->
      Simplified Chinese (zh-cn)
  Applications  --->
    luci-app-aria2
    luci-app-arpbind
    luci-app-frpc
    luci-app-nlbwmon
    luci-app-openvpn
    luci-app-qos
    luci-app-samba
    luci-app-serverchan
    luci-app-sqm
    luci-app-ssr-plus
    luci-app-upnp
    luci-app-vlmcsd
  Protocols  --->
    luci-proto-3g 
    luci-proto-openconnect
    luci-proto-qmi
    luci-proto-wireguard

Network  --->
  Download Manager  --->
    ariang

Utilities  --->
  Disc  --->
    blkid
    fdisk
    gdisk
    hdparm
    lsblk
  Filesystem  --->
    e2fsprogs
    f2fsck
```

# Disable LTE modem when the lan is working

```
* * * * * /bin/ping -I eth0 -c 3 114.114.114.114 &> /dev/null && /sbin/ifdown wwan; ubus call network reload || /sbin/ifup wwan; ubus call network reload
```
