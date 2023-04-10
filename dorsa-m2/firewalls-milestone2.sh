# Restart IPTABLES
systemctl restart iptables
./nat_basic-connectivity.sh

# Drop partner traffic after NAT mapping
# RDP: 		Drop by Source Port			-s 172.17.158.36 -d 192.168.157.36 --sport 3389
iptables -I FORWARD -p tcp -s 172.17.158.36 -d 192.168.157.36 --sport 3389 -j DROP
iptables -I FORWARD -p tcp -s 172.17.158.36 -d 192.168.157.36 --sport 3389 -j LOG --log-prefix "Dropping-Port-Forwarding-RDP "

# SSH: 		Drop by Destination Port	-d 172.17.158.37 -s 192.168.157.36 --dport 22 
iptables -I FORWARD -p tcp -s 192.168.157.36 -d 172.17.158.37 --dport 22 -j DROP
iptables -I FORWARD -p tcp -s 192.168.157.36 -d 172.17.158.37 --dport 22 -j LOG --log-prefix "Dropping-Port-Forwarding-SSH "

# MYSQL:		Drop by Source Port			-s 172.17.158.37 -d 192.168.157.36 --sport 3306
iptables -I FORWARD -p tcp -d 192.168.157.36 -s 172.17.158.37  --sport 3306 -j DROP
iptables -I FORWARD -p tcp -d 192.168.157.36 -s 172.17.158.37  --sport 3306 -j LOG --log-prefix "Dropping-Port-Forwarding-MYSQL "

# IIS: 		Drop by Destination Port	-d 172.17.158.36 -s 192.168.157.36 --dport 80
iptables -I FORWARD -p tcp -s 192.168.158.3 -d 172.17.158.36 --dport 80 -j DROP
iptables -I FORWARD -p tcp -s 192.168.158.3 -d 172.17.158.36 --dport 80 -j LOG --log-prefix "Dropping-Port-Forwarding-IIS "

# APACHE: 	Drop by Source Port -s 172.17.158.37 -d 192.168.157.36 --sport 80 
iptables -I FORWARD -p tcp -d 192.168.157.36 -s 172.17.158.37 --sport 80 -j DROP
iptables -I FORWARD -p tcp -d 192.168.157.36 -s 172.17.158.37 --sport 80 -j LOG --log-prefix "Dropping-Port-Forwarding-APACHE "

# list the updated iptables
iptables -t nat -nvL --line-number
iptables -nvL --line-number