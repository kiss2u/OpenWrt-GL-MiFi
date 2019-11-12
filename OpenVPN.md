# 方式一 (is Working)
## 创建网络接口

```
cat >> /etc/config/network << EOF
config interface 'openvpn'
    option proto 'none'
    option ifname 'tun0'
EOF

# 重启network
/etc/init.d/network restart
```

## 配置防火墙的Default Rules & Forwarding

```
cat >> /etc/config/firewall << EOF
config zone
    option name 'openvpn_fw'
    option input 'REJECT'
    option output 'ACCEPT'
    option forward 'REJECT'
    option masq '1'
    option mtu_fix '1'
    option network 'openvpn'

config forwarding                               
    option dest 'openvpn_fw'                    
    option src 'lan' 
EOF

# 重启firewall
/etc/init.d/firewall restart
```

## 配置OpenVPN Client

将openvpn配置文件上传到 `/etc/openvpn/` 目录,`Home.ovpn` 改成你自己的名字即可.

```
uci set openvpn.Home="openvpn"
uci set openvpn.Home.enabled="1"
uci set openvpn.Home.config="/etc/openvpn/Home.ovpn"
uci commit openvpn 

# 重启openvpn
/etc/init.d/openvpn restart

# 开机启动
/etc/init.d/openvpn enable
```



# 方式二 (not Testting)
## 创建网络接口

```
uci set network.openvpn=interface
uci set network.openvpn.ifname='tun0'
uci set network.openvpn.proto='none'
uci commit network

# 重启network
/etc/init.d/network restart
```

## 配置防火墙的Default Rules & Forwarding

```
uci add firewall zone
uci set firewall.@zone[-1].name='openvpn_fw'
uci set firewall.@zone[-1].input='REJECT'
uci set firewall.@zone[-1].output='ACCEPT'
uci set firewall.@zone[-1].forward='REJECT'
uci set firewall.@zone[-1].masq='1'
uci set firewall.@zone[-1].mtu_fix='1'
uci add_list firewall.@zone[-1].network='openvpn'

uci add firewall forwarding
uci set firewall.@forwarding[-1].src='lan'
uci set firewall.@forwarding[-1].dest='openvpn_fw'

uci commit firewall

# 重启firewall
/etc/init.d/firewall restart
```

## 配置OpenVPN Client

将openvpn client配置文件上传到 `/etc/openvpn/` 目录,`Home.ovpn` 改成你自己的名字即可.

```
uci add firewall zone
uci set openvpn.Home='openvpn'
uci set openvpn.Home.enabled='1'
uci set openvpn.Home.config='/etc/openvpn/Home.ovpn'
uci commit openvpn 

# 重启openvpn
/etc/init.d/openvpn restart

# 开机启动
/etc/init.d/openvpn enable
```

# 技巧

如果是家里的网络, 只是为了能够访问, 而不需要全局流量都经过VPN可以在ovpn文件中加入如下配置:

```
route-nopull                                        # 不抓取服务端的路由配置
route 172.16.0.0 255.255.0.0 vpn_gateway            # 设置路由, 仅允许172.16.0.0/16这个目标网段的流量走VPN通道
```

