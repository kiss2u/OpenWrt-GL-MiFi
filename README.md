# OpenWrt GL-MiFi

fork this repo and upload the `config` file to this repo.

if you want to Custom configuration, you can modify the `diy.sh` file.

if you want to add extend feeds, you can modify the `feeds.conf.default` file.

## Packages list

```
Target System (x86)  --->
  Atheros AR7xxx/AR9xxx

Subtarget (Generic)  --->
  Generic

Target Profile (Default Profile (all drivers))  --->
  GL.iNet GL-MiFi

Base system  --->
  ca-certificates

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
  VPN  --->
    openvpn-easy-rsa
    openvpn-openssl
  hostapd

Utilities  --->
  Disc  --->
    blkid
    fdisk
    lsblk
  Filesystem  --->
    e2fsprogs
    f2fsck
```

# Disable LTE modem when the lan is working

```
* * * * * /bin/ping -I eth0 -c 3 114.114.114.114 &> /dev/null && /sbin/ifdown wwan; ubus call network reload || /sbin/ifup wwan; ubus call network reload
```