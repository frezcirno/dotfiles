#!/bin/bash
wget 'http://127.0.0.1:9000/clash/config.yaml?mode=tun&eth=enp11s0&upstream=grass,bird&group=cn,tw,oversea&port=7890&controller_port=9091&dns=1&dns_listen=127.0.0.153&proxy_rule_providers=1' -O /etc/clash/config.yaml
#wget 'http://127.0.0.1:9000/clash/config.yaml?mode=tun&eth=wlp12s0&upstream=bird,shadowsocks,nano&group=cn,oversea&port=7890&dns=1&dns_listen=127.0.0.153&no_rule_providers=1' -O /etc/clash/config.yaml
curl -XPUT localhost:9091/configs -d '{"path":"/etc/clash/config.yaml"}'
