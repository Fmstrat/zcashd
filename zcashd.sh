#!/bin/bash

if [ ! -f /root/.zcash/zcash.conf ]; then
	echo "addnode=mainnet.z.cash" > /root/.zcash/zcash.conf
	echo "gen=0" >> /root/.zcash/zcash.conf
	echo "genproclimit=-1" >> /root/.zcash/zcash.conf
	echo "equihashsolver=tromp" >> /root/.zcash/zcash.conf
fi

zcash-fetch-params

zcashd -experimentalfeatures -paymentdisclosure -debug=paymentdisclosure -txindex=1
