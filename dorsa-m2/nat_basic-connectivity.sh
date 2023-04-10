# to flush NAT tables
iptables -t nat -F

# to allow other students to access APACHE server 
iptables -t nat -A PREROUTING -p tcp --dport 18158 -j LOG --log-prefix "log-captures-masquerading"
iptables -t nat -A PREROUTING -p tcp --dport 18158 -j DNAT --to-destination 172.17.158.37:80

# to allow other students to access MySQL server 
iptables -t nat -A PREROUTING -p tcp --dport 16158 -j LOG --log-prefix "log-captures-masquerading"
iptables -t nat -A PREROUTING -p tcp --dport 16158 -j DNAT --to-destination 172.17.158.37:3306

# to allow other students to access Linux server - SSH 
iptables -t nat -A PREROUTING -p tcp --dport 12158 -j LOG --log-prefix "log-captures-masquerading"
iptables -t nat -A PREROUTING -p tcp --dport 12158 -j DNAT --to-destination 172.17.158.37:22

# to allow other students to access IIS server 
iptables -t nat -A PREROUTING -p tcp --dport 19158 -j LOG --log-prefix "log-captures-masquerading"
iptables -t nat -A PREROUTING -p tcp --dport 19158 -j DNAT --to-destination 172.17.158.36:80

# to allow other students to access Windows server - RDP 
iptables -t nat -A PREROUTING -p tcp --dport 13158 -j LOG --log-prefix "log-captures-masquerading"
iptables -t nat -A PREROUTING -p tcp --dport 13158 -j DNAT --to-destination 172.17.158.36:3389

# post route
iptables -t nat -A POSTROUTING -o eth0 -j LOG --log-prefix "log-captures-masquerading"
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE