#!/bin/bash

if [ -n "$TOR" ]; then
	if [ ! -f /root/.zcash/zcash.conf ]; then
		echo "addnode=zcmaintvsivr7pcn.onion" > /root/.zcash/zcash.conf
		echo "gen=0" >> /root/.zcash/zcash.conf
		echo "genproclimit=-1" >> /root/.zcash/zcash.conf
		echo "equihashsolver=tromp" >> /root/.zcash/zcash.conf
		echo "exportdir=/root/export" >> /root/.zcash/zcash.conf
		echo "addnode=zcashiqykswlzpsu.onion" >> /root/.zcash/zcash.conf
		echo "addnode=zcashqhrmju6zfhn.onion" >> /root/.zcash/zcash.conf
		echo "addnode=zcashgmvxwrmjsut.onion" >> /root/.zcash/zcash.conf
		echo "addnode=zcashz3uma65ix7b.onion" >> /root/.zcash/zcash.conf
		echo "addnode=zcashiyf4kxluf3x.onion" >> /root/.zcash/zcash.conf
		echo "addnode=zcashwfe4x3jkz2b.onion" >> /root/.zcash/zcash.conf
		echo "addnode=zcashvkeki52iqpc.onion" >> /root/.zcash/zcash.conf
		echo "addnode=zcasha3cmfrpy7b7.onion" >> /root/.zcash/zcash.conf
		echo "addnode=zcashz7ed3nvbdxm.onion" >> /root/.zcash/zcash.conf
		echo "addnode=zcash5adwfpxfuvf.onion" >> /root/.zcash/zcash.conf
		echo "addnode=zcashixg5ol2ndo4.onion" >> /root/.zcash/zcash.conf
		echo "addnode=zcashuzwa365oh3n.onion" >> /root/.zcash/zcash.conf
		echo "addnode=zcashskbeoiwtym3.onion" >> /root/.zcash/zcash.conf
		echo "addnode=zcashuyvk5e7qfzy.onion" >> /root/.zcash/zcash.conf
		echo "addnode=fhsxfrwpyrtoxeal.onion" >> /root/.zcash/zcash.conf
		echo "addnode=zcash2iihed2wdux.onion" >> /root/.zcash/zcash.conf
		echo "addnode=w3dxku36wbp3lowx.onion" >> /root/.zcash/zcash.conf
	fi
	service tor start
	TORSTATUS=""
	while [ -z "$TORSTATUS" ]; do
		echo "Checking Tor status..."
		TORSTATUS=$(curl -x socks5h://localhost:9050 -s https://check.torproject.org | grep "Congratulations. This browser is configured to use Tor.")
		if [ -n "$TORSTATUS" ]; then
			echo "Tor is connected."
		else
			echo "Tor is not connected, sleeping 10s..."
			sleep 10
		fi
	done
	HOST=""
	if [ -f /var/lib/tor/zcash-service/hostname ]; then
		HOST=$(cat /var/lib/tor/zcash-service/hostname)
	fi
	while [ -z "$HOST" ]; do
		echo "Sleeping 10s while waiting for onion address..."
		sleep 10
		if [ -f /var/lib/tor/zcash-service/hostname ]; then
			HOST=$(cat /var/lib/tor/zcash-service/hostname)
		fi
	done
	torsocks zcash-fetch-params
	zcashd -experimentalfeatures -paymentdisclosure -debug=paymentdisclosure -txindex=1 -proxy=127.0.0.1:9050 -externalip=$HOST -listen -bind=127.0.0.1 -dnsseed=0 -onlynet=onion
else
	if [ ! -f /root/.zcash/zcash.conf ]; then
		echo "addnode=mainnet.z.cash" > /root/.zcash/zcash.conf
		echo "gen=0" >> /root/.zcash/zcash.conf
		echo "genproclimit=-1" >> /root/.zcash/zcash.conf
		echo "equihashsolver=tromp" >> /root/.zcash/zcash.conf
		echo "exportdir=/root/export" >> /root/.zcash/zcash.conf
	fi
	zcash-fetch-params
	zcashd -experimentalfeatures -paymentdisclosure -debug=paymentdisclosure -txindex=1
fi
