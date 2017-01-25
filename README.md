# docker-bitcoin-qt
Dockerfile for bitcoin-qt built from https://github.com/bitcoin/bitcoin/archive/master.tar.gz

Builds with wallet and upnp enabled

X11 is shared from calling used

datadir should have space for the entire blockchain (https://blockchain.info/charts/blocks-size)

from a Linux system with docker installed, run an a terminal

./build.sh

./run.sh

