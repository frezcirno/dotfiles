#!/bin/bash
wget 'http://lh2/clash.php?mode=tun&eth=wlp7s0&custom_groups=cn,oversea,udp-oversea&keep_upstream_chains=1&secret_upstreams=default&port=7890&keep_upstream_chains=1&dns_listen=127.0.0.153' -O /etc/clash/config.yaml
curl -XPUT localhost:9090/configs -d '{"path":"/etc/clash/config.yaml"}'
