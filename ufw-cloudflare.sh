#!/bin/bash

curl -s https://www.cloudflare.com/ips-v4 -o /tmp/cloudflare_ips
echo "" >> /tmp/cloudflare_ips
curl -s https://www.cloudflare.com/ips-v6 >> /tmp/cloudflare_ips

# Allow all traffic from Cloudflare IPs (all ports).
for ip in `cat /tmp/cloudflare_ips`; do ufw allow proto tcp from $ip comment 'Cloudflare IP'; done

ufw reload > /dev/null

rm /tmp/cloudflare_ips

# OTHER EXAMPLE RULES
# Allow on port 80
#for cfip in `cat /tmp/cf_ips`; do ufw allow proto tcp from $cfip to any port 80 comment 'Cloudflare IP'; done

# Allow on port 443
#for cfip in `cat /tmp/cf_ips`; do ufw allow proto tcp from $cfip to any port 443 comment 'Cloudflare IP'; done

# Allow on ports 80 & 443
#for cfip in `cat /tmp/cf_ips`; do ufw allow proto tcp from $cfip to any port 80,443 comment 'Cloudflare IP'; done
