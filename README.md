# zcashd
A docker image for zcashd with Payment Disclosure. This uses the most up to date debian packages provided by the zcashd team.

To run:
```
docker run --rm -ti -v /data/zcash:/root/.zcash -v /data/zcash-params:/root/.zcash-params nowsci/zcashd
```

This will automatically run fetch-params and then fire up zcashd with a default `zcashd.conf`. At any point you can edit `/data/zcash/zcash.conf` and restart.
