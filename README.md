# OpenWrt GL-MiFi

## Download OpenWrt

```
sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler -y

sudo apt-get install libpam0g-dev \
libidn2-0-dev \
libssh2-1-dev \
libgnutls-dev \
libldap2-dev \
libcap-dev liblzma-dev \
libjansson-dev -y

# Lede
git clone https://github.com/coolsnowwolf/lede.git
cd ./lede
wget https://raw.githubusercontent.com/openwrt/openwrt/master/include/target.mk -O ./include/target.mk
./scripts/feeds update -a
./scripts/feeds install -a

# Openwrt
git clone https://github.com/openwrt/openwrt.git ./openwrt
cd ./openwrt
./scripts/feeds update -a
./scripts/feeds install -a
```

## Download GL-MiFi config

```
wget https://raw.githubusercontent.com/buxiaomo/OpenWrt-GL-MiFi/master/.config -O .config
make download
```

## Build image

```
make -j8
```


## Packages list

```
Target System (x86)  --->
  Atheros AR7xxx/AR9xxx

Subtarget (Generic)  --->
  Generic

Target Profile (Default Profile (all drivers))  --->
  GL.iNet GL-MiFi

Kernel modules  --->
  Filesystems  --->
    kmod-fs-ext4
    kmod-fs-vfat
    kmod-fs-xfs
  Network Support  --->
    kmod-tcp-bbr
  USB Support  --->
    kmod-usb-net
    kmod-usb-net-rndis
    kmod-usb-serial
    kmod-usb-serial-option
    kmod-usb-storage
    kmod-usb2

LuCI  --->
  Collections  --->
    luci
  Modules  --->
    Translations  --->
      Chinese (zh-cn)
  Applications  --->
    luci-app-aria2
    <!-- luci-app-arpbind -->
    <!-- luci-app-autoreboot -->
    luci-app-ddns
    <!-- luci-app-filetransfer -->
    <!-- luci-app-frpc -->
    luci-app-frpc
    luci-app-nlbwmon
    luci-app-qos
    luci-app-samba
    luci-app-shadowsocks-libev
    luci-app-sfe
    luci-app-sqm
    luci-app-ssr-plus
    luci-app-upnp
    <!-- luci-app-vlmcsd -->
  Themes  --->
    luci-theme-material
    luci-theme-openwrt
    luci-theme-rosy
  Protocols  --->
    luci-proto-3g
    luci-proto-openconnect
    luci-proto-qmi
  default-settings

Network  --->
  Download Manager  --->
    ariang
    curl
    wget
  IP Addresses and Names  --->
    avahi-dbus-daemon
    <!-- ddns-scripts_aliyun -->
    ddns-scripts_cloudflare.com-v4
  VPN  --->
    openvpn-easy-rsa
    openvpn-openssl
    <!-- openvpn-mbedtls -->
  Web Servers/Proxies  --->
    frpc
Utilities  --->
  Disc  --->
    blkid
    fdisk
    lsblk
  Filesystem  --->
    e2fsprogs
    f2fsck
```
automount

# Disable LTE modem when the lan is working

```
* * * * * /bin/ping -I eth0 -c 3 114.114.114.114 &> /dev/null && /sbin/ifdown wwan; ubus call network reload || /sbin/ifup wwan; ubus call network reload
```