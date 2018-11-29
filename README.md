# zcashd
A docker image for zcashd with Payment Disclosure and Tor. This uses the most up to date debian packages provided by the zcashd team.

To run in clearnet:
```
docker run --rm -ti --name zcashd -h zcashd -v /data/zcash:/root/.zcash -v /data/zcash-params:/root/.zcash-params -v /data/export:/root/export nowsci/zcashd
```

To run via Tor:
```
docker run --rm -ti --name zcashdtor -h zcashdtor -v /data/zcash:/root/.zcash -v /data/zcash-params:/root/.zcash-params -v /data/export:/root/export -e "TOR=1" nowsci/zcashd
```

This will automatically run fetch-params and then fire up zcashd with a default `zcashd.conf`. At any point you can edit `/data/zcash/zcash.conf` and restart. If Tor is enabled, `zcash-fetch-params` runs through `torsocks` and `zcashd` is configured to run on a `.onion` service and only connect to specific `.onion` nodes.

Once running, you can access the CLI via:

```
docker exec -ti zcashd zcash-cli <commands>
```
