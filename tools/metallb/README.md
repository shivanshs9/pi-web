### Fix Outgoing traffic from cluster to Internet
1. IPv4 Cluster IP CIDRs
```bash
sudo ufw allow from 10.42.0.0/16 to any
sudo ufw allow from 10.43.0.0/16 to any
```
2. IPv6 Cluster IP CIDRs
```bash
sudo ufw allow from 2001:cafe:42:0::/56 to any
sudo ufw allow from 2001:cafe:42:1::/112 to any
```

### Fix incoming traffic from Node to LB
```bash
sudo ufw allow from any port 80 to fc00:f853:ccd:e799:: port 80
```