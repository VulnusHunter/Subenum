#!/bin/bash
#A Tool for subdomain enumeration of combination of  amass,subfinder,assetfinder,dnsgen,massdns
#getting the file directory as input
read -p "Enter the directory of domains :" DIR
#checking the directory is correct or not
read -p "verify that $DIR is correct file or not (y/n) : " OPTION
if [[ $OPTION = "y" ]]; 
then
	echo "OK"
else
	read -p 'Enter the correct directory :'
fi
#subfinder 
cat $DIR | subfinder > results/subfinder.txt
#amasss scan
amass enum -df $DIR > results/amass.txt
#assetfinder
cat $DIR | assetfinder --subs-only  > results/assetfinder.txt
#dnsgen
cat $DIR | dnsgen - > results/dnsgen.txt
#massdns
massdns -r rs/resolvers.txt -t AAAA $DIR domains.txt > results/results.txt
#checking for alive files
cd results
cat *.txt > probe.txt
cat probe.txt | httprobe > alive.txt
echo "Thanks for using the script check alive.txt"
