#!/bin/bash

echo "Starting to bootstrap Vagrant SevenDB Riak VM"
# INSTALL VM NECESSITIES :)
apt-get update && apt-get install -y git emacs24-nox vim wget curl

# INSTALL ERLANG
#curl -O https://raw.githubusercontent.com/spawngrid/kerl/master/kerl
#chmod a+x kerl
#mv kerl /usr/local/bin
# FYI if you use R16B02-basho5 you will get a kerl build error because for some
# reason its used as a shell variable in basho's otp_build script which is
# invalid (no dashes). hence not using kerl way, which Basho recommended.
#kerl build git git://github.com/basho/otp.git OTP_R16B02_basho5 R16B02_basho5

# To install Erlang just downloading Basho Erlang
wget http://s3.amazonaws.com/downloads.basho.com/erlang/otp_src_R16B02-basho5.tar.gz
tar zxvf otp_src_R16B02-basho5.tar.gz
sudo apt-get install build-essential libncurses5-dev openssl libssl-dev fop xsltproc unixodbc-dev
pushd otp_src_R16B02-basho5
./configure && make && sudo make install
popd

# INSTALL RIAK
curl -O http://s3.amazonaws.com/downloads.basho.com/riak/2.0/2.0.5/riak-2.0.5.tar.gz
tar zxvf riak-2.0.5.tar.gz
# Fix for "error: security/pam_appl.h: No such file or directory" while compiling riak
sudo apt-get install libpam0g-dev
pushd riak-2.0.5
# The book says to do deverel to get 3 servers; the default way should be rel
# make rel
make devrel
# START RIAK SERVERS
dev/dev1/bin/riak start
dev/dev2/bin/riak start
dev/dev3/bin/riak start

echo "All done! Happy Hacking! :)"
