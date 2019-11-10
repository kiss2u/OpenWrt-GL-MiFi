# OpenWrt GL-MiFi

## Download OpenWrt

```
sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler -y

git clone https://github.com/openwrt/openwrt.git
cd ./openwrt
./scripts/feeds update -a
./scripts/feeds install -a
```

## Download GL-MiFi config

```
wget https://raw.githubusercontent.com/buxiaomo/OpenWrt-GL-MiFi/master/.config -O .config
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
  USB Support  --->
    kmod-usb-net
    kmod-usb-net-rndis
    kmod-usb-serial
    kmod-usb-serial-option
    kmod-usb-storage
    kmod-usb2

LuCI  --->
  Applications  --->
    luci-app-aria2
    luci-app-frpc
    luci-app-openvpn
    luci-app-openvpn-server
  Protocols  --->
    luci-proto-qmi
    luci-proto-openconnect
    luci-proto-3g

Utilities  --->
  Filesystem  --->
    e2fsprogs
    f2fsck
  Disc  --->
    lsblk
    fdisk
    blkid
```