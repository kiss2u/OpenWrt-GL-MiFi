## 创建网络接口

```
cat >> /etc/config/network << EOF
config interface 'vpn'
    option proto 'none'
    option ifname 'tun0'
EOF

/etc/init.d/network restart
```

## 配置防火墙的Default Rules & Forwarding

```
cat >> /etc/config/firewall << EOF
config zone
    option name 'vpn_fw'
    option input 'REJECT'
    option output 'ACCEPT'
    option forward 'REJECT'
    option masq '1'
    option mtu_fix '1'
    option network 'vpn'

config forwarding                               
    option dest 'vpn_fw'                    
    option src 'lan' 
EOF

/etc/init.d/firewall restart
```

## 配置OpenVPN Client

将openvpn配置文件上传到 `/etc/openvpn/` 目录,`Home.ovpn` 改成你自己的名字即可.

```
uci set openvpn.Home="openvpn"
uci set openvpn.Home.enabled="1"
uci set openvpn.Home.config="/etc/openvpn/Home.ovpn"
uci commit openvpn 
/etc/init.d/openvpn restart
/etc/init.d/openvpn enable
```



<!-- 
## 创建网络接口
```
uci set network.openvpn="interface"
uci set network.openvpn.ifname="tun0"
uci set network.openvpn.proto="none"
uci commit network
/etc/init.d/network restart
```

## 配置防火墙的Default Rules & Forwarding
uci add firewall zone
uci set firewall.@zone[-1].name="openvpn_fw"
uci add_list firewall.@zone[-1].network="openvpn"
uci set firewall.@zone[-1].input="REJECT"
uci set firewall.@zone[-1].output="ACCEPT"
uci set firewall.@zone[-1].forward="REJECT"
uci set firewall.@zone[-1].masq="​1"​
uci set firewall.@zone[-1].mtu_fix="1"
uci add firewall forwarding
uci set firewall.@forwarding[-1].src="lan"
uci set firewall.@forwarding[-1].dest="openvpn_fw"
uci commit firewall
/etc/init.d/firewall restart

## 配置OpenVPN Client
uci add firewall zone
uci set openvpn.Home="openvpn"
uci set openvpn.Home.enabled="1"
uci set openvpn.Home.config="/etc/openvpn/Home.ovpn"
uci commit openvpn 
/etc/init.d/openvpn restart
/etc/init.d/openvpn enable -->