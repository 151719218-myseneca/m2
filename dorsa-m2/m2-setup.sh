# Reset Logs
echo "------ RESETTING LOGS ------"
rm /var/messages/log
systemct restart rsyslog

# Record
echo "------ RECORD PACKETS ------"
tcpdump -i any -w milestone2-capture.pcap &

# Reset IP tables
echo "------ RESETTING IPTABLES ------"
systemctl restart iptables
./nat_basic-connectivity.sh