#!/bin/bash
read -p "Enter target (IP or domain): " TARGET
echo "Starting scans in parallel...."
nmap -p $TARGET -oN nmap_scan.txt &
sslscan $TARGET > sslscan_report.txt &
dirb http://$TARGET > dirb_report.txt &
sqlmap -u "http://$TARGET/index.php?id=1" --batch --crawl=1 --output-dir=sqlmap_results &

wait
echo "All scan completed."
