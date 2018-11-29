FROM debian:stretch-slim
MAINTAINER No Spam <nospam@nospam.tld>
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y --no-install-recommends apt-transport-https gnupg ca-certificates wget && \
  wget -qO - https://apt.z.cash/zcash.asc | apt-key add - && \
  echo "deb https://apt.z.cash/ jessie main" | tee /etc/apt/sources.list.d/zcash.list && \
  apt-get update && \
  apt-get install -y --no-install-recommends zcash && \
  apt-get install -y --no-install-recommends tor torsocks curl && \
  apt-get purge -y apt-transport-https && \
  apt-get autoclean && \
  mkdir -p /root/.zcash-params /root/.zcash
COPY torrc /etc/tor/torrc
COPY zcashd.sh /root/zcashd.sh
RUN chmod +x /root/zcashd.sh
ENTRYPOINT [ "/root/zcashd.sh" ]
