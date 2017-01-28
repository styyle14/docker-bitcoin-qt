FROM ubuntu:latest

ARG username="bitcoin"
ARG password="${username}"

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get clean && \
	apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y \
		build-essential \
		libtool \
		autotools-dev \
		automake \
		pkg-config \
		libssl-dev \
		libevent-dev \
		bsdmainutils \
		libboost-all-dev \
		libqt5gui5 \
		libqt5core5a \
		libqt5dbus5 \
		qttools5-dev \
		qttools5-dev-tools \
		libprotobuf-dev \
		protobuf-compiler \
		sudo \
		wget

RUN \
	wget 'http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz' && \
	echo '12edc0df75bf9abd7f82f821795bcee50f42cb2e5f76a6a281b85732798364ef  db-4.8.30.NC.tar.gz' | sha256sum -c && \
	tar -xzvf db-4.8.30.NC.tar.gz && \
	rm -r db-4.8.30.NC.tar.gz && \
	cd db-4.8.30.NC/build_unix/ && \
	../dist/configure \
		--prefix=/usr \
		--enable-cxx \
		--disable-shared \
		--with-pic && \
	make && \
	make install && \
	cd ../../ && \
	rm -r db-4.8.30.NC/

RUN \
	wget https://github.com/bitcoin/bitcoin/archive/master.tar.gz && \
	tar -xzvf master.tar.gz && \
	rm -r master.tar.gz && \
	cd bitcoin-master && \
	./autogen.sh && \
	./configure \
		--prefix=/usr \
		--with-gui=qt5 \
		--enable-hardening && \
	make && \
	make install && \
	cd ../ && \
	rm -r bitcoin-master

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get remove -y \
		build-essential \
		libtool \
		autotools-dev \
		automake \
		pkg-config \
		bsdmainutils \
		protobuf-compiler \
		wget && \ 
	apt-get autoremove -y && \
	rm -rf /var/lib/apt/* /var/cache/apt/*

RUN \
	useradd \
		--create-home \
		--groups \
			sudo \
		"${username}" && \
	echo "${username}:${password}" | chpasswd

USER "${username}"
VOLUME ["/home/${username}/datadir"]
WORKDIR "/home/${username}/datadir"
EXPOSE 8333
CMD bitcoin-qt -datadir="${PWD}"; rm -f .lock

