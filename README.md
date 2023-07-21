## pi-web

Cloud native IaC for personal Home server on PI.

#### Features
- Running a K3S cluster on a Raspberry Pi, and using MetalLB to provide a Network load balancer for my bare-metal Kubernetes cluster.
- K3S is configured to run on external SSD (check [shivanshs9/pi-dotfiles](https://github.com/shivanshs9/pi-dotfiles) for the required config)
- Configured my router and UFW firewall to allow public IPv6 HTTPS traffic for K8S services, protected behind CloudFlare Anti-DDOS Proxy.
- For the dynamic IPv6 Host IP, written a script to rotate my IP on CF DNS records.
- Using Telegraf and Influx to store the APM metrics (host/k8s).
- PiHole is running as a adblocker DNS server, and using [external DNS](https://github.com/kubernetes-sigs/external-dns/) to update Ingress host entries in Pihole records.
- Using CF Origin TLS certs with Traefik for HTTPS.
- Running both MariaDB and PostgreSQL with automated snapshot using CronJobs.
- Using a RAID-like setup with 3 data disks and 1 parity disk, achieving disk failover for data recovery , and leveraged OverlayFS for merging the data disks.

#### Apps
- [Photoprism](https://github.com/photoprism/photoprism)
- Stremio server
- Grafana
- Docker registry
- Traefik as Ingress controller
- MetalLB as NLB

#### TODO
1. Dashboard to access all my apps
2. SAML-based Auth powered by ORY Kratos and Hydra
